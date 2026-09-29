module 0x22192a91b2a20898c5e7e616b8775c19e5c3a67885b465b7aed7c9646e18f769::version {
    public fun assert_is_current(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public fun current() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

