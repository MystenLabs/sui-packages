module 0x69cc8ffb1d296d9c3b3b4f9eadb6b762ac60ad8d9307eb5f3631132dccab8c17::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x69cc8ffb1d296d9c3b3b4f9eadb6b762ac60ad8d9307eb5f3631132dccab8c17::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

