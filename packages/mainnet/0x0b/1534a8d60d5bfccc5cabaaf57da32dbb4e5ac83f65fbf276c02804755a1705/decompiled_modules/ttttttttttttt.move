module 0xb1534a8d60d5bfccc5cabaaf57da32dbb4e5ac83f65fbf276c02804755a1705::ttttttttttttt {
    struct TTTTTTTTTTTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTTTTTTTTTTTT, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<TTTTTTTTTTTTT>(arg0, 77929713, b"TTTTTTT", b"ttttttttttttt", b"tttttttt", b"https://ipfs.io/ipfs/bafkreihnsewxf45t3y5viukzpv2lhwtcyfnpln54ng3yazcz6hgcq2f2ym", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

