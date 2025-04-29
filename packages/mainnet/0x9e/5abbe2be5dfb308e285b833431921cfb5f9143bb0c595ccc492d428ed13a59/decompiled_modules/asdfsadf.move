module 0x9e5abbe2be5dfb308e285b833431921cfb5f9143bb0c595ccc492d428ed13a59::asdfsadf {
    struct ASDFSADF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDFSADF, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<ASDFSADF>(arg0, 671377491, b"ASDF", b"asdfsadf", b"asdfasdfadsf", b"https://ipfs.io/ipfs/bafkreicvdofbha2ffo27aehxarlkgf6bky7nytwheme2p3oiwxqn5x7eoi", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

