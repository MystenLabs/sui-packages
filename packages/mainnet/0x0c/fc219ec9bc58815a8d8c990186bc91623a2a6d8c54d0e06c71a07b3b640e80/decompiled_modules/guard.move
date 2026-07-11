module 0xcfc219ec9bc58815a8d8c990186bc91623a2a6d8c54d0e06c71a07b3b640e80::guard {
    public fun assert_min_value<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun assert_u128_between(arg0: u128, arg1: u128, arg2: u128) {
        assert!(arg0 >= arg1 && arg0 <= arg2, 2);
    }

    public fun assert_u64_between(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1 && arg0 <= arg2, 2);
    }

    // decompiled from Move bytecode v7
}

