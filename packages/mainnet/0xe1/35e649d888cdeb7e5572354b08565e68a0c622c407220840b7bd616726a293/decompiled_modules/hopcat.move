module 0xe135e649d888cdeb7e5572354b08565e68a0c622c407220840b7bd616726a293::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPCAT>(arg0, 13445393144442605827, b"HopCat", b"$HopCat", b"First cat on Hop Fun", b"https://images.hop.ag/ipfs/QmWgvj3yw9AhXjDiDcS3tusixMAjTwE7LdxAKaPAFgXoQK", 0x1::string::utf8(b"https://x.com/HopCatSui"), 0x1::string::utf8(b"https://hopcat.fun/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

