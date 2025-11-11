module 0x530ed9e3b09a374893833a725d4362f1c7164bb0f0a2ee8a7be0f5e51ba0caa1::nest {
    struct NEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEST>(arg0, 6, b"NEST", b"Nest Token", b"Native token of SuiNest ecosystem - Backed by locked SUIP reserves", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

