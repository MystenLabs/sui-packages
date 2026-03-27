module 0x1e1b7e2e7201a5b8ed896c929d0f094d1108d23f4a25667d1f540513793fcfb2::ptb_executor {
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

    struct ExecutionTicket {
        proposal_id: 0x2::object::ID,
    }

    struct ProposalExecutionSucceeded has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        winning_outcome: u64,
        intent_key: 0x1::string::String,
        timestamp: u64,
    }

    struct ProposalMarketFinalized has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        winning_outcome: u64,
        approved: bool,
        timestamp: u64,
    }

    struct ProposerFeeRefunded has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        amount: u64,
        fee_in_asset: bool,
    }

    public fun begin_execution<T0, T1, T2>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_mutation_auth::ProposalMutationRegistry, arg3: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::market_state_mutation_auth::MarketStateMutationRegistry, arg5: &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::escrow_mutation_auth::EscrowMutationRegistry, arg6: &mut 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::Proposal<T0, T1>, arg7: &mut 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyOutcome>, ExecutionTicket) {
        begin_execution_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun begin_execution_internal<T0, T1, T2>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_mutation_auth::ProposalMutationRegistry, arg3: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::market_state_mutation_auth::MarketStateMutationRegistry, arg5: &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::escrow_mutation_auth::EscrowMutationRegistry, arg6: &mut 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::Proposal<T0, T1>, arg7: &mut 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyOutcome>, ExecutionTicket) {
        let v0 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyConfig>(arg0);
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::assert_not_terminated(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::dao_state(v0));
        let v1 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::get_spot_pool_id(v0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 9);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1) == 0x2::object::id<0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg7), 9);
        let v2 = ProposalMutationWitness{dummy_field: false};
        let v3 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_mutation_auth::create<ProposalMutationWitness>(arg2, v2, 0x2::object::id<0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::Proposal<T0, T1>>(arg6));
        let v4 = MarketStateMutationWitness{dummy_field: false};
        let v5 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::market_state_mutation_auth::create<MarketStateMutationWitness>(arg4, v4);
        let v6 = EscrowMutationWitness{dummy_field: false};
        let v7 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::escrow_mutation_auth::create<EscrowMutationWitness>(arg5, v6);
        let v8 = SpotPoolMutationWitness{dummy_field: false};
        let v9 = 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg7, 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v8, 0x2::object::id<0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg7)));
        let v10 = 0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::coin_escrow::get_market_state<T0, T1>(&v9);
        assert!(0x2::object::id<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::market_state::MarketState>(v10) == 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::market_state_id<T0, T1>(arg6), 4);
        assert!(0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_dao_id<T0, T1>(arg6) == 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg0), 8);
        assert!(0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_state<T0, T1>(arg6) == 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::state_awaiting_execution(), 5);
        0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::market_state::assert_can_execute(v10, arg8);
        let v11 = 0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::market_state::get_market_winner(v10);
        let v12 = *0x1::option::borrow<u64>(&v11);
        assert!(v12 > 0, 2);
        assert!(0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::has_intent_spec<T0, T1>(arg6, v12), 3);
        0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::market_state::finalize_from_execution_success(0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::coin_escrow::get_market_state_mut<T0, T1>(&mut v9, &v7), arg8, &v5);
        0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::set_winning_outcome<T0, T1>(arg6, v12, &v3);
        0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::set_state<T0, T1>(arg6, 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::state_finalized(), v3);
        let v13 = SpotPoolMutationWitness{dummy_field: false};
        0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::quantum_lp_manager::auto_redeem_on_proposal_end_from_escrow<T0, T1, T2>(v12, arg7, &mut v9, arg5, arg4, arg8, arg9, 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v13, 0x2::object::id<0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg7)));
        let v14 = SpotPoolMutationWitness{dummy_field: false};
        0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::archive_finalized_escrow<T0, T1, T2>(arg7, v9, 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v14, 0x2::object::id<0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg7)));
        let (v15, v16) = 0x4aaab55346e9d28ae101d40c0b1c81864b53dca46dc9eda33cad3e9a8afc9ac6::governance_intents::execute_proposal_intent<T0, T1>(arg0, arg1, arg2, arg6, v12, 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::new_futarchy_outcome_full(build_intent_key_hint<T0, T1>(arg6, arg8), 0x1::option::some<0x2::object::ID>(0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_id<T0, T1>(arg6)), 0x1::option::some<0x2::object::ID>(0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::market_state_id<T0, T1>(arg6)), true, 0x2::clock::timestamp_ms(arg8)), arg8, arg9);
        0x4aaab55346e9d28ae101d40c0b1c81864b53dca46dc9eda33cad3e9a8afc9ac6::governance_intents::consume_governance_execution_ticket(v16, arg1, 0x1e1b7e2e7201a5b8ed896c929d0f094d1108d23f4a25667d1f540513793fcfb2::futarchy_governance_version::current(), 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_id<T0, T1>(arg6));
        let v17 = ExecutionTicket{proposal_id: 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_id<T0, T1>(arg6)};
        (v15, v17)
    }

    fun build_intent_key_hint<T0, T1>(arg0: &0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::Proposal<T0, T1>, arg1: &0x2::clock::Clock) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"ptb_execution_");
        let v1 = 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_id<T0, T1>(arg0);
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(&v1)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"_"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(0x2::clock::timestamp_ms(arg1)));
        v0
    }

    public fun finalize_execution_success<T0, T1>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_mutation_auth::ProposalMutationRegistry, arg3: &mut 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::Proposal<T0, T1>, arg4: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyOutcome>, arg5: ExecutionTicket, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let ExecutionTicket { proposal_id: v0 } = arg5;
        assert!(v0 == 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_id<T0, T1>(arg3), 7);
        let v1 = ProposalMutationWitness{dummy_field: false};
        let v2 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_mutation_auth::create<ProposalMutationWitness>(arg2, v1, 0x2::object::id<0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::Proposal<T0, T1>>(arg3));
        assert!(0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_dao_id<T0, T1>(arg3) == 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg0), 8);
        let v3 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::outcome_proposal_id(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::outcome<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyOutcome>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyOutcome>(&arg4)));
        assert!(0x1::option::is_some<0x2::object::ID>(&v3) && *0x1::option::borrow<0x2::object::ID>(&v3) == 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_id<T0, T1>(arg3), 7);
        assert!(0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_state<T0, T1>(arg3) == 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::state_finalized(), 5);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::confirm_execution<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyOutcome>(arg0, arg4);
        let v4 = 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_winning_outcome<T0, T1>(arg3);
        let v5 = 0;
        while (v5 < 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_num_outcomes<T0, T1>(arg3)) {
            if (v5 != v4) {
                0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::make_cancel_witness<T0, T1>(arg3, v5, &v2);
            };
            v5 = v5 + 1;
        };
        0x4aaab55346e9d28ae101d40c0b1c81864b53dca46dc9eda33cad3e9a8afc9ac6::intent_janitor::cleanup_all_expired_intents(arg0, arg1, arg6, arg7);
        let v6 = 0x2::clock::timestamp_ms(arg6);
        let v7 = 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_id<T0, T1>(arg3);
        let v8 = 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_dao_id<T0, T1>(arg3);
        let v9 = ProposalExecutionSucceeded{
            proposal_id     : v7,
            dao_id          : v8,
            winning_outcome : v4,
            intent_key      : 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::key<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyOutcome>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyOutcome>(&arg4)),
            timestamp       : v6,
        };
        0x2::event::emit<ProposalExecutionSucceeded>(v9);
        let v10 = ProposalMarketFinalized{
            proposal_id     : v7,
            dao_id          : v8,
            winning_outcome : v4,
            approved        : true,
            timestamp       : v6,
        };
        0x2::event::emit<ProposalMarketFinalized>(v10);
        refund_proposer_fee<T0, T1>(arg3, arg2, arg7);
    }

    fun refund_proposer_fee<T0, T1>(arg0: &mut 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::Proposal<T0, T1>, arg1: &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_mutation_auth::ProposalMutationRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ProposalMutationWitness{dummy_field: false};
        let v1 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::proposal_mutation_auth::create<ProposalMutationWitness>(arg1, v0, 0x2::object::id<0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::Proposal<T0, T1>>(arg0));
        let v2 = 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_proposer<T0, T1>(arg0);
        if (0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_total_fee_paid<T0, T1>(arg0) == 0 || !0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::has_fee_escrow<T0, T1>(arg0)) {
            return
        };
        if (0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::fee_paid_in_asset<T0, T1>(arg0)) {
            let v3 = 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::take_fee_escrow_asset<T0, T1>(arg0, &v1);
            let v4 = 0x2::balance::value<T0>(&v3);
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg2), v2);
                let v5 = ProposerFeeRefunded{
                    proposal_id  : 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_id<T0, T1>(arg0),
                    proposer     : v2,
                    amount       : v4,
                    fee_in_asset : true,
                };
                0x2::event::emit<ProposerFeeRefunded>(v5);
            } else {
                0x2::balance::destroy_zero<T0>(v3);
            };
        } else {
            let v6 = 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::take_fee_escrow_stable<T0, T1>(arg0, &v1);
            let v7 = 0x2::balance::value<T1>(&v6);
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg2), v2);
                let v8 = ProposerFeeRefunded{
                    proposal_id  : 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::proposal::get_id<T0, T1>(arg0),
                    proposer     : v2,
                    amount       : v7,
                    fee_in_asset : false,
                };
                0x2::event::emit<ProposerFeeRefunded>(v8);
            } else {
                0x2::balance::destroy_zero<T1>(v6);
            };
        };
    }

    // decompiled from Move bytecode v6
}

