module 0x800eab21007561002897d628ebf6bb4591a63a8173f3f47482b84d5180c7fd62::popo {
    struct POPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x1b9d42d5f968fda629ca9cbb61825e4bf75a25ca9b0bf3617a3e124a12bf21a2::connector_v3::new<POPO>(arg0, 122346542, b"POPOPO", b"popo", b"pararpapaarara", b"https://ipfs.io/ipfs/bafkreia6wkgtdwxeloysuwbkg4nzbhn5ffe5pdnmg6y2ieahg7zvz65eom", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

