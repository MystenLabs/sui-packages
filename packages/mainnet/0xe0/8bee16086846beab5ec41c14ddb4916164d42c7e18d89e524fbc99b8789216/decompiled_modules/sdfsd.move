module 0xe08bee16086846beab5ec41c14ddb4916164d42c7e18d89e524fbc99b8789216::sdfsd {
    struct SDFSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFSD>(arg0, 6, b"SDFSD", b"SDFSD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDFSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

