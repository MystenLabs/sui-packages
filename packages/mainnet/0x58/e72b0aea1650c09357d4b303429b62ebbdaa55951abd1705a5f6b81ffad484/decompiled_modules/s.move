module 0x58e72b0aea1650c09357d4b303429b62ebbdaa55951abd1705a5f6b81ffad484::s {
    public fun deepbook_0<T0, T1>(arg0: &mut 0xdee9::clob::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0xdee9::clob::place_market_order<T0, T1>(arg0, 0x2::coin::value<T0>(&arg2), false, arg2, 0x2::coin::zero<T1>(arg3), arg1, arg3);
        return_remaining_coin<T0>(v0, arg3);
        v1
    }

    public fun deepbook_1<T0, T1>(arg0: &mut 0xdee9::clob::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, _) = 0xdee9::clob::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::value<T1>(&arg2), arg1, arg2, arg3);
        return_remaining_coin<T1>(v1, arg3);
        v0
    }

    public fun deepbook_v2_0<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T0>(&arg4), false, arg4, 0x2::coin::zero<T1>(arg5), arg3, arg5);
        return_remaining_coin<T0>(v0, arg5);
        v1
    }

    public fun deepbook_v2_1<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg2, arg1, 0x2::coin::value<T1>(&arg4), arg3, arg4, arg5);
        return_remaining_coin<T1>(v1, arg5);
        v0
    }

    public fun return_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

