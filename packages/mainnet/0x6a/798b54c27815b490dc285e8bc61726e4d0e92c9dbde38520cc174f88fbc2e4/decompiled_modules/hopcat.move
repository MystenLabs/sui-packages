module 0x6a798b54c27815b490dc285e8bc61726e4d0e92c9dbde38520cc174f88fbc2e4::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPCAT>(arg0, 11562663673820976625, b"HopCat", b"HopCat", x"466972737420636174206f6e20486f702046756e200a4c61756e6368696e67206f6e204e6f76656d6265722037", b"https://images.hop.ag/ipfs/QmWBx34wFTPcn8u2RbT74MgrKZFcbssptPYZWZhHQM3oVt", 0x1::string::utf8(b"https://x.com/HopCatSui"), 0x1::string::utf8(b"https://hopcat.fun/"), 0x1::string::utf8(b"https://t.me/HopCatSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

