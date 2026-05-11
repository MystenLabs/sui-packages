module 0x93387d85c12eac0de035ab11474d3f001c3837503757c564b1c2fbb7eb5a4665::r {
    struct LL<T0> {
        r: T0,
        a: u64,
    }

    struct ProfitEvent<phantom T0> has copy, drop {
        profit: u64,
        recipient: address,
    }

    public fun assert_min_out(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 6);
    }

    public fun haedal_pmm_a2b<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::from_balance<T0>(arg3, arg5);
        0x2::coin::destroy_zero<T0>(v0);
        0x2::coin::into_balance<T1>(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_base_coin<T0, T1>(arg0, arg4, arg1, arg2, &mut v0, 0x2::balance::value<T0>(&arg3), 0, arg5))
    }

    public fun haedal_pmm_b2a<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::from_balance<T1>(arg3, arg5);
        0x2::coin::destroy_zero<T1>(v0);
        0x2::coin::into_balance<T0>(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::sell_quote_coin<T0, T1>(arg0, arg4, arg1, arg2, &mut v0, 0x2::balance::value<T1>(&arg3), 0, arg5))
    }

    fun kiosk_v3_link(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::kiosk_lock_rule::Rule) {
        abort 0
    }

    public fun obric_a2b<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg0, arg5, arg1, arg2, arg3, 0x2::coin::from_balance<T0>(arg4, arg6), arg6))
    }

    public fun obric_b2a<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg0, arg5, arg1, arg2, arg3, 0x2::coin::from_balance<T1>(arg4, arg6), arg6))
    }

    fun phantom_dep_anchor(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: &0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext) {
        abort 0
    }

    public fun steamm_omm_v2_a2b<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: u64, arg6: u64, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::coin::from_balance<T1>(arg9, arg11);
        let v1 = 0x2::coin::zero<T2>(arg11);
        0x87b4289a2d040d37a05fa7839267c2b579d9437c4ba1a4a35c681f80431d9233::steamm_omm_v2::omm_swap_v2_<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg4, arg7, arg5, arg10), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg4, arg8, arg6, arg10), &mut v0, &mut v1, true, 0x2::balance::value<T1>(&arg9), arg10, arg11);
        0x2::coin::destroy_zero<T1>(v0);
        0x2::coin::into_balance<T2>(v1)
    }

    public fun steamm_omm_v2_b2a<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: u64, arg6: u64, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::balance::Balance<T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::zero<T1>(arg11);
        let v1 = 0x2::coin::from_balance<T2>(arg9, arg11);
        0x87b4289a2d040d37a05fa7839267c2b579d9437c4ba1a4a35c681f80431d9233::steamm_omm_v2::omm_swap_v2_<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg4, arg7, arg5, arg10), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg4, arg8, arg6, arg10), &mut v0, &mut v1, false, 0x2::balance::value<T2>(&arg9), arg10, arg11);
        0x2::coin::destroy_zero<T2>(v1);
        0x2::coin::into_balance<T1>(v0)
    }

    public fun xz<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 >= arg1, 2);
        let v1 = ProfitEvent<T0>{
            profit    : v0,
            recipient : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProfitEvent<T0>>(v1);
        0x2::coin::from_balance<T0>(arg0, arg2)
    }

    public fun zofai_slp_a2b<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: 0x2::balance::Balance<T1>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T6> {
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::create_vaults_valuation<T0>(arg15, arg0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T1>(arg0, arg2, arg3, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T2>(arg0, arg4, arg5, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T3>(arg0, arg6, arg7, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T4>(arg0, arg8, arg9, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T5>(arg0, arg10, arg11, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T6>(arg0, arg12, arg13, &mut v0);
        0x2::coin::into_balance<T6>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::swap_v2_ptb<T0, T1, T6>(arg0, arg1, 0x2::coin::from_balance<T1>(arg14, arg16), 0, v0, arg3, arg13, arg16))
    }

    public fun zofai_slp_b2a<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: 0x2::balance::Balance<T6>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::create_vaults_valuation<T0>(arg15, arg0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T1>(arg0, arg2, arg3, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T2>(arg0, arg4, arg5, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T3>(arg0, arg6, arg7, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T4>(arg0, arg8, arg9, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T5>(arg0, arg10, arg11, &mut v0);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::valuate_vault_v1_1<T0, T6>(arg0, arg12, arg13, &mut v0);
        0x2::coin::into_balance<T1>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market::swap_v2_ptb<T0, T6, T1>(arg0, arg1, 0x2::coin::from_balance<T6>(arg14, arg16), 0, v0, arg13, arg3, arg16))
    }

    public fun zofai_zlp_a2b<T0, T1, T2, T3, T4>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: 0x2::balance::Balance<T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::create_vaults_valuation<T0>(arg11, arg0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T1>(arg0, arg2, arg3, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T2>(arg0, arg4, arg5, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T3>(arg0, arg6, arg7, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T4>(arg0, arg8, arg9, &mut v0);
        0x2::coin::into_balance<T3>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::swap_v2_ptb<T0, T1, T3>(arg0, arg1, 0x2::coin::from_balance<T1>(arg10, arg12), 0, v0, arg3, arg7, arg12))
    }

    public fun zofai_zlp_b2a<T0, T1, T2, T3, T4>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg5: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg7: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: 0x2::balance::Balance<T3>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::create_vaults_valuation<T0>(arg11, arg0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T1>(arg0, arg2, arg3, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T2>(arg0, arg4, arg5, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T3>(arg0, arg6, arg7, &mut v0);
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::valuate_vault<T0, T4>(arg0, arg8, arg9, &mut v0);
        0x2::coin::into_balance<T1>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::swap_v2_ptb<T0, T3, T1>(arg0, arg1, 0x2::coin::from_balance<T3>(arg10, arg12), 0, v0, arg7, arg3, arg12))
    }

    // decompiled from Move bytecode v7
}

