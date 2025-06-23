module 0xdc1ccbd55aff906c6445495e40455486c54efe44cf8e3a0bc178ad39db8e82ab::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0xdc1ccbd55aff906c6445495e40455486c54efe44cf8e3a0bc178ad39db8e82ab::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

