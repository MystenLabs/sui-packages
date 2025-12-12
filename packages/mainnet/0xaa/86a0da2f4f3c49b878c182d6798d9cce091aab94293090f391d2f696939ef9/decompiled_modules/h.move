module 0xaa86a0da2f4f3c49b878c182d6798d9cce091aab94293090f391d2f696939ef9::h {
    public fun sxy<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xaa86a0da2f4f3c49b878c182d6798d9cce091aab94293090f391d2f696939ef9::u::tod<T0>(arg4, 0x2::tx_context::sender(arg5));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg0, arg1, arg2, arg3, &mut arg4, 0x2::coin::value<T0>(&arg4), 0, arg5)
    }

    public fun syx<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xaa86a0da2f4f3c49b878c182d6798d9cce091aab94293090f391d2f696939ef9::u::tod<T1>(arg4, 0x2::tx_context::sender(arg5));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg0, arg1, arg2, arg3, &mut arg4, 0x2::coin::value<T1>(&arg4), 0, arg5)
    }

    // decompiled from Move bytecode v6
}

