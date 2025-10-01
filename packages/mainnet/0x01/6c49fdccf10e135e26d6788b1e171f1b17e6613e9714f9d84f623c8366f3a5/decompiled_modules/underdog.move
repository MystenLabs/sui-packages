module 0x16c49fdccf10e135e26d6788b1e171f1b17e6613e9714f9d84f623c8366f3a5::underdog {
    struct UNDERDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNDERDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNDERDOG>(arg0, 9, b"underdog", b"ALPHADOG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<UNDERDOG>>(0x2::coin::mint<UNDERDOG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<UNDERDOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UNDERDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

