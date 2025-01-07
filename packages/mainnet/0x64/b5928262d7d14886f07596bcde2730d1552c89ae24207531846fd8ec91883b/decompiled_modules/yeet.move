module 0x64b5928262d7d14886f07596bcde2730d1552c89ae24207531846fd8ec91883b::yeet {
    struct YEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEET, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<YEET>(arg0, 12277688612224121206, b"YEET", b"YEET", b"YEET", b"https://images.hop.ag/ipfs/QmZj9rMA81g7nUdztVLdHgUmEqcmpP8fmYgLL597YGUfwY", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

