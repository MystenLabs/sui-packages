module 0x7ebca0d346bf05dec08e8761add9132ae9437e95c4203452a3a23e5b76ba88d0::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x7ebca0d346bf05dec08e8761add9132ae9437e95c4203452a3a23e5b76ba88d0::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

