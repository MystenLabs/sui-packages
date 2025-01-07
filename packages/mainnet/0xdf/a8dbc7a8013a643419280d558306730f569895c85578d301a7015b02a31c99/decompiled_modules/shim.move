module 0xdfa8dbc7a8013a643419280d558306730f569895c85578d301a7015b02a31c99::shim {
    struct SHIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SHIM>(arg0, 18056064898179231306, b"Shima Inu", b"SHIM", b"The Shima Enaga is a small fluffy white bird which is often described as a \"bouncy cotton ball.\" This bird is native to Hokkaido where it lives among the tree branches eating seeds.", b"https://images.hop.ag/ipfs/QmbcHQZKsTD1LYVoQeviFXKafRtZe4TaJatgTXRZw1X9Wf", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

