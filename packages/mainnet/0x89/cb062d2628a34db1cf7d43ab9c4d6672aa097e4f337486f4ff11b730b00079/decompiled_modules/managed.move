module 0x89cb062d2628a34db1cf7d43ab9c4d6672aa097e4f337486f4ff11b730b00079::managed {
    struct MANAGED has drop {
        dummy_field: bool,
    }

    struct TreasuryAccess has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<MANAGED>,
    }

    public fun burn(arg0: &mut TreasuryAccess, arg1: 0x2::coin::Coin<MANAGED>) {
        0x2::coin::burn<MANAGED>(&mut arg0.treasury_cap, arg1);
    }

    fun init(arg0: MANAGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGED>(arg0, 9, b"NFT", b"Early Adopter", b"Early Adopter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/c6hXB5C/NFT-3-1.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED>>(v1);
        let v2 = TreasuryAccess{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryAccess>(v2);
    }

    public entry fun mint(arg0: &mut TreasuryAccess, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MANAGED>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

