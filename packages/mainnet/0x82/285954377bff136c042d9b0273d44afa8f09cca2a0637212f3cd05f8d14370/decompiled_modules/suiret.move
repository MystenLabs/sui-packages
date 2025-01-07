module 0x82285954377bff136c042d9b0273d44afa8f09cca2a0637212f3cd05f8d14370::suiret {
    struct SUIRET has drop {
        dummy_field: bool,
    }

    struct TreasuryAccess has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SUIRET>,
    }

    fun init(arg0: SUIRET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRET>(arg0, 9, b"SUI", b"Sui", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1727362166/sui_xwsf0m.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRET>>(v1);
        let v2 = TreasuryAccess{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryAccess>(v2);
    }

    public entry fun mint(arg0: &mut TreasuryAccess, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIRET>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

