module 0x7900ecd29348b09e41f3918e64eaf7c46e6f6be92d0d41041190e5b10f9b3626::guard {
    public fun assert_and_split_profit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg1 > 0, 1003);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1001);
        (arg0, 0x2::coin::split<T0>(&mut arg0, 0x2::coin::value<T0>(&arg0) - arg1, arg2))
    }

    public fun assert_min_balance<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 1001);
    }

    public fun assert_min_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1 + arg2, 1002);
    }

    public fun assert_min_value<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1001);
    }

    public fun destroy_zero_balance<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun destroy_zero_coin<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::coin::destroy_zero<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

