module 0x60931bd2c8aefe6a52bb66524e4db2bf2ca73f88d989b5d0d409e4f0cd0e189::q {
    public fun al(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 101);
    }

    public fun am(arg0: u128, arg1: u128) {
        assert!(arg0 <= arg1, 101);
    }

    public fun aq64aq96(arg0: u128, arg1: u256, arg2: bool) {
        if (arg2) {
            assert!((arg0 as u256) << 32 >= arg1, 101);
        } else {
            assert!((arg0 as u256) << 32 <= arg1, 101);
        };
    }

    public fun bch<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 101);
    }

    public fun ca1(arg0: u128, arg1: u256, arg2: bool) {
        aq64aq96(arg0, arg1, arg2);
    }

    public fun cch<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 101);
    }

    public fun csx64(arg0: u128, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg0 >= arg1, 101);
        } else {
            assert!(arg0 <= arg1, 101);
        };
    }

    public fun tdb<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun tdc<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

