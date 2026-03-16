module 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::swap_core {
    struct EscrowMutationWitness has drop {
        dummy_field: bool,
    }

    struct SwapSession {
        market_id: 0x2::object::ID,
    }

    public fun swap_asset_to_stable<T0, T1, T2, T3>(arg0: &SwapSession, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::EscrowMutationRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(arg2 <= 255, 8);
        let v0 = 0x2::coin::value<T2>(&arg3);
        let v1 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state<T0, T1>(arg1);
        assert!(arg0.market_id == 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::market_id(v1), 6);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::assert_swaps_allowed(v1, arg6);
        assert!(arg2 < 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::outcome_count(v1), 0);
        let v2 = create_auth(arg5);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::burn_conditional<T0, T1, T2>(arg1, arg2, true, arg3, &v2);
        let v3 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v2);
        let v4 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_amm::swap_asset_to_stable(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::get_pool_mut_by_outcome(v3, arg2, &v2), 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::market_id(v3), v0, arg4, arg6, arg7);
        assert!(v4 >= arg4, 5);
        assert!(v4 > 0, 9);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::track_swap_asset_to_stable<T0, T1>(arg1, arg2, v0, v4, &v2);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::mint_conditional<T0, T1, T3>(arg1, arg2, false, v4, arg7, &v2)
    }

    public fun swap_stable_to_asset<T0, T1, T2, T3>(arg0: &SwapSession, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T3>, arg4: u64, arg5: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::EscrowMutationRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg2 <= 255, 8);
        let v0 = 0x2::coin::value<T3>(&arg3);
        let v1 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state<T0, T1>(arg1);
        assert!(arg0.market_id == 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::market_id(v1), 6);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::assert_swaps_allowed(v1, arg6);
        assert!(arg2 < 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::outcome_count(v1), 0);
        let v2 = create_auth(arg5);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::burn_conditional<T0, T1, T3>(arg1, arg2, false, arg3, &v2);
        let v3 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v2);
        let v4 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_amm::swap_stable_to_asset(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::get_pool_mut_by_outcome(v3, arg2, &v2), 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::market_id(v3), v0, arg4, arg6, arg7);
        assert!(v4 >= arg4, 5);
        assert!(v4 > 0, 9);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::track_swap_stable_to_asset<T0, T1>(arg1, arg2, v0, v4, &v2);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::mint_conditional<T0, T1, T2>(arg1, arg2, true, v4, arg7, &v2)
    }

    public fun begin_swap_session<T0, T1>(arg0: &0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>) : SwapSession {
        SwapSession{market_id: 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::market_id(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state<T0, T1>(arg0))}
    }

    public(friend) fun create_auth(arg0: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::EscrowMutationRegistry) : 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::EscrowMutationAuth {
        let v0 = EscrowMutationWitness{dummy_field: false};
        0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::create<EscrowMutationWitness>(arg0, v0)
    }

    public fun finalize_swap_session<T0, T1>(arg0: SwapSession, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::EscrowMutationRegistry) {
        let SwapSession { market_id: v0 } = arg0;
        let v1 = create_auth(arg2);
        assert!(v0 == 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::market_id(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v1)), 6);
    }

    public fun swap_balance_asset_to_stable<T0, T1>(arg0: &SwapSession, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::ConditionalMarketBalance<T0, T1>, arg3: u8, arg4: u64, arg5: u64, arg6: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::EscrowMutationRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = create_auth(arg6);
        let v1 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v0);
        let v2 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::market_id(v1);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::assert_swaps_allowed(v1, arg7);
        assert!(arg0.market_id == v2, 6);
        assert!(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::market_id<T0, T1>(arg2) == v2, 7);
        assert!((arg3 as u64) < 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::outcome_count(v1), 0);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::sub_from_balance<T0, T1>(arg2, arg3, true, arg4, &v0);
        let v3 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_amm::swap_asset_to_stable(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::get_pool_mut_by_outcome(v1, (arg3 as u64), &v0), v2, arg4, arg5, arg7, arg8);
        assert!(v3 >= arg5, 5);
        assert!(v3 > 0, 9);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::add_to_balance<T0, T1>(arg2, arg3, false, v3, &v0);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::decrement_wrapped_balance<T0, T1>(arg1, (arg3 as u64), true, arg4, &v0);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::increment_wrapped_balance<T0, T1>(arg1, (arg3 as u64), false, v3, &v0);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::track_swap_asset_to_stable<T0, T1>(arg1, (arg3 as u64), arg4, v3, &v0);
        v3
    }

    public fun swap_balance_stable_to_asset<T0, T1>(arg0: &SwapSession, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::ConditionalMarketBalance<T0, T1>, arg3: u8, arg4: u64, arg5: u64, arg6: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::EscrowMutationRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = create_auth(arg6);
        let v1 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v0);
        let v2 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::market_id(v1);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::assert_swaps_allowed(v1, arg7);
        assert!(arg0.market_id == v2, 6);
        assert!(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::market_id<T0, T1>(arg2) == v2, 7);
        assert!((arg3 as u64) < 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::outcome_count(v1), 0);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::sub_from_balance<T0, T1>(arg2, arg3, false, arg4, &v0);
        let v3 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_amm::swap_stable_to_asset(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::get_pool_mut_by_outcome(v1, (arg3 as u64), &v0), v2, arg4, arg5, arg7, arg8);
        assert!(v3 >= arg5, 5);
        assert!(v3 > 0, 9);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::add_to_balance<T0, T1>(arg2, arg3, true, v3, &v0);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::decrement_wrapped_balance<T0, T1>(arg1, (arg3 as u64), false, arg4, &v0);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::increment_wrapped_balance<T0, T1>(arg1, (arg3 as u64), true, v3, &v0);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::track_swap_stable_to_asset<T0, T1>(arg1, (arg3 as u64), arg4, v3, &v0);
        v3
    }

    // decompiled from Move bytecode v6
}

