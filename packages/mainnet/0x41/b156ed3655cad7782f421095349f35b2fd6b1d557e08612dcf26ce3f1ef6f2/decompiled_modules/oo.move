module 0x41b156ed3655cad7782f421095349f35b2fd6b1d557e08612dcf26ce3f1ef6f2::oo {
    struct OO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OO, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<OO>(arg0, 306798522, b"OOO", b"oo", b"Oo", b"https://ipfs.io/ipfs/bafkreiemaxfxaasi5qw5v4bpawyc2ulv2r4rhv72vggi3jmzmrndrgz2vq", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

