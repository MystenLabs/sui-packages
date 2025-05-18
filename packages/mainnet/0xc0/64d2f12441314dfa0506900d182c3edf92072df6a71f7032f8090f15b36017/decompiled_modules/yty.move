module 0xc064d2f12441314dfa0506900d182c3edf92072df6a71f7032f8090f15b36017::yty {
    struct YTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YTY, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<YTY>(arg0, 71529638, b"TYTYTYT", b"yty", b"tyyy", b"https://ipfs.io/ipfs/bafkreiewb5k3ysxsym3tz3gmdynduwfwy4ipcwwovzfh6hgnhp2ib23kry", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

