module 0xfa4595dc1849291c9a36484a714b4bb2cff81a6e0135435fad9d18f6d9fd635d::evmprofile3 {
    struct EVMPROFILE3 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EVMPROFILE3>, arg1: 0x2::coin::Coin<EVMPROFILE3>) {
        0x2::coin::burn<EVMPROFILE3>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EVMPROFILE3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EVMPROFILE3>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: EVMPROFILE3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVMPROFILE3>(arg0, 9, b"evmprofile3", b"EVMPROFILE3", b"Releap Profile Token: evmprofile3", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVMPROFILE3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVMPROFILE3>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<EVMPROFILE3>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<EVMPROFILE3> {
        0x2::coin::mint<EVMPROFILE3>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

