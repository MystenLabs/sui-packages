module 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::version {
    public fun check_version(arg0: u64) {
        assert!(1 == arg0, 1001);
    }

    public fun get_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

