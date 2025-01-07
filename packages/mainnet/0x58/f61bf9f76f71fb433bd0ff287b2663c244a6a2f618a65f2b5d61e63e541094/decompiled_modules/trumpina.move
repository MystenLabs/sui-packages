module 0x58f61bf9f76f71fb433bd0ff287b2663c244a6a2f618a65f2b5d61e63e541094::trumpina {
    struct TRUMPINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPINA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<TRUMPINA>(arg0, 1570765973786667612, b"The Trumpina Tor", b"TRUMPINA", b"The Trumpina Tor - Came with me if you want to moon.", b"https://images.hop.ag/ipfs/QmYa4sTeDqVFUNrDdzecozd38tUMrpyt7RbhSBFGqGNwr3", 0x1::string::utf8(b"https://x.com/Trumpinatorsui"), 0x1::string::utf8(b"https://thetrumpinator.fun/"), 0x1::string::utf8(b"https://t.me/thetrumpinatorsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

