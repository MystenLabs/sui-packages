module 0x477ba4b87024d6fa3bf79ea56924627fe75745862c18e68d6e9b7e90c19f035e::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 3741862847169707405, b"Hop Frog On Sui", b"HOPFROG", x"486f7046726f6720e28093206120737465616c74687920616e64206167696c652077617272696f722c20737472696b696e672066726f6d2074686520736861646f77732077697468206c696768746e696e672073706565642e", b"https://images.hop.ag/ipfs/QmXCXYSbvteuGnfC4hGL8KH1GNf5nsNnhN5AU3iuNfjRwG", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

