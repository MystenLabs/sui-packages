module 0x9a123326c749fa18ddfca987fba3751f2a16eb7b2b96cd5d1dce975480a6f713::swap_obric {
    public fun swap_a2b<T0, T1, T2, T3>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg7: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg0, arg5, arg2, arg3, arg4, arg1, arg8);
        let v1 = 0x2::object::id<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg0);
        0x9a123326c749fa18ddfca987fba3751f2a16eb7b2b96cd5d1dce975480a6f713::swap_event::emit_common_swap<T0, T1>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::DEX_OBRIC(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<T0>(&arg1), 0x2::coin::value<T1>(&v0), true);
        v0
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg7: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg0, arg5, arg2, arg3, arg4, arg1, arg8);
        let v1 = 0x2::object::id<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg0);
        0x9a123326c749fa18ddfca987fba3751f2a16eb7b2b96cd5d1dce975480a6f713::swap_event::emit_common_swap<T0, T1>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::DEX_OBRIC(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<T1>(&arg1), 0x2::coin::value<T0>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

