module 0x1c00074e80bcb82298b8cb4f743af3f9423b057bfdfaea40e085f62960021f4e::proposal_lifecycle {
    struct ProposalMutationWitness has drop {
        dummy_field: bool,
    }

    struct SpotPoolMutationWitness has drop {
        dummy_field: bool,
    }

    struct MarketStateMutationWitness has drop {
        dummy_field: bool,
    }

    struct EscrowMutationWitness has drop {
        dummy_field: bool,
    }

    struct ProposalActivated has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        has_intent_spec: bool,
        timestamp: u64,
    }

    struct ProposalMarketFinalized has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        winning_outcome: u64,
        approved: bool,
        timestamp: u64,
    }

    struct ProposalIntentExecuted has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        intent_key: 0x1::string::String,
        timestamp: u64,
    }

    struct ExecutionWindowStarted has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        market_winner: u64,
        execution_deadline: u64,
        timestamp: u64,
    }

    struct ExecutionTimedOut has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        market_winner: u64,
        actual_winner: u64,
        timestamp: u64,
    }

    struct ProposerFeeToTreasury has copy, drop {
        proposal_id: 0x2::object::ID,
        treasury_address: address,
        amount: u64,
        fee_in_asset: bool,
    }

    public fun advance_proposal_state<T0, T1, T2>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::ProposalMutationRegistry, arg2: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg3: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::MarketStateMutationRegistry, arg4: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::EscrowMutationRegistry, arg5: &mut 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>, arg6: &mut 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (bool, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = ProposalMutationWitness{dummy_field: false};
        let v1 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::create<ProposalMutationWitness>(arg1, v0, 0x2::object::id<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>>(arg5));
        assert!(0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::has_active_escrow<T0, T1, T2>(arg6), 21);
        let v2 = SpotPoolMutationWitness{dummy_field: false};
        let v3 = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg6, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v2, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_dao_id<T0, T1>(arg5) == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), 17);
        assert!(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::market_state_id<T0, T1>(&v3) == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::market_state_id<T0, T1>(arg5), 8);
        let v4 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg0);
        let v5 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::get_spot_pool_id(v4);
        assert!(0x1::option::is_some<0x2::object::ID>(&v5), 19);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v5) == 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6), 18);
        let v6 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_state<T0, T1>(arg5);
        let (arg7, arg8) = if (0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_state<T0, T1>(arg5) != v6 && v6 == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::state_trading()) {
            let v7 = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::calculate_scaled_gap_fee<T0, T1, T2>(arg6, 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::proposal_creation_fee(v4), arg9);
            let (arg7, arg8) = if (0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::fee_in_asset_token(v4)) {
                assert!(0x2::coin::value<T1>(&arg8) == 0, 12);
                if (v7 > 0) {
                    assert!(0x2::coin::value<T0>(&arg7) >= v7, 11);
                    let v8 = SpotPoolMutationWitness{dummy_field: false};
                    0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::deposit_protocol_fees_asset<T0, T1, T2>(arg6, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg7), v7), 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v8, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
                };
                (arg7, arg8)
            } else {
                assert!(0x2::coin::value<T0>(&arg7) == 0, 12);
                if (v7 > 0) {
                    assert!(0x2::coin::value<T1>(&arg8) >= v7, 11);
                    let v9 = SpotPoolMutationWitness{dummy_field: false};
                    0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::deposit_protocol_fees_stable<T0, T1, T2>(arg6, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg8), v7), 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v9, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
                };
                (arg7, arg8)
            };
            let v10 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::conditional_liquidity_ratio_percent(v4);
            let v11 = SpotPoolMutationWitness{dummy_field: false};
            0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::mark_liquidity_to_proposal<T0, T1, T2>(arg6, v10, arg9, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v11, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
            let v12 = SpotPoolMutationWitness{dummy_field: false};
            0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::quantum_lp_manager::auto_quantum_split_on_proposal_start<T0, T1, T2>(arg6, &mut v3, 0x2::object::id<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>>(arg5), v10, arg4, arg9, arg10, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v12, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
            (arg7, arg8)
        } else {
            (arg7, arg8)
        };
        let v13 = SpotPoolMutationWitness{dummy_field: false};
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::store_active_escrow<T0, T1, T2>(arg6, v3, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v13, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
        (0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::advance_state<T0, T1, T2>(arg5, &v1, &mut v3, arg3, arg4, arg6, *0x1::option::borrow<0x2::object::ID>(&v5), arg9, arg10), arg7, arg8)
    }

    public fun calculate_winning_outcome_with_twaps<T0, T1, T2>(arg0: &mut 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>, arg1: &mut 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::EscrowMutationRegistry, arg3: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::MarketStateMutationRegistry, arg4: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg5: &0x2::clock::Clock) : (u64, vector<u128>) {
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        let v1 = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg4, v0, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1));
        let v2 = EscrowMutationWitness{dummy_field: false};
        let v3 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::create<EscrowMutationWitness>(arg2, v2);
        let v4 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::get_trading_end_time(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state_mut<T0, T1>(0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::borrow_active_escrow_mut<T0, T1, T2>(arg1, &v1), &v3));
        assert!(0x1::option::is_some<u64>(&v4), 20);
        let v5 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_twaps_for_proposal_at<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, *0x1::option::borrow<u64>(&v4), arg5);
        let v6 = 0x1::vector::length<u128>(&v5);
        let v7 = if (v6 > 0) {
            *0x1::vector::borrow<u128>(&v5, 0)
        } else {
            0
        };
        let v8 = (((0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_sponsored_threshold<T0, T1>(arg0) as u256) * (v7 as u256) / (0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::twap_threshold_base() as u256)) as u128);
        let v9 = if (v8 > v7) {
            0
        } else {
            v7 - v8
        };
        let v10 = false;
        let v11 = 1;
        while (v11 < v6) {
            let v12 = *0x1::vector::borrow<u128>(&v5, v11);
            let v13 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_outcome_sponsorship_type<T0, T1>(arg0, v11);
            if ((v13 == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::sponsorship_none() && v12 > v7 + (((0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_twap_threshold<T0, T1>(arg0) as u256) * (v7 as u256) / (0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::twap_threshold_base() as u256)) as u128) || v13 == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::sponsorship_zero_threshold() && v12 >= v7 || v13 == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::sponsorship_negative_discount() && v12 >= v9) && (!v10 || v12 > 0)) {
                v10 = true;
            };
            v11 = v11 + 1;
        };
        (0, v5)
    }

    public fun can_execute_proposal<T0, T1>(arg0: &0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>, arg1: &0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::MarketState, arg2: &0x2::clock::Clock) : bool {
        if (0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_state<T0, T1>(arg0) != 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::state_awaiting_execution()) {
            return false
        };
        if (0x2::object::id<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::MarketState>(arg1) != 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::market_state_id<T0, T1>(arg0)) {
            return false
        };
        if (!0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::can_execute(arg1, arg2)) {
            return false
        };
        let v0 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::get_market_winner(arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return false
        };
        *0x1::option::borrow<u64>(&v0) != 0
    }

    public(friend) fun emit_proposal_market_finalized(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: u64) {
        let v0 = ProposalMarketFinalized{
            proposal_id     : arg0,
            dao_id          : arg1,
            winning_outcome : arg2,
            approved        : arg3,
            timestamp       : arg4,
        };
        0x2::event::emit<ProposalMarketFinalized>(v0);
    }

    public fun end_trading_and_start_execution_window<T0, T1, T2>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::ProposalMutationRegistry, arg2: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg3: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::MarketStateMutationRegistry, arg4: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::EscrowMutationRegistry, arg5: &mut 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>, arg6: &mut 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg7: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = ProposalMutationWitness{dummy_field: false};
        let v1 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::create<ProposalMutationWitness>(arg1, v0, 0x2::object::id<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>>(arg5));
        let v2 = MarketStateMutationWitness{dummy_field: false};
        let v3 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::create<MarketStateMutationWitness>(arg3, v2);
        let v4 = EscrowMutationWitness{dummy_field: false};
        let v5 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::create<EscrowMutationWitness>(arg4, v4);
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_dao_id<T0, T1>(arg5) == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), 17);
        let v6 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::get_spot_pool_id(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg0));
        assert!(0x1::option::is_some<0x2::object::ID>(&v6), 19);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v6) == 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6), 18);
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_state<T0, T1>(arg5) == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::state_trading(), 9);
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::is_trading_period_ended<T0, T1>(arg5, arg8), 10);
        let (v7, v8) = calculate_winning_outcome_with_twaps<T0, T1, T2>(arg5, arg6, arg4, arg3, arg2, arg8);
        let v9 = SpotPoolMutationWitness{dummy_field: false};
        let v10 = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg6, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v9, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
        assert!(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::market_state_id<T0, T1>(&v10) == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::market_state_id<T0, T1>(arg5), 8);
        0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::set_twap_prices<T0, T1>(arg5, v8, &v1);
        if (v7 == 0) {
            0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::finalize_immediately_with_reject(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state_mut<T0, T1>(&mut v10, &v5), v8, arg8, &v3);
            0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::set_winning_outcome<T0, T1>(arg5, 0, &v1);
            let v11 = SpotPoolMutationWitness{dummy_field: false};
            0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::quantum_lp_manager::auto_redeem_on_proposal_end_from_escrow<T0, T1, T2>(0, arg6, &mut v10, arg4, arg3, arg8, arg9, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v11, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
            let v12 = SpotPoolMutationWitness{dummy_field: false};
            0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::archive_finalized_escrow<T0, T1, T2>(arg6, v10, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v12, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
            0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::set_state<T0, T1>(arg5, 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::state_finalized(), v1);
            let v13 = ProposalMutationWitness{dummy_field: false};
            let v14 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::create<ProposalMutationWitness>(arg1, v13, 0x2::object::id<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>>(arg5));
            let v15 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_num_outcomes<T0, T1>(arg5);
            assert!(v15 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::protocol_max_outcomes(), 13);
            let v16 = 1;
            while (v16 < v15) {
                let v17 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::make_cancel_witness<T0, T1>(arg5, v16, &v14);
                if (0x1::option::is_some<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::CancelWitness>(&v17)) {
                    0x1::option::extract<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::CancelWitness>(&mut v17);
                };
                0x1::option::destroy_none<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::CancelWitness>(v17);
                v16 = v16 + 1;
            };
            let v18 = ProposalMarketFinalized{
                proposal_id     : 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_id<T0, T1>(arg5),
                dao_id          : 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_dao_id<T0, T1>(arg5),
                winning_outcome : 0,
                approved        : false,
                timestamp       : 0x2::clock::timestamp_ms(arg8),
            };
            0x2::event::emit<ProposalMarketFinalized>(v18);
            send_fee_to_treasury<T0, T1>(arg5, arg1, arg0, arg7, arg9);
            return true
        };
        let v19 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::execution_window_ms();
        0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::start_execution_window(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state_mut<T0, T1>(&mut v10, &v5), v19, *0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_twap_prices<T0, T1>(arg5), v7, arg8, &v3);
        0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::set_state<T0, T1>(arg5, 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::state_awaiting_execution(), v1);
        let v20 = 0x2::clock::timestamp_ms(arg8);
        let v21 = ExecutionWindowStarted{
            proposal_id        : 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_id<T0, T1>(arg5),
            dao_id             : 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_dao_id<T0, T1>(arg5),
            market_winner      : v7,
            execution_deadline : v20 + v19,
            timestamp          : v20,
        };
        0x2::event::emit<ExecutionWindowStarted>(v21);
        let v22 = SpotPoolMutationWitness{dummy_field: false};
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::store_active_escrow<T0, T1, T2>(arg6, v10, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v22, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
        false
    }

    public fun force_reject_on_timeout<T0, T1, T2>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::ProposalMutationRegistry, arg2: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg3: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::MarketStateMutationRegistry, arg4: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::EscrowMutationRegistry, arg5: &mut 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>, arg6: &mut 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg7: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = ProposalMutationWitness{dummy_field: false};
        let v1 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::create<ProposalMutationWitness>(arg1, v0, 0x2::object::id<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>>(arg5));
        let v2 = MarketStateMutationWitness{dummy_field: false};
        let v3 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::create<MarketStateMutationWitness>(arg3, v2);
        let v4 = EscrowMutationWitness{dummy_field: false};
        let v5 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::escrow_mutation_auth::create<EscrowMutationWitness>(arg4, v4);
        let v6 = SpotPoolMutationWitness{dummy_field: false};
        let v7 = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg6, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v6, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_dao_id<T0, T1>(arg5) == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), 17);
        assert!(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::market_state_id<T0, T1>(&v7) == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::market_state_id<T0, T1>(arg5), 8);
        let v8 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::get_spot_pool_id(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg0));
        assert!(0x1::option::is_some<0x2::object::ID>(&v8), 19);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v8) == 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6), 18);
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_state<T0, T1>(arg5) == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::state_awaiting_execution(), 9);
        let v9 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state_mut<T0, T1>(&mut v7, &v5);
        0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::finalize_from_timeout(v9, arg8, &v3);
        let v10 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::get_market_winner(v9);
        let v11 = 0;
        0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::set_winning_outcome<T0, T1>(arg5, v11, &v1);
        let v12 = SpotPoolMutationWitness{dummy_field: false};
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::quantum_lp_manager::auto_redeem_on_proposal_end_from_escrow<T0, T1, T2>(v11, arg6, &mut v7, arg4, arg3, arg8, arg9, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v12, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
        let v13 = SpotPoolMutationWitness{dummy_field: false};
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::archive_finalized_escrow<T0, T1, T2>(arg6, v7, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v13, 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg6)));
        let v14 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_num_outcomes<T0, T1>(arg5);
        assert!(v14 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::protocol_max_outcomes(), 13);
        let v15 = 1;
        while (v15 < v14) {
            let v16 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::make_cancel_witness<T0, T1>(arg5, v15, &v1);
            if (0x1::option::is_some<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::CancelWitness>(&v16)) {
                0x1::option::extract<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::CancelWitness>(&mut v16);
            };
            0x1::option::destroy_none<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::CancelWitness>(v16);
            v15 = v15 + 1;
        };
        0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::set_state<T0, T1>(arg5, 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::state_finalized(), v1);
        let v17 = 0x2::clock::timestamp_ms(arg8);
        let v18 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_id<T0, T1>(arg5);
        let v19 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_dao_id<T0, T1>(arg5);
        let v20 = ExecutionTimedOut{
            proposal_id   : v18,
            dao_id        : v19,
            market_winner : *0x1::option::borrow<u64>(&v10),
            actual_winner : v11,
            timestamp     : v17,
        };
        0x2::event::emit<ExecutionTimedOut>(v20);
        let v21 = ProposalMarketFinalized{
            proposal_id     : v18,
            dao_id          : v19,
            winning_outcome : v11,
            approved        : false,
            timestamp       : v17,
        };
        0x2::event::emit<ProposalMarketFinalized>(v21);
        send_fee_to_treasury<T0, T1>(arg5, arg1, arg0, arg7, arg9);
    }

    public fun is_passed<T0, T1>(arg0: &0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>) : bool {
        0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::is_finalized<T0, T1>(arg0) && 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_winning_outcome<T0, T1>(arg0) != 0
    }

    public(friend) fun new_proposal_intent_executed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64) : ProposalIntentExecuted {
        ProposalIntentExecuted{
            proposal_id : arg0,
            dao_id      : arg1,
            intent_key  : arg2,
            timestamp   : arg3,
        }
    }

    fun send_fee_to_treasury<T0, T1>(arg0: &mut 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>, arg1: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::ProposalMutationRegistry, arg2: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg3: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ProposalMutationWitness{dummy_field: false};
        let v1 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::create<ProposalMutationWitness>(arg1, v0, 0x2::object::id<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>>(arg0));
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::addr(arg2);
        if (0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_total_fee_paid<T0, T1>(arg0) == 0 || !0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::has_fee_escrow<T0, T1>(arg0)) {
            return
        };
        let v3 = 0x1::string::utf8(b"treasury");
        if (0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::fee_paid_in_asset<T0, T1>(arg0)) {
            let v4 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::take_fee_escrow_asset<T0, T1>(arg0, &v1);
            let v5 = 0x2::balance::value<T0>(&v4);
            if (v5 > 0) {
                if (0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::has_vault(arg2, v3) && 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::can_deposit_coin_type<T0>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::borrow_vault(arg2, arg3, v3), &v3)) {
                    0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::deposit_approved<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig, T0>(arg2, arg3, v3, 0x2::coin::from_balance<T0>(v4, arg4));
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg4), v2);
                };
                let v6 = ProposerFeeToTreasury{
                    proposal_id      : 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_id<T0, T1>(arg0),
                    treasury_address : v2,
                    amount           : v5,
                    fee_in_asset     : true,
                };
                0x2::event::emit<ProposerFeeToTreasury>(v6);
            } else {
                0x2::balance::destroy_zero<T0>(v4);
            };
        } else {
            let v7 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::take_fee_escrow_stable<T0, T1>(arg0, &v1);
            let v8 = 0x2::balance::value<T1>(&v7);
            if (v8 > 0) {
                if (0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::has_vault(arg2, v3) && 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::can_deposit_coin_type<T1>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::borrow_vault(arg2, arg3, v3), &v3)) {
                    0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::deposit_approved<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig, T1>(arg2, arg3, v3, 0x2::coin::from_balance<T1>(v7, arg4));
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg4), v2);
                };
                let v9 = ProposerFeeToTreasury{
                    proposal_id      : 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_id<T0, T1>(arg0),
                    treasury_address : v2,
                    amount           : v8,
                    fee_in_asset     : false,
                };
                0x2::event::emit<ProposerFeeToTreasury>(v9);
            } else {
                0x2::balance::destroy_zero<T1>(v7);
            };
        };
    }

    public fun set_intent_spec_for_outcome<T0, T1>(arg0: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::ProposalMutationRegistry, arg1: &mut 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>, arg2: u64, arg3: vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>, arg4: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg5: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry) {
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_dao_id<T0, T1>(arg1) == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg4), 17);
        let v0 = ProposalMutationWitness{dummy_field: false};
        let v1 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::proposal_mutation_auth::create<ProposalMutationWitness>(arg0, v0, 0x2::object::id<0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>>(arg1));
        0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::set_intent_spec_for_outcome<T0, T1>(arg1, arg2, arg3, 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::max_actions_per_outcome(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::governance_config(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::dao_config(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg4)))), arg4, arg5, &v1);
    }

    // decompiled from Move bytecode v6
}

