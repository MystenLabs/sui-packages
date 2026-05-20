module 0x7951601496d1b478e4cb269c21bcccf6848fc1d9612fb661cf5ea510f41381f7::liquidator_navi_flash_v2 {
    struct FlashLiqDiagV2 has copy, drop {
        flash_amount: u64,
        leftover_debt: u64,
        coll_amount: u64,
        debt_shortfall: u64,
        coll_owed: u64,
        variant: u8,
        push_phase0: bool,
    }

    struct BatchSkip has copy, drop {
        user: address,
        reason: u8,
        index: u64,
    }

    struct BatchLiquidated has copy, drop {
        user: address,
        index: u64,
        repay_used: u64,
        coll_seized: u64,
        leftover_debt: u64,
    }

    struct BatchSummary has copy, drop {
        batch_size: u64,
        liquidated_count: u64,
        skipped_count: u64,
        total_repay_used: u64,
        flash_amount: u64,
        flash_fees: u64,
        final_payout: u64,
        push_phase0: bool,
        variant: u8,
    }

    public fun batch_flash_liq_navi_a_keeper_ride<T0, T1>(arg0: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg5: address, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg8: address, arg9: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg15: u8, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg19: &mut 0x3::sui_system::SuiSystemState, arg20: u64, arg21: u128, arg22: vector<address>, arg23: vector<u64>, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg24, arg0, arg1, arg2, arg3, arg4, arg5);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg24, arg0, arg1, arg2, arg6, arg7, arg8);
        batch_flash_liquidate_swap_a<T0, T1>(false, arg9, arg10, arg11, arg1, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
    }

    public fun batch_flash_liq_navi_a_with_pyth_push<T0, T1>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: address, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg13: address, arg14: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg18: u8, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg20: u8, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg24: &mut 0x3::sui_system::SuiSystemState, arg25: u64, arg26: u128, arg27: vector<address>, arg28: vector<u64>, arg29: &0x2::clock::Clock, arg30: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg1, 1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg29), arg29), arg8, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg30), arg29), arg11, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg30), arg29));
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg29, arg5, arg6, arg7, arg8, arg9, arg10);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg29, arg5, arg6, arg7, arg11, arg12, arg13);
        batch_flash_liquidate_swap_a<T0, T1>(true, arg14, arg15, arg16, arg6, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30);
    }

    public fun batch_flash_liq_navi_b_keeper_ride<T0, T1>(arg0: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg5: address, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg8: address, arg9: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg15: u8, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg19: &mut 0x3::sui_system::SuiSystemState, arg20: u64, arg21: u128, arg22: vector<address>, arg23: vector<u64>, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg24, arg0, arg1, arg2, arg3, arg4, arg5);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg24, arg0, arg1, arg2, arg6, arg7, arg8);
        batch_flash_liquidate_swap_b<T0, T1>(false, arg9, arg10, arg11, arg1, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
    }

    public fun batch_flash_liq_navi_b_with_pyth_push<T0, T1>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: address, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg13: address, arg14: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg18: u8, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg20: u8, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg24: &mut 0x3::sui_system::SuiSystemState, arg25: u64, arg26: u128, arg27: vector<address>, arg28: vector<u64>, arg29: &0x2::clock::Clock, arg30: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg1, 1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg29), arg29), arg8, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg30), arg29), arg11, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg30), arg29));
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg29, arg5, arg6, arg7, arg8, arg9, arg10);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg29, arg5, arg6, arg7, arg11, arg12, arg13);
        batch_flash_liquidate_swap_b<T0, T1>(true, arg14, arg15, arg16, arg6, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30);
    }

    fun batch_flash_liquidate_swap_a<T0, T1>(arg0: bool, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: u128, arg15: vector<address>, arg16: vector<u64>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg15);
        assert!(v0 == 0x1::vector::length<u64>(&arg16), 2);
        assert!(v0 > 0, 3);
        let (v1, v2) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg1, arg7, arg13, arg12, arg18);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::balance::zero<T1>();
        let v6 = 0x2::balance::zero<T0>();
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < v0) {
            let v11 = *0x1::vector::borrow<address>(&arg15, v10);
            let v12 = *0x1::vector::borrow<u64>(&arg16, v10);
            if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg17, arg4, arg5, v11)) {
                let v13 = BatchSkip{
                    user   : v11,
                    reason : 0,
                    index  : v10,
                };
                0x2::event::emit<BatchSkip>(v13);
                v9 = v9 + 1;
                v10 = v10 + 1;
                continue
            };
            let v14 = 0x2::balance::value<T0>(&v4);
            let v15 = if (v12 < v14) {
                v12
            } else {
                v14
            };
            if (v15 == 0) {
                let v16 = BatchSkip{
                    user   : v11,
                    reason : 1,
                    index  : v10,
                };
                0x2::event::emit<BatchSkip>(v16);
                v9 = v9 + 1;
                v10 = v10 + 1;
                continue
            };
            let (v17, v18) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg17, arg4, arg5, arg6, arg7, 0x2::balance::split<T0>(&mut v4, v15), arg8, arg9, v11, arg10, arg11, arg12, arg18);
            let v19 = v18;
            let v20 = v17;
            let v21 = 0x2::balance::value<T1>(&v20);
            let v22 = 0x2::balance::value<T0>(&v19);
            0x2::balance::join<T1>(&mut v5, v20);
            0x2::balance::join<T0>(&mut v6, v19);
            if (v21 == 0 && v22 == 0) {
                let v23 = BatchSkip{
                    user   : v11,
                    reason : 2,
                    index  : v10,
                };
                0x2::event::emit<BatchSkip>(v23);
                v9 = v9 + 1;
            } else {
                let v24 = BatchLiquidated{
                    user          : v11,
                    index         : v10,
                    repay_used    : v15,
                    coll_seized   : v21,
                    leftover_debt : v22,
                };
                0x2::event::emit<BatchLiquidated>(v24);
                v8 = v8 + 1;
            };
            v7 = v7 + v15;
            v10 = v10 + 1;
        };
        0x2::balance::join<T0>(&mut v6, v4);
        let (_, _, _, _, v29, v30) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&v3);
        let v31 = arg13 + v29 + v30;
        let v32 = 0x2::balance::value<T0>(&v6);
        let v33 = if (v31 > v32) {
            v31 - v32
        } else {
            0
        };
        if (0x2::balance::value<T1>(&v5) > 0 && v33 > 0) {
            let (v34, v35, v36) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, false, false, v33, arg14, arg17);
            let v37 = v36;
            0x2::balance::destroy_zero<T1>(v35);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v37)), v37);
            0x2::balance::join<T0>(&mut v6, v34);
        };
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg18), 0x2::tx_context::sender(arg18));
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        let v38 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg17, arg5, arg7, v3, v6, arg18);
        let v39 = 0x2::balance::value<T0>(&v38);
        let v40 = BatchSummary{
            batch_size       : v0,
            liquidated_count : v8,
            skipped_count    : v9,
            total_repay_used : v7,
            flash_amount     : arg13,
            flash_fees       : v29 + v30,
            final_payout     : v39,
            push_phase0      : arg0,
            variant          : 0,
        };
        0x2::event::emit<BatchSummary>(v40);
        if (v39 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v38, arg18), 0x2::tx_context::sender(arg18));
        } else {
            0x2::balance::destroy_zero<T0>(v38);
        };
    }

    fun batch_flash_liquidate_swap_b<T0, T1>(arg0: bool, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: u128, arg15: vector<address>, arg16: vector<u64>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg15);
        assert!(v0 == 0x1::vector::length<u64>(&arg16), 2);
        assert!(v0 > 0, 3);
        let (v1, v2) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg1, arg7, arg13, arg12, arg18);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::balance::zero<T1>();
        let v6 = 0x2::balance::zero<T0>();
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < v0) {
            let v11 = *0x1::vector::borrow<address>(&arg15, v10);
            let v12 = *0x1::vector::borrow<u64>(&arg16, v10);
            if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg17, arg4, arg5, v11)) {
                let v13 = BatchSkip{
                    user   : v11,
                    reason : 0,
                    index  : v10,
                };
                0x2::event::emit<BatchSkip>(v13);
                v9 = v9 + 1;
                v10 = v10 + 1;
                continue
            };
            let v14 = 0x2::balance::value<T0>(&v4);
            let v15 = if (v12 < v14) {
                v12
            } else {
                v14
            };
            if (v15 == 0) {
                let v16 = BatchSkip{
                    user   : v11,
                    reason : 1,
                    index  : v10,
                };
                0x2::event::emit<BatchSkip>(v16);
                v9 = v9 + 1;
                v10 = v10 + 1;
                continue
            };
            let (v17, v18) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg17, arg4, arg5, arg6, arg7, 0x2::balance::split<T0>(&mut v4, v15), arg8, arg9, v11, arg10, arg11, arg12, arg18);
            let v19 = v18;
            let v20 = v17;
            let v21 = 0x2::balance::value<T1>(&v20);
            let v22 = 0x2::balance::value<T0>(&v19);
            0x2::balance::join<T1>(&mut v5, v20);
            0x2::balance::join<T0>(&mut v6, v19);
            if (v21 == 0 && v22 == 0) {
                let v23 = BatchSkip{
                    user   : v11,
                    reason : 2,
                    index  : v10,
                };
                0x2::event::emit<BatchSkip>(v23);
                v9 = v9 + 1;
            } else {
                let v24 = BatchLiquidated{
                    user          : v11,
                    index         : v10,
                    repay_used    : v15,
                    coll_seized   : v21,
                    leftover_debt : v22,
                };
                0x2::event::emit<BatchLiquidated>(v24);
                v8 = v8 + 1;
            };
            v7 = v7 + v15;
            v10 = v10 + 1;
        };
        0x2::balance::join<T0>(&mut v6, v4);
        let (_, _, _, _, v29, v30) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&v3);
        let v31 = arg13 + v29 + v30;
        let v32 = 0x2::balance::value<T0>(&v6);
        let v33 = if (v31 > v32) {
            v31 - v32
        } else {
            0
        };
        if (0x2::balance::value<T1>(&v5) > 0 && v33 > 0) {
            let (v34, v35, v36) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg2, arg3, true, false, v33, arg14, arg17);
            let v37 = v36;
            0x2::balance::destroy_zero<T1>(v34);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg2, arg3, 0x2::balance::split<T1>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v37)), 0x2::balance::zero<T0>(), v37);
            0x2::balance::join<T0>(&mut v6, v35);
        };
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg18), 0x2::tx_context::sender(arg18));
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        let v38 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg17, arg5, arg7, v3, v6, arg18);
        let v39 = 0x2::balance::value<T0>(&v38);
        let v40 = BatchSummary{
            batch_size       : v0,
            liquidated_count : v8,
            skipped_count    : v9,
            total_repay_used : v7,
            flash_amount     : arg13,
            flash_fees       : v29 + v30,
            final_payout     : v39,
            push_phase0      : arg0,
            variant          : 1,
        };
        0x2::event::emit<BatchSummary>(v40);
        if (v39 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v38, arg18), 0x2::tx_context::sender(arg18));
        } else {
            0x2::balance::destroy_zero<T0>(v38);
        };
    }

    public fun flash_liq_navi_a_keeper_ride<T0, T1>(arg0: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg5: address, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg8: address, arg9: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg15: u8, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg17: address, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg20: &mut 0x3::sui_system::SuiSystemState, arg21: u64, arg22: u128, arg23: u64, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg24, arg0, arg1, arg2, arg3, arg4, arg5);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg24, arg0, arg1, arg2, arg6, arg7, arg8);
        flash_liquidate_swap_a<T0, T1>(false, arg9, arg10, arg11, arg1, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
    }

    public fun flash_liq_navi_a_with_pyth_push<T0, T1>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: address, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg13: address, arg14: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg18: u8, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg20: u8, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg22: address, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg24: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg25: &mut 0x3::sui_system::SuiSystemState, arg26: u64, arg27: u128, arg28: u64, arg29: &0x2::clock::Clock, arg30: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg1, 1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg29), arg29), arg8, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg30), arg29), arg11, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg30), arg29));
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg29, arg5, arg6, arg7, arg8, arg9, arg10);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg29, arg5, arg6, arg7, arg11, arg12, arg13);
        flash_liquidate_swap_a<T0, T1>(true, arg14, arg15, arg16, arg6, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30);
    }

    public fun flash_liq_navi_a_with_pyth_push_aliased<T0, T1>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: address, arg11: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg12: address, arg13: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg14: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg15: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg17: u8, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg19: u8, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg21: address, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg24: &mut 0x3::sui_system::SuiSystemState, arg25: u64, arg26: u128, arg27: u64, arg28: &0x2::clock::Clock, arg29: &mut 0x2::tx_context::TxContext) {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg28), arg28), arg8, 0x2::coin::split<0x2::sui::SUI>(arg4, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg1, 1), arg29), arg28));
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg28, arg5, arg6, arg7, arg8, arg9, arg10);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg28, arg5, arg6, arg7, arg8, arg11, arg12);
        flash_liquidate_swap_a<T0, T1>(true, arg13, arg14, arg15, arg6, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29);
    }

    public fun flash_liq_navi_b_keeper_ride<T0, T1>(arg0: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg5: address, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg8: address, arg9: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg15: u8, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg17: address, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg20: &mut 0x3::sui_system::SuiSystemState, arg21: u64, arg22: u128, arg23: u64, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg24, arg0, arg1, arg2, arg3, arg4, arg5);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg24, arg0, arg1, arg2, arg6, arg7, arg8);
        flash_liquidate_swap_b<T0, T1>(false, arg9, arg10, arg11, arg1, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
    }

    public fun flash_liq_navi_b_with_pyth_push<T0, T1>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: address, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg13: address, arg14: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg15: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg18: u8, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg20: u8, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg22: address, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg24: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg25: &mut 0x3::sui_system::SuiSystemState, arg26: u64, arg27: u128, arg28: u64, arg29: &0x2::clock::Clock, arg30: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg1, 1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg29), arg29), arg8, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg30), arg29), arg11, 0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg30), arg29));
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg29, arg5, arg6, arg7, arg8, arg9, arg10);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg29, arg5, arg6, arg7, arg11, arg12, arg13);
        flash_liquidate_swap_b<T0, T1>(true, arg14, arg15, arg16, arg6, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30);
    }

    public fun flash_liq_navi_b_with_pyth_push_aliased<T0, T1>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg8: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: address, arg11: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg12: address, arg13: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg14: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg15: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg17: u8, arg18: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg19: u8, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg21: address, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg24: &mut 0x3::sui_system::SuiSystemState, arg25: u64, arg26: u128, arg27: u64, arg28: &0x2::clock::Clock, arg29: &mut 0x2::tx_context::TxContext) {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg3, arg28), arg28), arg8, 0x2::coin::split<0x2::sui::SUI>(arg4, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_total_update_fee(arg1, 1), arg29), arg28));
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg28, arg5, arg6, arg7, arg8, arg9, arg10);
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price_v2(arg28, arg5, arg6, arg7, arg8, arg11, arg12);
        flash_liquidate_swap_b<T0, T1>(true, arg13, arg14, arg15, arg6, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29);
    }

    fun flash_liquidate_swap_a<T0, T1>(arg0: bool, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: u128, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg1, arg7, arg14, arg13, arg18);
        let v2 = v1;
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg17, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12, arg13, arg18);
        let v5 = v3;
        let v6 = v4;
        let (_, _, _, _, v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&v2);
        let v13 = arg14 + v11 + v12;
        let v14 = 0x2::balance::value<T1>(&v5);
        let v15 = 0x2::balance::value<T0>(&v6);
        let v16 = if (v13 > v15) {
            v13 - v15
        } else {
            0
        };
        let v17 = FlashLiqDiagV2{
            flash_amount   : arg14,
            leftover_debt  : v15,
            coll_amount    : v14,
            debt_shortfall : v16,
            coll_owed      : 0,
            variant        : 0,
            push_phase0    : arg0,
        };
        0x2::event::emit<FlashLiqDiagV2>(v17);
        if (v14 > 0 && v16 > 0) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, false, false, v16, arg15, arg17);
            let v21 = v20;
            0x2::balance::destroy_zero<T1>(v19);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v21);
            let v23 = FlashLiqDiagV2{
                flash_amount   : arg14,
                leftover_debt  : v15,
                coll_amount    : v14,
                debt_shortfall : v16,
                coll_owed      : v22,
                variant        : 0,
                push_phase0    : arg0,
            };
            0x2::event::emit<FlashLiqDiagV2>(v23);
            assert!(v22 <= v14, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, v22), v21);
            0x2::balance::join<T0>(&mut v6, v18);
        };
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg18), 0x2::tx_context::sender(arg18));
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        let v24 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg17, arg5, arg7, v2, v6, arg18);
        assert!(0x2::balance::value<T0>(&v24) >= arg16, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v24, arg18), 0x2::tx_context::sender(arg18));
    }

    fun flash_liquidate_swap_b<T0, T1>(arg0: bool, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: u128, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg1, arg7, arg14, arg13, arg18);
        let v2 = v1;
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg17, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12, arg13, arg18);
        let v5 = v3;
        let v6 = v4;
        let (_, _, _, _, v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&v2);
        let v13 = arg14 + v11 + v12;
        let v14 = 0x2::balance::value<T1>(&v5);
        let v15 = 0x2::balance::value<T0>(&v6);
        let v16 = if (v13 > v15) {
            v13 - v15
        } else {
            0
        };
        let v17 = FlashLiqDiagV2{
            flash_amount   : arg14,
            leftover_debt  : v15,
            coll_amount    : v14,
            debt_shortfall : v16,
            coll_owed      : 0,
            variant        : 1,
            push_phase0    : arg0,
        };
        0x2::event::emit<FlashLiqDiagV2>(v17);
        if (v14 > 0 && v16 > 0) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg2, arg3, true, false, v16, arg15, arg17);
            let v21 = v20;
            0x2::balance::destroy_zero<T1>(v18);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v21);
            let v23 = FlashLiqDiagV2{
                flash_amount   : arg14,
                leftover_debt  : v15,
                coll_amount    : v14,
                debt_shortfall : v16,
                coll_owed      : v22,
                variant        : 1,
                push_phase0    : arg0,
            };
            0x2::event::emit<FlashLiqDiagV2>(v23);
            assert!(v22 <= v14, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg2, arg3, 0x2::balance::split<T1>(&mut v5, v22), 0x2::balance::zero<T0>(), v21);
            0x2::balance::join<T0>(&mut v6, v19);
        };
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg18), 0x2::tx_context::sender(arg18));
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        let v24 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg17, arg5, arg7, v2, v6, arg18);
        assert!(0x2::balance::value<T0>(&v24) >= arg16, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v24, arg18), 0x2::tx_context::sender(arg18));
    }

    // decompiled from Move bytecode v7
}

