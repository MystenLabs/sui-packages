module 0x6b3dc8a74ae042d615ecb51aab7d958b31f9d449ba7bd4aa2ece733d9d85b94c::haedalpmm {
    public fun swap_a2b<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x6b3dc8a74ae042d615ecb51aab7d958b31f9d449ba7bd4aa2ece733d9d85b94c::utils::transfer_or_destroy_coin<T0>(arg3, arg5);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg0, arg4, arg1, arg2, &mut arg3, 0x2::coin::value<T0>(&arg3), 0, arg5)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6b3dc8a74ae042d615ecb51aab7d958b31f9d449ba7bd4aa2ece733d9d85b94c::utils::transfer_or_destroy_coin<T1>(arg3, arg5);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg0, arg4, arg1, arg2, &mut arg3, 0x2::coin::value<T1>(&arg3), 0, arg5)
    }

    // decompiled from Move bytecode v6
}

