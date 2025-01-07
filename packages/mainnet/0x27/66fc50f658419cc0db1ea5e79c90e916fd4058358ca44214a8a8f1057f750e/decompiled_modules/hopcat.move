module 0x2766fc50f658419cc0db1ea5e79c90e916fd4058358ca44214a8a8f1057f750e::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPCAT>(arg0, 3832750015080952757, b"HOPCAT", b"HOPCAT", b"Just a cat", b"https://images.hop.ag/ipfs/QmWBx34wFTPcn8u2RbT74MgrKZFcbssptPYZWZhHQM3oVt", 0x1::string::utf8(b"https://x.com/HopCatSui"), 0x1::string::utf8(b"https://hopcat.fun/"), 0x1::string::utf8(b"https://t.me/HopCatSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

