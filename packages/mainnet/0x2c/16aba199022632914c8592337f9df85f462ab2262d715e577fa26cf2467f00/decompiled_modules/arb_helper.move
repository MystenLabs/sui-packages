module 0x8a280163ccd8d2e1f897290eb3e7f3cb1c33f4e0f110e5bf15d9cc17f98b3ede::arb_helper {
    public fun borrow_to_coin_x<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::balance::destroy_zero<T1>(arg1);
        0x2::coin::from_balance<T0>(arg0, arg2)
    }

    public fun borrow_to_coin_y<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::balance::destroy_zero<T0>(arg0);
        0x2::coin::from_balance<T1>(arg1, arg2)
    }

    public fun consume_a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        arg1
    }

    public fun consume_b2a<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>) : 0x2::coin::Coin<T0> {
        0x2::coin::destroy_zero<T1>(arg1);
        arg0
    }

    public fun prepare_repay_x<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::coin::Coin<T0>) {
        (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, arg1, arg2)), 0x2::balance::zero<T1>(), arg0)
    }

    public fun prepare_repay_y<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::coin::Coin<T1>) {
        (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg0, arg1, arg2)), arg0)
    }

    // decompiled from Move bytecode v7
}

