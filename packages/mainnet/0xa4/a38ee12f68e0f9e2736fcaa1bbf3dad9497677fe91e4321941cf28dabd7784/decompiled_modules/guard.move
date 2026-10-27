module 0xa4a38ee12f68e0f9e2736fcaa1bbf3dad9497677fe91e4321941cf28dabd7784::guard {
    public fun assert_balance_ge<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 22);
    }

    public fun assert_between_u128(arg0: u128, arg1: u128, arg2: u128) {
        assert!(arg0 >= arg1, 13);
        assert!(arg0 <= arg2, 14);
    }

    public fun assert_between_u64(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1, 3);
        assert!(arg0 <= arg2, 4);
    }

    public fun assert_coin_ge<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 21);
    }

    public fun assert_ge_u128(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 11);
    }

    public fun assert_ge_u64(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 1);
    }

    public fun assert_le_u128(arg0: u128, arg1: u128) {
        assert!(arg0 <= arg1, 12);
    }

    public fun assert_le_u64(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 2);
    }

    public fun assert_profit_u64(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg1 >= arg0 && arg1 - arg0 >= arg2, 31);
    }

    // decompiled from Move bytecode v7
}

