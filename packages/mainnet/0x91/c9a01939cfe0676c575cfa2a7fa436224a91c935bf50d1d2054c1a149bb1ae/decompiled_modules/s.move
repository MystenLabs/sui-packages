module 0x91c9a01939cfe0676c575cfa2a7fa436224a91c935bf50d1d2054c1a149bb1ae::s {
    public fun deepbook_0<T0, T1>(arg0: &mut 0xdee9::clob::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0xdee9::clob::place_market_order<T0, T1>(arg0, 0x2::coin::value<T0>(&arg2), false, arg2, 0x2::coin::zero<T1>(arg3), arg1, arg3);
        0x2::coin::destroy_zero<T0>(v0);
        v1
    }

    public fun deepbook_1<T0, T1>(arg0: &mut 0xdee9::clob::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, _) = 0xdee9::clob::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::value<T1>(&arg2), arg1, arg2, arg3);
        0x2::coin::destroy_zero<T1>(v1);
        v0
    }

    public fun deepbook_v2_0<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T0>(&arg4), false, arg4, 0x2::coin::zero<T1>(arg5), arg3, arg5);
        0x2::coin::destroy_zero<T0>(v0);
        v1
    }

    public fun deepbook_v2_1<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg2, arg1, 0x2::coin::value<T1>(&arg4), arg3, arg4, arg5);
        0x2::coin::destroy_zero<T1>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

