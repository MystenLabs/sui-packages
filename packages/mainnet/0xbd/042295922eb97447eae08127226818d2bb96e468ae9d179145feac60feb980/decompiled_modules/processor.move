module 0xbd042295922eb97447eae08127226818d2bb96e468ae9d179145feac60feb980::processor {
    struct ProcessedSwap has copy, drop {
        input_amount: u64,
        output_amount: u64,
    }

    public fun merge_coins<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun process_swap_result<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = ProcessedSwap{
            input_amount  : arg1,
            output_amount : 0x2::balance::value<T0>(&arg0),
        };
        0x2::event::emit<ProcessedSwap>(v0);
        0x2::coin::from_balance<T0>(arg0, arg2)
    }

    public fun split_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        (0x2::coin::from_balance<T0>(v0, arg2), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, 0x2::balance::value<T0>(&v0) - arg1), arg2))
    }

    // decompiled from Move bytecode v6
}

