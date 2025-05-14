module 0xd7668276de9ae327a43b8d8dcaa1a4be294280d1afaa81e8af05399a6f4153f7::sss_AAA_a {
    struct SSS_AAA_A has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS_AAA_A, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<SSS_AAA_A>(arg0, 216816168, b"SSS", b"sss AAA a", b"sfsf", b"https://ipfs.io/ipfs/bafybeic57e2n66q6tx4ekemblbnu26zkbquzvpnp4af4llgikb6pqn7s5i", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

