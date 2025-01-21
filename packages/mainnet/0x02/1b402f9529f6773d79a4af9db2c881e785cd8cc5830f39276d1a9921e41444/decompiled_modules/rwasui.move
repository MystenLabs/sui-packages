module 0x21b402f9529f6773d79a4af9db2c881e785cd8cc5830f39276d1a9921e41444::rwasui {
    struct RWASUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RWASUI>, arg1: 0x2::coin::Coin<RWASUI>) {
        0x2::coin::burn<RWASUI>(arg0, arg1);
    }

    fun init(arg0: RWASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWASUI>(arg0, 9, b"RWASUI", b"RWA SUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RWASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RWASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RWASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RWASUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<RWASUI>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RWASUI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

