module 0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

