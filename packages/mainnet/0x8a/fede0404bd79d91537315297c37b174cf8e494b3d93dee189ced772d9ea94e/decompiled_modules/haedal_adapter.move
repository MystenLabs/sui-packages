module 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::haedal_adapter {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::SwapContext, arg1: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::take_balance<T0>(arg0);
        let v1 = 0x2::coin::from_balance<T0>(v0, arg5);
        0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg1, arg2, arg3, arg4, &mut v1, 0x2::balance::value<T0>(&v0), 0, arg5)));
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::SwapContext, arg1: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::take_balance<T1>(arg0);
        let v1 = 0x2::coin::from_balance<T1>(v0, arg5);
        0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v1));
        0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg1, arg2, arg3, arg4, &mut v1, 0x2::balance::value<T1>(&v0), 0, arg5)));
    }

    // decompiled from Move bytecode v6
}

