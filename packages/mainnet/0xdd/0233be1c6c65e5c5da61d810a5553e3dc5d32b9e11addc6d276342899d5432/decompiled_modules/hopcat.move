module 0xdd0233be1c6c65e5c5da61d810a5553e3dc5d32b9e11addc6d276342899d5432::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPCAT>(arg0, 8036605201435624694, b"HopCat", b"HopCat", b"Official First cat on Hop Fun", b"https://images.hop.ag/ipfs/QmWBx34wFTPcn8u2RbT74MgrKZFcbssptPYZWZhHQM3oVt", 0x1::string::utf8(b"https://x.com/HopCatSui"), 0x1::string::utf8(b"https://hopcat.fun/"), 0x1::string::utf8(b"https://t.me/HopCatSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

