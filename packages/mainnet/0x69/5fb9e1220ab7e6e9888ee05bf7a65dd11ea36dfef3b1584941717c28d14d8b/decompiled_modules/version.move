module 0x695fb9e1220ab7e6e9888ee05bf7a65dd11ea36dfef3b1584941717c28d14d8b::version {
    public fun assert_is_current(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public fun current() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

