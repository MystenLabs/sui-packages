module 0xbb94b961f2a11a7f6974037bf6cb421a426a549892ceef12a149bc22be459bd5::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, 18446744073709551615, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, 0x1::type_name::get<0x2::sui::SUI>(), arg1);
    }

    // decompiled from Move bytecode v6
}

