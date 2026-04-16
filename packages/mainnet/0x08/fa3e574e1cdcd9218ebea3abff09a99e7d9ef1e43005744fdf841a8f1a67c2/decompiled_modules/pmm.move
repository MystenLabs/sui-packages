module 0x8fa3e574e1cdcd9218ebea3abff09a99e7d9ef1e43005744fdf841a8f1a67c2::pmm {
    public fun haedal_sell_base_coin<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T2, T3>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T2>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T2, T3>(arg3, arg4, arg5, arg6, &mut arg7, arg2, 0, arg8);
        0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::refund_aux<T0, T1, T2>(arg0, arg7);
        let v1 = 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T2, T3>>(arg3);
        0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::record_leg<T0, T1, T2, T3>(arg0, arg1, 3, 0x2::object::id_to_address(&v1), arg2, 0x2::coin::value<T3>(&v0));
        v0
    }

    public fun haedal_sell_quote_coin<T0, T1, T2, T3>(arg0: &mut 0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T2, T3>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T3>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T2, T3>(arg3, arg4, arg5, arg6, &mut arg7, arg2, 0, arg8);
        0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::refund_aux<T0, T1, T3>(arg0, arg7);
        let v1 = 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T2, T3>>(arg3);
        0x8600917a661d910297c066dd741e08b7e924383b95c3a0b204c183998b3d4fd5::execution::record_leg<T0, T1, T3, T2>(arg0, arg1, 3, 0x2::object::id_to_address(&v1), arg2, 0x2::coin::value<T2>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

