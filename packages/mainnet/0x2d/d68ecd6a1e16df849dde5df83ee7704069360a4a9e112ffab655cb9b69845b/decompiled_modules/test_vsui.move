module 0x2dd68ecd6a1e16df849dde5df83ee7704069360a4a9e112ffab655cb9b69845b::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2dd68ecd6a1e16df849dde5df83ee7704069360a4a9e112ffab655cb9b69845b::test_setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, 1000, 3000, 2592000000, 2592000000, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

