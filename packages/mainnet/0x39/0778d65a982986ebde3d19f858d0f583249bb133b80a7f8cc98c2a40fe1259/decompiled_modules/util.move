module 0x390778d65a982986ebde3d19f858d0f583249bb133b80a7f8cc98c2a40fe1259::util {
    public fun assert_balance_value_ge<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 10000002);
    }

    public fun assert_balance_value_gt<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) > arg1, 10000002);
    }

    public fun assert_balance_value_le<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) <= arg1, 10000002);
    }

    public fun assert_balance_value_lt<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) < arg1, 10000002);
    }

    public fun assert_coin_value_ge<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 10000001);
    }

    public fun assert_coin_value_gt<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) > arg1, 10000001);
    }

    public fun assert_coin_value_le<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) <= arg1, 10000001);
    }

    public fun assert_coin_value_lt<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) < arg1, 10000001);
    }

    public fun coin_join_b<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2));
    }

    public fun return_remaining_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(arg0, arg1), arg1);
        };
    }

    public fun return_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::pay::keep<T0>(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

