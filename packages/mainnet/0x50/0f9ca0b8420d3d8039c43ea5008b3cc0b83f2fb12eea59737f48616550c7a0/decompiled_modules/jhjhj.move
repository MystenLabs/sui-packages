module 0x500f9ca0b8420d3d8039c43ea5008b3cc0b83f2fb12eea59737f48616550c7a0::jhjhj {
    struct JHJHJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHJHJ, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<JHJHJ>(arg0, 113148822, b"JHHJHJHJH", b"jhjhj", b"hj", b"https://ipfs.io/ipfs/bafybeicol7p4pt5dxrbwwsnhcomhynsg2i3kstksbbyqsbcvktnp4qdgty", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

