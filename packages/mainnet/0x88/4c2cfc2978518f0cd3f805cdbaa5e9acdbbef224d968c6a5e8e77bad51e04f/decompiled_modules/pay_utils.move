module 0x884c2cfc2978518f0cd3f805cdbaa5e9acdbbef224d968c6a5e8e77bad51e04f::pay_utils {
    public(friend) fun balance_split_percent_to_coin<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(arg0, 0x2::balance::value<T0>(arg0) * arg1 / 100, arg2)
    }

    public(friend) fun balance_top_up<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun balance_withdraw<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::take<T0>(arg0, arg1, arg2), arg2);
    }

    public(friend) fun balance_withdraw_all<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1), arg1);
    }

    public(friend) fun balance_withdraw_all_to_coin<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1)
    }

    public(friend) fun coin_split_percent_to_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, 0x2::coin::value<T0>(arg0) * arg1 / 100, arg2)
    }

    // decompiled from Move bytecode v6
}

