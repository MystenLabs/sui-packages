module 0x4ef71ad740248bb9f59aa73d5de02f4771edc24fb78eccdbb7a4de3dda05a8c2::potato {
    struct POTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTATO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<POTATO>(arg0, 1038864670640730796, b"HAPPY POTATO", b"$POTATO", x"49e280996d206120686170707920706f7461746f2c20736f616b696e67207570207468652073756e2c2064616e63696e672077697468206a6f792c20616e6420737072656164696e6720736d696c65732065766572797768657265204920676f2e204c6966652069732073696d706c652c20627574206974e2809973206f6820736f2062656175746966756c21", b"https://images.hop.ag/ipfs/QmZnfcvKFuTHnK435Q4v89zzR2XYkPcPpYhYLKaDQEsx28", 0x1::string::utf8(b"https://x.com/HappyPotat14753"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

