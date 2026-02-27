module 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit {
    public(friend) fun assert_profit(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1 && arg0 - arg1 >= arg2, 1);
    }

    public(friend) fun balance_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public(friend) fun coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public(friend) fun coin_value<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public(friend) fun merge_coins<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    public(friend) fun split_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public(friend) fun zero_coin<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

