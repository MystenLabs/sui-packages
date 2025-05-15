module 0xac1689f0379c758dc89ca8cf34f2d791bcbcdf042e45ae674c0ef2fdc758d9ec::dddd {
    struct DDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDD, arg1: &mut 0x2::tx_context::TxContext) {
        0xf8c370f97f9dcc0da935edd0e941dcd9b22994fe66d1c8dcdf194bd308f4b1d1::connector_v3::new<DDDD>(arg0, 71624814, b"DFDD", b"dddd", b"ddd", b"https://ipfs.io/ipfs/bafkreibr6n46se3mbi6eoj74gww6dxticssnx6alvbkq3bhcxtzyb7pasm", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

