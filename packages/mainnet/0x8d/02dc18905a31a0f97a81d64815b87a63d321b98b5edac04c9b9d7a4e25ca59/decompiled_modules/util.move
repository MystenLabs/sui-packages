module 0x8d02dc18905a31a0f97a81d64815b87a63d321b98b5edac04c9b9d7a4e25ca59::util {
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

    public fun return_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::pay::keep<T0>(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

