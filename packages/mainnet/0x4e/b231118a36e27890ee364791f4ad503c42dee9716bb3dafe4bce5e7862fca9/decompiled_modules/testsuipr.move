module 0x4eb231118a36e27890ee364791f4ad503c42dee9716bb3dafe4bce5e7862fca9::testsuipr {
    struct TESTSUIPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTSUIPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTSUIPR>(arg0, 6, b"testsuipr", b"testsuiprod", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTSUIPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTSUIPR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

