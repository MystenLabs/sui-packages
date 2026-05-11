module 0xf70474ed480b74232a1ff445a0a992bb7221445f16e0c9eb334011fe36d00563::utils {
    public fun balance_check_threshold<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 1);
    }

    public fun balance_keep_or_destroy<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(arg0, arg1), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun balances_check_threshold<T0>(arg0: &vector<0x2::balance::Balance<T0>>, arg1: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0x2::balance::Balance<T0>>(arg0)) {
            v1 = v1 + 0x2::balance::value<T0>(0x1::vector::borrow<0x2::balance::Balance<T0>>(arg0, v0));
            v0 = v0 + 1;
        };
        assert!(v1 >= arg1, 1);
    }

    public fun coin_keep_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::pay::keep<T0>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun coins_check_threshold<T0>(arg0: &vector<0x2::coin::Coin<T0>>, arg1: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0x2::coin::Coin<T0>>(arg0)) {
            v1 = v1 + 0x2::coin::value<T0>(0x1::vector::borrow<0x2::coin::Coin<T0>>(arg0, v0));
            v0 = v0 + 1;
        };
        assert!(v1 >= arg1, 1);
    }

    public fun core_check_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

