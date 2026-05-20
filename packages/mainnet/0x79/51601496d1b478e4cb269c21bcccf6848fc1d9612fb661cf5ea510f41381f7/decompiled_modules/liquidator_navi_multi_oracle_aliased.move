module 0x7951601496d1b478e4cb269c21bcccf6848fc1d9612fb661cf5ea510f41381f7::liquidator_navi_multi_oracle_aliased {
    struct FlashLiqDiagMultiOracleAliased has copy, drop {
        flash_amount: u64,
        leftover_debt: u64,
        coll_amount: u64,
        debt_shortfall: u64,
        coll_owed: u64,
        push_phase0: bool,
        extras_refreshed: u8,
        unique_pios_pushed: u8,
    }

    public fun flash_liq_navi_a_multi_oracle_aliased_keeper_ride<T0, T1>(arg0: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg5: address, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg8: address, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg14: vector<address>, arg15: vector<u8>, arg16: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg17: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg20: u8, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg22: u8, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg24: address, arg25: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg26: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg27: &mut 0x3::sui_system::SuiSystemState, arg28: u64, arg29: u128, arg30: u64, arg31: &0x2::clock::Clock, arg32: &mut 0x2::tx_context::TxContext) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg31, arg0, arg1, arg2, arg3, arg4, arg5);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg31, arg0, arg1, arg2, arg6, arg7, arg8);
        let v0 = 0x1::vector::length<address>(&arg14);
        assert!(v0 == 0x1::vector::length<u8>(&arg15), 101);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u8>(&arg15, v1);
            if (v3 == 0) {
                0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg31, arg0, arg1, arg2, arg9, arg13, *0x1::vector::borrow<address>(&arg14, v1));
            } else if (v3 == 1) {
                0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg31, arg0, arg1, arg2, arg10, arg13, *0x1::vector::borrow<address>(&arg14, v1));
            } else if (v3 == 2) {
                0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg31, arg0, arg1, arg2, arg11, arg13, *0x1::vector::borrow<address>(&arg14, v1));
            } else {
                assert!(v3 == 3, 100);
                0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg31, arg0, arg1, arg2, arg12, arg13, *0x1::vector::borrow<address>(&arg14, v1));
            };
            v2 = v2 + 1;
            v1 = v1 + 1;
        };
        flash_liquidate_swap_a_inlined<T0, T1>(false, v2, 0, arg16, arg17, arg18, arg1, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32);
    }

    public fun flash_liq_navi_a_multi_oracle_aliased_with_pyth_push<T0, T1>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: address, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg13: address, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg19: u8, arg20: vector<address>, arg21: vector<u8>, arg22: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg23: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg24: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg25: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg26: u8, arg27: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg28: u8, arg29: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg30: address, arg31: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg32: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg33: &mut 0x3::sui_system::SuiSystemState, arg34: u64, arg35: u128, arg36: u64, arg37: &0x2::clock::Clock, arg38: &mut 0x2::tx_context::TxContext) {
        assert!(arg19 <= 4, 100);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg1, 1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg37), arg37), arg8, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg38), arg37), arg11, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg38), arg37);
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        if (arg19 >= 1) {
            v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, v1, arg14, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg38), arg37);
            v4 = v3 + 1;
        };
        if (arg19 >= 2) {
            v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, v2, arg15, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg38), arg37);
            v4 = v4 + 1;
        };
        if (arg19 >= 3) {
            v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, v2, arg16, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg38), arg37);
            v4 = v4 + 1;
        };
        if (arg19 >= 4) {
            v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, v2, arg17, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg38), arg37);
            v4 = v4 + 1;
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v2);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg37, arg5, arg6, arg7, arg8, arg9, arg10);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg37, arg5, arg6, arg7, arg11, arg12, arg13);
        let v5 = 0x1::vector::length<address>(&arg20);
        assert!(v5 == 0x1::vector::length<u8>(&arg21), 101);
        let v6 = 0;
        let v7 = 0;
        while (v6 < v5) {
            let v8 = *0x1::vector::borrow<u8>(&arg21, v6);
            assert!((v8 as u8) < arg19, 100);
            if (v8 == 0) {
                0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg37, arg5, arg6, arg7, arg14, arg18, *0x1::vector::borrow<address>(&arg20, v6));
            } else if (v8 == 1) {
                0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg37, arg5, arg6, arg7, arg15, arg18, *0x1::vector::borrow<address>(&arg20, v6));
            } else if (v8 == 2) {
                0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg37, arg5, arg6, arg7, arg16, arg18, *0x1::vector::borrow<address>(&arg20, v6));
            } else {
                assert!(v8 == 3, 100);
                0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg37, arg5, arg6, arg7, arg17, arg18, *0x1::vector::borrow<address>(&arg20, v6));
            };
            v7 = v7 + 1;
            v6 = v6 + 1;
        };
        flash_liquidate_swap_a_inlined<T0, T1>(true, v7, v4, arg22, arg23, arg24, arg6, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38);
    }

    fun flash_liquidate_swap_a_inlined<T0, T1>(arg0: bool, arg1: u8, arg2: u8, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg12: address, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &mut 0x3::sui_system::SuiSystemState, arg16: u64, arg17: u128, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg3, arg9, arg16, arg15, arg20);
        let v2 = v1;
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg19, arg6, arg7, arg8, arg9, v0, arg10, arg11, arg12, arg13, arg14, arg15, arg20);
        let v5 = v3;
        let v6 = v4;
        let (_, _, _, _, v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&v2);
        let v13 = arg16 + v11 + v12;
        let v14 = 0x2::balance::value<T1>(&v5);
        let v15 = 0x2::balance::value<T0>(&v6);
        let v16 = if (v13 > v15) {
            v13 - v15
        } else {
            0
        };
        let v17 = FlashLiqDiagMultiOracleAliased{
            flash_amount       : arg16,
            leftover_debt      : v15,
            coll_amount        : v14,
            debt_shortfall     : v16,
            coll_owed          : 0,
            push_phase0        : arg0,
            extras_refreshed   : arg1,
            unique_pios_pushed : arg2,
        };
        0x2::event::emit<FlashLiqDiagMultiOracleAliased>(v17);
        if (v14 > 0 && v16 > 0) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, false, false, v16, arg17, arg19);
            let v21 = v20;
            0x2::balance::destroy_zero<T1>(v19);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v21);
            let v23 = FlashLiqDiagMultiOracleAliased{
                flash_amount       : arg16,
                leftover_debt      : v15,
                coll_amount        : v14,
                debt_shortfall     : v16,
                coll_owed          : v22,
                push_phase0        : arg0,
                extras_refreshed   : arg1,
                unique_pios_pushed : arg2,
            };
            0x2::event::emit<FlashLiqDiagMultiOracleAliased>(v23);
            assert!(v22 <= v14, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, v22), v21);
            0x2::balance::join<T0>(&mut v6, v18);
        };
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg20), 0x2::tx_context::sender(arg20));
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        let v24 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg19, arg7, arg9, v2, v6, arg20);
        assert!(0x2::balance::value<T0>(&v24) >= arg18, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v24, arg20), 0x2::tx_context::sender(arg20));
    }

    // decompiled from Move bytecode v7
}

