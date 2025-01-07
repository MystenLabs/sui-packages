module 0x157b9bc48b55a4dc4b38d867a760f743822f7b2336da1acfb1c5f8ccbc548::hfrog {
    struct HFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HFROG>(arg0, 4056673468636384914, b"HopFrogSui", b"HFROG", x"486f7046726f6720e28093206120737465616c74687920616e64206167696c652077617272696f722c20737472696b696e672066726f6d2074686520736861646f77732077697468206c696768746e696e672073706565642e", b"https://images.hop.ag/ipfs/QmXmmpgWbSniRVV4e7cgUgfxanjsTojqvFTp1HKSPKTZfe", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

