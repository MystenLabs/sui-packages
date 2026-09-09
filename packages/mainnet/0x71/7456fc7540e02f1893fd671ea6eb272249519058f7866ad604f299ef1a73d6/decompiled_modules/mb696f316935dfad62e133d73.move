module 0x717456fc7540e02f1893fd671ea6eb272249519058f7866ad604f299ef1a73d6::mb696f316935dfad62e133d73 {
    public fun f25d3ed408c49635965e7335d<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun f885c850cfd2ca1db19eb9583<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

