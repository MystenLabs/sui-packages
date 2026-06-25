module 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::version {
    public fun check_version(arg0: u64) {
        assert!(1 == arg0, 1001);
    }

    public fun get_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

