module 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils {
    public fun split_balance_by_pips<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::safe_math::mul_div_u64(0x2::balance::value<T0>(arg0), arg1, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::scaling_pips()))
    }

    public fun split_coin_by_pips<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::safe_math::mul_div_u64(0x2::coin::value<T0>(arg0), arg1, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::scaling_pips()), arg2)
    }

    public fun transfer_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

