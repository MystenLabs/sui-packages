module 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::swap_core {
    struct EscrowMutationWitness has drop {
        dummy_field: bool,
    }

    struct SwapSession {
        market_id: 0x2::object::ID,
    }

    public fun swap_asset_to_stable<T0, T1, T2, T3>(arg0: &SwapSession, arg1: &mut 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::EscrowMutationRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(arg2 <= 255, 8);
        let v0 = 0x2::coin::value<T2>(&arg3);
        let v1 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state<T0, T1>(arg1);
        assert!(arg0.market_id == 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::market_id(v1), 6);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::assert_swaps_allowed(v1, arg6);
        assert!(arg2 < 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::outcome_count(v1), 0);
        let v2 = create_auth(arg5);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::burn_conditional<T0, T1, T2>(arg1, arg2, true, arg3, &v2);
        let v3 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v2);
        let v4 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::swap_asset_to_stable(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::get_pool_mut_by_outcome(v3, arg2, &v2), 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::market_id(v3), v0, arg4, arg6, arg7);
        assert!(v4 >= arg4, 5);
        assert!(v4 > 0, 9);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::track_swap_asset_to_stable<T0, T1>(arg1, arg2, v0, v4, &v2);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::mint_conditional<T0, T1, T3>(arg1, arg2, false, v4, arg7, &v2)
    }

    public fun swap_stable_to_asset<T0, T1, T2, T3>(arg0: &SwapSession, arg1: &mut 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T3>, arg4: u64, arg5: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::EscrowMutationRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg2 <= 255, 8);
        let v0 = 0x2::coin::value<T3>(&arg3);
        let v1 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state<T0, T1>(arg1);
        assert!(arg0.market_id == 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::market_id(v1), 6);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::assert_swaps_allowed(v1, arg6);
        assert!(arg2 < 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::outcome_count(v1), 0);
        let v2 = create_auth(arg5);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::burn_conditional<T0, T1, T3>(arg1, arg2, false, arg3, &v2);
        let v3 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v2);
        let v4 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::swap_stable_to_asset(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::get_pool_mut_by_outcome(v3, arg2, &v2), 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::market_id(v3), v0, arg4, arg6, arg7);
        assert!(v4 >= arg4, 5);
        assert!(v4 > 0, 9);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::track_swap_stable_to_asset<T0, T1>(arg1, arg2, v0, v4, &v2);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::mint_conditional<T0, T1, T2>(arg1, arg2, true, v4, arg7, &v2)
    }

    public fun begin_swap_session<T0, T1>(arg0: &0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>) : SwapSession {
        SwapSession{market_id: 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::market_id(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state<T0, T1>(arg0))}
    }

    public(friend) fun create_auth(arg0: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::EscrowMutationRegistry) : 0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::EscrowMutationAuth {
        let v0 = EscrowMutationWitness{dummy_field: false};
        0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::create<EscrowMutationWitness>(arg0, v0)
    }

    public fun finalize_swap_session<T0, T1>(arg0: SwapSession, arg1: &mut 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>, arg2: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::EscrowMutationRegistry) {
        let SwapSession { market_id: v0 } = arg0;
        let v1 = create_auth(arg2);
        assert!(v0 == 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::market_id(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v1)), 6);
    }

    public fun swap_balance_asset_to_stable<T0, T1>(arg0: &SwapSession, arg1: &mut 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>, arg2: &mut 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_balance::ConditionalMarketBalance<T0, T1>, arg3: u8, arg4: u64, arg5: u64, arg6: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::EscrowMutationRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = create_auth(arg6);
        let v1 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v0);
        let v2 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::market_id(v1);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::assert_swaps_allowed(v1, arg7);
        assert!(arg0.market_id == v2, 6);
        assert!(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_balance::market_id<T0, T1>(arg2) == v2, 7);
        assert!((arg3 as u64) < 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::outcome_count(v1), 0);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_balance::sub_from_balance<T0, T1>(arg2, arg3, true, arg4, &v0);
        let v3 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::swap_asset_to_stable(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::get_pool_mut_by_outcome(v1, (arg3 as u64), &v0), v2, arg4, arg5, arg7, arg8);
        assert!(v3 >= arg5, 5);
        assert!(v3 > 0, 9);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_balance::add_to_balance<T0, T1>(arg2, arg3, false, v3, &v0);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::decrement_wrapped_balance<T0, T1>(arg1, (arg3 as u64), true, arg4, &v0);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::increment_wrapped_balance<T0, T1>(arg1, (arg3 as u64), false, v3, &v0);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::track_swap_asset_to_stable<T0, T1>(arg1, (arg3 as u64), arg4, v3, &v0);
        v3
    }

    public fun swap_balance_stable_to_asset<T0, T1>(arg0: &SwapSession, arg1: &mut 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>, arg2: &mut 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_balance::ConditionalMarketBalance<T0, T1>, arg3: u8, arg4: u64, arg5: u64, arg6: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::escrow_mutation_auth::EscrowMutationRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = create_auth(arg6);
        let v1 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v0);
        let v2 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::market_id(v1);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::assert_swaps_allowed(v1, arg7);
        assert!(arg0.market_id == v2, 6);
        assert!(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_balance::market_id<T0, T1>(arg2) == v2, 7);
        assert!((arg3 as u64) < 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::outcome_count(v1), 0);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_balance::sub_from_balance<T0, T1>(arg2, arg3, false, arg4, &v0);
        let v3 = 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::swap_stable_to_asset(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::get_pool_mut_by_outcome(v1, (arg3 as u64), &v0), v2, arg4, arg5, arg7, arg8);
        assert!(v3 >= arg5, 5);
        assert!(v3 > 0, 9);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_balance::add_to_balance<T0, T1>(arg2, arg3, true, v3, &v0);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::decrement_wrapped_balance<T0, T1>(arg1, (arg3 as u64), false, arg4, &v0);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::increment_wrapped_balance<T0, T1>(arg1, (arg3 as u64), true, v3, &v0);
        0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::track_swap_stable_to_asset<T0, T1>(arg1, (arg3 as u64), arg4, v3, &v0);
        v3
    }

    // decompiled from Move bytecode v6
}

