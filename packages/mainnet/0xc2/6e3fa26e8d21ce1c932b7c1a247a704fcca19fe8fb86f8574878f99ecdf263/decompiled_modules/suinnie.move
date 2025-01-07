module 0xc26e3fa26e8d21ce1c932b7c1a247a704fcca19fe8fb86f8574878f99ecdf263::suinnie {
    struct SUINNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINNIE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUINNIE>(arg0, 1098216530716541054, b"Suinnie The Pooh", b"Suinnie", b"Suinnie The Pooh not having to double check his address because he uses SuiNS", b"https://images.hop.ag/ipfs/QmRsw421Ph2x3M8fFVURrtCdJG1taEBhmkpwRwKe3Q3BW7", 0x1::string::utf8(b"https://x.com/SuinniePooh"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

