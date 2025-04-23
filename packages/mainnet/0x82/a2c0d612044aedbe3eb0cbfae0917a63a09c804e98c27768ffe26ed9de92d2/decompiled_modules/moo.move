module 0x82a2c0d612044aedbe3eb0cbfae0917a63a09c804e98c27768ffe26ed9de92d2::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        0xd51307d2235e10c4ce65d838f7e49a7447be439e03fc9fd9f3b7295fd09a6e84::connector_v3::new<MOO>(arg0, 8855501, b"MOO DENG", b"moo", b"moo deng in sui", b"https://ipfs.io/ipfs/bafkreihl5rptdvy2nt72psn5lrrs3az5lsrqlkzkw4742bf6swgkjifnoi", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

