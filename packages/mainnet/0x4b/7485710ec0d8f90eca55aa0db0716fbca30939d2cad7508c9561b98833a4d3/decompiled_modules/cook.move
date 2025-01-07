module 0x4b7485710ec0d8f90eca55aa0db0716fbca30939d2cad7508c9561b98833a4d3::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<COOK>(arg0, 14355473733697626016, b"COOK on SUI", b"COOK", b"Just let him $COOK", b"https://images.hop.ag/ipfs/QmWtwx8ZtAG3wuybhycmmCnZq2x949jXNXvRL175wNdT57", 0x1::string::utf8(b"https://x.com/ChefOfSui"), 0x1::string::utf8(b"http://chefofsui.com/"), 0x1::string::utf8(b"http://t.me/CookSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

