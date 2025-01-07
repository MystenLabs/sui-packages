module 0x657f0955881948f3f20280d5646df3c9283ae6a1556c9e259d0c96b267bfc2ab::utils {
    public(friend) fun withdraw_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1), arg1);
    }

    public(friend) fun withdraw_balance_to_coin<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1)
    }

    public(friend) fun withdraw_balance_value<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

