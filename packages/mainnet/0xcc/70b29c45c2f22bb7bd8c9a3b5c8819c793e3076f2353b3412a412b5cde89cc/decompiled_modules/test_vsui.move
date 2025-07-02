module 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

