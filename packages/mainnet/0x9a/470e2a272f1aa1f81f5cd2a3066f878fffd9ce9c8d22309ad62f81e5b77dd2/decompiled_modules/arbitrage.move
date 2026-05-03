module 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::arbitrage {
    struct EscrowMutationWitness has drop {
        dummy_field: bool,
    }

    struct MarketStateMutationWitness has drop {
        dummy_field: bool,
    }

    struct SystemRebalanceExecuted has copy, drop {
        market_id: 0x2::object::ID,
        is_cond_to_spot: bool,
        arb_amount_hint: u64,
        actual_input: u64,
        actual_output: u64,
        retained_system_dust_created: bool,
    }

    public fun auto_rebalance_spot_after_conditional_swaps<T0, T1, T2>(arg0: &mut 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &mut 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x1::option::Option<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>, arg3: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::EscrowMutationRegistry, arg4: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::MarketStateMutationRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>> {
        let v0 = create_auth(arg3);
        let v1 = create_market_auth(arg4);
        let v2 = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::get_active_escrow_id<T0, T1, T2>(arg0);
        if (0x1::option::is_some<0x2::object::ID>(&v2)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v2) == 0x2::object::id<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::TokenEscrow<T0, T1>>(arg1), 103);
        } else {
            if (!0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::is_locked_for_proposal<T0, T1, T2>(arg0)) {
                return arg2
            };
            let v3 = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::get_active_proposal_id<T0, T1, T2>(arg0);
            assert!(*0x1::option::borrow<0x2::object::ID>(&v3) == 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::proposal_id(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state<T0, T1>(arg1)), 103);
        };
        let v4 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state<T0, T1>(arg1);
        let v5 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::market_id(v4);
        let v6 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::outcome_count(v4);
        if (0x1::option::is_some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg2)) {
            assert!(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::market_id<T0, T1>(0x1::option::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg2)) == v5, 100);
        };
        assert!(v6 <= 255, 104);
        if (!0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::are_swaps_allowed(v4, arg5)) {
            return arg2
        };
        let (v7, v8, _) = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::arbitrage_math::compute_optimal_internal_rebalance<T0, T1, T2>(arg0, 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::borrow_amm_pools(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state<T0, T1>(arg1)), 0);
        if (v7 == 0) {
            return arg2
        };
        let (v10, v11) = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
        let (v12, v13, v14) = if (v8) {
            let v15 = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::arbitrage_math::max_conditional_stable_cost(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::borrow_amm_pools(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state<T0, T1>(arg1)), v7);
            if (v15 == 340282366920938463463374607431768211455 || v15 > 18446744073709551615) {
                return arg2
            };
            let v16 = (v15 as u64);
            if (v11 < v16) {
                return arg2
            };
            let v17 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::borrow_amm_pools(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state<T0, T1>(arg1));
            let v18 = 0;
            while (v18 < v6) {
                let (_, v20) = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_reserves(0x1::vector::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(v17, v18));
                if (v20 > 18446744073709551615 - v16) {
                    return arg2
                };
                v18 = v18 + 1;
            };
            let (v21, v22) = preview_system_rebalance_stable_to_asset(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::borrow_amm_pools(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state<T0, T1>(arg1)), v16);
            let v23 = if (v21 == 0) {
                true
            } else if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_escrowed_asset_balance<T0, T1>(arg1) < v21) {
                true
            } else if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_lp_deposited_stable<T0, T1>(arg1) > 18446744073709551615 - v16) {
                true
            } else if (v10 > 18446744073709551615 - v21) {
                true
            } else {
                !can_account_system_rebalance_stable_to_asset<T0, T1>(arg1, v6, v16, v21)
            };
            if (v23) {
                return arg2
            };
            0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::deposit_spot_liquidity<T0, T1>(arg1, 0x2::balance::zero<T0>(), 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::take_stable_for_arbitrage<T0, T1, T2>(arg0, v16), &v0);
            0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::decrement_lp_backing<T0, T1>(arg1, 0, v16, &v0);
            0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::increment_supplies_for_all_outcomes<T0, T1>(arg1, 0, v16, &v0);
            let v24 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v0);
            let v25 = 0;
            while (v25 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::inject_reserves_for_arbitrage(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::get_pool_mut_by_outcome(v24, v25, &v0), v5, 0, v16, &v1);
                v25 = v25 + 1;
            };
            v25 = 0;
            while (v25 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::swap_from_injected_stable_to_asset(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::get_pool_mut_by_outcome(v24, v25, &v0), v5, v16, v21, arg5, &v1);
                v25 = v25 + 1;
            };
            v25 = 0;
            while (v25 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::extract_reserves_for_arbitrage(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::get_pool_mut_by_outcome(v24, v25, &v0), v5, v21, 0, &v1);
                v25 = v25 + 1;
            };
            let v26 = 0;
            while (v26 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::track_system_swap_stable_to_asset<T0, T1>(arg1, v26, v16, v21, &v0);
                v26 = v26 + 1;
            };
            let v27 = 0;
            while (v27 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::decrement_supply_for_outcome<T0, T1>(arg1, v27, true, v21, &v0);
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::decrement_pool_claim<T0, T1>(arg1, v27, v21, 0, &v0);
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::increment_wrapped_balance<T0, T1>(arg1, v27, true, v21, &v0);
                v27 = v27 + 1;
            };
            let v28 = 0;
            while (v28 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::decrement_wrapped_balance<T0, T1>(arg1, v28, true, v21, &v0);
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::decrement_outcome_allocation<T0, T1>(arg1, v28, v21, 0, &v0);
                v28 = v28 + 1;
            };
            0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::return_asset_from_arbitrage<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::withdraw_asset_balance<T0, T1>(arg1, v21, arg6, &v0)));
            (v22, v16, v21)
        } else {
            if (v10 < v7) {
                return arg2
            };
            let v29 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::borrow_amm_pools(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state<T0, T1>(arg1));
            let v30 = 0;
            while (v30 < v6) {
                let (v31, _) = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_reserves(0x1::vector::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(v29, v30));
                if (v31 > 18446744073709551615 - v7) {
                    return arg2
                };
                v30 = v30 + 1;
            };
            let (v33, v34) = preview_system_rebalance_asset_to_stable(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::borrow_amm_pools(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state<T0, T1>(arg1)), v7);
            let v35 = if (v33 == 0) {
                true
            } else if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_escrowed_stable_balance<T0, T1>(arg1) < v33) {
                true
            } else if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_lp_deposited_asset<T0, T1>(arg1) > 18446744073709551615 - v7) {
                true
            } else if (v11 > 18446744073709551615 - v33) {
                true
            } else {
                !can_account_system_rebalance_asset_to_stable<T0, T1>(arg1, v6, v7, v33)
            };
            if (v35) {
                return arg2
            };
            0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::deposit_spot_liquidity<T0, T1>(arg1, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::take_asset_for_arbitrage<T0, T1, T2>(arg0, v7), 0x2::balance::zero<T1>(), &v0);
            0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::decrement_lp_backing<T0, T1>(arg1, v7, 0, &v0);
            0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::increment_supplies_for_all_outcomes<T0, T1>(arg1, v7, 0, &v0);
            let v36 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v0);
            let v37 = 0;
            while (v37 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::inject_reserves_for_arbitrage(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::get_pool_mut_by_outcome(v36, v37, &v0), v5, v7, 0, &v1);
                v37 = v37 + 1;
            };
            v37 = 0;
            while (v37 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::swap_from_injected_asset_to_stable(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::get_pool_mut_by_outcome(v36, v37, &v0), v5, v7, v33, arg5, &v1);
                v37 = v37 + 1;
            };
            v37 = 0;
            while (v37 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::extract_reserves_for_arbitrage(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::get_pool_mut_by_outcome(v36, v37, &v0), v5, 0, v33, &v1);
                v37 = v37 + 1;
            };
            let v38 = 0;
            while (v38 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::track_system_swap_asset_to_stable<T0, T1>(arg1, v38, v7, v33, &v0);
                v38 = v38 + 1;
            };
            let v39 = 0;
            while (v39 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::decrement_supply_for_outcome<T0, T1>(arg1, v39, false, v33, &v0);
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::decrement_pool_claim<T0, T1>(arg1, v39, 0, v33, &v0);
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::increment_wrapped_balance<T0, T1>(arg1, v39, false, v33, &v0);
                v39 = v39 + 1;
            };
            let v40 = 0;
            while (v40 < v6) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::decrement_wrapped_balance<T0, T1>(arg1, v40, false, v33, &v0);
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::decrement_outcome_allocation<T0, T1>(arg1, v40, 0, v33, &v0);
                v40 = v40 + 1;
            };
            0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::return_stable_from_arbitrage<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::withdraw_stable_balance<T0, T1>(arg1, v33, arg6, &v0)));
            (v34, v7, v33)
        };
        0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::assert_quantum_invariant<T0, T1>(arg1);
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::update_twap_after_arbitrage<T0, T1, T2>(arg0, arg5);
        let v41 = SystemRebalanceExecuted{
            market_id                    : v5,
            is_cond_to_spot              : v8,
            arb_amount_hint              : v7,
            actual_input                 : v13,
            actual_output                : v14,
            retained_system_dust_created : v12,
        };
        0x2::event::emit<SystemRebalanceExecuted>(v41);
        arg2
    }

    fun can_account_system_rebalance_asset_to_stable<T0, T1>(arg0: &0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_escrowed_asset_balance<T0, T1>(arg0) > 18446744073709551615 - arg2) {
            return false
        };
        let v0 = 0;
        while (v0 < arg1) {
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_outcome_asset_supply<T0, T1>(arg0, v0) > 18446744073709551615 - arg2) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_outcome_escrowed_asset<T0, T1>(arg0, v0) > 18446744073709551615 - arg2) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_pool_claim_asset<T0, T1>(arg0, v0) > 18446744073709551615 - arg2) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_outcome_stable_supply<T0, T1>(arg0, v0) > 18446744073709551615 - arg3) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_outcome_escrowed_stable<T0, T1>(arg0, v0) > 18446744073709551615 - arg3) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_pool_claim_stable<T0, T1>(arg0, v0) > 18446744073709551615 - arg3) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_outcome_wrapped_stable<T0, T1>(arg0, v0) > 18446744073709551615 - arg3) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun can_account_system_rebalance_stable_to_asset<T0, T1>(arg0: &0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_escrowed_stable_balance<T0, T1>(arg0) > 18446744073709551615 - arg2) {
            return false
        };
        let v0 = 0;
        while (v0 < arg1) {
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_outcome_stable_supply<T0, T1>(arg0, v0) > 18446744073709551615 - arg2) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_outcome_escrowed_stable<T0, T1>(arg0, v0) > 18446744073709551615 - arg2) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_pool_claim_stable<T0, T1>(arg0, v0) > 18446744073709551615 - arg2) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_outcome_asset_supply<T0, T1>(arg0, v0) > 18446744073709551615 - arg3) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_outcome_escrowed_asset<T0, T1>(arg0, v0) > 18446744073709551615 - arg3) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_pool_claim_asset<T0, T1>(arg0, v0) > 18446744073709551615 - arg3) {
                return false
            };
            if (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_outcome_wrapped_asset<T0, T1>(arg0, v0) > 18446744073709551615 - arg3) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun create_auth(arg0: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::EscrowMutationRegistry) : 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::EscrowMutationAuth {
        let v0 = EscrowMutationWitness{dummy_field: false};
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::create<EscrowMutationWitness>(arg0, v0)
    }

    fun create_market_auth(arg0: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::MarketStateMutationRegistry) : 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::MarketStateMutationAuth {
        let v0 = MarketStateMutationWitness{dummy_field: false};
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::create<MarketStateMutationWitness>(arg0, v0)
    }

    fun merge_balance_options<T0, T1>(arg0: 0x1::option::Option<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>, arg1: 0x1::option::Option<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>) : 0x1::option::Option<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>> {
        let v0 = if (0x1::option::is_some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg0)) {
            let v1 = 0x1::option::extract<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&mut arg0);
            if (0x1::option::is_some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg1)) {
                0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::merge<T0, T1>(&mut v1, 0x1::option::extract<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&mut arg1));
            };
            0x1::option::destroy_none<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(arg1);
            0x1::option::some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(v1)
        } else if (0x1::option::is_some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg1)) {
            arg1
        } else {
            0x1::option::destroy_none<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(arg1);
            0x1::option::none<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>()
        };
        0x1::option::destroy_none<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(arg0);
        v0
    }

    fun preview_constant_product_output(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = (arg2 as u256) * (arg0 as u256) / ((arg1 as u256) + (arg0 as u256));
        if (v1 >= (arg2 as u256)) {
            0
        } else {
            (v1 as u64)
        }
    }

    fun preview_system_rebalance_asset_to_stable(arg0: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg1: u64) : (u64, bool) {
        if (arg1 == 0) {
            return (0, false)
        };
        let v0 = 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0);
        if (v0 == 0) {
            return (0, false)
        };
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = false;
        let v4 = 0;
        while (v4 < v0) {
            let (v5, v6) = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_reserves(0x1::vector::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0, v4));
            let v7 = preview_constant_product_output(arg1, v5, v6);
            if (v7 == 0) {
                return (0, false)
            };
            if (v1 != 18446744073709551615 && v7 != v1) {
                v3 = true;
            };
            if (v7 < v1) {
                if (v1 != 18446744073709551615) {
                    v3 = true;
                };
                v2 = v7;
            };
            v4 = v4 + 1;
        };
        let (v8, v9) = if (v2 == 18446744073709551615) {
            (false, 0)
        } else {
            (v3, v2)
        };
        (v9, v8)
    }

    fun preview_system_rebalance_stable_to_asset(arg0: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg1: u64) : (u64, bool) {
        if (arg1 == 0) {
            return (0, false)
        };
        let v0 = 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0);
        if (v0 == 0) {
            return (0, false)
        };
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = false;
        let v4 = 0;
        while (v4 < v0) {
            let (v5, v6) = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_reserves(0x1::vector::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0, v4));
            let v7 = preview_constant_product_output(arg1, v6, v5);
            if (v7 == 0) {
                return (0, false)
            };
            if (v1 != 18446744073709551615 && v7 != v1) {
                v3 = true;
            };
            if (v7 < v1) {
                if (v1 != 18446744073709551615) {
                    v3 = true;
                };
                v2 = v7;
            };
            v4 = v4 + 1;
        };
        let (v8, v9) = if (v2 == 18446744073709551615) {
            (false, 0)
        } else {
            (v3, v2)
        };
        (v9, v8)
    }

    public fun swap_asset_to_stable_through_conditionals<T0, T1>(arg0: &mut 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::TokenEscrow<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::option::Option<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>, arg4: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::EscrowMutationRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x1::option::Option<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 105);
        let v1 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state<T0, T1>(arg0);
        0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::assert_swaps_allowed(v1, arg5);
        let v2 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::market_id(v1);
        let v3 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::outcome_count(v1);
        if (0x1::option::is_some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg3)) {
            assert!(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::market_id<T0, T1>(0x1::option::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg3)) == v2, 100);
        };
        assert!(v3 <= 255, 104);
        assert!(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_escrowed_stable_balance<T0, T1>(arg0) >= 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::arbitrage_math::quote_conditional_asset_to_stable(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::borrow_amm_pools(v1), v0), 106);
        let v4 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::new<T0, T1>(v2, (v3 as u8), arg6);
        0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::split_asset_to_balance<T0, T1>(arg0, &mut v4, arg1);
        let v5 = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::swap_core::begin_swap_session<T0, T1>(arg0);
        let v6 = 0;
        while (v6 < v3) {
            0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::swap_core::swap_balance_asset_to_stable<T0, T1>(&v5, arg0, &mut v4, (v6 as u8), v0, 0, arg4, arg5, arg6);
            v6 = v6 + 1;
        };
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::swap_core::finalize_swap_session<T0, T1>(v5, arg0, arg4);
        let v7 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::find_min_balance<T0, T1>(&v4, false);
        assert!(v7 > 0, 102);
        assert!(v7 >= arg2, 107);
        let v8 = if (!0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::is_empty<T0, T1>(&v4)) {
            0x1::option::some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(v4)
        } else {
            0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::destroy_empty<T0, T1>(v4);
            0x1::option::none<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>()
        };
        0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::assert_quantum_invariant<T0, T1>(arg0);
        (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::recombine_balance_to_stable<T0, T1>(arg0, &mut v4, v7, arg6), merge_balance_options<T0, T1>(arg3, v8))
    }

    public fun swap_stable_to_asset_through_conditionals<T0, T1>(arg0: &mut 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::TokenEscrow<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: 0x1::option::Option<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>, arg4: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::EscrowMutationRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1::option::Option<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 105);
        let v1 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state<T0, T1>(arg0);
        0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::assert_swaps_allowed(v1, arg5);
        let v2 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::market_id(v1);
        let v3 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::outcome_count(v1);
        if (0x1::option::is_some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg3)) {
            assert!(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::market_id<T0, T1>(0x1::option::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg3)) == v2, 100);
        };
        assert!(v3 <= 255, 104);
        assert!(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_escrowed_asset_balance<T0, T1>(arg0) >= 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::arbitrage_math::quote_conditional_stable_to_asset(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::borrow_amm_pools(v1), v0), 106);
        let v4 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::new<T0, T1>(v2, (v3 as u8), arg6);
        0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::split_stable_to_balance<T0, T1>(arg0, &mut v4, arg1);
        let v5 = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::swap_core::begin_swap_session<T0, T1>(arg0);
        let v6 = 0;
        while (v6 < v3) {
            0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::swap_core::swap_balance_stable_to_asset<T0, T1>(&v5, arg0, &mut v4, (v6 as u8), v0, 0, arg4, arg5, arg6);
            v6 = v6 + 1;
        };
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::swap_core::finalize_swap_session<T0, T1>(v5, arg0, arg4);
        let v7 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::find_min_balance<T0, T1>(&v4, true);
        assert!(v7 > 0, 102);
        assert!(v7 >= arg2, 107);
        let v8 = if (!0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::is_empty<T0, T1>(&v4)) {
            0x1::option::some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>(v4)
        } else {
            0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::destroy_empty<T0, T1>(v4);
            0x1::option::none<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::ConditionalMarketBalance<T0, T1>>()
        };
        0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::assert_quantum_invariant<T0, T1>(arg0);
        (0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_balance::recombine_balance_to_asset<T0, T1>(arg0, &mut v4, v7, arg6), merge_balance_options<T0, T1>(arg3, v8))
    }

    // decompiled from Move bytecode v6
}

