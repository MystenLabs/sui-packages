module 0x665c14920cd445de72329a74d0822996b155d2fef0a5746119ccc785e3c1821d::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<SSS>(arg0, 20649523, b"SS", b"sss", b"ss", b"https://ipfs.io/ipfs/bafkreiatguvd62t2v4yrnmdxue62sdpex7qh3ri55w7z2lwu6qyxg4nkom", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

