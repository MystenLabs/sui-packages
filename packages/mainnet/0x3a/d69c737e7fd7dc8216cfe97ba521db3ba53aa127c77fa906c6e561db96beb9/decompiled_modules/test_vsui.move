module 0x3ad69c737e7fd7dc8216cfe97ba521db3ba53aa127c77fa906c6e561db96beb9::test_vsui {
    struct TEST_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ad69c737e7fd7dc8216cfe97ba521db3ba53aa127c77fa906c6e561db96beb9::setup::setup<TEST_VSUI>(arg0, 9, b"test_vSUI", b"test_vSUI", b"{\"test\"}}}", b"", true, true, true, @0xaf, 1000000000, 10010, 9990, 1000, 0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

