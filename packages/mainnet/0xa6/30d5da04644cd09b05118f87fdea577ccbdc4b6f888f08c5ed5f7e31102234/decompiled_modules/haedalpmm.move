module 0xa630d5da04644cd09b05118f87fdea577ccbdc4b6f888f08c5ed5f7e31102234::haedalpmm {
    public fun swap_a2b<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg0, arg4, arg1, arg2, &mut arg3, 0x2::coin::value<T0>(&arg3), 0, arg5);
        0x2::coin::value<T1>(&v0);
        0xa630d5da04644cd09b05118f87fdea577ccbdc4b6f888f08c5ed5f7e31102234::utils::transfer_or_destroy_coin<T0>(arg3, arg5);
        v0
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg0, arg4, arg1, arg2, &mut arg3, 0x2::coin::value<T1>(&arg3), 0, arg5);
        0x2::coin::value<T0>(&v0);
        0xa630d5da04644cd09b05118f87fdea577ccbdc4b6f888f08c5ed5f7e31102234::utils::transfer_or_destroy_coin<T1>(arg3, arg5);
        v0
    }

    // decompiled from Move bytecode v6
}

