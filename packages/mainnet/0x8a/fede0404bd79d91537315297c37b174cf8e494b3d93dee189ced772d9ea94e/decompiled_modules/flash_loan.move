module 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::flash_loan {
    public fun split_repay<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 10);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun split_repay_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 10);
        0x2::balance::split<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

