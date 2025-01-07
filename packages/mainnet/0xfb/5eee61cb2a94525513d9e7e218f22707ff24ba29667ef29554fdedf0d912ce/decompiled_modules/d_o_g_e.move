module 0xfb5eee61cb2a94525513d9e7e218f22707ff24ba29667ef29554fdedf0d912ce::d_o_g_e {
    struct D_O_G_E has drop {
        dummy_field: bool,
    }

    fun init(arg0: D_O_G_E, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<D_O_G_E>(arg0, 7744072039328984654, b"D.O.G.E", b"D.O.G.E", b"ELON MUSK x DOGE!", b"https://images.hop.ag/ipfs/QmTBcfvtsgZgX9CSE1pTuGemkCbBC8TqM8D2svyg8M94cs", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

