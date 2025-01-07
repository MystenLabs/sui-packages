module 0x923583a7ff785bd4466d1ad1537b2ee430f50e1d01906094f890e4736e3991e2::Version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    public fun assert_version(arg0: u64) {
        assert!(1 == arg0, 1000);
    }

    public fun get_version() : u64 {
        1
    }

    fun init(arg0: VERSION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VERSION>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

