module 0xf6eb07da8a02a4bcf02ba86b06b9c3d4d05a6cac445f39e16f9190ca504f9648::mammo {
    struct MAMMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMMO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MAMMO>(arg0, 9948631134034609808, b"Mammo", b"MAMMO", b"Mammo is inspired by Matt Furie", b"https://images.hop.ag/ipfs/Qmb4Lsu6Rv9BvPQAbD6sZAxNW13HWEVp1ZvzRR2nnawB6A", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

