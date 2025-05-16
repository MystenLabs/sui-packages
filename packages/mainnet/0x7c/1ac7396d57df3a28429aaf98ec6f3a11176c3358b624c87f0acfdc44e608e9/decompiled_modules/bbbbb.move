module 0x7c1ac7396d57df3a28429aaf98ec6f3a11176c3358b624c87f0acfdc44e608e9::bbbbb {
    struct BBBBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBBBB, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<BBBBB>(arg0, 681746944, b"BBBB", b"bbbbb", b"Bbbbb", b"https://ipfs.io/ipfs/bafkreifxtatfxsiagxxixuhinnwdaaotylverwhueavr7jzy6vctm5sgei", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

