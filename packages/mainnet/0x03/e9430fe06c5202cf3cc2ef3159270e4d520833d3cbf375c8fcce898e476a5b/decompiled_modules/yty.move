module 0x3e9430fe06c5202cf3cc2ef3159270e4d520833d3cbf375c8fcce898e476a5b::yty {
    struct YTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YTY, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<YTY>(arg0, 30595369, b"TYTYTYT", b"yty", b"tyyy", b"https://ipfs.io/ipfs/bafkreiewb5k3ysxsym3tz3gmdynduwfwy4ipcwwovzfh6hgnhp2ib23kry", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

