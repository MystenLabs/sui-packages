module 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::xo {
    public fun qs<T0, T1>(arg0: &mut 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::M, arg1: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg2: bool) {
        if (!0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::live(arg0)) {
            return
        };
        0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::fd(arg0, 0x4bf24f9da9df94354fba4d87224795b000593d211413c124a5e1773e49a28f7f::vo::qo<T0, T1>(arg1, arg2, 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::cy(arg0)));
    }

    public fun sa<T0, T1>(arg0: &mut 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::M, arg1: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x4bf24f9da9df94354fba4d87224795b000593d211413c124a5e1773e49a28f7f::vo::sa<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::hp<T1>(arg0, &v0);
        v0
    }

    public fun sb<T0, T1>(arg0: &mut 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::M, arg1: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg2) == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x4bf24f9da9df94354fba4d87224795b000593d211413c124a5e1773e49a28f7f::vo::sb<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::hp<T0>(arg0, &v0);
        v0
    }

    // decompiled from Move bytecode v7
}

