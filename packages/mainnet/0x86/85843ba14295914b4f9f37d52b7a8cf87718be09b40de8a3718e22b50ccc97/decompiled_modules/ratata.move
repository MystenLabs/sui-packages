module 0x8685843ba14295914b4f9f37d52b7a8cf87718be09b40de8a3718e22b50ccc97::ratata {
    struct RATATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATATA, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<RATATA>(arg0, 781156618, b"RATATATATA", b"ratata", b"sssss", b"https://ipfs.io/ipfs/bafkreibvc52vhrrafzeh2sb46a4dwvceai744vv4iihbox25bd5svhkh3a", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

