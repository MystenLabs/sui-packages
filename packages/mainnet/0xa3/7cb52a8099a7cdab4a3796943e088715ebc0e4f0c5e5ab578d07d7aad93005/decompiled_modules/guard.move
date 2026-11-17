module 0xa37cb52a8099a7cdab4a3796943e088715ebc0e4f0c5e5ab578d07d7aad93005::guard {
    public fun assert_and_sweep_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 101);
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(arg0, arg3), arg2);
        };
    }

    public fun assert_and_sweep_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 101);
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::coin::send_funds<T0>(arg0, arg2);
        };
    }

    public fun assert_min_balance<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 101);
    }

    public fun assert_sqrt_price_band(arg0: u128, arg1: u128, arg2: u128) {
        assert!(arg0 >= arg1 && arg0 <= arg2, 103);
    }

    public fun assert_u64_ge(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 104);
    }

    public fun assert_u64_le(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 105);
    }

    public fun destroy_or_sweep_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun destroy_or_sweep_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::coin::send_funds<T0>(arg0, arg1);
        };
    }

    public fun take_repay_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 102);
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun take_repay_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 102);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

