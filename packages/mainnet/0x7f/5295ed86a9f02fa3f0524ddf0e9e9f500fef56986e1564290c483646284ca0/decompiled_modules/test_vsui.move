module 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, 18446744073709551615, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, 0x1::type_name::get<0x2::sui::SUI>(), arg1);
    }

    // decompiled from Move bytecode v6
}

