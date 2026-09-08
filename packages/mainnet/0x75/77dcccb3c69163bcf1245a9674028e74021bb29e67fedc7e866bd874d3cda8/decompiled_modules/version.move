module 0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::version {
    public fun assert_is_current(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public fun current() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

