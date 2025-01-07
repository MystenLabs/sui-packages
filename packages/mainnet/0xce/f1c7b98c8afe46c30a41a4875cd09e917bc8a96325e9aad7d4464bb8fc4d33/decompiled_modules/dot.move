module 0xcef1c7b98c8afe46c30a41a4875cd09e917bc8a96325e9aad7d4464bb8fc4d33::dot {
    struct DOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DOT>(arg0, 17595593735165041537, b"dot", b"dot", b"dot is dot", b"https://images.hop.ag/ipfs/QmQdEXh8E7vNjQEvfv9Riy5VcyPLsiagT2Pt55SyXUcoCd", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

