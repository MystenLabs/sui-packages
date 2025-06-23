module 0x470b9af649bcedf6bc5496d9639e7a2b5686ddb5c20e44ca31f9629d7d156d31::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x470b9af649bcedf6bc5496d9639e7a2b5686ddb5c20e44ca31f9629d7d156d31::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

