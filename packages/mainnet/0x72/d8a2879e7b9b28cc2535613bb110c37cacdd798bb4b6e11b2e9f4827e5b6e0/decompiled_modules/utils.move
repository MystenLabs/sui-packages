module 0x72d8a2879e7b9b28cc2535613bb110c37cacdd798bb4b6e11b2e9f4827e5b6e0::utils {
    public fun balance_check_threshold<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 10002);
    }

    public fun balance_keep_or_destroy<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
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
            0x2::balance::send_funds<T0>(0x2::coin::into_balance<T0>(arg0), 0x2::tx_context::sender(arg1));
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

