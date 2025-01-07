module 0xd0bee8d11f2fde46d76809569b4b65e234192c9f43cef552efe622e1d952004e::three_pool {
    struct LP<phantom T0, phantom T1, phantom T2, phantom T3> has drop {
        dummy_field: bool,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        fee_amt: u64,
        krafted_pools_list: 0x2::linked_table::LinkedTable<PoolRegistryItem, 0x2::object::ID>,
        fee_claim_cap: 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::ThreeAmmFeeClaimCapability,
        public_kraft_enabled: bool,
    }

    struct PoolRegistryItem has copy, drop, store {
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
        c: 0x1::type_name::TypeName,
        curve: 0x1::type_name::TypeName,
    }

    struct LiquidityPool<phantom T0, phantom T1, phantom T2, phantom T3> has store, key {
        id: 0x2::object::UID,
        coin_x_reserve: 0x2::balance::Balance<T0>,
        coin_x_decimals: u8,
        coin_y_reserve: 0x2::balance::Balance<T1>,
        coin_y_decimals: u8,
        coin_z_reserve: 0x2::balance::Balance<T2>,
        coin_z_decimals: u8,
        lp_supply: 0x2::balance::Supply<LP<T0, T1, T2, T3>>,
        curved_config: 0x1::option::Option<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>,
        stable_config: 0x1::option::Option<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::StablePoolConfig>,
        weighted_config: 0x1::option::Option<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>,
        hive_x: 0x2::balance::Balance<T0>,
        hive_y: 0x2::balance::Balance<T1>,
        hive_z: 0x2::balance::Balance<T2>,
        fee_info: PoolFeeInfo,
        is_locked: bool,
        cumulative_x_price_y: u256,
        cumulative_y_price_x: u256,
        cumulative_x_price_z: u256,
        cumulative_z_price_x: u256,
        cumulative_y_price_z: u256,
        cumulative_z_price_y: u256,
        last_timestamp: u64,
        pool_hive_addr: 0x1::option::Option<address>,
    }

    struct PoolFeeInfo has store {
        total_fee_bps: u64,
        hive_fee_percent: u64,
    }

    struct Flashloan<phantom T0, phantom T1, phantom T2, phantom T3> {
        x_loan: u64,
        y_loan: u64,
        z_loan: u64,
    }

    struct PoolKraftingFeeUpdated has copy, drop {
        fee: u64,
    }

    struct StableConfigUpdated<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        id: 0x2::object::ID,
        init_amp_time: u64,
        next_amp: u64,
        next_amp_time: u64,
    }

    struct WeightedConfigUpdated<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        id: 0x2::object::ID,
        new_weights: vector<u64>,
        new_exit_fee: u64,
    }

    struct CurvedConfigUpdatedAmp<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        id: 0x2::object::ID,
        init_A_gamma_time: u64,
        next_amp: u64,
        next_gamma: u256,
        future_A_gamma_time: u64,
    }

    struct CurvedConfigUpdatedParams<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        id: 0x2::object::ID,
        new_mid_fee: u64,
        new_out_fee: u64,
        new_fee_gamma: u64,
        new_ma_half_time: u64,
        new_allowed_extra_profit: u64,
        new_adjustment_step: u64,
    }

    struct NewPoolCreated<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct LiquidityAddedToPool<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        id: 0x2::object::ID,
        coin_x_amount: u64,
        coin_y_amount: u64,
        coin_z_amount: u64,
        lp_minted: u64,
        total_x_fee: u64,
        total_y_fee: u64,
        total_z_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
        z_hive_fee: u64,
    }

    struct LiquidityRemovedFromPool<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        id: 0x2::object::ID,
        coin_x_amount: u64,
        coin_y_amount: u64,
        coin_z_amount: u64,
        lp_burned: u64,
        total_x_fee: u64,
        total_y_fee: u64,
        total_z_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
        z_hive_fee: u64,
    }

    struct TokensSwapped<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        id: 0x2::object::ID,
        x_offer_amt: u64,
        y_offer_amt: u64,
        z_offer_amt: u64,
        x_return_amt: u64,
        y_return_amt: u64,
        z_return_amt: u64,
        x_total_fee: u64,
        y_total_fee: u64,
        z_total_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
        z_hive_fee: u64,
    }

    struct FlashLoanExecuted<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        id: 0x2::object::ID,
        x_loan: u64,
        y_loan: u64,
        z_loan: u64,
        total_x_fee: u64,
        total_y_fee: u64,
        total_z_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
        z_hive_fee: u64,
    }

    struct CumPriceUpdatedEvent<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        id: 0x2::object::ID,
        cumulative_x_price_y: u256,
        cumulative_y_price_x: u256,
        cumulative_x_price_z: u256,
        cumulative_z_price_x: u256,
        cumulative_y_price_z: u256,
        cumulative_z_price_y: u256,
        timestamp: u64,
    }

    struct InternalPricesUpdated<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        id: 0x2::object::ID,
        price_scale: vector<u256>,
        oracle_prices: vector<u256>,
        last_prices: vector<u256>,
        last_prices_timestamp: u64,
        virtual_price: u256,
        xcp_profit: u256,
        not_adjusted: bool,
        _D: u256,
    }

    struct CollectedFeeForPool<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        id: 0x2::object::ID,
        x_fee_collected: u64,
        y_fee_collected: u64,
        z_fee_collected: u64,
    }

    struct PoolFeeUpdated has copy, drop {
        id: 0x2::object::ID,
        total_fee_bps: u64,
        hive_fee_percent: u64,
    }

    struct HarvestedHiveSui<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        hsui_for_hive: u64,
        hsui_for_treasury: u64,
        fee_balance_sold: u64,
    }

    struct LpBurntForever has copy, drop {
        pool_addr: address,
        lp_burned: u64,
    }

    public fun swap<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: 0x2::balance::Balance<T2>, arg7: u64, arg8: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(!arg1.is_locked, 5010);
        let (v0, v1, v2) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::get_asset_index_and_amount(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::create_vector(0x1::option::some<u64>(0x2::balance::value<T0>(&arg2)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg4)), 0x1::option::some<u64>(0x2::balance::value<T2>(&arg6)), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        assert!(!v2, 5013);
        let (v3, v4, v5) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::get_asset_index_and_amount(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::create_vector(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg5), 0x1::option::some<u64>(arg7), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        assert!(!v5, 5014);
        assert!(v1 != v4, 5015);
        let v6 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::some<u64>(0x2::balance::value<T2>(&arg1.coin_z_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v7 = arg1.fee_info.total_fee_bps;
        let v8 = arg1.fee_info.hive_fee_percent;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        update_cumulative_prices<T0, T1, T2, T3>(arg0, arg1);
        if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_curved<T3>()) {
            let v12 = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v13 = *0x1::vector::borrow<u256>(&v12, v4);
            if (arg8) {
                v9 = v0;
                let (v14, v15) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::compute_ask_amount(arg0, 0x1::option::borrow_mut<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), v1, v4, (v0 as u256) * *0x1::vector::borrow<u256>(&v12, v1), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(v6), v12), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256(((0x2::balance::supply_value<LP<T0, T1, T2, T3>>(&arg1.lp_supply) as u128) as u256), 1000000000000000000, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_u256(10, (6 as u128))));
                v10 = ((v14 / v13) as u64);
                v11 = ((v15 / v13) as u64);
            } else {
                let (v16, v17) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::compute_offer_amount(arg0, 0x1::option::borrow_mut<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), v1, v4, (v3 as u256) * v13, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(v6), v12), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256(((0x2::balance::supply_value<LP<T0, T1, T2, T3>>(&arg1.lp_supply) as u128) as u256), 1000000000000000000, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_u256(10, (6 as u128))));
                v9 = ((v16 / *0x1::vector::borrow<u256>(&v12, v1)) as u64);
                let v18 = ((v17 / v13) as u64);
                v11 = v18;
                v10 = v3 + v18;
            };
            let (v19, v20, v21, v22) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_prices_info(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v23, v24, v25, v26) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v27 = InternalPricesUpdated<T0, T1, T2, T3>{
                id                    : 0x2::object::uid_to_inner(&arg1.id),
                price_scale           : v19,
                oracle_prices         : v20,
                last_prices           : v21,
                last_prices_timestamp : v22,
                virtual_price         : v24,
                xcp_profit            : v25,
                not_adjusted          : v26,
                _D                    : v23,
            };
            0x2::event::emit<InternalPricesUpdated<T0, T1, T2, T3>>(v27);
        } else if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_stable<T3>()) {
            let (v28, v29) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::get_cur_A_and_scaling_factors(arg0, 0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::StablePoolConfig>(&arg1.stable_config));
            let v30 = v29;
            let v31 = *0x1::vector::borrow<u256>(&v30, v4);
            if (arg8) {
                v9 = v0;
                let v32 = ((0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::compute_ask_amount(v28, v1, (v0 as u256) * *0x1::vector::borrow<u256>(&v30, v1), v4, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(v6), v30)) / v31) as u64);
                v10 = v32;
                v11 = (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v7 as u256), (v32 as u256), (10000 as u256)) as u64);
            } else {
                let (v33, v34) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::compute_offer_amount(v28, (v3 as u256) * v31, v4, v1, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(v6), v30), v7);
                v9 = ((v33 / *0x1::vector::borrow<u256>(&v30, v1)) as u64);
                let v35 = ((v34 / v31) as u64);
                v11 = v35;
                v10 = v3 + v35;
            };
        } else if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_weighted<T3>()) {
            let (v36, v37) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::get_weight_and_sf_at_index(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(&arg1.weighted_config), v1, true);
            let (v38, v39) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::get_weight_and_sf_at_index(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(&arg1.weighted_config), v4, true);
            if (arg8) {
                v9 = v0;
                let v40 = ((0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::compute_ask_amount((v0 as u256) * v37, (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v37, (v36 as u256), (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v39, (v38 as u256)) / v39) as u64);
                v10 = v40;
                v11 = (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v7 as u256), (v40 as u256), (10000 as u256)) as u64);
            } else {
                let (v41, v42) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::compute_offer_amount((v3 as u256) * v39, (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v39, (v38 as u256), (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v37, (v36 as u256), v7);
                v9 = ((v41 / v37) as u64);
                let v43 = ((v42 / v39) as u64);
                v11 = v43;
                v10 = v3 + v43;
            };
        };
        assert!(v10 >= v3, 5017);
        assert!(v9 <= v0, 5018);
        let v44 = 0;
        let v45 = 0;
        let v46 = 0;
        let v47 = 0;
        let v48 = 0;
        let v49 = 0;
        let v50 = 0;
        let v51 = 0;
        let v52 = 0;
        let v53 = 0;
        let v54 = 0;
        let v55 = 0;
        if (v1 == 0 && v4 == 1) {
            v44 = v9;
            v48 = v10 - v11;
            v51 = v11;
            let (v56, v57) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::process_coin_balances_processing_for_swap<T0, T1>(&mut arg1.coin_x_reserve, &mut arg2, v9, &mut arg1.coin_y_reserve, &mut arg4, v10, v11, v8);
            v54 = v57;
            0x2::balance::join<T1>(&mut arg1.hive_y, v56);
        } else if (v1 == 0 && v4 == 2) {
            v44 = v9;
            v49 = v10 - v11;
            v52 = v11;
            let (v58, v59) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::process_coin_balances_processing_for_swap<T0, T2>(&mut arg1.coin_x_reserve, &mut arg2, v9, &mut arg1.coin_z_reserve, &mut arg6, v10, v11, v8);
            v55 = v59;
            0x2::balance::join<T2>(&mut arg1.hive_z, v58);
        } else if (v1 == 1 && v4 == 0) {
            v45 = v9;
            v47 = v10 - v11;
            v50 = v11;
            let (v60, v61) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::process_coin_balances_processing_for_swap<T1, T0>(&mut arg1.coin_y_reserve, &mut arg4, v9, &mut arg1.coin_x_reserve, &mut arg2, v10, v11, v8);
            v53 = v61;
            0x2::balance::join<T0>(&mut arg1.hive_x, v60);
        } else if (v1 == 1 && v4 == 2) {
            v45 = v9;
            v49 = v10 - v11;
            v52 = v11;
            let (v62, v63) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::process_coin_balances_processing_for_swap<T1, T2>(&mut arg1.coin_y_reserve, &mut arg4, v9, &mut arg1.coin_z_reserve, &mut arg6, v10, v11, v8);
            v55 = v63;
            0x2::balance::join<T2>(&mut arg1.hive_z, v62);
        } else if (v1 == 2 && v4 == 0) {
            v46 = v9;
            v47 = v10 - v11;
            v50 = v11;
            let (v64, v65) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::process_coin_balances_processing_for_swap<T2, T0>(&mut arg1.coin_z_reserve, &mut arg6, v9, &mut arg1.coin_x_reserve, &mut arg2, v10, v11, v8);
            v53 = v65;
            0x2::balance::join<T0>(&mut arg1.hive_x, v64);
        } else if (v1 == 2 && v4 == 1) {
            v46 = v9;
            v48 = v10 - v11;
            v51 = v11;
            let (v66, v67) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::process_coin_balances_processing_for_swap<T2, T1>(&mut arg1.coin_z_reserve, &mut arg6, v9, &mut arg1.coin_y_reserve, &mut arg4, v10, v11, v8);
            v54 = v67;
            0x2::balance::join<T1>(&mut arg1.hive_y, v66);
        };
        let v68 = TokensSwapped<T0, T1, T2, T3>{
            id           : 0x2::object::uid_to_inner(&arg1.id),
            x_offer_amt  : v44,
            y_offer_amt  : v45,
            z_offer_amt  : v46,
            x_return_amt : v47,
            y_return_amt : v48,
            z_return_amt : v49,
            x_total_fee  : v50,
            y_total_fee  : v51,
            z_total_fee  : v52,
            x_hive_fee   : v53,
            y_hive_fee   : v54,
            z_hive_fee   : v55,
        };
        0x2::event::emit<TokensSwapped<T0, T1, T2, T3>>(v68);
        (arg2, arg4, arg6)
    }

    public fun add_liquidity<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T2>, arg5: u64) : 0x2::balance::Balance<LP<T0, T1, T2, T3>> {
        let v0 = internal_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4);
        assert!(v0 >= arg5, 5009);
        0x2::balance::increase_supply<LP<T0, T1, T2, T3>>(&mut arg1.lp_supply, v0)
    }

    public entry fun collect_fee_for_pool<T0, T1, T2, T3>(arg0: &mut LiquidityPool<T0, T1, T2, T3>, arg1: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::FeeCollector<T0>, arg2: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::FeeCollector<T1>, arg3: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::FeeCollector<T2>) {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.hive_x);
        let v1 = 0x2::balance::withdraw_all<T1>(&mut arg0.hive_y);
        let v2 = 0x2::balance::withdraw_all<T2>(&mut arg0.hive_z);
        let v3 = CollectedFeeForPool<T0, T1, T2, T3>{
            id              : 0x2::object::uid_to_inner(&arg0.id),
            x_fee_collected : 0x2::balance::value<T0>(&v0),
            y_fee_collected : 0x2::balance::value<T1>(&v1),
            z_fee_collected : 0x2::balance::value<T2>(&v2),
        };
        0x2::event::emit<CollectedFeeForPool<T0, T1, T2, T3>>(v3);
        0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T0>(arg1, v0);
        0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T1>(arg2, v1);
        0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T2>(arg3, v2);
    }

    public fun dangerous_burn_lp_coins<T0, T1, T2, T3>(arg0: &mut LiquidityPool<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<LP<T0, T1, T2, T3>>) {
        let v0 = LpBurntForever{
            pool_addr : 0x2::object::uid_to_address(&arg0.id),
            lp_burned : 0x2::balance::value<LP<T0, T1, T2, T3>>(&arg1),
        };
        0x2::event::emit<LpBurntForever>(v0);
        0x2::balance::decrease_supply<LP<T0, T1, T2, T3>>(&mut arg0.lp_supply, arg1);
    }

    public fun enable_public_pools(arg0: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::HiveEntryCap, arg1: &mut PoolRegistry) {
        arg1.public_kraft_enabled = true;
    }

    public fun flashloan<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2, T3>, arg2: u64, arg3: u64, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, Flashloan<T0, T1, T2, T3>, u64, u64, u64) {
        assert!(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::is_sorted_3<T0, T1, T2>(), 5007);
        assert!(arg2 > 0 || arg3 > 0 || arg4 > 0, 5019);
        assert!(!arg1.is_locked, 5010);
        let v0 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, arg2);
        let v1 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, arg3);
        let v2 = 0x2::balance::split<T2>(&mut arg1.coin_z_reserve, arg4);
        let v3 = arg1.fee_info.total_fee_bps;
        arg1.is_locked = true;
        update_cumulative_prices<T0, T1, T2, T3>(arg0, arg1);
        let v4 = arg2 + (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((arg2 as u256), (v3 as u256), (10000 as u256)) as u64);
        let v5 = arg3 + (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((arg3 as u256), (v3 as u256), (10000 as u256)) as u64);
        let v6 = arg4 + (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((arg4 as u256), (v3 as u256), (10000 as u256)) as u64);
        let v7 = Flashloan<T0, T1, T2, T3>{
            x_loan : v4,
            y_loan : v5,
            z_loan : v6,
        };
        (v0, v1, v2, v7, v4, v5, v6)
    }

    public entry fun get_collected_fee<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.hive_x), 0x2::balance::value<T1>(&arg0.hive_y), 0x2::balance::value<T2>(&arg0.hive_z))
    }

    fun get_decimal_for_coin<T0>(arg0: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config) : u8 {
        let (v0, v1) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::get_decimals_for_coin<T0>(arg0);
        assert!(v0, 5001);
        v1
    }

    public fun get_hive_for_pool<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : address {
        *0x1::option::borrow<address>(&arg0.pool_hive_addr)
    }

    public entry fun get_liquidity_pool_id<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public entry fun get_pool_cumulative_prices_x_y<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (u256, u256, u64) {
        (arg0.cumulative_x_price_y, arg0.cumulative_y_price_x, arg0.last_timestamp)
    }

    public entry fun get_pool_cumulative_prices_x_z<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (u256, u256, u64) {
        (arg0.cumulative_x_price_z, arg0.cumulative_z_price_x, arg0.last_timestamp)
    }

    public entry fun get_pool_cumulative_prices_y_z<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (u256, u256, u64) {
        (arg0.cumulative_y_price_z, arg0.cumulative_z_price_y, arg0.last_timestamp)
    }

    public entry fun get_pool_curved_config_amp_gamma<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (u64, u64, u64, u64, u256, u256) {
        0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_amp_gamma_params(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public entry fun get_pool_curved_config_fee<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (u64, u64, u64, u256, u256, u256) {
        0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_fee_params(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public entry fun get_pool_curved_config_precision<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : vector<u256> {
        0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public entry fun get_pool_curved_config_prices_info<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (vector<u256>, vector<u256>, vector<u256>, u64) {
        0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_prices_info(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public entry fun get_pool_curved_config_xcp<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (u256, u256, u256, bool) {
        0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public entry fun get_pool_fee_config<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (u64, u64) {
        (arg0.fee_info.total_fee_bps, arg0.fee_info.hive_fee_percent)
    }

    public entry fun get_pool_id<T0, T1, T2, T3>(arg0: &PoolRegistry) : 0x2::object::ID {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            c     : 0x1::type_name::get<T2>(),
            curve : 0x1::type_name::get<T3>(),
        };
        *0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0)
    }

    public entry fun get_pool_id_as_address<T0, T1, T2, T3>(arg0: &PoolRegistry) : address {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            c     : 0x1::type_name::get<T2>(),
            curve : 0x1::type_name::get<T3>(),
        };
        0x2::object::id_to_address(0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0))
    }

    public fun get_pool_registery(arg0: &PoolRegistry) : (u64, bool, u64) {
        (arg0.fee_amt, arg0.public_kraft_enabled, 0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list))
    }

    public entry fun get_pool_reserves<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x_reserve), 0x2::balance::value<T1>(&arg0.coin_y_reserve), 0x2::balance::value<T2>(&arg0.coin_z_reserve))
    }

    public entry fun get_pool_reserves_decimals<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (u8, u8, u8) {
        (arg0.coin_x_decimals, arg0.coin_y_decimals, arg0.coin_z_decimals)
    }

    public entry fun get_pool_stable_config<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (u64, u64, u64, u64, vector<u256>) {
        0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::get_stable_config_params(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::StablePoolConfig>(&arg0.stable_config))
    }

    public entry fun get_pool_total_supply<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : u64 {
        0x2::balance::supply_value<LP<T0, T1, T2, T3>>(&arg0.lp_supply)
    }

    public entry fun get_pool_weighted_config<T0, T1, T2, T3>(arg0: &LiquidityPool<T0, T1, T2, T3>) : (vector<u64>, vector<u256>, u64, u64) {
        0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::get_weighted_config_params(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(&arg0.weighted_config))
    }

    public entry fun harvest_sui_for_collected_fee_x_y<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg3: &PoolRegistry, arg4: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg5: &mut LiquidityPool<T0, T1, 0x2::sui::SUI, T2>, arg6: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::FeeCollector<T0>, arg7: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::FeeCollector<T1>, arg8: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg9: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Treasury<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg10: &mut 0x2::tx_context::TxContext) {
        if (0x1::type_name::get<T0>() != 0x1::type_name::get<0x2::sui::SUI>() && 0x1::type_name::get<T0>() != 0x1::type_name::get<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>()) {
            let v0 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::extract_fee_for_coin_3amm<T0>(&arg3.fee_claim_cap, arg6);
            let (v1, v2, v3) = swap<T0, T1, 0x2::sui::SUI, T2>(arg0, arg5, v0, 0, 0x2::balance::zero<T1>(), 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
            let v4 = v1;
            let (_, v6, v7) = 0x509e65a8cc3cb8867dc1efeb442e72897bed01df6d9618dc672192c2d17ab1d5::two_pool::stake_and_distribute_harvested_hive_sui(arg1, arg4, arg2, arg8, arg9, v3, arg10);
            let v8 = HarvestedHiveSui<T0>{
                pool_id           : 0x2::object::uid_to_inner(&arg5.id),
                hsui_for_hive     : v6,
                hsui_for_treasury : v7,
                fee_balance_sold  : 0x2::balance::value<T0>(&v0) - 0x2::balance::value<T0>(&v4),
            };
            0x2::event::emit<HarvestedHiveSui<T0>>(v8);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T0>(arg6, v4);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T1>(arg7, v2);
        };
        if (0x1::type_name::get<T1>() != 0x1::type_name::get<0x2::sui::SUI>() && 0x1::type_name::get<T1>() != 0x1::type_name::get<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>()) {
            let v9 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::extract_fee_for_coin_3amm<T1>(&arg3.fee_claim_cap, arg7);
            let (v10, v11, v12) = swap<T0, T1, 0x2::sui::SUI, T2>(arg0, arg5, 0x2::balance::zero<T0>(), 0, v9, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
            let v13 = v11;
            let (_, v15, v16) = 0x509e65a8cc3cb8867dc1efeb442e72897bed01df6d9618dc672192c2d17ab1d5::two_pool::stake_and_distribute_harvested_hive_sui(arg1, arg4, arg2, arg8, arg9, v12, arg10);
            let v17 = HarvestedHiveSui<T1>{
                pool_id           : 0x2::object::uid_to_inner(&arg5.id),
                hsui_for_hive     : v15,
                hsui_for_treasury : v16,
                fee_balance_sold  : 0x2::balance::value<T1>(&v9) - 0x2::balance::value<T1>(&v13),
            };
            0x2::event::emit<HarvestedHiveSui<T1>>(v17);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T0>(arg6, v10);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T1>(arg7, v13);
        };
    }

    public entry fun harvest_sui_for_collected_fee_x_z<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg3: &PoolRegistry, arg4: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg5: &mut LiquidityPool<T0, 0x2::sui::SUI, T1, T2>, arg6: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::FeeCollector<T0>, arg7: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::FeeCollector<T1>, arg8: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg9: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Treasury<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg10: &mut 0x2::tx_context::TxContext) {
        if (0x1::type_name::get<T0>() != 0x1::type_name::get<0x2::sui::SUI>() && 0x1::type_name::get<T0>() != 0x1::type_name::get<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>()) {
            let v0 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::extract_fee_for_coin_3amm<T0>(&arg3.fee_claim_cap, arg6);
            let (v1, v2, v3) = swap<T0, 0x2::sui::SUI, T1, T2>(arg0, arg5, v0, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, 0x2::balance::zero<T1>(), 0, true);
            let v4 = v1;
            let (_, v6, v7) = 0x509e65a8cc3cb8867dc1efeb442e72897bed01df6d9618dc672192c2d17ab1d5::two_pool::stake_and_distribute_harvested_hive_sui(arg1, arg4, arg2, arg8, arg9, v2, arg10);
            let v8 = HarvestedHiveSui<T0>{
                pool_id           : 0x2::object::uid_to_inner(&arg5.id),
                hsui_for_hive     : v6,
                hsui_for_treasury : v7,
                fee_balance_sold  : 0x2::balance::value<T0>(&v0) - 0x2::balance::value<T0>(&v4),
            };
            0x2::event::emit<HarvestedHiveSui<T0>>(v8);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T0>(arg6, v4);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T1>(arg7, v3);
        };
        if (0x1::type_name::get<T1>() != 0x1::type_name::get<0x2::sui::SUI>() && 0x1::type_name::get<T1>() != 0x1::type_name::get<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>()) {
            let v9 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::extract_fee_for_coin_3amm<T1>(&arg3.fee_claim_cap, arg7);
            let (v10, v11, v12) = swap<T0, 0x2::sui::SUI, T1, T2>(arg0, arg5, 0x2::balance::zero<T0>(), 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, v9, 0, true);
            let v13 = v12;
            let (_, v15, v16) = 0x509e65a8cc3cb8867dc1efeb442e72897bed01df6d9618dc672192c2d17ab1d5::two_pool::stake_and_distribute_harvested_hive_sui(arg1, arg4, arg2, arg8, arg9, v11, arg10);
            let v17 = HarvestedHiveSui<T1>{
                pool_id           : 0x2::object::uid_to_inner(&arg5.id),
                hsui_for_hive     : v15,
                hsui_for_treasury : v16,
                fee_balance_sold  : 0x2::balance::value<T1>(&v9) - 0x2::balance::value<T1>(&v13),
            };
            0x2::event::emit<HarvestedHiveSui<T1>>(v17);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T0>(arg6, v10);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T1>(arg7, v13);
        };
    }

    public entry fun harvest_sui_for_collected_fee_y_z<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg3: &PoolRegistry, arg4: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg5: &mut LiquidityPool<0x2::sui::SUI, T0, T1, T2>, arg6: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::FeeCollector<T0>, arg7: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::FeeCollector<T1>, arg8: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg9: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Treasury<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg10: &mut 0x2::tx_context::TxContext) {
        if (0x1::type_name::get<T0>() != 0x1::type_name::get<0x2::sui::SUI>() && 0x1::type_name::get<T0>() != 0x1::type_name::get<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>()) {
            let v0 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::extract_fee_for_coin_3amm<T0>(&arg3.fee_claim_cap, arg6);
            let (v1, v2, v3) = swap<0x2::sui::SUI, T0, T1, T2>(arg0, arg5, 0x2::balance::zero<0x2::sui::SUI>(), 1, v0, 0, 0x2::balance::zero<T1>(), 0, true);
            let v4 = v2;
            let (_, v6, v7) = 0x509e65a8cc3cb8867dc1efeb442e72897bed01df6d9618dc672192c2d17ab1d5::two_pool::stake_and_distribute_harvested_hive_sui(arg1, arg4, arg2, arg8, arg9, v1, arg10);
            let v8 = HarvestedHiveSui<T0>{
                pool_id           : 0x2::object::uid_to_inner(&arg5.id),
                hsui_for_hive     : v6,
                hsui_for_treasury : v7,
                fee_balance_sold  : 0x2::balance::value<T0>(&v0) - 0x2::balance::value<T0>(&v4),
            };
            0x2::event::emit<HarvestedHiveSui<T0>>(v8);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T0>(arg6, v4);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T1>(arg7, v3);
        };
        if (0x1::type_name::get<T1>() != 0x1::type_name::get<0x2::sui::SUI>() && 0x1::type_name::get<T1>() != 0x1::type_name::get<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>()) {
            let v9 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::extract_fee_for_coin_3amm<T1>(&arg3.fee_claim_cap, arg7);
            let (v10, v11, v12) = swap<0x2::sui::SUI, T0, T1, T2>(arg0, arg5, 0x2::balance::zero<0x2::sui::SUI>(), 1, 0x2::balance::zero<T0>(), 0, v9, 0, true);
            let v13 = v12;
            let (_, v15, v16) = 0x509e65a8cc3cb8867dc1efeb442e72897bed01df6d9618dc672192c2d17ab1d5::two_pool::stake_and_distribute_harvested_hive_sui(arg1, arg4, arg2, arg8, arg9, v10, arg10);
            let v17 = HarvestedHiveSui<T1>{
                pool_id           : 0x2::object::uid_to_inner(&arg5.id),
                hsui_for_hive     : v15,
                hsui_for_treasury : v16,
                fee_balance_sold  : 0x2::balance::value<T1>(&v9) - 0x2::balance::value<T1>(&v13),
            };
            0x2::event::emit<HarvestedHiveSui<T1>>(v17);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T0>(arg6, v11);
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::collect_fee_for_coin<T1>(arg7, v13);
        };
    }

    fun imbalanced_exit<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &LiquidityPool<T0, T1, T2, T3>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: u64) : (u64, vector<u64>) {
        let (v0, v1) = if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_stable<T3>()) {
            let (v2, v3) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::get_cur_A_and_scaling_factors(arg0, 0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::StablePoolConfig>(&arg1.stable_config));
            let v4 = v3;
            let (v5, v6) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::imbalanced_liquidity_withdraw(v2, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(arg3), v4), (arg2 as u256), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(arg4), v4), arg5);
            let v7 = v6;
            let v0 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v0, ((*0x1::vector::borrow<u256>(&v7, 0) / *0x1::vector::borrow<u256>(&v4, 0)) as u64));
            0x1::vector::push_back<u64>(&mut v0, ((*0x1::vector::borrow<u256>(&v7, 1) / *0x1::vector::borrow<u256>(&v4, 1)) as u64));
            0x1::vector::push_back<u64>(&mut v0, ((*0x1::vector::borrow<u256>(&v7, 2) / *0x1::vector::borrow<u256>(&v4, 2)) as u64));
            (v0, (v5 as u64))
        } else {
            let v8 = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::get_scaling_factor_vec(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(&arg1.weighted_config));
            let (v9, v10) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::imbalanced_liquidity_withdraw(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(&arg1.weighted_config), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(arg3), v8), (arg2 as u256), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(arg4), v8), arg5);
            let v11 = v10;
            let v0 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v0, ((*0x1::vector::borrow<u256>(&v11, 0) / *0x1::vector::borrow<u256>(&v8, 0)) as u64));
            0x1::vector::push_back<u64>(&mut v0, ((*0x1::vector::borrow<u256>(&v11, 1) / *0x1::vector::borrow<u256>(&v8, 1)) as u64));
            0x1::vector::push_back<u64>(&mut v0, ((*0x1::vector::borrow<u256>(&v11, 2) / *0x1::vector::borrow<u256>(&v8, 2)) as u64));
            (v0, (v9 as u64))
        };
        (v1, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_pool_registry(arg0: 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::ThreeAmmFeeClaimCapability, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id                   : 0x2::object::new(arg1),
            fee_amt              : 0,
            krafted_pools_list   : 0x2::linked_table::new<PoolRegistryItem, 0x2::object::ID>(arg1),
            fee_claim_cap        : arg0,
            public_kraft_enabled : false,
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    fun internal_add_liquidity<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<T2>) : u64 {
        assert!(!arg1.is_locked, 5010);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        let v2 = 0x2::balance::value<T2>(&arg4);
        let v3 = (0x2::balance::supply_value<LP<T0, T1, T2, T3>>(&arg1.lp_supply) as u128);
        if (v3 == 0) {
            assert!(v0 > 0 && v1 > 0 && v2 > 0, 5027);
        };
        let v4 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::some<u64>(0x2::balance::value<T2>(&arg1.coin_z_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        let v5 = arg1.fee_info.total_fee_bps;
        let v6 = arg1.fee_info.hive_fee_percent;
        update_cumulative_prices<T0, T1, T2, T3>(arg0, arg1);
        let (v7, v8) = if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_curved<T3>()) {
            let v9 = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v10, v11) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::add_liquidity_computation(arg0, 0x1::option::borrow_mut<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(v4, v9), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::some<u64>(v2), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v9), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v3 as u256), 1000000000000000000, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_u256(10, (6 as u128))));
            let v12 = v11;
            let v7 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v7, ((*0x1::vector::borrow<u256>(&v12, 0) / *0x1::vector::borrow<u256>(&v9, 0)) as u64));
            0x1::vector::push_back<u64>(&mut v7, ((*0x1::vector::borrow<u256>(&v12, 1) / *0x1::vector::borrow<u256>(&v9, 1)) as u64));
            0x1::vector::push_back<u64>(&mut v7, ((*0x1::vector::borrow<u256>(&v12, 1) / *0x1::vector::borrow<u256>(&v9, 2)) as u64));
            let (v13, v14, v15, v16) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_prices_info(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v17, v18, v19, v20) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v21 = InternalPricesUpdated<T0, T1, T2, T3>{
                id                    : 0x2::object::uid_to_inner(&arg1.id),
                price_scale           : v13,
                oracle_prices         : v14,
                last_prices           : v15,
                last_prices_timestamp : v16,
                virtual_price         : v18,
                xcp_profit            : v19,
                not_adjusted          : v20,
                _D                    : v17,
            };
            0x2::event::emit<InternalPricesUpdated<T0, T1, T2, T3>>(v21);
            (v7, (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256(v10, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_u256(10, (6 as u128)), 1000000000000000000) as u64))
        } else if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_stable<T3>()) {
            let (v22, v23) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::get_cur_A_and_scaling_factors(arg0, 0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::StablePoolConfig>(&arg1.stable_config));
            let v24 = v23;
            let (v25, v26) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::add_liquidity_computation(v22, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(v4, v24), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::some<u64>(v2), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v24), v5, (v3 as u256));
            let v27 = v26;
            let v7 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v7, ((*0x1::vector::borrow<u256>(&v27, 0) / *0x1::vector::borrow<u256>(&v24, 0)) as u64));
            0x1::vector::push_back<u64>(&mut v7, ((*0x1::vector::borrow<u256>(&v27, 1) / *0x1::vector::borrow<u256>(&v24, 1)) as u64));
            0x1::vector::push_back<u64>(&mut v7, ((*0x1::vector::borrow<u256>(&v27, 2) / *0x1::vector::borrow<u256>(&v24, 2)) as u64));
            (v7, (v25 as u64))
        } else {
            let v28 = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::get_scaling_factor_vec(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(&arg1.weighted_config));
            let (v29, v30) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::add_liquidity_computation(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(&arg1.weighted_config), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(v4, v28), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::some<u64>(v2), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v28), v5, (v3 as u256));
            let v31 = v30;
            let v7 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v7, ((*0x1::vector::borrow<u256>(&v31, 0) / *0x1::vector::borrow<u256>(&v28, 0)) as u64));
            0x1::vector::push_back<u64>(&mut v7, ((*0x1::vector::borrow<u256>(&v31, 1) / *0x1::vector::borrow<u256>(&v28, 1)) as u64));
            0x1::vector::push_back<u64>(&mut v7, ((*0x1::vector::borrow<u256>(&v31, 2) / *0x1::vector::borrow<u256>(&v28, 2)) as u64));
            (v7, (v29 as u64))
        };
        assert!(v8 > 0, 5008);
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, arg2);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, arg3);
        0x2::balance::join<T2>(&mut arg1.coin_z_reserve, arg4);
        let v32 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v7, 0));
        let v33 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v7, 1));
        let v34 = 0x2::balance::split<T2>(&mut arg1.coin_z_reserve, *0x1::vector::borrow<u64>(&v7, 2));
        let v35 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(*0x1::vector::borrow<u64>(&v7, 0), v6, 100);
        let v36 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(*0x1::vector::borrow<u64>(&v7, 1), v6, 100);
        let v37 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(*0x1::vector::borrow<u64>(&v7, 2), v6, 100);
        0x2::balance::join<T0>(&mut arg1.hive_x, 0x2::balance::split<T0>(&mut v32, v35));
        0x2::balance::join<T1>(&mut arg1.hive_y, 0x2::balance::split<T1>(&mut v33, v36));
        0x2::balance::join<T2>(&mut arg1.hive_z, 0x2::balance::split<T2>(&mut v34, v37));
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, v32);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, v33);
        0x2::balance::join<T2>(&mut arg1.coin_z_reserve, v34);
        let v38 = LiquidityAddedToPool<T0, T1, T2, T3>{
            id            : 0x2::object::uid_to_inner(&arg1.id),
            coin_x_amount : v0,
            coin_y_amount : v1,
            coin_z_amount : v2,
            lp_minted     : v8,
            total_x_fee   : *0x1::vector::borrow<u64>(&v7, 0),
            total_y_fee   : *0x1::vector::borrow<u64>(&v7, 1),
            total_z_fee   : *0x1::vector::borrow<u64>(&v7, 2),
            x_hive_fee    : v35,
            y_hive_fee    : v36,
            z_hive_fee    : v37,
        };
        0x2::event::emit<LiquidityAddedToPool<T0, T1, T2, T3>>(v38);
        update_cumulative_prices<T0, T1, T2, T3>(arg0, arg1);
        v8
    }

    fun internal_register_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg3: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: u8, arg8: u8, arg9: u8, arg10: vector<u64>, arg11: 0x1::option::Option<vector<u256>>, arg12: 0x1::option::Option<vector<u64>>, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::deposit_hsui_for_hive<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>(arg5, 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg6, arg4.fee_amt), 0x1::option::none<address>(), arg13));
        0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::assert_valid_curve<T3>();
        let v0 = 0x2::object::new(arg13);
        registry_add<T0, T1, T2, T3>(arg4, arg3, arg7, arg8, arg9, 0x2::object::uid_to_inner(&v0));
        let (v1, v2) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::get_fee_info<T3>(arg3);
        let v3 = NewPoolCreated<T0, T1, T2, T3>{pool_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<NewPoolCreated<T0, T1, T2, T3>>(v3);
        let v4 = LP<T0, T1, T2, T3>{dummy_field: false};
        let v5 = PoolFeeInfo{
            total_fee_bps    : v1,
            hive_fee_percent : v2,
        };
        let v6 = LiquidityPool<T0, T1, T2, T3>{
            id                   : v0,
            coin_x_reserve       : 0x2::balance::zero<T0>(),
            coin_x_decimals      : arg7,
            coin_y_reserve       : 0x2::balance::zero<T1>(),
            coin_y_decimals      : arg8,
            coin_z_reserve       : 0x2::balance::zero<T2>(),
            coin_z_decimals      : arg9,
            lp_supply            : 0x2::balance::create_supply<LP<T0, T1, T2, T3>>(v4),
            curved_config        : 0x1::option::none<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(),
            stable_config        : 0x1::option::none<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::StablePoolConfig>(),
            weighted_config      : 0x1::option::none<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(),
            hive_x               : 0x2::balance::zero<T0>(),
            hive_y               : 0x2::balance::zero<T1>(),
            hive_z               : 0x2::balance::zero<T2>(),
            fee_info             : v5,
            is_locked            : false,
            cumulative_x_price_y : 0,
            cumulative_y_price_x : 0,
            cumulative_x_price_z : 0,
            cumulative_z_price_x : 0,
            cumulative_y_price_z : 0,
            cumulative_z_price_y : 0,
            last_timestamp       : 0x2::clock::timestamp_ms(arg0),
            pool_hive_addr       : 0x1::option::none<address>(),
        };
        let v7 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v7, 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::computeScalingFactor(arg7));
        0x1::vector::push_back<u256>(&mut v7, 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::computeScalingFactor(arg8));
        0x1::vector::push_back<u256>(&mut v7, 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::computeScalingFactor(arg9));
        if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_curved<T3>()) {
            assert!(0x1::option::is_some<vector<u256>>(&arg11), 5004);
            v6.curved_config = 0x1::option::some<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::initialize_curved_config(arg0, arg10, 0x1::option::extract<vector<u256>>(&mut arg11), v7, (3 as u128), arg13));
        } else if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_stable<T3>()) {
            assert!(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::is_sorted_3<T0, T1, T2>(), 5007);
            v6.stable_config = 0x1::option::some<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::StablePoolConfig>(0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::initialize_stable_config(arg0, arg10, v7, arg13));
        } else {
            assert!(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_weighted<T3>(), 5021);
            assert!(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::is_sorted_3<T0, T1, T2>(), 5007);
            assert!(0x1::option::is_some<vector<u64>>(&arg12), 5005);
            v6.weighted_config = 0x1::option::some<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::initialize_weighted_config(arg10, 0x1::option::extract<vector<u64>>(&mut arg12), v7, (3 as u64), arg13));
        };
        0x2::transfer::share_object<LiquidityPool<T0, T1, T2, T3>>(v6);
        if (!0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::is_fee_collector_present<T0>(arg3)) {
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::create_fee_collector<T0>(arg3, arg13);
        };
        if (!0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::is_fee_collector_present<T1>(arg3)) {
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::create_fee_collector<T1>(arg3, arg13);
        };
        if (!0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::is_fee_collector_present<T2>(arg3)) {
            0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::create_fee_collector<T2>(arg3, arg13);
        };
        arg6
    }

    fun internal_remove_liquidity<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2, T3>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, u64) {
        let v0 = (0x2::balance::supply_value<LP<T0, T1, T2, T3>>(&arg1.lp_supply) as u128);
        assert!(!arg1.is_locked, 5010);
        let v1 = 0x2::balance::value<T0>(&arg1.coin_x_reserve);
        let v2 = 0x2::balance::value<T1>(&arg1.coin_y_reserve);
        let v3 = 0x2::balance::value<T2>(&arg1.coin_z_reserve);
        let v4 = arg1.fee_info.total_fee_bps;
        let v5 = arg1.fee_info.hive_fee_percent;
        let v6 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_create_u64(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg4), 0x1::option::some<u64>(arg5), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v7 = arg2;
        let v8 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::create_zero_vector(3);
        update_cumulative_prices<T0, T1, T2, T3>(arg0, arg1);
        if (arg3 == 0 && arg4 == 0 && arg5 == 0) {
            *0x1::vector::borrow_mut<u64>(&mut v6, 0) = (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((arg2 as u256), (v1 as u256), (v0 as u256)) as u64);
            *0x1::vector::borrow_mut<u64>(&mut v6, 1) = (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((arg2 as u256), (v2 as u256), (v0 as u256)) as u64);
            *0x1::vector::borrow_mut<u64>(&mut v6, 2) = (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((arg2 as u256), (v3 as u256), (v0 as u256)) as u64);
            if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_curved<T3>()) {
                0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::reduce_d(0x1::option::borrow_mut<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_u256(10, (6 as u128))), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v0 as u256), 1000000000000000000, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_u256(10, (6 as u128))));
            };
        } else if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_curved<T3>()) {
            let (v9, v10) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::get_non_zero_count_and_index(v6);
            assert!(v9 == 1, 5012);
            let v11 = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            *0x1::vector::borrow_mut<u64>(&mut v6, v10) = ((0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::calc_withdraw_one_coin(arg0, 0x1::option::borrow_mut<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_create_u64(0x1::option::some<u64>(v1), 0x1::option::some<u64>(v2), 0x1::option::some<u64>(v3), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v11), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v0 as u256), 1000000000000000000, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_u256(10, (6 as u128))), v10, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_u256(10, (6 as u128))), false, true) / *0x1::vector::borrow<u256>(&v11, v10)) as u64);
            assert!(*0x1::vector::borrow_mut<u64>(&mut v6, v10) > *0x1::vector::borrow<u64>(&v6, v10), 5026);
            let (v12, v13, v14, v15) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_prices_info(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v16, v17, v18, v19) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v20 = InternalPricesUpdated<T0, T1, T2, T3>{
                id                    : 0x2::object::uid_to_inner(&arg1.id),
                price_scale           : v12,
                oracle_prices         : v13,
                last_prices           : v14,
                last_prices_timestamp : v15,
                virtual_price         : v17,
                xcp_profit            : v18,
                not_adjusted          : v19,
                _D                    : v16,
            };
            0x2::event::emit<InternalPricesUpdated<T0, T1, T2, T3>>(v20);
        } else {
            let (v21, v22) = imbalanced_exit<T0, T1, T2, T3>(arg0, arg1, (v0 as u64), 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_create_u64(0x1::option::some<u64>(v1), 0x1::option::some<u64>(v2), 0x1::option::some<u64>(v3), 0x1::option::none<u64>(), 0x1::option::none<u64>()), v6, v4);
            v8 = v22;
            v7 = v21;
        };
        assert!(v7 > 0, 5011);
        let v23 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v6, 0));
        let v24 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v6, 1));
        let v25 = 0x2::balance::split<T2>(&mut arg1.coin_z_reserve, *0x1::vector::borrow<u64>(&v6, 2));
        if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_weighted<T3>()) {
            let v26 = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::get_exit_fee(0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(&arg1.weighted_config));
            *0x1::vector::borrow_mut<u64>(&mut v8, 0) = *0x1::vector::borrow<u64>(&v8, 0) + 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(*0x1::vector::borrow<u64>(&v6, 0), v26, 10000);
            *0x1::vector::borrow_mut<u64>(&mut v8, 1) = *0x1::vector::borrow<u64>(&v8, 1) + 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(*0x1::vector::borrow<u64>(&v6, 1), v26, 10000);
            *0x1::vector::borrow_mut<u64>(&mut v8, 2) = *0x1::vector::borrow<u64>(&v8, 2) + 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(*0x1::vector::borrow<u64>(&v6, 2), v26, 10000);
        };
        let v27 = if (0x2::balance::value<T0>(&v23) >= *0x1::vector::borrow<u64>(&v8, 0)) {
            0x2::balance::split<T0>(&mut v23, *0x1::vector::borrow<u64>(&v8, 0))
        } else {
            0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v8, 0))
        };
        let v28 = if (0x2::balance::value<T1>(&v24) >= *0x1::vector::borrow<u64>(&v8, 1)) {
            0x2::balance::split<T1>(&mut v24, *0x1::vector::borrow<u64>(&v8, 1))
        } else {
            0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v8, 1))
        };
        let v29 = if (0x2::balance::value<T2>(&v25) >= *0x1::vector::borrow<u64>(&v8, 2)) {
            0x2::balance::split<T2>(&mut v25, *0x1::vector::borrow<u64>(&v8, 2))
        } else {
            0x2::balance::split<T2>(&mut arg1.coin_z_reserve, *0x1::vector::borrow<u64>(&v8, 2))
        };
        let v30 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(*0x1::vector::borrow<u64>(&v8, 0), v5, 100);
        let v31 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(*0x1::vector::borrow<u64>(&v8, 1), v5, 100);
        let v32 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(*0x1::vector::borrow<u64>(&v8, 2), v5, 100);
        0x2::balance::join<T0>(&mut arg1.hive_x, 0x2::balance::split<T0>(&mut v27, v30));
        0x2::balance::join<T1>(&mut arg1.hive_y, 0x2::balance::split<T1>(&mut v28, v31));
        0x2::balance::join<T2>(&mut arg1.hive_z, 0x2::balance::split<T2>(&mut v29, v32));
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, v27);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, v28);
        0x2::balance::join<T2>(&mut arg1.coin_z_reserve, v29);
        let v33 = LiquidityRemovedFromPool<T0, T1, T2, T3>{
            id            : 0x2::object::uid_to_inner(&arg1.id),
            coin_x_amount : *0x1::vector::borrow<u64>(&v6, 0),
            coin_y_amount : *0x1::vector::borrow<u64>(&v6, 1),
            coin_z_amount : *0x1::vector::borrow<u64>(&v6, 2),
            lp_burned     : v7,
            total_x_fee   : *0x1::vector::borrow<u64>(&v8, 0),
            total_y_fee   : *0x1::vector::borrow<u64>(&v8, 1),
            total_z_fee   : *0x1::vector::borrow<u64>(&v8, 2),
            x_hive_fee    : v30,
            y_hive_fee    : v31,
            z_hive_fee    : v32,
        };
        0x2::event::emit<LiquidityRemovedFromPool<T0, T1, T2, T3>>(v33);
        (v23, v24, v25, arg2 - v7)
    }

    public entry fun is_pool_registered<T0, T1, T2, T3>(arg0: &PoolRegistry) : bool {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            c     : 0x1::type_name::get<T2>(),
            curve : 0x1::type_name::get<T3>(),
        };
        0x2::linked_table::contains<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0)
    }

    public fun pay_flashloan<T0, T1, T2, T3>(arg0: &mut LiquidityPool<T0, T1, T2, T3>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T2>, arg4: Flashloan<T0, T1, T2, T3>) {
        assert!(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::is_sorted_3<T0, T1, T2>(), 5007);
        let Flashloan {
            x_loan : v0,
            y_loan : v1,
            z_loan : v2,
        } = arg4;
        let v3 = 0x2::balance::value<T0>(&arg1);
        let v4 = 0x2::balance::value<T1>(&arg2);
        let v5 = 0x2::balance::value<T2>(&arg3);
        assert!(v3 >= v0 && v4 >= v1 && v5 >= v2, 5020);
        let v6 = arg0.fee_info.total_fee_bps;
        let v7 = arg0.fee_info.hive_fee_percent;
        let v8 = (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v3 as u256), (v6 as u256), (10000 as u256)) as u64);
        let v9 = (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v4 as u256), (v6 as u256), (10000 as u256)) as u64);
        let v10 = (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v5 as u256), (v6 as u256), (10000 as u256)) as u64);
        let v11 = 0x2::balance::split<T0>(&mut arg1, v8);
        let v12 = 0x2::balance::split<T1>(&mut arg2, v9);
        let v13 = 0x2::balance::split<T2>(&mut arg3, v10);
        let v14 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(v8, v7, 10000);
        let v15 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(v9, v7, 10000);
        let v16 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(v10, v7, 10000);
        0x2::balance::join<T0>(&mut arg0.hive_x, 0x2::balance::split<T0>(&mut v11, v14));
        0x2::balance::join<T1>(&mut arg0.hive_y, 0x2::balance::split<T1>(&mut v12, v15));
        0x2::balance::join<T2>(&mut arg0.hive_z, 0x2::balance::split<T2>(&mut v13, v16));
        0x2::balance::join<T0>(&mut arg0.coin_x_reserve, arg1);
        0x2::balance::join<T1>(&mut arg0.coin_y_reserve, arg2);
        0x2::balance::join<T2>(&mut arg0.coin_z_reserve, arg3);
        0x2::balance::join<T0>(&mut arg0.coin_x_reserve, v11);
        0x2::balance::join<T1>(&mut arg0.coin_y_reserve, v12);
        0x2::balance::join<T2>(&mut arg0.coin_z_reserve, v13);
        let v17 = FlashLoanExecuted<T0, T1, T2, T3>{
            id          : 0x2::object::uid_to_inner(&arg0.id),
            x_loan      : v0,
            y_loan      : v1,
            z_loan      : v2,
            total_x_fee : v8,
            total_y_fee : v9,
            total_z_fee : v10,
            x_hive_fee  : v14,
            y_hive_fee  : v15,
            z_hive_fee  : v16,
        };
        0x2::event::emit<FlashLoanExecuted<T0, T1, T2, T3>>(v17);
        arg0.is_locked = false;
    }

    public fun query_across_all_pools<T0, T1, T2, T3>(arg0: &PoolRegistry, arg1: u64) : (vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            c     : 0x1::type_name::get<T2>(),
            curve : 0x1::type_name::get<T3>(),
        };
        let v6 = 0x1::option::some<PoolRegistryItem>(v5);
        let v7 = 0;
        while (0x1::option::is_some<PoolRegistryItem>(&v6) && v7 < arg1) {
            let v8 = *0x1::option::borrow<PoolRegistryItem>(&v6);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::from_ascii(0x1::type_name::into_string(v8.a)));
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::from_ascii(0x1::type_name::into_string(v8.b)));
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::from_ascii(0x1::type_name::into_string(v8.c)));
            0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::from_ascii(0x1::type_name::into_string(v8.curve)));
            0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v8)));
            v6 = *0x2::linked_table::next<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v8);
            v7 = v7 + 1;
        };
        (v1, v2, v3, v4, v0, 0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list))
    }

    public fun query_first_pool(arg0: &PoolRegistry) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, address, u64) {
        let v0 = *0x2::linked_table::front<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list);
        let v1 = *0x1::option::borrow<PoolRegistryItem>(&v0);
        (0x1::string::from_ascii(0x1::type_name::into_string(v1.a)), 0x1::string::from_ascii(0x1::type_name::into_string(v1.b)), 0x1::string::from_ascii(0x1::type_name::into_string(v1.c)), 0x1::string::from_ascii(0x1::type_name::into_string(v1.curve)), 0x2::object::id_to_address(0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v1)), 0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list))
    }

    public entry fun query_swap<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &LiquidityPool<T0, T1, T2, T3>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        if (arg1.is_locked) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5010)
        };
        let (v0, v1, v2) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::get_asset_index_and_amount(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::create_vector(0x1::option::some<u64>(arg2), 0x1::option::some<u64>(arg4), 0x1::option::some<u64>(arg6), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        if (v2) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5013)
        };
        let (v3, v4, v5) = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::get_asset_index_and_amount(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::create_vector(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg5), 0x1::option::some<u64>(arg7), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        if (v5) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5015)
        };
        if (v1 == v4) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5015)
        };
        let v6 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::some<u64>(0x2::balance::value<T2>(&arg1.coin_z_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        if (v3 > *0x1::vector::borrow<u64>(&v6, v4)) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5025)
        };
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_curved<T3>()) {
            let v10 = 0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg1.curved_config);
            let v11 = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::get_curved_config_scaling_factor(v10);
            let v12 = *0x1::vector::borrow<u256>(&v11, v4);
            if (arg8) {
                v7 = v0;
                let (v13, v14) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::query_ask_amount(arg0, v10, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(v6), v11), (v0 as u256) * *0x1::vector::borrow<u256>(&v11, v1), v1, v4);
                v8 = ((v13 / v12) as u64);
                v9 = ((v14 / v12) as u64);
            } else {
                let (v15, v16) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::query_offer_amount(arg0, v10, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(v6), v11), (v3 as u256) * v12, v1, v4);
                v7 = ((v15 / *0x1::vector::borrow<u256>(&v11, v1)) as u64);
                let v17 = ((v16 / v12) as u64);
                v9 = v17;
                v8 = v3 + v17;
            };
        } else if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_stable<T3>()) {
            let (v18, v19) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::get_cur_A_and_scaling_factors(arg0, 0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::StablePoolConfig>(&arg1.stable_config));
            let v20 = v19;
            let v21 = *0x1::vector::borrow<u256>(&v20, v4);
            if (arg8) {
                v7 = v0;
                let v22 = ((0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::compute_ask_amount(v18, v1, (v0 as u256) * *0x1::vector::borrow<u256>(&v20, v1), v4, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(v6), v20)) / v21) as u64);
                v8 = v22;
                v9 = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div(arg1.fee_info.total_fee_bps, v22, 10000);
            } else {
                let (v23, v24) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::compute_offer_amount(v18, (v3 as u256) * v21, v4, v1, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::multiply_vectors_u256(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::vector_u64_to_u256(v6), v20), arg1.fee_info.total_fee_bps);
                v7 = ((v23 / *0x1::vector::borrow<u256>(&v20, v1)) as u64);
                let v25 = ((v24 / v21) as u64);
                v9 = v25;
                v8 = v3 + v25;
            };
        } else if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_weighted<T3>()) {
            let v26 = 0x1::option::borrow<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(&arg1.weighted_config);
            let (v27, v28) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::get_weight_and_sf_at_index(v26, v1, true);
            let (v29, v30) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::get_weight_and_sf_at_index(v26, v4, true);
            if (arg8) {
                v7 = v0;
                let v31 = ((0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::compute_ask_amount((v0 as u256) * v28, (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v28, (v27 as u256), (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v30, (v29 as u256)) / v30) as u64);
                v8 = v31;
                v9 = (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((arg1.fee_info.total_fee_bps as u256), (v31 as u256), (10000 as u256)) as u64);
            } else {
                let (v32, v33) = 0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::compute_offer_amount((v3 as u256) * v30, (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v30, (v29 as u256), (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v28, (v27 as u256), arg1.fee_info.total_fee_bps);
                v7 = ((v32 / v28) as u64);
                let v34 = ((v33 / v30) as u64);
                v9 = v34;
                v8 = v3 + v34;
            };
        };
        if (v8 < v3) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5017)
        };
        if (v7 > v0) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 5018)
        };
        let v35 = 0;
        let v36 = 0;
        let v37 = 0;
        let v38 = 0;
        let v39 = 0;
        let v40 = 0;
        let v41 = 0;
        let v42 = 0;
        let v43 = 0;
        if (v1 == 0 && v4 == 1) {
            v35 = v7;
            v39 = v8 - v9;
            v40 = v9;
        } else if (v1 == 0 && v4 == 2) {
            v35 = v7;
            v42 = v8 - v9;
            v43 = v9;
        } else if (v1 == 1 && v4 == 0) {
            v38 = v7;
            v36 = v8 - v9;
            v37 = v9;
        } else if (v1 == 1 && v4 == 2) {
            v38 = v7;
            v42 = v8 - v9;
            v43 = v9;
        } else if (v1 == 2 && v4 == 0) {
            v41 = v7;
            v36 = v8 - v9;
            v37 = v9;
        } else if (v1 == 2 && v4 == 1) {
            v41 = v7;
            v39 = v8 - v9;
            v40 = v9;
        };
        (v35, v36, v37, v38, v39, v40, v41, v42, v43, 0)
    }

    public fun register_pool_all_coin_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg3: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: &0x2::coin::CoinMetadata<T2>, arg10: vector<u64>, arg11: 0x1::option::Option<vector<u256>>, arg12: 0x1::option::Option<vector<u64>>, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        internal_register_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::get_decimals<T0>(arg7), 0x2::coin::get_decimals<T1>(arg8), 0x2::coin::get_decimals<T2>(arg9), arg10, arg11, arg12, arg13)
    }

    public fun register_pool_no_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg3: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T0>(arg3);
        let v1 = get_decimal_for_coin<T1>(arg3);
        let v2 = get_decimal_for_coin<T2>(arg3);
        internal_register_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, v1, v2, arg7, arg8, arg9, arg10)
    }

    public fun register_pool_x_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg3: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: vector<u64>, arg9: 0x1::option::Option<vector<u256>>, arg10: 0x1::option::Option<vector<u64>>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T1>(arg3);
        let v1 = get_decimal_for_coin<T2>(arg3);
        internal_register_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::get_decimals<T0>(arg7), v0, v1, arg8, arg9, arg10, arg11)
    }

    public fun register_pool_x_y_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg3: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: vector<u64>, arg10: 0x1::option::Option<vector<u256>>, arg11: 0x1::option::Option<vector<u64>>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T2>(arg3);
        internal_register_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::get_decimals<T0>(arg7), 0x2::coin::get_decimals<T1>(arg8), v0, arg9, arg10, arg11, arg12)
    }

    public fun register_pool_x_z_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg3: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T2>, arg9: vector<u64>, arg10: 0x1::option::Option<vector<u256>>, arg11: 0x1::option::Option<vector<u64>>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T1>(arg3);
        internal_register_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::get_decimals<T0>(arg7), v0, 0x2::coin::get_decimals<T2>(arg8), arg9, arg10, arg11, arg12)
    }

    public fun register_pool_y_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg3: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: vector<u64>, arg9: 0x1::option::Option<vector<u256>>, arg10: 0x1::option::Option<vector<u64>>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T0>(arg3);
        let v1 = get_decimal_for_coin<T2>(arg3);
        internal_register_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, 0x2::coin::get_decimals<T1>(arg7), v1, arg8, arg9, arg10, arg11)
    }

    public fun register_pool_y_z_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg3: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: &0x2::coin::CoinMetadata<T2>, arg9: vector<u64>, arg10: 0x1::option::Option<vector<u256>>, arg11: 0x1::option::Option<vector<u64>>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T0>(arg3);
        internal_register_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, 0x2::coin::get_decimals<T1>(arg7), 0x2::coin::get_decimals<T2>(arg8), arg9, arg10, arg11, arg12)
    }

    public fun register_pool_z_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x313f1bbebbc5125e304e04166e4f54d72f264d07b43b5617dc213fc2fd039d1::hsui_vault::HSuiVault, arg3: &mut 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0x6e01c9f3bad43c724f17f1605df882ea2b9d850840609a40db4f333587d73836::hive_profile::HSuiDisperser<0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T2>, arg8: vector<u64>, arg9: 0x1::option::Option<vector<u256>>, arg10: 0x1::option::Option<vector<u64>>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T0>(arg3);
        let v1 = get_decimal_for_coin<T1>(arg3);
        internal_register_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, v1, 0x2::coin::get_decimals<T2>(arg7), arg8, arg9, arg10, arg11)
    }

    fun registry_add<T0, T1, T2, T3>(arg0: &mut PoolRegistry, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::Config, arg2: u8, arg3: u8, arg4: u8, arg5: 0x2::object::ID) {
        if (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::curves::is_curved<T3>()) {
            assert!(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::valid_curved_coins_3_pool<T0, T1, T2>(arg1), 5006);
        } else {
            assert!(0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::coin_helper::is_sorted_3<T0, T1, T2>(), 5007);
        };
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            c     : 0x1::type_name::get<T2>(),
            curve : 0x1::type_name::get<T3>(),
        };
        assert!(!0x2::linked_table::contains<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0), 5003);
        0x2::linked_table::push_back<PoolRegistryItem, 0x2::object::ID>(&mut arg0.krafted_pools_list, v0, arg5);
    }

    public fun remove_liquidity<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::balance::Balance<LP<T0, T1, T2, T3>>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<LP<T0, T1, T2, T3>>) {
        let v0 = 0x2::balance::value<LP<T0, T1, T2, T3>>(&arg2);
        let (v1, v2, v3, v4) = internal_remove_liquidity<T0, T1, T2, T3>(arg0, arg1, v0, arg3, arg4, arg5);
        let v5 = v0 - v4;
        if (arg6 > 0) {
            assert!(v5 <= arg6, 5016);
        };
        0x2::balance::decrease_supply<LP<T0, T1, T2, T3>>(&mut arg1.lp_supply, 0x2::balance::split<LP<T0, T1, T2, T3>>(&mut arg2, v5));
        (v1, v2, v3, arg2)
    }

    public fun set_pool_hive_addr<T0, T1, T2, T3>(arg0: &mut LiquidityPool<T0, T1, T2, T3>, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::DexDaoCapability, arg2: address) {
        assert!(!0x1::option::is_some<address>(&arg0.pool_hive_addr), 5024);
        arg0.pool_hive_addr = 0x1::option::some<address>(arg2);
    }

    fun update_cumulative_prices<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2, T3>) {
        let v0 = 0x2::clock::timestamp_ms(arg0) - arg1.last_timestamp;
        let v1 = 0x2::balance::value<T0>(&arg1.coin_x_reserve);
        let v2 = 0x2::balance::value<T1>(&arg1.coin_y_reserve);
        let v3 = 0x2::balance::value<T2>(&arg1.coin_z_reserve);
        if (v0 > 0 && v1 != 0 && v2 != 0 && v3 != 0) {
            arg1.cumulative_x_price_y = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::overflow_add_u256(arg1.cumulative_x_price_y, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v2 as u256), (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_10(6) as u256), (v1 as u256)) * (v0 as u256));
            arg1.cumulative_y_price_x = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::overflow_add_u256(arg1.cumulative_y_price_x, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v1 as u256), (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_10(6) as u256), (v2 as u256)) * (v0 as u256));
            arg1.cumulative_x_price_z = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::overflow_add_u256(arg1.cumulative_x_price_z, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v3 as u256), (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_10(6) as u256), (v1 as u256)) * (v0 as u256));
            arg1.cumulative_z_price_x = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::overflow_add_u256(arg1.cumulative_z_price_x, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v1 as u256), (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_10(6) as u256), (v3 as u256)) * (v0 as u256));
            arg1.cumulative_y_price_z = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::overflow_add_u256(arg1.cumulative_y_price_z, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v3 as u256), (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_10(6) as u256), (v2 as u256)) * (v0 as u256));
            arg1.cumulative_z_price_y = 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::overflow_add_u256(arg1.cumulative_z_price_y, 0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::mul_div_u256((v2 as u256), (0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::math::pow_10(6) as u256), (v3 as u256)) * (v0 as u256));
            arg1.last_timestamp = 0x2::clock::timestamp_ms(arg0);
        };
        let v4 = CumPriceUpdatedEvent<T0, T1, T2, T3>{
            id                   : 0x2::object::uid_to_inner(&arg1.id),
            cumulative_x_price_y : arg1.cumulative_x_price_y,
            cumulative_y_price_x : arg1.cumulative_y_price_x,
            cumulative_x_price_z : arg1.cumulative_x_price_z,
            cumulative_z_price_x : arg1.cumulative_z_price_x,
            cumulative_y_price_z : arg1.cumulative_y_price_z,
            cumulative_z_price_y : arg1.cumulative_z_price_y,
            timestamp            : arg1.last_timestamp,
        };
        0x2::event::emit<CumPriceUpdatedEvent<T0, T1, T2, T3>>(v4);
    }

    public entry fun update_curved_A_and_gamma<T0, T1, T2, T3>(arg0: &mut LiquidityPool<T0, T1, T2, T3>, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::DexDaoCapability, arg2: u64, arg3: u64, arg4: u256, arg5: u64) {
        assert!(0x1::option::is_some<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg0.curved_config), 5022);
        0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::update_A_and_gamma(0x1::option::borrow_mut<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&mut arg0.curved_config), arg2, arg3, arg4, arg5);
        let v0 = CurvedConfigUpdatedAmp<T0, T1, T2, T3>{
            id                  : 0x2::object::uid_to_inner(&arg0.id),
            init_A_gamma_time   : arg2,
            next_amp            : arg3,
            next_gamma          : arg4,
            future_A_gamma_time : arg5,
        };
        0x2::event::emit<CurvedConfigUpdatedAmp<T0, T1, T2, T3>>(v0);
    }

    public entry fun update_curved_config_fee_params<T0, T1, T2, T3>(arg0: &mut LiquidityPool<T0, T1, T2, T3>, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::DexDaoCapability, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(0x1::option::is_some<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&arg0.curved_config), 5022);
        0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::update_config_fee_params(0x1::option::borrow_mut<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::curved_math::CurvedPoolConfig>(&mut arg0.curved_config), arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = CurvedConfigUpdatedParams<T0, T1, T2, T3>{
            id                       : 0x2::object::uid_to_inner(&arg0.id),
            new_mid_fee              : arg2,
            new_out_fee              : arg3,
            new_fee_gamma            : arg4,
            new_ma_half_time         : arg5,
            new_allowed_extra_profit : arg6,
            new_adjustment_step      : arg7,
        };
        0x2::event::emit<CurvedConfigUpdatedParams<T0, T1, T2, T3>>(v0);
    }

    public fun update_fee_for_pool<T0, T1, T2, T3>(arg0: &mut LiquidityPool<T0, T1, T2, T3>, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::DexDaoCapability, arg2: u64, arg3: u64) {
        assert!(arg2 >= 1 && arg2 <= 300, 5000);
        assert!(arg3 >= 30 && arg3 <= 70, 5023);
        arg0.fee_info.total_fee_bps = arg2;
        arg0.fee_info.hive_fee_percent = arg3;
        let v0 = PoolFeeUpdated{
            id               : 0x2::object::uid_to_inner(&arg0.id),
            total_fee_bps    : arg2,
            hive_fee_percent : arg3,
        };
        0x2::event::emit<PoolFeeUpdated>(v0);
    }

    public fun update_pool_kraft_fee(arg0: &mut PoolRegistry, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::HiveDaoCapability, arg2: u64) {
        assert!(arg2 <= 50000000000, 5000);
        arg0.fee_amt = arg2;
        let v0 = PoolKraftingFeeUpdated{fee: arg2};
        0x2::event::emit<PoolKraftingFeeUpdated>(v0);
    }

    public entry fun update_stable_config<T0, T1, T2, T3>(arg0: &mut LiquidityPool<T0, T1, T2, T3>, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::DexDaoCapability, arg2: u64, arg3: u64, arg4: u64) {
        assert!(0x1::option::is_some<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::StablePoolConfig>(&arg0.stable_config), 5022);
        0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::update_stable_config(0x1::option::borrow_mut<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::stable_math::StablePoolConfig>(&mut arg0.stable_config), arg3, arg2, arg4);
        let v0 = StableConfigUpdated<T0, T1, T2, T3>{
            id            : 0x2::object::uid_to_inner(&arg0.id),
            init_amp_time : arg3,
            next_amp      : arg2,
            next_amp_time : arg4,
        };
        0x2::event::emit<StableConfigUpdated<T0, T1, T2, T3>>(v0);
    }

    public entry fun update_weighted_config<T0, T1, T2, T3>(arg0: &mut LiquidityPool<T0, T1, T2, T3>, arg1: &0x6c981865f9945278a43801b6bc294ecad49dd84b215bc9e2fbbf987c4c4b8291::config::DexDaoCapability, arg2: vector<u64>, arg3: u64) {
        assert!(0x1::option::is_some<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(&arg0.weighted_config), 5022);
        0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::update_weighted_config(0x1::option::borrow_mut<0xed3dfc0c70823687ae6fd5d390119e360d87dc8370bd099fd23dcab4472588dc::weighted_math::WeightedConfig>(&mut arg0.weighted_config), arg2, arg3);
        let v0 = WeightedConfigUpdated<T0, T1, T2, T3>{
            id           : 0x2::object::uid_to_inner(&arg0.id),
            new_weights  : arg2,
            new_exit_fee : arg3,
        };
        0x2::event::emit<WeightedConfigUpdated<T0, T1, T2, T3>>(v0);
    }

    // decompiled from Move bytecode v6
}

