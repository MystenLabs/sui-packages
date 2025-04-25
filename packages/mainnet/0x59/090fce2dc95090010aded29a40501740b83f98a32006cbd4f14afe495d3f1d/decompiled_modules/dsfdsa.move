module 0x59090fce2dc95090010aded29a40501740b83f98a32006cbd4f14afe495d3f1d::dsfdsa {
    struct DSFDSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSFDSA, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<DSFDSA>(arg0, 712313212, b"SDFSDA", b"dsfdsa", b"asdfsad", b"https://ipfs.io/ipfs/bafkreih2xg5fx3zbv2r23kmsjzkw4434vwe3zc3z2txg3yj7iayqjtpnxu", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

