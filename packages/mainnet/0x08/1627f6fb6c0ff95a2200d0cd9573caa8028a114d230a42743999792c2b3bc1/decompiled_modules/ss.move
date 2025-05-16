module 0x81627f6fb6c0ff95a2200d0cd9573caa8028a114d230a42743999792c2b3bc1::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<SS>(arg0, 429969356, b"SSS", b"ss", b"Dmff", b"https://ipfs.io/ipfs/bafybeiglcn5hp3be6qgkij7xebqyhci4ikhdd44lfvzav53gio4dlghfxu", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

