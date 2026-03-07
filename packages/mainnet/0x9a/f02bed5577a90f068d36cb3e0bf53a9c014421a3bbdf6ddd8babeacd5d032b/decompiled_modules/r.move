module 0x9af02bed5577a90f068d36cb3e0bf53a9c014421a3bbdf6ddd8babeacd5d032b::r {
    public fun a<T0, T1, T2>(arg0: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::VaultsValuation, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::swap_v2_ptb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun cv<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::VaultsValuation {
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::create_vaults_valuation<T0>(arg0, arg1)
    }

    public fun vv<T0, T1>(arg0: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::VaultsValuation) {
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

