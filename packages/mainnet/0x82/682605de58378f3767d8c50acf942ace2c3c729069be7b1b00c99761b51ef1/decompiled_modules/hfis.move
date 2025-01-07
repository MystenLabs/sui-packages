module 0x82682605de58378f3767d8c50acf942ace2c3c729069be7b1b00c99761b51ef1::hfis {
    struct HFIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFIS>(arg0, 6, b"Hfis", b"HopFun is shit", b"Let's laugh together at the HopFun losers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730988205470.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

