module 0x568f3889b8833cb953eb4a6cd103d219a370bdcb3578dd85027123727d6c2efa::flash_loan {
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

