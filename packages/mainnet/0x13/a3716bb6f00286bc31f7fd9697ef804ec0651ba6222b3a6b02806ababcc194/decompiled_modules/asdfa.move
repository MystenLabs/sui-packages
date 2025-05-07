module 0x13a3716bb6f00286bc31f7fd9697ef804ec0651ba6222b3a6b02806ababcc194::asdfa {
    struct ASDFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDFA, arg1: &mut 0x2::tx_context::TxContext) {
        0x124f062a1eb37f9ec5f87bdc3cba16664fddcdd97f4ae1c2f4b0669992afbb41::connector_v3::new<ASDFA>(arg0, 894996707, b"ASDFAA", b"asdfa", b"asdfaa d ", b"https://ipfs.io/ipfs/bafkreidnrowzc2evpnxwyl56lh23fw62gi2p34uebgxx3oowcbkm4qwcna", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

