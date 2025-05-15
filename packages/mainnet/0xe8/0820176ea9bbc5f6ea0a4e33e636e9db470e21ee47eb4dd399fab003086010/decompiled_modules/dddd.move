module 0xe80820176ea9bbc5f6ea0a4e33e636e9db470e21ee47eb4dd399fab003086010::dddd {
    struct DDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDD, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<DDDD>(arg0, 145274455, b"DFDD", b"dddd", b"ddd", b"https://ipfs.io/ipfs/bafybeigq622wyabvcb65n3bga3cbjy5vtviidbuduy2o5nzal5pnpqj3ra", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

