module 0x60bf99b3cc443766b9d412e8d23e36fac4044ab4ee56015f26a5920cc7c7911a::fffffff {
    struct FFFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<FFFFFFF>(arg0, 584387969, b"FFFFF", b"fffffff", b"fff", b"https://ipfs.io/ipfs/bafkreihnsewxf45t3y5viukzpv2lhwtcyfnpln54ng3yazcz6hgcq2f2ym", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

