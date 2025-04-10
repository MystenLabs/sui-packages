module 0x945a6414409f56a3044cd014a4d5cb9af322a5bb788ed9bac4c58a4081171cfa::asdfasdf {
    struct ASDFASDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDFASDF, arg1: &mut 0x2::tx_context::TxContext) {
        0xd51307d2235e10c4ce65d838f7e49a7447be439e03fc9fd9f3b7295fd09a6e84::connector_v3::new<ASDFASDF>(arg0, 10640085, b"ASDFASDF", b"asdfasdf", b"adsfasdfasdf", b"https://ipfs.io/ipfs/bafkreih2xg5fx3zbv2r23kmsjzkw4434vwe3zc3z2txg3yj7iayqjtpnxu", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

