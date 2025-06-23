module 0xddfc4646c0d5b7a099ec966974ec4443776166a4954f0e24ede71b60c5033ba6::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0xddfc4646c0d5b7a099ec966974ec4443776166a4954f0e24ede71b60c5033ba6::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

