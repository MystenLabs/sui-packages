module 0x31ca320f04bc4dde213abc5984b454d84b99038ae63029c003615a61894e2b72::iii {
    struct III has drop {
        dummy_field: bool,
    }

    fun init(arg0: III, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<III>(arg0, 20257, b"IIUIU", b"iii", b"iuu", b"https://ipfs.io/ipfs/bafkreihnsewxf45t3y5viukzpv2lhwtcyfnpln54ng3yazcz6hgcq2f2ym", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

