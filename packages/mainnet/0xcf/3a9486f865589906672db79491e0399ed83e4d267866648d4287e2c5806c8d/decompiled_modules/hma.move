module 0xcf3a9486f865589906672db79491e0399ed83e4d267866648d4287e2c5806c8d::hma {
    public fun sxy<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xcf3a9486f865589906672db79491e0399ed83e4d267866648d4287e2c5806c8d::u::tod<T0>(arg4, 0x2::tx_context::sender(arg6));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_base_pyth_core<T0, T1>(arg0, arg1, arg5, arg2, arg3, &mut arg4, 0x2::coin::value<T0>(&arg4), 0, arg6)
    }

    public fun syx<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xcf3a9486f865589906672db79491e0399ed83e4d267866648d4287e2c5806c8d::u::tod<T1>(arg4, 0x2::tx_context::sender(arg6));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_quote_pyth_core<T0, T1>(arg0, arg1, arg5, arg2, arg3, &mut arg4, 0x2::coin::value<T1>(&arg4), 0, arg6)
    }

    // decompiled from Move bytecode v6
}

