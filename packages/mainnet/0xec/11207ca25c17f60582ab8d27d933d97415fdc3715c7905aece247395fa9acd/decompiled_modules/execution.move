module 0xec11207ca25c17f60582ab8d27d933d97415fdc3715c7905aece247395fa9acd::execution {
    public fun maybe_x_to_y<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x1::option::Option<0x2::coin::Coin<T0>>, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg5)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg5);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x1::option::some<0x2::coin::Coin<T1>>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg5), arg6))
    }

    public fun maybe_y_to_x<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x1::option::Option<0x2::coin::Coin<T1>>, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg5)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg5);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg5), arg6))
    }

    // decompiled from Move bytecode v7
}

