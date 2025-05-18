module 0xdbcc36357d6b52c153243daf77b47da7dede058aa989ccb4541824803d1e20a5::aa {
    struct AA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AA, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<AA>(arg0, 220122298, b"AAAAAA", b"aa", b"aaa", b"https://ipfs.io/ipfs/bafkreihnsewxf45t3y5viukzpv2lhwtcyfnpln54ng3yazcz6hgcq2f2ym", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

