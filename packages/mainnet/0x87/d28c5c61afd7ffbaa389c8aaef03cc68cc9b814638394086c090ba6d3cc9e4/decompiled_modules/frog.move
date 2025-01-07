module 0x87d28c5c61afd7ffbaa389c8aaef03cc68cc9b814638394086c090ba6d3cc9e4::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FROG>(arg0, 533719252037772897, b"FROG", b"FROG", b"FROG", b"https://images.hop.ag/ipfs/Qmf6Eps6XymRtnkZVgGmw6RB37wJcMtRgFGMgTifSNu8B1", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

