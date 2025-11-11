module 0xc26d08f022c3f972bc3d384444d61c1c95adf5320dff5e532796e69e3e36231a::nest {
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

