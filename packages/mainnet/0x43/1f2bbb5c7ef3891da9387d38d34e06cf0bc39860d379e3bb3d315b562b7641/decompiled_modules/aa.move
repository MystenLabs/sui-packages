module 0x431f2bbb5c7ef3891da9387d38d34e06cf0bc39860d379e3bb3d315b562b7641::aa {
    struct AA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AA, arg1: &mut 0x2::tx_context::TxContext) {
        0x523484ac51314276091c922e4bfa0e4922f2c034fd66ccf79df734fccefc1f45::connector_v3::new<AA>(arg0, 455704677, b"AAA", b"aa", b"aaa", b"https://ipfs.io/ipfs/bafkreidnrowzc2evpnxwyl56lh23fw62gi2p34uebgxx3oowcbkm4qwcna", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

