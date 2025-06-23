module 0x6ea2836304294f0dc7fa05270a91a2f284b0644d92fe3ba47e9cf508f99f58d1::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x6ea2836304294f0dc7fa05270a91a2f284b0644d92fe3ba47e9cf508f99f58d1::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

