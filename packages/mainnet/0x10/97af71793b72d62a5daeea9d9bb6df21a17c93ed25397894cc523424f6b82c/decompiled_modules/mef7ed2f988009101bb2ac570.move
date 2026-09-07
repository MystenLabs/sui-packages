module 0x1097af71793b72d62a5daeea9d9bb6df21a17c93ed25397894cc523424f6b82c::mef7ed2f988009101bb2ac570 {
    public fun f1af29344275d8adb74548c43<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun f6536a02e2fbefe44d92672ee<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::buy_base_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun f7587a856688f9aad19b1e567<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    // decompiled from Move bytecode v7
}

