module 0x35a0f9da1d786f724ec27a716dd56b4b627dc5ad673081a5a5a81adcffbf9897::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<SSS>(arg0, 35422977, b"SS", b"sss", b"ss", b"https://ipfs.io/ipfs/bafkreigobaimsxl2tqukvpdw33cxa2akxkd2747n6kxxogwuzlokzpdnfe", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

