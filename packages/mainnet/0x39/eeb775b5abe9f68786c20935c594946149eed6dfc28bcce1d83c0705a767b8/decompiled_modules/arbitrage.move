module 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::arbitrage {
    struct EscrowMutationWitness has drop {
        dummy_field: bool,
    }

    struct MarketStateMutationWitness has drop {
        dummy_field: bool,
    }

    struct ArbitrageExecuted has copy, drop {
        market_id: 0x2::object::ID,
        is_cond_to_spot: bool,
        arb_amount_hint: u64,
        actual_input: u64,
        actual_output: u64,
        dust_created: bool,
    }

    public fun auto_rebalance_spot_after_conditional_swaps<T0, T1, T2>(arg0: &mut 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &mut 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x1::option::Option<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>, arg3: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::escrow_mutation_auth::EscrowMutationRegistry, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>> {
        let v0 = create_auth(arg3);
        let v1 = create_market_auth(arg4);
        let v2 = 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::get_active_escrow_id<T0, T1, T2>(arg0);
        if (0x1::option::is_some<0x2::object::ID>(&v2)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v2) == 0x2::object::id<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::TokenEscrow<T0, T1>>(arg1), 103);
        } else {
            if (!0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::is_locked_for_proposal<T0, T1, T2>(arg0)) {
                return arg2
            };
            let v3 = 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::get_active_proposal_id<T0, T1, T2>(arg0);
            assert!(*0x1::option::borrow<0x2::object::ID>(&v3) == 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::proposal_id(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::get_market_state<T0, T1>(arg1)), 103);
        };
        let v4 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::get_market_state<T0, T1>(arg1);
        let (v5, v6, _) = 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::arbitrage_math::compute_optimal_arbitrage<T0, T1, T2>(arg0, 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::borrow_amm_pools(v4), 0);
        let v8 = v6 == 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::arbitrage_math::route_cond_to_spot();
        let v9 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::market_id(v4);
        let v10 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::outcome_count(v4);
        if (0x1::option::is_some<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg2)) {
            assert!(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::market_id<T0, T1>(0x1::option::borrow<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg2)) == v9, 100);
        };
        assert!(v10 <= 255, 104);
        if (v5 == 0) {
            return arg2
        };
        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::assert_swaps_allowed(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::get_market_state<T0, T1>(arg1), arg5);
        let (v11, v12) = 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
        let (v13, v14, v15) = if (v8) {
            let v16 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::borrow_amm_pools(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::get_market_state<T0, T1>(arg1));
            let v17 = 0;
            let v18 = v17;
            let v19 = 0;
            while (v19 < v10) {
                let (v20, v21) = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::get_reserves(0x1::vector::borrow<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>(v16, v19));
                if (v5 >= v20) {
                    return arg2
                };
                let v22 = ((v20 - v5) as u128);
                let v23 = ((v21 as u128) * (v5 as u128) + v22 - 1) / v22;
                assert!(v23 <= 18446744073709551615, 101);
                let v24 = (v23 as u64);
                if (v24 > v17) {
                    v18 = v24;
                };
                v19 = v19 + 1;
            };
            if (v12 < v18) {
                return arg2
            };
            0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::deposit_spot_liquidity<T0, T1>(arg1, 0x2::balance::zero<T0>(), 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::take_stable_for_arbitrage<T0, T1, T2>(arg0, v18), &v0);
            0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::decrement_lp_backing<T0, T1>(arg1, 0, v18, &v0);
            0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::increment_supplies_for_all_outcomes<T0, T1>(arg1, 0, v18, &v0);
            let v25 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v0);
            let v26 = 0;
            while (v26 < v10) {
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::inject_reserves_for_arbitrage(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::get_pool_mut_by_outcome(v25, v26, &v0), v9, 0, v18, &v1);
                v26 = v26 + 1;
            };
            let v27 = vector[];
            v26 = 0;
            while (v26 < v10) {
                0x1::vector::push_back<u64>(&mut v27, 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::swap_from_injected_stable_to_asset(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::get_pool_mut_by_outcome(v25, v26, &v0), v9, v18, arg5, &v1));
                v26 = v26 + 1;
            };
            let v28 = *0x1::vector::borrow<u64>(&v27, 0);
            v26 = 1;
            while (v26 < v10) {
                let v29 = *0x1::vector::borrow<u64>(&v27, v26);
                if (v29 < v28) {
                    v28 = v29;
                };
                v26 = v26 + 1;
            };
            assert!(v28 > 0, 102);
            v26 = 0;
            while (v26 < v10) {
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::extract_reserves_for_arbitrage(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::get_pool_mut_by_outcome(v25, v26, &v0), v9, *0x1::vector::borrow<u64>(&v27, v26), 0, &v1);
                v26 = v26 + 1;
            };
            let v30 = 0;
            while (v30 < v10) {
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::track_system_swap_stable_to_asset<T0, T1>(arg1, v30, v18, *0x1::vector::borrow<u64>(&v27, v30), &v0);
                v30 = v30 + 1;
            };
            let v31 = 0;
            while (v31 < v10) {
                let v32 = *0x1::vector::borrow<u64>(&v27, v31);
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::decrement_supply_for_outcome<T0, T1>(arg1, v31, true, v32, &v0);
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::decrement_pool_claim<T0, T1>(arg1, v31, v32, 0, &v0);
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::increment_wrapped_balance<T0, T1>(arg1, v31, true, v32, &v0);
                v31 = v31 + 1;
            };
            let v33 = 0;
            while (v33 < v10) {
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::decrement_wrapped_balance<T0, T1>(arg1, v33, true, v28, &v0);
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::decrement_outcome_allocation<T0, T1>(arg1, v33, v28, 0, &v0);
                v33 = v33 + 1;
            };
            0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::return_asset_from_arbitrage<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::withdraw_asset_balance<T0, T1>(arg1, v28, arg6, &v0)));
            let v34 = false;
            let v35 = 0;
            while (v35 < v10) {
                if (*0x1::vector::borrow<u64>(&v27, v35) > v28) {
                    v34 = true;
                    break
                };
                v35 = v35 + 1;
            };
            let v36 = if (v34) {
                let v37 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::new<T0, T1>(v9, (v10 as u8), arg6);
                v35 = 0;
                while (v35 < v10) {
                    let v38 = *0x1::vector::borrow<u64>(&v27, v35) - v28;
                    if (v38 > 0) {
                        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::increment_dust_created<T0, T1>(arg1, v35, true, v38, &v0);
                        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::add_to_balance<T0, T1>(&mut v37, (v35 as u8), true, v38, &v0);
                    };
                    v35 = v35 + 1;
                };
                0x1::option::some<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(v37)
            } else {
                0x1::option::none<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>()
            };
            (v36, v18, v28)
        } else {
            if (v11 < v5) {
                return arg2
            };
            0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::deposit_spot_liquidity<T0, T1>(arg1, 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::take_asset_for_arbitrage<T0, T1, T2>(arg0, v5), 0x2::balance::zero<T1>(), &v0);
            0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::decrement_lp_backing<T0, T1>(arg1, v5, 0, &v0);
            0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::increment_supplies_for_all_outcomes<T0, T1>(arg1, v5, 0, &v0);
            let v39 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v0);
            let v40 = 0;
            while (v40 < v10) {
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::inject_reserves_for_arbitrage(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::get_pool_mut_by_outcome(v39, v40, &v0), v9, v5, 0, &v1);
                v40 = v40 + 1;
            };
            let v41 = vector[];
            v40 = 0;
            while (v40 < v10) {
                0x1::vector::push_back<u64>(&mut v41, 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::swap_from_injected_asset_to_stable(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::get_pool_mut_by_outcome(v39, v40, &v0), v9, v5, arg5, &v1));
                v40 = v40 + 1;
            };
            let v42 = *0x1::vector::borrow<u64>(&v41, 0);
            v40 = 1;
            while (v40 < v10) {
                let v43 = *0x1::vector::borrow<u64>(&v41, v40);
                if (v43 < v42) {
                    v42 = v43;
                };
                v40 = v40 + 1;
            };
            assert!(v42 > 0, 102);
            v40 = 0;
            while (v40 < v10) {
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::extract_reserves_for_arbitrage(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::get_pool_mut_by_outcome(v39, v40, &v0), v9, 0, *0x1::vector::borrow<u64>(&v41, v40), &v1);
                v40 = v40 + 1;
            };
            let v44 = 0;
            while (v44 < v10) {
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::track_system_swap_asset_to_stable<T0, T1>(arg1, v44, v5, *0x1::vector::borrow<u64>(&v41, v44), &v0);
                v44 = v44 + 1;
            };
            let v45 = 0;
            while (v45 < v10) {
                let v46 = *0x1::vector::borrow<u64>(&v41, v45);
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::decrement_supply_for_outcome<T0, T1>(arg1, v45, false, v46, &v0);
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::decrement_pool_claim<T0, T1>(arg1, v45, 0, v46, &v0);
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::increment_wrapped_balance<T0, T1>(arg1, v45, false, v46, &v0);
                v45 = v45 + 1;
            };
            let v47 = 0;
            while (v47 < v10) {
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::decrement_wrapped_balance<T0, T1>(arg1, v47, false, v42, &v0);
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::decrement_outcome_allocation<T0, T1>(arg1, v47, 0, v42, &v0);
                v47 = v47 + 1;
            };
            0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::return_stable_from_arbitrage<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::withdraw_stable_balance<T0, T1>(arg1, v42, arg6, &v0)));
            let v48 = false;
            let v49 = 0;
            while (v49 < v10) {
                if (*0x1::vector::borrow<u64>(&v41, v49) > v42) {
                    v48 = true;
                    break
                };
                v49 = v49 + 1;
            };
            let v50 = if (v48) {
                let v51 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::new<T0, T1>(v9, (v10 as u8), arg6);
                v49 = 0;
                while (v49 < v10) {
                    let v52 = *0x1::vector::borrow<u64>(&v41, v49) - v42;
                    if (v52 > 0) {
                        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::increment_dust_created<T0, T1>(arg1, v49, false, v52, &v0);
                        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::add_to_balance<T0, T1>(&mut v51, (v49 as u8), false, v52, &v0);
                    };
                    v49 = v49 + 1;
                };
                0x1::option::some<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(v51)
            } else {
                0x1::option::none<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>()
            };
            (v50, v5, v42)
        };
        let v53 = v13;
        let v54 = if (0x1::option::is_some<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg2)) {
            let v55 = 0x1::option::extract<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(&mut arg2);
            if (0x1::option::is_some<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(&v53)) {
                0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::merge<T0, T1>(&mut v55, 0x1::option::extract<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(&mut v53));
            };
            0x1::option::destroy_none<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(v53);
            0x1::option::some<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(v55)
        } else if (0x1::option::is_some<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(&v53)) {
            v53
        } else {
            0x1::option::destroy_none<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(v53);
            0x1::option::none<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>()
        };
        0x1::option::destroy_none<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(arg2);
        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::assert_quantum_invariant<T0, T1>(arg1);
        0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::update_twap_after_arbitrage<T0, T1, T2>(arg0, arg5);
        let v56 = ArbitrageExecuted{
            market_id       : v9,
            is_cond_to_spot : v8,
            arb_amount_hint : v5,
            actual_input    : v14,
            actual_output   : v15,
            dust_created    : 0x1::option::is_some<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_balance::ConditionalMarketBalance<T0, T1>>(&v53),
        };
        0x2::event::emit<ArbitrageExecuted>(v56);
        v54
    }

    fun create_auth(arg0: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::escrow_mutation_auth::EscrowMutationRegistry) : 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::escrow_mutation_auth::EscrowMutationAuth {
        let v0 = EscrowMutationWitness{dummy_field: false};
        0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::escrow_mutation_auth::create<EscrowMutationWitness>(arg0, v0)
    }

    fun create_market_auth(arg0: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationRegistry) : 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth {
        let v0 = MarketStateMutationWitness{dummy_field: false};
        0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::create<MarketStateMutationWitness>(arg0, v0)
    }

    // decompiled from Move bytecode v6
}

