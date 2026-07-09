module 0x42f765744a05cdc2eb9e6fb50d8db682a8aba79c8d0ff53f743a38c7a271390::zo {
    public(friend) fun keep_zo_linkage_dependencies(arg0: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg1: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg4: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg5: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::CardRegistry) {
    }

    public fun slp_deposit<T0, T1>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg3: u64, arg4: u64, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::VaultsValuation, arg6: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::SymbolsValuation, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 > 0, 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::errors::err_amount_in_is_zero());
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::deposit_ptb<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg7), arg4, arg5, arg6, arg7);
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::emit_swap_event<T1, T0>(arg0, b"ZO", 0x2::object::id<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>>(arg1), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    public fun slp_swap<T0, T1, T2>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg3: u64, arg4: u64, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::VaultsValuation, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 > 0, 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::errors::err_amount_in_is_zero());
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::swap_v2_ptb<T0, T1, T2>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg8), arg4, arg5, arg6, arg7, arg8);
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::merge_balance<T2>(arg0, 0x2::coin::into_balance<T2>(v2));
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::emit_swap_event<T1, T2>(arg0, b"ZO", 0x2::object::id<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>>(arg1), v1, 0x2::coin::value<T2>(&v2), 0);
    }

    public fun slp_withdraw<T0, T1>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg3: u64, arg4: u64, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::VaultsValuation, arg6: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::SymbolsValuation, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::errors::err_amount_in_is_zero());
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::withdraw_ptb<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg7), arg4, arg5, arg6, arg7);
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::emit_swap_event<T0, T1>(arg0, b"ZO", 0x2::object::id<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>>(arg1), v1, 0x2::coin::value<T1>(&v2), 0);
    }

    public fun zlp_deposit<T0, T1>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg3: u64, arg4: u64, arg5: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation, arg6: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SymbolsValuation, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 > 0, 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::errors::err_amount_in_is_zero());
        let v2 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::deposit_ptb<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg7), arg4, arg5, arg6, arg7);
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::emit_swap_event<T1, T0>(arg0, b"ZO", 0x2::object::id<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>>(arg1), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    public fun zlp_swap<T0, T1, T2>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg3: u64, arg4: u64, arg5: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 > 0, 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::errors::err_amount_in_is_zero());
        let v2 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::swap_v2_ptb<T0, T1, T2>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg8), arg4, arg5, arg6, arg7, arg8);
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::merge_balance<T2>(arg0, 0x2::coin::into_balance<T2>(v2));
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::emit_swap_event<T1, T2>(arg0, b"ZO", 0x2::object::id<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>>(arg1), v1, 0x2::coin::value<T2>(&v2), 0);
    }

    public fun zlp_withdraw<T0, T1>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg3: u64, arg4: u64, arg5: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::VaultsValuation, arg6: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SymbolsValuation, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::errors::err_amount_in_is_zero());
        let v2 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::withdraw_ptb<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg7), arg4, arg5, arg6, arg7);
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::emit_swap_event<T0, T1>(arg0, b"ZO", 0x2::object::id<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>>(arg1), v1, 0x2::coin::value<T1>(&v2), 0);
    }

    // decompiled from Move bytecode v7
}

