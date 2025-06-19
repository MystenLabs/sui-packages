module 0x2b82b64320d4f5b8430d40974830d4b84cbcb948d46b46483b87fc254b45aa51::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2b82b64320d4f5b8430d40974830d4b84cbcb948d46b46483b87fc254b45aa51::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

