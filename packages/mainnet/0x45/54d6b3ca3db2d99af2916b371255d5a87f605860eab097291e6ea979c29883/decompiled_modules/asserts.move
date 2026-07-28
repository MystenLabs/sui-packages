module 0x4554d6b3ca3db2d99af2916b371255d5a87f605860eab097291e6ea979c29883::asserts {
    public fun must_collector_set(arg0: address) {
        assert!(arg0 != @0x0, 103);
    }

    public fun must_profit_at_least(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 102);
    }

    public fun must_sqrt_within(arg0: u128, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg0 >= arg1, 101);
        } else {
            assert!(arg0 <= arg1, 101);
        };
    }

    // decompiled from Move bytecode v7
}

