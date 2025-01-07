module 0xf23ab5dcc1c6d78a60ccd51ca9c5d433b2734653877f19fac7f1b4f6a962cb2c::tiger {
    struct TIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGER, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TIGER>(arg0, 3982116040299611353, b"SUI TOOTH TIGER", b"TIGER", x"5375697320736162657220746f6f74682074696765722e200a4a6f696e20746865207061636b", b"https://images.hop.ag/ipfs/QmUeVwt4YW53DF1fSyESFGSXLihmZwttpioigYay5yvySv", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

