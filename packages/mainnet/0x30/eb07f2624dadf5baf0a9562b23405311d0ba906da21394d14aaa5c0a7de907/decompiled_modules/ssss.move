module 0x30eb07f2624dadf5baf0a9562b23405311d0ba906da21394d14aaa5c0a7de907::ssss {
    struct SSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSS, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<SSSS>(arg0, 710165836, b"TEST F 2", b"ssss", b"sss411 ", b"https://ipfs.io/ipfs/bafkreieegkfzikghnwob7exvvzkfq6z3odcopikvdr3yq5sdzwmb5vdyzi", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

