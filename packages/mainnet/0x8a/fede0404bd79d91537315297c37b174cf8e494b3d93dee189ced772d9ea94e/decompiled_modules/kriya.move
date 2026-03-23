module 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::kriya {
    public fun swap_x_to_y<T0, T1>(arg0: &mut 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::SwapContext, arg1: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) {
        0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::take_balance<T0>(arg0), arg6), arg6)));
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::SwapContext, arg1: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) {
        0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T1>(0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::take_balance<T1>(arg0), arg6), arg6)));
    }

    // decompiled from Move bytecode v6
}

