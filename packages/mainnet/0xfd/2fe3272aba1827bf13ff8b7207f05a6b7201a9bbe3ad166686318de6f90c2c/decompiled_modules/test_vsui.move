module 0xfd2fe3272aba1827bf13ff8b7207f05a6b7201a9bbe3ad166686318de6f90c2c::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0xfd2fe3272aba1827bf13ff8b7207f05a6b7201a9bbe3ad166686318de6f90c2c::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

