module 0xed5fb66668e6d1dad91e20abd5ce0d84f6cb774303bb089593b469c553043fc8::dasdasd {
    struct DASDASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DASDASD, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<DASDASD>(arg0, 13110814537875814111, b"asdas", b"dasdasd", b"asdasd", b"https://images.hop.ag/ipfs/QmWHUntEF2Tb7HpWmzLr2uUT3RaxRaA1UAYPYnCYcJzXhA", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

