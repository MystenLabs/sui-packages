module 0x3968b09e7c65cc4636cb7d746fb21cf154f4c789936d5cd8cf791ad318ffef61::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x3968b09e7c65cc4636cb7d746fb21cf154f4c789936d5cd8cf791ad318ffef61::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

