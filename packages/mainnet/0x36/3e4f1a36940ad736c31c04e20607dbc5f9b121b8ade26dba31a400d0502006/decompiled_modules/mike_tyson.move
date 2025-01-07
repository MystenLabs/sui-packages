module 0x363e4f1a36940ad736c31c04e20607dbc5f9b121b8ade26dba31a400d0502006::mike_tyson {
    struct MIKE_TYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKE_TYSON, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MIKE_TYSON>(arg0, 11725375864536177635, b"Tyson", b"Mike Tyson", b"winner", b"https://images.hop.ag/ipfs/QmQn15mewES12yLWdYoFhXW9uyrzRKhAU5PS8TeTGvsAMi", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

