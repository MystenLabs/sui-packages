module 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::quantum_lp_manager {
    struct EscrowMutationWitness has drop {
        dummy_field: bool,
    }

    struct MarketStateMutationWitness has drop {
        dummy_field: bool,
    }

    fun assert_spot_pool_escrow_binding<T0, T1, T2>(arg0: &0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>) {
        let v0 = 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::get_active_escrow_id<T0, T1, T2>(arg0);
        if (0x1::option::is_some<0x2::object::ID>(&v0)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>>(arg1), 3);
        } else {
            let v1 = 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::get_active_proposal_id<T0, T1, T2>(arg0);
            if (0x1::option::is_some<0x2::object::ID>(&v1)) {
                assert!(*0x1::option::borrow<0x2::object::ID>(&v1) == 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::proposal_id(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state<T0, T1>(arg1)), 3);
            };
        };
    }

    public fun auto_quantum_split_on_proposal_start<T0, T1, T2>(arg0: &mut 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &mut 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::EscrowMutationRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext, arg7: 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::spot_pool_mutation_auth::SpotPoolMutationAuth) {
        assert!(0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::spot_pool_mutation_auth::target_id(&arg7) == 0x2::object::id<0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0), 6);
        assert!(!0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::is_locked_for_proposal<T0, T1, T2>(arg0), 2);
        assert_spot_pool_escrow_binding<T0, T1, T2>(arg0, arg1);
        0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::check_proposal_gap<T0, T1, T2>(arg0, arg5);
        let (v0, v1) = 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
        let v2 = 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::math::mul_div_to_64(v0, arg3, 100);
        let v3 = 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::math::mul_div_to_64(v1, arg3, 100);
        assert!(v2 > 0 && v3 > 0, 7);
        0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::set_active_proposal<T0, T1, T2>(arg0, arg2);
        let (v4, v5) = 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::split_reserves_for_quantum<T0, T1, T2>(arg0, v2, v3);
        let v6 = EscrowMutationWitness{dummy_field: false};
        let v7 = 0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::create<EscrowMutationWitness>(arg4, v6);
        let (_, _) = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::lp_deposit_quantum<T0, T1>(arg1, v4, v5, &v7);
        let v10 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v7);
        let v11 = 0;
        while (v11 < 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::outcome_count(v10)) {
            0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::add_liquidity_proportional(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::get_pool_mut_by_outcome(v10, v11, &v7), v2, v3, 0, arg5, arg6);
            v11 = v11 + 1;
        };
    }

    public fun auto_redeem_on_proposal_end_from_escrow<T0, T1, T2>(arg0: u64, arg1: &mut 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &mut 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>, arg3: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::EscrowMutationRegistry, arg4: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::market_state_mutation_auth::MarketStateMutationRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext, arg7: 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::spot_pool_mutation_auth::SpotPoolMutationAuth) {
        assert!(0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::spot_pool_mutation_auth::target_id(&arg7) == 0x2::object::id<0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1), 6);
        assert_spot_pool_escrow_binding<T0, T1, T2>(arg1, arg2);
        let v0 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state<T0, T1>(arg2);
        assert!(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::is_finalized(v0), 4);
        assert!(arg0 == 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::get_winning_outcome(v0), 5);
        let v1 = EscrowMutationWitness{dummy_field: false};
        let v2 = 0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::create<EscrowMutationWitness>(arg3, v1);
        let v3 = MarketStateMutationWitness{dummy_field: false};
        let v4 = 0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::market_state_mutation_auth::create<MarketStateMutationWitness>(arg4, v3);
        let v5 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state_mut<T0, T1>(arg2, &v2);
        let v6 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::outcome_count(v5);
        assert!(arg0 < v6, 1);
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < v6) {
            let (v10, v11) = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::empty_all_amm_liquidity(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::get_pool_mut_by_outcome(v5, v9, &v2), arg6, &v4);
            if (v9 == arg0) {
                v7 = v10;
                v8 = v11;
            };
            v9 = v9 + 1;
        };
        let v12 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_lp_deposited_asset<T0, T1>(arg2);
        let v13 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_lp_deposited_stable<T0, T1>(arg2);
        let v14 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_escrowed_asset_balance<T0, T1>(arg2);
        let v15 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_escrowed_stable_balance<T0, T1>(arg2);
        let v16 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_outcome_asset_supply<T0, T1>(arg2, arg0);
        let v17 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_outcome_stable_supply<T0, T1>(arg2, arg0);
        let v18 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_outcome_escrowed_asset<T0, T1>(arg2, arg0);
        let v19 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_outcome_escrowed_stable<T0, T1>(arg2, arg0);
        let v20 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_pool_claim_asset<T0, T1>(arg2, arg0);
        let v21 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_pool_claim_stable<T0, T1>(arg2, arg0);
        let v22 = if (v18 > v20) {
            v18 - v20
        } else {
            0
        };
        let v23 = if (v19 > v21) {
            v19 - v21
        } else {
            0
        };
        let v24 = if (v14 > v22) {
            v14 - v22
        } else {
            0
        };
        let v25 = if (v15 > v23) {
            v15 - v23
        } else {
            0
        };
        let v26 = if (v7 < v12) {
            v7
        } else {
            v12
        };
        let v27 = if (v26 < v16) {
            v26
        } else {
            v16
        };
        let v28 = if (v27 < v24) {
            v27
        } else {
            v24
        };
        let v29 = if (v28 < v20) {
            v28
        } else {
            v20
        };
        let v30 = if (v8 < v13) {
            v8
        } else {
            v13
        };
        let v31 = if (v30 < v17) {
            v30
        } else {
            v17
        };
        let v32 = if (v31 < v25) {
            v31
        } else {
            v25
        };
        let v33 = if (v32 < v21) {
            v32
        } else {
            v21
        };
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::decrement_lp_backing<T0, T1>(arg2, v29, v33, &v2);
        if (v29 > 0) {
            0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::decrement_supply_for_outcome<T0, T1>(arg2, arg0, true, v29, &v2);
        };
        if (v33 > 0) {
            0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::decrement_supply_for_outcome<T0, T1>(arg2, arg0, false, v33, &v2);
        };
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::decrement_outcome_allocation<T0, T1>(arg2, arg0, v29, v33, &v2);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::decrement_pool_claim<T0, T1>(arg2, arg0, v29, v33, &v2);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::assert_quantum_invariant<T0, T1>(arg2);
        let v34 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::get_pool_by_outcome(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state<T0, T1>(arg2), arg0);
        let (v35, v36) = compute_post_finalize_sweep_amounts<T0, T1>(arg2, arg0, 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::get_protocol_fees_asset(v34), 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::get_protocol_fees_stable(v34));
        let v37 = 0x2::coin::into_balance<T0>(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::withdraw_asset_balance<T0, T1>(arg2, v29, arg6, &v2));
        let v38 = 0x2::coin::into_balance<T1>(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::withdraw_stable_balance<T0, T1>(arg2, v33, arg6, &v2));
        let v39 = v12 - v29;
        let v40 = v13 - v33;
        let v41 = if (v35 < v39) {
            v35
        } else {
            v39
        };
        let v42 = if (v36 < v40) {
            v36
        } else {
            v40
        };
        if (v41 > 0 || v42 > 0) {
            0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::decrement_lp_backing<T0, T1>(arg2, v41, v42, &v2);
        };
        if (v35 > 0) {
            let v43 = v35 - v41;
            if (v43 > 0) {
                0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::decrement_user_backing<T0, T1>(arg2, v43, true, &v2);
            };
            0x2::balance::join<T0>(&mut v37, 0x2::coin::into_balance<T0>(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::withdraw_asset_balance<T0, T1>(arg2, v35, arg6, &v2)));
        };
        if (v36 > 0) {
            let v44 = v36 - v42;
            if (v44 > 0) {
                0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::decrement_user_backing<T0, T1>(arg2, v44, false, &v2);
            };
            0x2::balance::join<T1>(&mut v38, 0x2::coin::into_balance<T1>(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::withdraw_stable_balance<T0, T1>(arg2, v36, arg6, &v2)));
        };
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::assert_quantum_invariant<T0, T1>(arg2);
        0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::add_liquidity_from_quantum_redeem<T0, T1, T2>(arg1, v37, v38);
        0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::update_twap_after_arbitrage<T0, T1, T2>(arg1, arg5);
        0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::clear_active_proposal<T0, T1, T2>(arg1, arg5);
    }

    fun compute_post_finalize_sweep_amounts<T0, T1>(arg0: &0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_escrowed_asset_balance<T0, T1>(arg0);
        let v1 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_escrowed_stable_balance<T0, T1>(arg0);
        let v2 = (0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_outcome_escrowed_asset<T0, T1>(arg0, arg1) as u128) + (arg2 as u128);
        let v3 = (0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_outcome_escrowed_stable<T0, T1>(arg0, arg1) as u128) + (arg3 as u128);
        let v4 = if ((v0 as u128) > v2) {
            (((v0 as u128) - v2) as u64)
        } else {
            0
        };
        let v5 = if ((v1 as u128) > v3) {
            (((v1 as u128) - v3) as u64)
        } else {
            0
        };
        (v4, v5)
    }

    // decompiled from Move bytecode v6
}

