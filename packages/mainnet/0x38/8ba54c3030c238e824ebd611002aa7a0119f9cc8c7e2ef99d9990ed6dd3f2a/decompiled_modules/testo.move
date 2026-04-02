module 0x388ba54c3030c238e824ebd611002aa7a0119f9cc8c7e2ef99d9990ed6dd3f2a::testo {
    struct TESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTO>(arg0, 6, b"TESTO", b"TESTO", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

