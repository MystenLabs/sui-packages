module 0x18a0c022e52bbbe50bbc689793107829064ecd80574c0db2a4ce0b8331298501::SRT {
    struct SRT has drop {
        dummy_field: bool,
    }

    struct TreasuryAccess has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SRT>,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SUI", b"Sui", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dovgmcejr/image/upload/v1716468091/suiRewardToken/sui_ad0bcf.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SRT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SRT>(arg0, arg1);
        let v1 = TreasuryAccess{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryAccess>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SRT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SRT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

