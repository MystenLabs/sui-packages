module 0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool {
    struct LP<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        fee_amt: u64,
        krafted_pools_list: 0x2::linked_table::LinkedTable<PoolRegistryItem, 0x2::object::ID>,
        fee_claim_cap: 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::TwoAmmFeeClaimCapability,
        x_hive_pool_addr: 0x1::option::Option<address>,
        public_kraft_enabled: bool,
    }

    struct PoolRegistryItem has copy, drop, store {
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
        curve: 0x1::type_name::TypeName,
    }

    struct LiquidityPool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        coin_x_reserve: 0x2::balance::Balance<T0>,
        coin_x_decimals: u8,
        coin_y_reserve: 0x2::balance::Balance<T1>,
        coin_y_decimals: u8,
        lp_supply: 0x2::balance::Supply<LP<T0, T1, T2>>,
        curved_config: 0x1::option::Option<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>,
        stable_config: 0x1::option::Option<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::StablePoolConfig>,
        weighted_config: 0x1::option::Option<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>,
        hive_x: 0x2::balance::Balance<T0>,
        hive_y: 0x2::balance::Balance<T1>,
        fee_info: PoolFeeInfo,
        is_locked: bool,
        cumulative_x_price: u256,
        cumulative_y_price: u256,
        last_timestamp: u64,
        pool_hive_addr: 0x1::option::Option<address>,
    }

    struct PoolFeeInfo has store {
        total_fee_bps: u64,
        hive_fee_percent: u64,
    }

    struct Flashloan<phantom T0, phantom T1, phantom T2> {
        x_loan: u64,
        y_loan: u64,
    }

    struct X_HIVE_Pool_Krafted has copy, drop {
        x_hive_pool_addr: address,
    }

    struct PoolKraftingFeeUpdated has copy, drop {
        fee: u64,
    }

    struct StableConfigUpdated<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        init_amp_time: u64,
        next_amp: u64,
        next_amp_time: u64,
    }

    struct WeightedConfigUpdated<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        new_weights: vector<u64>,
        new_exit_fee: u64,
    }

    struct CurvedConfigUpdatedAmp<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        init_A_gamma_time: u64,
        next_amp: u64,
        next_gamma: u256,
        future_A_gamma_time: u64,
    }

    struct CurvedConfigUpdatedParams<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        new_mid_fee: u64,
        new_out_fee: u64,
        new_fee_gamma: u64,
        new_ma_half_time: u64,
        new_allowed_extra_profit: u64,
        new_adjustment_step: u64,
    }

    struct NewPoolCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct LiquidityAddedToPool<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        coin_x_amount: u64,
        coin_y_amount: u64,
        lp_minted: u64,
        total_x_fee: u64,
        total_y_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
    }

    struct LiquidityRemovedFromPool<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        coin_x_amount: u64,
        coin_y_amount: u64,
        lp_burned: u64,
        total_x_fee: u64,
        total_y_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
    }

    struct LpBurntForever has copy, drop {
        pool_addr: address,
        lp_burned: u64,
    }

    struct TokensSwapped<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        x_offer_amt: u64,
        y_offer_amt: u64,
        x_return_amt: u64,
        y_return_amt: u64,
        x_total_fee: u64,
        y_total_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
    }

    struct FlashLoanExecuted<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        x_loan: u64,
        y_loan: u64,
        total_x_fee: u64,
        total_y_fee: u64,
        x_hive_fee: u64,
        y_hive_fee: u64,
    }

    struct CumPriceUpdatedEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        cumulative_x_price: u256,
        cumulative_y_price: u256,
        timestamp: u64,
    }

    struct InternalPricesUpdated<phantom T0, phantom T1, phantom T2> has copy, drop {
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

    struct CollectedFeeForPool<phantom T0, phantom T1, phantom T2> has copy, drop {
        id: 0x2::object::ID,
        x_fee_collected: u64,
        y_fee_collected: u64,
    }

    struct HarvestedHiveSui<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        hsui_for_hive: u64,
        hsui_for_treasury: u64,
        fee_balance_sold: u64,
    }

    struct PoolFeeUpdated has copy, drop {
        id: 0x2::object::ID,
        total_fee_bps: u64,
        hive_fee_percent: u64,
    }

    public fun swap<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg1.is_locked, 5009);
        let (v0, v1, v2) = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::get_asset_index_and_amount(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::create_vector(0x1::option::some<u64>(0x2::balance::value<T0>(&arg2)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg4)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        assert!(!v2, 5012);
        let (v3, v4, v5) = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::get_asset_index_and_amount(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::create_vector(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg5), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        assert!(!v5, 5013);
        assert!(v1 != v4, 5014);
        let v6 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v7 = arg1.fee_info.total_fee_bps;
        let v8 = arg1.fee_info.hive_fee_percent;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_curved<T2>()) {
            let v12 = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v13 = *0x1::vector::borrow<u256>(&v12, v4);
            if (arg6) {
                v9 = v0;
                let (v14, v15) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::compute_ask_amount(arg0, 0x1::option::borrow_mut<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), v1, v4, (v0 as u256) * *0x1::vector::borrow<u256>(&v12, v1), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(v6), v12), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256(((0x2::balance::supply_value<LP<T0, T1, T2>>(&arg1.lp_supply) as u128) as u256), 1000000000000000000, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::pow_u256(10, (6 as u128))));
                v10 = ((v14 / v13) as u64);
                v11 = ((v15 / v13) as u64);
            } else {
                let (v16, v17) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::compute_offer_amount(arg0, 0x1::option::borrow_mut<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), v1, v4, (v3 as u256) * v13, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(v6), v12), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256(((0x2::balance::supply_value<LP<T0, T1, T2>>(&arg1.lp_supply) as u128) as u256), 1000000000000000000, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::pow_u256(10, (6 as u128))));
                v9 = ((v16 / *0x1::vector::borrow<u256>(&v12, v1)) as u64);
                let v18 = ((v17 / v13) as u64);
                v11 = v18;
                v10 = v3 + v18;
            };
            let (v19, v20, v21, v22) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_prices_info(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v23, v24, v25, v26) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v27 = InternalPricesUpdated<T0, T1, T2>{
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
            0x2::event::emit<InternalPricesUpdated<T0, T1, T2>>(v27);
        } else if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_stable<T2>()) {
            let (v28, v29) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::get_cur_A_and_scaling_factors(arg0, 0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::StablePoolConfig>(&arg1.stable_config));
            let v30 = v29;
            let v31 = *0x1::vector::borrow<u256>(&v30, v4);
            if (arg6) {
                v9 = v0;
                let v32 = ((0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::compute_ask_amount(v28, v1, (v0 as u256) * *0x1::vector::borrow<u256>(&v30, v1), v4, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(v6), v30)) / v31) as u64);
                v10 = v32;
                v11 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u128((v7 as u128), (v32 as u128), (10000 as u128)) as u64);
            } else {
                let (v33, v34) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::compute_offer_amount(v28, (v3 as u256) * v31, v4, v1, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(v6), v30), v7);
                v9 = ((v33 / *0x1::vector::borrow<u256>(&v30, v1)) as u64);
                let v35 = ((v34 / v31) as u64);
                v11 = v35;
                v10 = v3 + v35;
            };
        } else if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_weighted<T2>()) {
            let (v36, v37) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::get_weight_and_sf_at_index(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(&arg1.weighted_config), v1, true);
            let (v38, v39) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::get_weight_and_sf_at_index(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(&arg1.weighted_config), v4, true);
            if (arg6) {
                v9 = v0;
                let v40 = ((0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::compute_ask_amount((v0 as u256) * v37, (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v37, (v36 as u256), (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v39, (v38 as u256)) / v39) as u64);
                v10 = v40;
                v11 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u128((v7 as u128), (v40 as u128), (10000 as u128)) as u64);
            } else {
                let (v41, v42) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::compute_offer_amount((v3 as u256) * v39, (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v39, (v38 as u256), (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v37, (v36 as u256), v7);
                v9 = ((v41 / v37) as u64);
                let v43 = ((v42 / v39) as u64);
                v11 = v43;
                v10 = v3 + v43;
            };
        };
        assert!(v10 >= v3, 5016);
        assert!(v9 <= v0, 5017);
        let v44 = 0;
        let v45 = 0;
        let v46 = 0;
        let v47 = 0;
        let v48 = 0;
        let v49 = 0;
        let v50 = 0;
        let v51 = 0;
        if (v1 == 0 && v4 == 1) {
            v44 = v9;
            v48 = v10 - v11;
            v49 = v11;
            let (v52, v53) = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::process_coin_balances_processing_for_swap<T0, T1>(&mut arg1.coin_x_reserve, &mut arg2, v9, &mut arg1.coin_y_reserve, &mut arg4, v10, v11, v8);
            v51 = v53;
            0x2::balance::join<T1>(&mut arg1.hive_y, v52);
        } else if (v1 == 1 && v4 == 0) {
            v47 = v9;
            v45 = v10 - v11;
            v46 = v11;
            let (v54, v55) = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::process_coin_balances_processing_for_swap<T1, T0>(&mut arg1.coin_y_reserve, &mut arg4, v9, &mut arg1.coin_x_reserve, &mut arg2, v10, v11, v8);
            v50 = v55;
            0x2::balance::join<T0>(&mut arg1.hive_x, v54);
        };
        let v56 = TokensSwapped<T0, T1, T2>{
            id           : 0x2::object::uid_to_inner(&arg1.id),
            x_offer_amt  : v44,
            y_offer_amt  : v47,
            x_return_amt : v45,
            y_return_amt : v48,
            x_total_fee  : v46,
            y_total_fee  : v49,
            x_hive_fee   : v50,
            y_hive_fee   : v51,
        };
        0x2::event::emit<TokensSwapped<T0, T1, T2>>(v56);
        (arg2, arg4)
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64) : 0x2::balance::Balance<LP<T0, T1, T2>> {
        let v0 = internal_add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3);
        assert!(v0 >= arg4, 5008);
        0x2::balance::increase_supply<LP<T0, T1, T2>>(&mut arg1.lp_supply, v0)
    }

    public fun claim_pol_from_streamer_buzz<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::HiveEntryCap, arg2: &PoolRegistry, arg3: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HiveVault, arg4: &mut LiquidityPool<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, T1>> {
        assert!(0x1::option::is_some<address>(&arg2.x_hive_pool_addr) && *0x1::option::borrow<address>(&arg2.x_hive_pool_addr) == 0x2::object::uid_to_address(&arg4.id), 5031);
        let (v0, v1) = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::transfer_pol<T0>(&arg2.fee_claim_cap, arg3, arg5);
        add_liquidity<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, T1>(arg0, arg4, v0, v1, 0)
    }

    public entry fun collect_fee_for_pool<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::FeeCollector<T0>, arg2: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::FeeCollector<T1>) {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.hive_x);
        let v1 = 0x2::balance::withdraw_all<T1>(&mut arg0.hive_y);
        let v2 = CollectedFeeForPool<T0, T1, T2>{
            id              : 0x2::object::uid_to_inner(&arg0.id),
            x_fee_collected : 0x2::balance::value<T0>(&v0),
            y_fee_collected : 0x2::balance::value<T1>(&v1),
        };
        0x2::event::emit<CollectedFeeForPool<T0, T1, T2>>(v2);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::collect_fee_for_coin<T0>(arg1, v0);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::collect_fee_for_coin<T1>(arg2, v1);
    }

    public fun dangerous_burn_lp_coins<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: 0x2::balance::Balance<LP<T0, T1, T2>>) {
        let v0 = LpBurntForever{
            pool_addr : 0x2::object::uid_to_address(&arg0.id),
            lp_burned : 0x2::balance::value<LP<T0, T1, T2>>(&arg1),
        };
        0x2::event::emit<LpBurntForever>(v0);
        0x2::balance::decrease_supply<LP<T0, T1, T2>>(&mut arg0.lp_supply, arg1);
    }

    public fun deployer_register_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::DegenHiveDeployerCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg4: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg5: &mut PoolRegistry, arg6: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0x2::coin::CoinMetadata<T1>, arg10: vector<u64>, arg11: 0x1::option::Option<vector<u256>>, arg12: 0x1::option::Option<vector<u64>>, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::get_decimals<T0>(arg8), 0x2::coin::get_decimals<T1>(arg9), arg10, arg11, arg12, arg13);
        v1
    }

    public fun deployer_register_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::DegenHiveDeployerCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg4: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg5: &mut PoolRegistry, arg6: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: vector<u64>, arg10: 0x1::option::Option<vector<u256>>, arg11: 0x1::option::Option<vector<u64>>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_decimal_for_coin<T1>(arg4);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::get_decimals<T0>(arg8), v0, arg9, arg10, arg11, arg12);
        v2
    }

    public fun deployer_register_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::DegenHiveDeployerCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg4: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg5: &mut PoolRegistry, arg6: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: vector<u64>, arg10: 0x1::option::Option<vector<u256>>, arg11: 0x1::option::Option<vector<u64>>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_decimal_for_coin<T0>(arg4);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, v0, 0x2::coin::get_decimals<T1>(arg8), arg9, arg10, arg11, arg12);
        v2
    }

    public fun distribute_hive_sui(arg0: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg1: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg2: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Treasury<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg3: 0x2::balance::Balance<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>) : (u64, u64) {
        let v0 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div(0x2::balance::value<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>(&arg3), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::get_hive_treasury_fee_info(arg0), 100);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::deposit_to_treasury<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>(arg2, 0x2::balance::split<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>(&mut arg3, v0));
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::deposit_hsui_for_hive<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>(arg1, arg3);
        (0x2::balance::value<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>(&arg3), v0)
    }

    public fun enable_public_pools(arg0: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::InfusionCapability, arg1: &mut PoolRegistry) {
        arg1.public_kraft_enabled = true;
    }

    public fun flashloan<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, Flashloan<T0, T1, T2>, u64, u64) {
        assert!(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::is_sorted_2<T0, T1>(), 5006);
        assert!(arg2 > 0 || arg3 > 0, 5018);
        assert!(!arg1.is_locked, 5009);
        let v0 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, arg2);
        let v1 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, arg3);
        let v2 = arg1.fee_info.total_fee_bps;
        arg1.is_locked = true;
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        let v3 = arg2 + (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg2 as u256), (v2 as u256), (10000 as u256)) as u64);
        let v4 = arg3 + (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg3 as u256), (v2 as u256), (10000 as u256)) as u64);
        let v5 = Flashloan<T0, T1, T2>{
            x_loan : v3,
            y_loan : v4,
        };
        (v0, v1, v5, v3, v4)
    }

    public fun get_collected_fee<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.hive_x), 0x2::balance::value<T1>(&arg0.hive_y))
    }

    fun get_decimal_for_coin<T0>(arg0: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config) : u8 {
        let (v0, v1) = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::get_decimals_for_coin<T0>(arg0);
        assert!(v0, 5001);
        v1
    }

    public fun get_hive_for_pool<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : address {
        *0x1::option::borrow<address>(&arg0.pool_hive_addr)
    }

    public fun get_liquidity_pool_id<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_pool_cumulative_prices<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u256, u256, u64) {
        (arg0.cumulative_x_price, arg0.cumulative_y_price, arg0.last_timestamp)
    }

    public fun get_pool_curved_config_amp_gamma<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64, u64, u256, u256) {
        0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_amp_gamma_params(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_fee<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64, u256, u256, u256) {
        0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_fee_params(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_precision<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : vector<u256> {
        0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_prices_info<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (vector<u256>, vector<u256>, vector<u256>, u64) {
        0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_prices_info(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_curved_config_xcp<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u256, u256, u256, bool) {
        0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg0.curved_config))
    }

    public fun get_pool_fee_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (arg0.fee_info.total_fee_bps, arg0.fee_info.hive_fee_percent)
    }

    public fun get_pool_id<T0, T1, T2>(arg0: &PoolRegistry) : 0x2::object::ID {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            curve : 0x1::type_name::get<T2>(),
        };
        *0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0)
    }

    public fun get_pool_id_as_address<T0, T1, T2>(arg0: &PoolRegistry) : address {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            curve : 0x1::type_name::get<T2>(),
        };
        0x2::object::id_to_address(0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0))
    }

    public fun get_pool_registery(arg0: &PoolRegistry) : (u64, bool, u64, bool) {
        (arg0.fee_amt, arg0.public_kraft_enabled, 0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list), 0x1::option::is_some<address>(&arg0.x_hive_pool_addr))
    }

    public fun get_pool_reserves<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x_reserve), 0x2::balance::value<T1>(&arg0.coin_y_reserve))
    }

    public fun get_pool_reserves_decimals<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u8, u8) {
        (arg0.coin_x_decimals, arg0.coin_y_decimals)
    }

    public fun get_pool_stable_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (u64, u64, u64, u64, vector<u256>) {
        0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::get_stable_config_params(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::StablePoolConfig>(&arg0.stable_config))
    }

    public fun get_pool_total_supply<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : u64 {
        0x2::balance::supply_value<LP<T0, T1, T2>>(&arg0.lp_supply)
    }

    public fun get_pool_weighted_config<T0, T1, T2>(arg0: &LiquidityPool<T0, T1, T2>) : (vector<u64>, vector<u256>, u64, u64) {
        0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::get_weighted_config_params(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(&arg0.weighted_config))
    }

    public fun get_x_hive_pool_for_pol(arg0: &PoolRegistry) : address {
        *0x1::option::borrow<address>(&arg0.x_hive_pool_addr)
    }

    public entry fun harvest_collected_hive_sui_fee(arg0: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg1: &PoolRegistry, arg2: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::FeeCollector<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg3: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg4: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Treasury<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, _) = distribute_hive_sui(arg0, arg3, arg4, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::extract_fee_for_coin_2amm<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>(&arg1.fee_claim_cap, arg2));
    }

    public entry fun harvest_hsui_for_collected_fee_x<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg2: &PoolRegistry, arg3: &mut LiquidityPool<T0, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI, T1>, arg4: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::FeeCollector<T0>, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg6: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Treasury<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::extract_fee_for_coin_2amm<T0>(&arg2.fee_claim_cap, arg4);
        let (v1, v2) = swap<T0, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI, T1>(arg0, arg3, v0, 0, 0x2::balance::zero<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>(), 1, true);
        let v3 = v1;
        let (v4, v5) = distribute_hive_sui(arg1, arg5, arg6, v2);
        let v6 = HarvestedHiveSui<T0>{
            pool_id           : 0x2::object::uid_to_inner(&arg3.id),
            hsui_for_hive     : v4,
            hsui_for_treasury : v5,
            fee_balance_sold  : 0x2::balance::value<T0>(&v0) - 0x2::balance::value<T0>(&v3),
        };
        0x2::event::emit<HarvestedHiveSui<T0>>(v6);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::collect_fee_for_coin<T0>(arg4, v3);
    }

    public entry fun harvest_hsui_for_collected_fee_y<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg2: &PoolRegistry, arg3: &mut LiquidityPool<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI, T0, T1>, arg4: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::FeeCollector<T0>, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg6: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Treasury<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::extract_fee_for_coin_2amm<T0>(&arg2.fee_claim_cap, arg4);
        let (v1, v2) = swap<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI, T0, T1>(arg0, arg3, 0x2::balance::zero<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>(), 1, v0, 0, true);
        let v3 = v2;
        let (v4, v5) = distribute_hive_sui(arg1, arg5, arg6, v1);
        let v6 = HarvestedHiveSui<T0>{
            pool_id           : 0x2::object::uid_to_inner(&arg3.id),
            hsui_for_hive     : v4,
            hsui_for_treasury : v5,
            fee_balance_sold  : 0x2::balance::value<T0>(&v0) - 0x2::balance::value<T0>(&v3),
        };
        0x2::event::emit<HarvestedHiveSui<T0>>(v6);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::collect_fee_for_coin<T0>(arg4, v3);
    }

    public entry fun harvest_sui_for_collected_fee_x<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg3: &PoolRegistry, arg4: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg5: &mut LiquidityPool<T0, 0x2::sui::SUI, T1>, arg6: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::FeeCollector<T0>, arg7: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg8: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Treasury<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::extract_fee_for_coin_2amm<T0>(&arg3.fee_claim_cap, arg6);
        let (v1, v2) = swap<T0, 0x2::sui::SUI, T1>(arg0, arg5, v0, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
        let v3 = v1;
        let (_, v5, v6) = stake_and_distribute_harvested_hive_sui(arg1, arg4, arg2, arg7, arg8, v2, arg9);
        let v7 = HarvestedHiveSui<T0>{
            pool_id           : 0x2::object::uid_to_inner(&arg5.id),
            hsui_for_hive     : v5,
            hsui_for_treasury : v6,
            fee_balance_sold  : 0x2::balance::value<T0>(&v0) - 0x2::balance::value<T0>(&v3),
        };
        0x2::event::emit<HarvestedHiveSui<T0>>(v7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::collect_fee_for_coin<T0>(arg6, v3);
    }

    public entry fun harvest_sui_for_collected_fee_y<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg3: &PoolRegistry, arg4: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg5: &mut LiquidityPool<0x2::sui::SUI, T0, T1>, arg6: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::FeeCollector<T0>, arg7: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg8: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Treasury<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::extract_fee_for_coin_2amm<T0>(&arg3.fee_claim_cap, arg6);
        let (v1, v2) = swap<0x2::sui::SUI, T0, T1>(arg0, arg5, 0x2::balance::zero<0x2::sui::SUI>(), 1, v0, 0, true);
        let v3 = v2;
        let (_, v5, v6) = stake_and_distribute_harvested_hive_sui(arg1, arg4, arg2, arg7, arg8, v1, arg9);
        let v7 = HarvestedHiveSui<T0>{
            pool_id           : 0x2::object::uid_to_inner(&arg5.id),
            hsui_for_hive     : v5,
            hsui_for_treasury : v6,
            fee_balance_sold  : 0x2::balance::value<T0>(&v0) - 0x2::balance::value<T0>(&v3),
        };
        0x2::event::emit<HarvestedHiveSui<T0>>(v7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::collect_fee_for_coin<T0>(arg6, v3);
    }

    fun imbalanced_exit<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &LiquidityPool<T0, T1, T2>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: u64) : (u64, vector<u64>) {
        let (v0, v1) = if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_stable<T2>()) {
            let (v2, v3) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::get_cur_A_and_scaling_factors(arg0, 0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::StablePoolConfig>(&arg1.stable_config));
            let v4 = v3;
            let (v5, v6) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::imbalanced_liquidity_withdraw(v2, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(arg3), v4), (arg2 as u256), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(arg4), v4), arg5);
            let v7 = v6;
            let v0 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v0, ((*0x1::vector::borrow<u256>(&v7, 0) / *0x1::vector::borrow<u256>(&v4, 0)) as u64));
            0x1::vector::push_back<u64>(&mut v0, ((*0x1::vector::borrow<u256>(&v7, 1) / *0x1::vector::borrow<u256>(&v4, 1)) as u64));
            (v0, (v5 as u64))
        } else {
            let v8 = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::get_scaling_factor_vec(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(&arg1.weighted_config));
            let (v9, v10) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::imbalanced_liquidity_withdraw(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(&arg1.weighted_config), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(arg3), v8), (arg2 as u256), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(arg4), v8), arg5);
            let v11 = v10;
            let v0 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v0, ((*0x1::vector::borrow<u256>(&v11, 0) / *0x1::vector::borrow<u256>(&v8, 0)) as u64));
            0x1::vector::push_back<u64>(&mut v0, ((*0x1::vector::borrow<u256>(&v11, 1) / *0x1::vector::borrow<u256>(&v8, 1)) as u64));
            (v0, (v9 as u64))
        };
        (v1, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_pool_registry(arg0: 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::TwoAmmFeeClaimCapability, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id                   : 0x2::object::new(arg1),
            fee_amt              : 0,
            krafted_pools_list   : 0x2::linked_table::new<PoolRegistryItem, 0x2::object::ID>(arg1),
            fee_claim_cap        : arg0,
            x_hive_pool_addr     : 0x1::option::none<address>(),
            public_kraft_enabled : false,
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    fun internal_add_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) : u64 {
        assert!(!arg1.is_locked, 5009);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        let v2 = 0x2::balance::supply_value<LP<T0, T1, T2>>(&arg1.lp_supply);
        if (v2 == 0) {
            assert!(v0 > 0 && v1 > 0, 5021);
        };
        let v3 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        let v4 = arg1.fee_info.total_fee_bps;
        let v5 = arg1.fee_info.hive_fee_percent;
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        let (v6, v7) = if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_curved<T2>()) {
            let v8 = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v9, v10) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::add_liquidity_computation(arg0, 0x1::option::borrow_mut<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(v3, v8), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v8), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((v2 as u256), 1000000000000000000, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::pow_u256(10, (6 as u128))));
            let v11 = v10;
            let v6 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v6, ((*0x1::vector::borrow<u256>(&v11, 0) / *0x1::vector::borrow<u256>(&v8, 0)) as u64));
            0x1::vector::push_back<u64>(&mut v6, ((*0x1::vector::borrow<u256>(&v11, 1) / *0x1::vector::borrow<u256>(&v8, 1)) as u64));
            let (v12, v13, v14, v15) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_prices_info(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v16, v17, v18, v19) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v20 = InternalPricesUpdated<T0, T1, T2>{
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
            0x2::event::emit<InternalPricesUpdated<T0, T1, T2>>(v20);
            (v6, (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256(v9, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::pow_u256(10, (6 as u128)), 1000000000000000000) as u64))
        } else if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_stable<T2>()) {
            let (v21, v22) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::get_cur_A_and_scaling_factors(arg0, 0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::StablePoolConfig>(&arg1.stable_config));
            let v23 = v22;
            let (v24, v25) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::add_liquidity_computation(v21, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(v3, v23), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v23), v4, (v2 as u256));
            let v26 = v25;
            let v6 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v6, ((*0x1::vector::borrow<u256>(&v26, 0) / *0x1::vector::borrow<u256>(&v23, 0)) as u64));
            0x1::vector::push_back<u64>(&mut v6, ((*0x1::vector::borrow<u256>(&v26, 1) / *0x1::vector::borrow<u256>(&v23, 1)) as u64));
            (v6, (v24 as u64))
        } else {
            let v27 = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::get_scaling_factor_vec(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(&arg1.weighted_config));
            let (v28, v29) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::add_liquidity_computation(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(&arg1.weighted_config), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(v3, v27), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_create_u64(0x1::option::some<u64>(v0), 0x1::option::some<u64>(v1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v27), v4, (v2 as u256));
            let v30 = v29;
            let v6 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v6, ((*0x1::vector::borrow<u256>(&v30, 0) / *0x1::vector::borrow<u256>(&v27, 0)) as u64));
            0x1::vector::push_back<u64>(&mut v6, ((*0x1::vector::borrow<u256>(&v30, 1) / *0x1::vector::borrow<u256>(&v27, 1)) as u64));
            (v6, (v28 as u64))
        };
        assert!(v7 > 0, 5007);
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, arg2);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, arg3);
        let v31 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v6, 0));
        let v32 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v6, 1));
        let v33 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u128((*0x1::vector::borrow<u64>(&v6, 0) as u128), (v5 as u128), (100 as u128)) as u64);
        let v34 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u128((*0x1::vector::borrow<u64>(&v6, 1) as u128), (v5 as u128), (100 as u128)) as u64);
        0x2::balance::join<T0>(&mut arg1.hive_x, 0x2::balance::split<T0>(&mut v31, v33));
        0x2::balance::join<T1>(&mut arg1.hive_y, 0x2::balance::split<T1>(&mut v32, v34));
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, v31);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, v32);
        let v35 = LiquidityAddedToPool<T0, T1, T2>{
            id            : 0x2::object::uid_to_inner(&arg1.id),
            coin_x_amount : v0,
            coin_y_amount : v1,
            lp_minted     : v7,
            total_x_fee   : *0x1::vector::borrow<u64>(&v6, 0),
            total_y_fee   : *0x1::vector::borrow<u64>(&v6, 1),
            x_hive_fee    : v33,
            y_hive_fee    : v34,
        };
        0x2::event::emit<LiquidityAddedToPool<T0, T1, T2>>(v35);
        v7
    }

    fun internal_register_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg3: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: u8, arg8: u8, arg9: vector<u64>, arg10: 0x1::option::Option<vector<u256>>, arg11: 0x1::option::Option<vector<u64>>, arg12: &mut 0x2::tx_context::TxContext) : (address, 0x2::balance::Balance<0x2::sui::SUI>) {
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::deposit_hsui_for_hive<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>(arg5, 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg6, arg4.fee_amt), 0x1::option::none<address>(), arg12));
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::assert_valid_curve<T2>();
        let v0 = 0x2::object::new(arg12);
        registry_add<T0, T1, T2>(arg4, arg3, arg7, arg8, 0x2::object::uid_to_inner(&v0));
        let (v1, v2) = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::get_fee_info<T2>(arg3);
        let v3 = NewPoolCreated<T0, T1, T2>{pool_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<NewPoolCreated<T0, T1, T2>>(v3);
        let v4 = LP<T0, T1, T2>{dummy_field: false};
        let v5 = PoolFeeInfo{
            total_fee_bps    : v1,
            hive_fee_percent : v2,
        };
        let v6 = LiquidityPool<T0, T1, T2>{
            id                 : v0,
            coin_x_reserve     : 0x2::balance::zero<T0>(),
            coin_x_decimals    : arg7,
            coin_y_reserve     : 0x2::balance::zero<T1>(),
            coin_y_decimals    : arg8,
            lp_supply          : 0x2::balance::create_supply<LP<T0, T1, T2>>(v4),
            curved_config      : 0x1::option::none<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(),
            stable_config      : 0x1::option::none<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::StablePoolConfig>(),
            weighted_config    : 0x1::option::none<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(),
            hive_x             : 0x2::balance::zero<T0>(),
            hive_y             : 0x2::balance::zero<T1>(),
            fee_info           : v5,
            is_locked          : false,
            cumulative_x_price : 0,
            cumulative_y_price : 0,
            last_timestamp     : 0x2::clock::timestamp_ms(arg0),
            pool_hive_addr     : 0x1::option::none<address>(),
        };
        let v7 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v7, 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::computeScalingFactor(arg7));
        0x1::vector::push_back<u256>(&mut v7, 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::computeScalingFactor(arg8));
        if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_curved<T2>()) {
            assert!(0x1::option::is_some<vector<u256>>(&arg10), 5003);
            v6.curved_config = 0x1::option::some<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::initialize_curved_config(arg0, arg9, 0x1::option::extract<vector<u256>>(&mut arg10), v7, (2 as u128), arg12));
        } else if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_stable<T2>()) {
            v6.stable_config = 0x1::option::some<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::StablePoolConfig>(0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::initialize_stable_config(arg0, arg9, v7, arg12));
        } else {
            assert!(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_weighted<T2>(), 5024);
            assert!(0x1::option::is_some<vector<u64>>(&arg11), 5004);
            v6.weighted_config = 0x1::option::some<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::initialize_weighted_config(arg9, 0x1::option::extract<vector<u64>>(&mut arg11), v7, 2, arg12));
        };
        0x2::transfer::share_object<LiquidityPool<T0, T1, T2>>(v6);
        if (!0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::is_fee_collector_present<T0>(arg3)) {
            0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::create_fee_collector<T0>(arg3, arg12);
        };
        if (!0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::is_fee_collector_present<T1>(arg3)) {
            0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::create_fee_collector<T1>(arg3, arg12);
        };
        (0x2::object::uid_to_address(&v0), arg6)
    }

    fun internal_remove_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64) {
        assert!(!arg1.is_locked, 5009);
        let v0 = (0x2::balance::supply_value<LP<T0, T1, T2>>(&arg1.lp_supply) as u128);
        let v1 = 0x2::balance::value<T0>(&arg1.coin_x_reserve);
        let v2 = 0x2::balance::value<T1>(&arg1.coin_y_reserve);
        let v3 = arg1.fee_info.total_fee_bps;
        let v4 = arg1.fee_info.hive_fee_percent;
        let v5 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_create_u64(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg4), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v6 = arg2;
        let v7 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::create_zero_vector(2);
        update_cumulative_prices<T0, T1, T2>(arg0, arg1);
        if (arg3 == 0 && arg4 == 0) {
            *0x1::vector::borrow_mut<u64>(&mut v5, 0) = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg2 as u256), (v1 as u256), (v0 as u256)) as u64);
            *0x1::vector::borrow_mut<u64>(&mut v5, 1) = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg2 as u256), (v2 as u256), (v0 as u256)) as u64);
            if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_curved<T2>()) {
                0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::reduce_d(0x1::option::borrow_mut<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::pow_u256(10, (6 as u128))), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((v0 as u256), 1000000000000000000, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::pow_u256(10, (6 as u128))));
            };
        } else if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_curved<T2>()) {
            let (v8, v9) = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::get_non_zero_count_and_index(v5);
            assert!(v8 == 1, 5011);
            let v10 = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_scaling_factor(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            *0x1::vector::borrow_mut<u64>(&mut v5, v9) = ((0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::calc_withdraw_one_coin(arg0, 0x1::option::borrow_mut<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&mut arg1.curved_config), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_create_u64(0x1::option::some<u64>(v1), 0x1::option::some<u64>(v2), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>())), v10), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((v0 as u256), 1000000000000000000, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::pow_u256(10, (6 as u128))), v9, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg2 as u256), 1000000000000000000, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::pow_u256(10, (6 as u128))), false, true) / *0x1::vector::borrow<u256>(&v10, v9)) as u64);
            assert!(*0x1::vector::borrow_mut<u64>(&mut v5, v9) > *0x1::vector::borrow<u64>(&v5, v9), 5029);
            let (v11, v12, v13, v14) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_prices_info(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let (v15, v16, v17, v18) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_xcp_params(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg1.curved_config));
            let v19 = InternalPricesUpdated<T0, T1, T2>{
                id                    : 0x2::object::uid_to_inner(&arg1.id),
                price_scale           : v11,
                oracle_prices         : v12,
                last_prices           : v13,
                last_prices_timestamp : v14,
                virtual_price         : v16,
                xcp_profit            : v17,
                not_adjusted          : v18,
                _D                    : v15,
            };
            0x2::event::emit<InternalPricesUpdated<T0, T1, T2>>(v19);
        } else {
            let (v20, v21) = imbalanced_exit<T0, T1, T2>(arg0, arg1, (v0 as u64), 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_create_u64(0x1::option::some<u64>(v1), 0x1::option::some<u64>(v2), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()), v5, v3);
            v7 = v21;
            v6 = v20;
        };
        assert!(v6 > 0, 5010);
        let v22 = 0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v5, 0));
        let v23 = 0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v5, 1));
        if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_weighted<T2>()) {
            let v24 = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::get_exit_fee(0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(&arg1.weighted_config));
            *0x1::vector::borrow_mut<u64>(&mut v7, 0) = *0x1::vector::borrow<u64>(&v7, 0) + 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div(*0x1::vector::borrow<u64>(&v5, 0), v24, 10000);
            *0x1::vector::borrow_mut<u64>(&mut v7, 1) = *0x1::vector::borrow<u64>(&v7, 1) + 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div(*0x1::vector::borrow<u64>(&v5, 1), v24, 10000);
        };
        let v25 = if (0x2::balance::value<T0>(&v22) >= *0x1::vector::borrow<u64>(&v7, 0)) {
            0x2::balance::split<T0>(&mut v22, *0x1::vector::borrow<u64>(&v7, 0))
        } else {
            0x2::balance::split<T0>(&mut arg1.coin_x_reserve, *0x1::vector::borrow<u64>(&v7, 0))
        };
        let v26 = if (0x2::balance::value<T1>(&v23) >= *0x1::vector::borrow<u64>(&v7, 1)) {
            0x2::balance::split<T1>(&mut v23, *0x1::vector::borrow<u64>(&v7, 1))
        } else {
            0x2::balance::split<T1>(&mut arg1.coin_y_reserve, *0x1::vector::borrow<u64>(&v7, 1))
        };
        let v27 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u128((*0x1::vector::borrow<u64>(&v7, 0) as u128), (v4 as u128), (100 as u128)) as u64);
        let v28 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u128((*0x1::vector::borrow<u64>(&v7, 1) as u128), (v4 as u128), (100 as u128)) as u64);
        0x2::balance::join<T0>(&mut arg1.hive_x, 0x2::balance::split<T0>(&mut v25, v27));
        0x2::balance::join<T1>(&mut arg1.hive_y, 0x2::balance::split<T1>(&mut v26, v28));
        0x2::balance::join<T0>(&mut arg1.coin_x_reserve, v25);
        0x2::balance::join<T1>(&mut arg1.coin_y_reserve, v26);
        let v29 = LiquidityRemovedFromPool<T0, T1, T2>{
            id            : 0x2::object::uid_to_inner(&arg1.id),
            coin_x_amount : *0x1::vector::borrow<u64>(&v5, 0),
            coin_y_amount : *0x1::vector::borrow<u64>(&v5, 1),
            lp_burned     : v6,
            total_x_fee   : *0x1::vector::borrow<u64>(&v7, 0),
            total_y_fee   : *0x1::vector::borrow<u64>(&v7, 1),
            x_hive_fee    : v27,
            y_hive_fee    : v28,
        };
        0x2::event::emit<LiquidityRemovedFromPool<T0, T1, T2>>(v29);
        (v22, v23, arg2 - v6)
    }

    public fun is_pool_registered<T0, T1, T2>(arg0: &PoolRegistry) : bool {
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            curve : 0x1::type_name::get<T2>(),
        };
        0x2::linked_table::contains<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0)
    }

    public fun lock_in_x_hive_pool_addr<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::HiveEntryCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg4: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg5: &mut PoolRegistry, arg6: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0x2::coin::CoinMetadata<T1>, arg10: vector<u64>, arg11: 0x1::option::Option<vector<u256>>, arg12: 0x1::option::Option<vector<u64>>, arg13: &mut 0x2::tx_context::TxContext) : address {
        assert!(0x1::type_name::get<0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE>() == 0x1::type_name::get<T1>(), 5001);
        assert!(0x1::option::is_none<address>(&arg5.x_hive_pool_addr), 5030);
        let (v0, v1) = internal_register_pool<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::get_decimals<T0>(arg8), 0x2::coin::get_decimals<T1>(arg9), arg10, arg11, arg12, arg13);
        arg5.x_hive_pool_addr = 0x1::option::some<address>(v0);
        let v2 = X_HIVE_Pool_Krafted{x_hive_pool_addr: v0};
        0x2::event::emit<X_HIVE_Pool_Krafted>(v2);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg13), arg13);
        v0
    }

    public fun pay_flashloan<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: Flashloan<T0, T1, T2>) {
        assert!(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::is_sorted_2<T0, T1>(), 5006);
        let Flashloan {
            x_loan : v0,
            y_loan : v1,
        } = arg3;
        let v2 = 0x2::balance::value<T0>(&arg1);
        let v3 = 0x2::balance::value<T1>(&arg2);
        assert!(v2 >= v0 && v3 >= v1, 5020);
        let v4 = arg0.fee_info.total_fee_bps;
        let v5 = arg0.fee_info.hive_fee_percent;
        let v6 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((v2 as u256), (v4 as u256), (10000 as u256)) as u64);
        let v7 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((v3 as u256), (v4 as u256), (10000 as u256)) as u64);
        let v8 = 0x2::balance::split<T0>(&mut arg1, v6);
        let v9 = 0x2::balance::split<T1>(&mut arg2, v7);
        let v10 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div(v6, v5, 100);
        let v11 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div(v7, v5, 100);
        0x2::balance::join<T0>(&mut arg0.hive_x, 0x2::balance::split<T0>(&mut v8, v10));
        0x2::balance::join<T1>(&mut arg0.hive_y, 0x2::balance::split<T1>(&mut v9, v11));
        0x2::balance::join<T0>(&mut arg0.coin_x_reserve, arg1);
        0x2::balance::join<T1>(&mut arg0.coin_y_reserve, arg2);
        0x2::balance::join<T0>(&mut arg0.coin_x_reserve, v8);
        0x2::balance::join<T1>(&mut arg0.coin_y_reserve, v9);
        let v12 = FlashLoanExecuted<T0, T1, T2>{
            id          : 0x2::object::uid_to_inner(&arg0.id),
            x_loan      : v0,
            y_loan      : v1,
            total_x_fee : v6,
            total_y_fee : v7,
            x_hive_fee  : v10,
            y_hive_fee  : v11,
        };
        0x2::event::emit<FlashLoanExecuted<T0, T1, T2>>(v12);
        arg0.is_locked = false;
    }

    public fun query_across_all_pools<T0, T1, T2>(arg0: &PoolRegistry, arg1: u64) : (vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            curve : 0x1::type_name::get<T2>(),
        };
        let v5 = 0x1::option::some<PoolRegistryItem>(v4);
        let v6 = 0;
        while (0x1::option::is_some<PoolRegistryItem>(&v5) && v6 < arg1) {
            let v7 = *0x1::option::borrow<PoolRegistryItem>(&v5);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::from_ascii(0x1::type_name::into_string(v7.a)));
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::from_ascii(0x1::type_name::into_string(v7.b)));
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::from_ascii(0x1::type_name::into_string(v7.curve)));
            0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v7)));
            v5 = *0x2::linked_table::next<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v7);
            v6 = v6 + 1;
        };
        (v1, v2, v3, v0, 0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list))
    }

    public fun query_first_pool(arg0: &PoolRegistry) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address, u64) {
        let v0 = *0x2::linked_table::front<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list);
        let v1 = *0x1::option::borrow<PoolRegistryItem>(&v0);
        (0x1::string::from_ascii(0x1::type_name::into_string(v1.a)), 0x1::string::from_ascii(0x1::type_name::into_string(v1.b)), 0x1::string::from_ascii(0x1::type_name::into_string(v1.curve)), 0x2::object::id_to_address(0x2::linked_table::borrow<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v1)), 0x2::linked_table::length<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list))
    }

    public entry fun query_swap<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &LiquidityPool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : (u64, u64, u64, u64, u64, u64, u64) {
        if (arg1.is_locked) {
            return (0, 0, 0, 0, 0, 0, 5009)
        };
        let (v0, v1, v2) = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::get_asset_index_and_amount(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::create_vector(0x1::option::some<u64>(arg2), 0x1::option::some<u64>(arg4), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        if (v2) {
            return (0, 0, 0, 0, 0, 0, 5012)
        };
        let (v3, v4, v5) = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::get_asset_index_and_amount(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::create_vector(0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg5), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>()));
        if (v5) {
            return (0, 0, 0, 0, 0, 0, 5012)
        };
        if (v1 == v4) {
            return (0, 0, 0, 0, 0, 0, 5014)
        };
        if (v5) {
            return (0, 0, 0, 0, 0, 0, 5014)
        };
        let v6 = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_create_u64(0x1::option::some<u64>(0x2::balance::value<T0>(&arg1.coin_x_reserve)), 0x1::option::some<u64>(0x2::balance::value<T1>(&arg1.coin_y_reserve)), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        if (v3 > *0x1::vector::borrow<u64>(&v6, v4)) {
            return (0, 0, 0, 0, 0, 0, 5028)
        };
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_curved<T2>()) {
            let v10 = 0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg1.curved_config);
            let v11 = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::get_curved_config_scaling_factor(v10);
            let v12 = *0x1::vector::borrow<u256>(&v11, v4);
            if (arg6) {
                v7 = v0;
                let (v13, v14) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::query_ask_amount(arg0, v10, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(v6), v11), (v0 as u256) * *0x1::vector::borrow<u256>(&v11, v1), v1, v4);
                v8 = ((v13 / v12) as u64);
                v9 = ((v14 / v12) as u64);
            } else {
                let (v15, v16) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::query_offer_amount(arg0, v10, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(v6), v11), (v3 as u256) * v12, v1, v4);
                v7 = ((v15 / *0x1::vector::borrow<u256>(&v11, v1)) as u64);
                let v17 = ((v16 / v12) as u64);
                v9 = v17;
                v8 = v3 + v17;
            };
        } else if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_stable<T2>()) {
            let (v18, v19) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::get_cur_A_and_scaling_factors(arg0, 0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::StablePoolConfig>(&arg1.stable_config));
            let v20 = v19;
            let v21 = *0x1::vector::borrow<u256>(&v20, v4);
            if (arg6) {
                v7 = v0;
                let v22 = ((0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::compute_ask_amount(v18, v1, (v0 as u256) * *0x1::vector::borrow<u256>(&v20, v1), v4, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(v6), v20)) / v21) as u64);
                v8 = v22;
                v9 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u128((arg1.fee_info.total_fee_bps as u128), (v22 as u128), (10000 as u128)) as u64);
            } else {
                let (v23, v24) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::compute_offer_amount(v18, (v3 as u256) * v21, v4, v1, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::multiply_vectors_u256(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::vector_u64_to_u256(v6), v20), arg1.fee_info.total_fee_bps);
                v7 = ((v23 / *0x1::vector::borrow<u256>(&v20, v1)) as u64);
                let v25 = ((v24 / v21) as u64);
                v9 = v25;
                v8 = v3 + v25;
            };
        } else if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_weighted<T2>()) {
            let v26 = 0x1::option::borrow<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(&arg1.weighted_config);
            let (v27, v28) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::get_weight_and_sf_at_index(v26, v1, true);
            let (v29, v30) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::get_weight_and_sf_at_index(v26, v4, true);
            if (arg6) {
                v7 = v0;
                let v31 = ((0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::compute_ask_amount((v0 as u256) * v28, (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v28, (v27 as u256), (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v30, (v29 as u256)) / v30) as u64);
                v8 = v31;
                v9 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u128((arg1.fee_info.total_fee_bps as u128), (v31 as u128), (10000 as u128)) as u64);
            } else {
                let (v32, v33) = 0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::compute_offer_amount((v3 as u256) * v30, (*0x1::vector::borrow<u64>(&v6, v4) as u256) * v30, (v29 as u256), (*0x1::vector::borrow<u64>(&v6, v1) as u256) * v28, (v27 as u256), arg1.fee_info.total_fee_bps);
                v7 = ((v32 / v28) as u64);
                let v34 = ((v33 / v30) as u64);
                v9 = v34;
                v8 = v3 + v34;
            };
        };
        if (v8 < v3) {
            return (0, 0, 0, 0, 0, 0, 5016)
        };
        if (v7 > v0) {
            return (0, 0, 0, 0, 0, 0, 5017)
        };
        let v35 = 0;
        let v36 = 0;
        let v37 = 0;
        let v38 = 0;
        let v39 = 0;
        let v40 = 0;
        if (v1 == 0 && v4 == 1) {
            v35 = v7;
            v39 = v8 - v9;
            v40 = v9;
        } else if (v1 == 1 && v4 == 0) {
            v38 = v7;
            v36 = v8 - v9;
            v37 = v9;
        };
        (v35, v36, v37, v38, v39, v40, 0)
    }

    public fun register_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg3: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: vector<u64>, arg10: 0x1::option::Option<vector<u256>>, arg11: 0x1::option::Option<vector<u64>>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        let (_, v1) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::get_decimals<T0>(arg7), 0x2::coin::get_decimals<T1>(arg8), arg9, arg10, arg11, arg12);
        v1
    }

    public fun register_pool_no_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg3: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: vector<u64>, arg8: 0x1::option::Option<vector<u256>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T0>(arg3);
        let v1 = get_decimal_for_coin<T1>(arg3);
        let (_, v3) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, v1, arg7, arg8, arg9, arg10);
        v3
    }

    public fun register_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg3: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: vector<u64>, arg9: 0x1::option::Option<vector<u256>>, arg10: 0x1::option::Option<vector<u64>>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T1>(arg3);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::get_decimals<T0>(arg7), v0, arg8, arg9, arg10, arg11);
        v2
    }

    public fun register_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg3: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg4: &mut PoolRegistry, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: vector<u64>, arg9: 0x1::option::Option<vector<u256>>, arg10: 0x1::option::Option<vector<u64>>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.public_kraft_enabled, 5032);
        let v0 = get_decimal_for_coin<T0>(arg3);
        let (_, v2) = internal_register_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, 0x2::coin::get_decimals<T1>(arg7), arg8, arg9, arg10, arg11);
        v2
    }

    fun registry_add<T0, T1, T2>(arg0: &mut PoolRegistry, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg2: u8, arg3: u8, arg4: 0x2::object::ID) {
        if (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::is_curved<T2>()) {
            assert!(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::valid_curved_coins_2_pool<T0, T1>(arg1), 5005);
        } else {
            assert!(0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::is_sorted<T0, T1>(), 5006);
        };
        let v0 = PoolRegistryItem{
            a     : 0x1::type_name::get<T0>(),
            b     : 0x1::type_name::get<T1>(),
            curve : 0x1::type_name::get<T2>(),
        };
        assert!(!0x2::linked_table::contains<PoolRegistryItem, 0x2::object::ID>(&arg0.krafted_pools_list, v0), 5002);
        0x2::linked_table::push_back<PoolRegistryItem, 0x2::object::ID>(&mut arg0.krafted_pools_list, v0, arg4);
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>, arg2: 0x2::balance::Balance<LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<LP<T0, T1, T2>>) {
        let v0 = 0x2::balance::value<LP<T0, T1, T2>>(&arg2);
        let (v1, v2, v3) = internal_remove_liquidity<T0, T1, T2>(arg0, arg1, v0, arg3, arg4);
        let v4 = v0 - v3;
        if (arg5 > 0) {
            assert!(v4 <= arg5, 5015);
        };
        0x2::balance::decrease_supply<LP<T0, T1, T2>>(&mut arg1.lp_supply, 0x2::balance::split<LP<T0, T1, T2>>(&mut arg2, v4));
        (v1, v2, arg2)
    }

    public fun set_pool_hive_addr<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::DexDaoCapability, arg2: address) {
        assert!(!0x1::option::is_some<address>(&arg0.pool_hive_addr), 5027);
        arg0.pool_hive_addr = 0x1::option::some<address>(arg2);
    }

    public fun stake_and_distribute_harvested_hive_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg2: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg3: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg4: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Treasury<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::stake_sui_request(arg0, arg1, arg5, 0x1::option::none<address>(), arg6);
        let (v1, v2) = distribute_hive_sui(arg2, arg3, arg4, v0);
        (0x2::balance::value<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>(&v0), v1, v2)
    }

    public entry fun stake_and_harvest_collected_sui_fee(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg2: &PoolRegistry, arg3: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg4: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::FeeCollector<0x2::sui::SUI>, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg6: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Treasury<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let (_, _, _) = stake_and_distribute_harvested_hive_sui(arg0, arg3, arg1, arg5, arg6, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::extract_fee_for_coin_2amm<0x2::sui::SUI>(&arg2.fee_claim_cap, arg4), arg7);
    }

    fun update_cumulative_prices<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut LiquidityPool<T0, T1, T2>) {
        let v0 = 0x2::clock::timestamp_ms(arg0) - arg1.last_timestamp;
        let v1 = 0x2::balance::value<T0>(&arg1.coin_x_reserve);
        let v2 = 0x2::balance::value<T1>(&arg1.coin_y_reserve);
        if (v0 > 0 && v1 != 0 && v2 != 0) {
            arg1.cumulative_x_price = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::overflow_add_u256(arg1.cumulative_x_price, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((v2 as u256), (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::pow_10(6) as u256), (v1 as u256)) * (v0 as u256));
            arg1.cumulative_y_price = 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::overflow_add_u256(arg1.cumulative_y_price, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((v1 as u256), (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::pow_10(6) as u256), (v2 as u256)) * (v0 as u256));
            arg1.last_timestamp = 0x2::clock::timestamp_ms(arg0);
        };
        let v3 = CumPriceUpdatedEvent<T0, T1, T2>{
            id                 : 0x2::object::uid_to_inner(&arg1.id),
            cumulative_x_price : arg1.cumulative_x_price,
            cumulative_y_price : arg1.cumulative_y_price,
            timestamp          : arg1.last_timestamp,
        };
        0x2::event::emit<CumPriceUpdatedEvent<T0, T1, T2>>(v3);
    }

    public entry fun update_curved_A_and_gamma<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::DexDaoCapability, arg2: u64, arg3: u64, arg4: u256, arg5: u64) {
        assert!(0x1::option::is_some<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg0.curved_config), 5025);
        0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::update_A_and_gamma(0x1::option::borrow_mut<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&mut arg0.curved_config), arg2, arg3, arg4, arg5);
        let v0 = CurvedConfigUpdatedAmp<T0, T1, T2>{
            id                  : 0x2::object::uid_to_inner(&arg0.id),
            init_A_gamma_time   : arg2,
            next_amp            : arg3,
            next_gamma          : arg4,
            future_A_gamma_time : arg5,
        };
        0x2::event::emit<CurvedConfigUpdatedAmp<T0, T1, T2>>(v0);
    }

    public fun update_curved_config_fee_params<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::DexDaoCapability, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(0x1::option::is_some<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&arg0.curved_config), 5025);
        0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::update_config_fee_params(0x1::option::borrow_mut<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::curved_math::CurvedPoolConfig>(&mut arg0.curved_config), arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = CurvedConfigUpdatedParams<T0, T1, T2>{
            id                       : 0x2::object::uid_to_inner(&arg0.id),
            new_mid_fee              : arg2,
            new_out_fee              : arg3,
            new_fee_gamma            : arg4,
            new_ma_half_time         : arg5,
            new_allowed_extra_profit : arg6,
            new_adjustment_step      : arg7,
        };
        0x2::event::emit<CurvedConfigUpdatedParams<T0, T1, T2>>(v0);
    }

    public fun update_fee_for_pool<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::DexDaoCapability, arg2: u64, arg3: u64) {
        assert!(arg2 >= 1 && arg2 <= 300, 5000);
        assert!(arg3 >= 30 && arg3 <= 70, 5026);
        arg0.fee_info.total_fee_bps = arg2;
        arg0.fee_info.hive_fee_percent = arg3;
        let v0 = PoolFeeUpdated{
            id               : 0x2::object::uid_to_inner(&arg0.id),
            total_fee_bps    : arg2,
            hive_fee_percent : arg3,
        };
        0x2::event::emit<PoolFeeUpdated>(v0);
    }

    public fun update_pool_kraft_fee(arg0: &mut PoolRegistry, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::HiveDaoCapability, arg2: u64) {
        assert!(arg2 <= 50000000000, 5000);
        arg0.fee_amt = arg2;
        let v0 = PoolKraftingFeeUpdated{fee: arg2};
        0x2::event::emit<PoolKraftingFeeUpdated>(v0);
    }

    public entry fun update_stable_config<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::DexDaoCapability, arg2: u64, arg3: u64, arg4: u64) {
        assert!(0x1::option::is_some<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::StablePoolConfig>(&arg0.stable_config), 5025);
        0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::update_stable_config(0x1::option::borrow_mut<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::stable_math::StablePoolConfig>(&mut arg0.stable_config), arg3, arg2, arg4);
        let v0 = StableConfigUpdated<T0, T1, T2>{
            id            : 0x2::object::uid_to_inner(&arg0.id),
            init_amp_time : arg3,
            next_amp      : arg2,
            next_amp_time : arg4,
        };
        0x2::event::emit<StableConfigUpdated<T0, T1, T2>>(v0);
    }

    public entry fun update_weighted_config<T0, T1, T2>(arg0: &mut LiquidityPool<T0, T1, T2>, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::DexDaoCapability, arg2: vector<u64>, arg3: u64) {
        assert!(0x1::option::is_some<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(&arg0.weighted_config), 5025);
        0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::update_weighted_config(0x1::option::borrow_mut<0xf9760d76173e6cd7ade04925b6fe66f168edafbca0f0f525dd7af19bea565f23::weighted_math::WeightedConfig>(&mut arg0.weighted_config), arg2, arg3);
        let v0 = WeightedConfigUpdated<T0, T1, T2>{
            id           : 0x2::object::uid_to_inner(&arg0.id),
            new_weights  : arg2,
            new_exit_fee : arg3,
        };
        0x2::event::emit<WeightedConfigUpdated<T0, T1, T2>>(v0);
    }

    // decompiled from Move bytecode v6
}

