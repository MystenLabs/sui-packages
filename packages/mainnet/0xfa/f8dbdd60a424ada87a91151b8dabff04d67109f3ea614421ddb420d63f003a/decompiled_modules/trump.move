module 0xfaf8dbdd60a424ada87a91151b8dabff04d67109f3ea614421ddb420d63f003a::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TRUMP>(arg0, 1718383126052062515, b"UNOFFICIAL TRUMP", b"TRUMP", b"ONLY UNOFFICIAL TRUMP MEME", b"https://images.hop.ag/ipfs/QmfYr6yqhujyV3ZRvyTY9aV9QPMXE1tnu71JHv1gaGpT5w", 0x1::string::utf8(b"https://x.com/GetTrumpMemes"), 0x1::string::utf8(b"https://gettrumpmemes.com/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

