module 0x39d610dcf68f0ce8b29f22bb34fb979d2f992ad437038ba744cddbe687d9be6e::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x39d610dcf68f0ce8b29f22bb34fb979d2f992ad437038ba744cddbe687d9be6e::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

