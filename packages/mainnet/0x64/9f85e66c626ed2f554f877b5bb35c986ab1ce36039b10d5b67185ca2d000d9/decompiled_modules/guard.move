module 0x649f85e66c626ed2f554f877b5bb35c986ab1ce36039b10d5b67185ca2d000d9::guard {
    public fun assert_min_balance<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 1);
    }

    public fun assert_min_profit<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1 + arg2, 2);
    }

    public fun split_repay_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 2);
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun split_repay_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

