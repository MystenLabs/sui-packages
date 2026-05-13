module 0xe5f061546d279a7dc57cae1cffbd145f663054ac5a03f9c98d34ac6c85156c39::utils {
    public fun balance_check_threshold<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 10002);
    }

    public fun balance_keep_or_destroy<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(arg0, arg1), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun balance_value<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 > 0, 10001);
        v0
    }

    public fun coin_check_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 10002);
    }

    public fun coin_keep_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::pay::keep<T0>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun coin_value<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 > 0, 10001);
        v0
    }

    // decompiled from Move bytecode v7
}

