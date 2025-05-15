module 0x6f7f1d1eb1d293f530b1946b41300af59671899128298e2aceb78c29538ff92a::fffffff {
    struct FFFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x1eb2a3d4d0f2ac3cc6848deb053ac8b15bd7844524bf11a225652ae4d694c882::connector_v3::new<FFFFFFF>(arg0, 919308761, b"FFFF", b"fffffff", b"ffffff", b"https://ipfs.io/ipfs/bafkreigk76k7khp5dd2mb3cfttxd27osxwr3pd3yxjd3utrzzrrsuohj2e", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

