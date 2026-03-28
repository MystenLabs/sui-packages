module 0x3cb7e4fb53827454a121d0171d20c5aea61cca56e968773e729aca536d0562da::ptb_executor {
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

    public fun begin_execution<T0, T1, T2>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::proposal_mutation_auth::ProposalMutationRegistry, arg3: &0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationRegistry, arg5: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::escrow_mutation_auth::EscrowMutationRegistry, arg6: &mut 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::Proposal<T0, T1>, arg7: &mut 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::Executable<0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::FutarchyOutcome>, ExecutionTicket) {
        begin_execution_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun begin_execution_internal<T0, T1, T2>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::proposal_mutation_auth::ProposalMutationRegistry, arg3: &0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationRegistry, arg5: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::escrow_mutation_auth::EscrowMutationRegistry, arg6: &mut 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::Proposal<T0, T1>, arg7: &mut 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::Executable<0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::FutarchyOutcome>, ExecutionTicket) {
        let v0 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::config<0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::FutarchyConfig>(arg0);
        0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::assert_not_terminated(0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::dao_state(v0));
        let v1 = 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::get_spot_pool_id(v0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 9);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1) == 0x2::object::id<0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg7), 9);
        let v2 = ProposalMutationWitness{dummy_field: false};
        let v3 = 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::proposal_mutation_auth::create<ProposalMutationWitness>(arg2, v2, 0x2::object::id<0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::Proposal<T0, T1>>(arg6));
        let v4 = MarketStateMutationWitness{dummy_field: false};
        let v5 = 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::create<MarketStateMutationWitness>(arg4, v4);
        let v6 = EscrowMutationWitness{dummy_field: false};
        let v7 = 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::escrow_mutation_auth::create<EscrowMutationWitness>(arg5, v6);
        let v8 = SpotPoolMutationWitness{dummy_field: false};
        let v9 = 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg7, 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v8, 0x2::object::id<0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg7)));
        let v10 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::get_market_state<T0, T1>(&v9);
        assert!(0x2::object::id<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::MarketState>(v10) == 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::market_state_id<T0, T1>(arg6), 4);
        assert!(0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_dao_id<T0, T1>(arg6) == 0x2::object::id<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account>(arg0), 8);
        assert!(0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_state<T0, T1>(arg6) == 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::state_awaiting_execution(), 5);
        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::assert_can_execute(v10, arg8);
        let v11 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::get_market_winner(v10);
        let v12 = *0x1::option::borrow<u64>(&v11);
        assert!(v12 > 0, 2);
        assert!(0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::has_intent_spec<T0, T1>(arg6, v12), 3);
        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::finalize_from_execution_success(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::get_market_state_mut<T0, T1>(&mut v9, &v7), arg8, &v5);
        0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::set_winning_outcome<T0, T1>(arg6, v12, &v3);
        0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::set_state<T0, T1>(arg6, 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::state_finalized(), v3);
        let v13 = SpotPoolMutationWitness{dummy_field: false};
        0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::quantum_lp_manager::auto_redeem_on_proposal_end_from_escrow<T0, T1, T2>(v12, arg7, &mut v9, arg5, arg4, arg8, arg9, 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v13, 0x2::object::id<0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg7)));
        let v14 = SpotPoolMutationWitness{dummy_field: false};
        0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::archive_finalized_escrow<T0, T1, T2>(arg7, v9, 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v14, 0x2::object::id<0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg7)));
        let (v15, v16) = 0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::governance_intents::execute_proposal_intent<T0, T1>(arg0, arg1, arg2, arg6, v12, 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::new_futarchy_outcome_full(build_intent_key_hint<T0, T1>(arg6, arg8), 0x1::option::some<0x2::object::ID>(0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_id<T0, T1>(arg6)), 0x1::option::some<0x2::object::ID>(0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::market_state_id<T0, T1>(arg6)), true, 0x2::clock::timestamp_ms(arg8)), arg8, arg9);
        0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::governance_intents::consume_governance_execution_ticket(v16, arg1, 0x3cb7e4fb53827454a121d0171d20c5aea61cca56e968773e729aca536d0562da::futarchy_governance_version::current(), 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_id<T0, T1>(arg6));
        let v17 = ExecutionTicket{proposal_id: 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_id<T0, T1>(arg6)};
        (v15, v17)
    }

    fun build_intent_key_hint<T0, T1>(arg0: &0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::Proposal<T0, T1>, arg1: &0x2::clock::Clock) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"ptb_execution_");
        let v1 = 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_id<T0, T1>(arg0);
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(&v1)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"_"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(0x2::clock::timestamp_ms(arg1)));
        v0
    }

    public fun finalize_execution_success<T0, T1>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::proposal_mutation_auth::ProposalMutationRegistry, arg3: &mut 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::Proposal<T0, T1>, arg4: 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::Executable<0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::FutarchyOutcome>, arg5: ExecutionTicket, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let ExecutionTicket { proposal_id: v0 } = arg5;
        assert!(v0 == 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_id<T0, T1>(arg3), 7);
        let v1 = ProposalMutationWitness{dummy_field: false};
        let v2 = 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::proposal_mutation_auth::create<ProposalMutationWitness>(arg2, v1, 0x2::object::id<0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::Proposal<T0, T1>>(arg3));
        assert!(0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_dao_id<T0, T1>(arg3) == 0x2::object::id<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account>(arg0), 8);
        let v3 = 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::outcome_proposal_id(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::outcome<0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::FutarchyOutcome>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::intent<0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::FutarchyOutcome>(&arg4)));
        assert!(0x1::option::is_some<0x2::object::ID>(&v3) && *0x1::option::borrow<0x2::object::ID>(&v3) == 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_id<T0, T1>(arg3), 7);
        assert!(0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_state<T0, T1>(arg3) == 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::state_finalized(), 5);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::confirm_execution<0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::FutarchyOutcome>(arg0, arg4);
        let v4 = 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_winning_outcome<T0, T1>(arg3);
        let v5 = 0;
        while (v5 < 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_num_outcomes<T0, T1>(arg3)) {
            if (v5 != v4) {
                0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::make_cancel_witness<T0, T1>(arg3, v5, &v2);
            };
            v5 = v5 + 1;
        };
        0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::intent_janitor::cleanup_all_expired_intents(arg0, arg1, arg6, arg7);
        let v6 = 0x2::clock::timestamp_ms(arg6);
        let v7 = 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_id<T0, T1>(arg3);
        let v8 = 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_dao_id<T0, T1>(arg3);
        let v9 = ProposalExecutionSucceeded{
            proposal_id     : v7,
            dao_id          : v8,
            winning_outcome : v4,
            intent_key      : 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::key<0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::FutarchyOutcome>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::intent<0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::futarchy_config::FutarchyOutcome>(&arg4)),
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

    fun refund_proposer_fee<T0, T1>(arg0: &mut 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::Proposal<T0, T1>, arg1: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::proposal_mutation_auth::ProposalMutationRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ProposalMutationWitness{dummy_field: false};
        let v1 = 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::proposal_mutation_auth::create<ProposalMutationWitness>(arg1, v0, 0x2::object::id<0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::Proposal<T0, T1>>(arg0));
        let v2 = 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_proposer<T0, T1>(arg0);
        if (0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_total_fee_paid<T0, T1>(arg0) == 0 || !0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::has_fee_escrow<T0, T1>(arg0)) {
            return
        };
        if (0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::fee_paid_in_asset<T0, T1>(arg0)) {
            let v3 = 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::take_fee_escrow_asset<T0, T1>(arg0, &v1);
            let v4 = 0x2::balance::value<T0>(&v3);
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg2), v2);
                let v5 = ProposerFeeRefunded{
                    proposal_id  : 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_id<T0, T1>(arg0),
                    proposer     : v2,
                    amount       : v4,
                    fee_in_asset : true,
                };
                0x2::event::emit<ProposerFeeRefunded>(v5);
            } else {
                0x2::balance::destroy_zero<T0>(v3);
            };
        } else {
            let v6 = 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::take_fee_escrow_stable<T0, T1>(arg0, &v1);
            let v7 = 0x2::balance::value<T1>(&v6);
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg2), v2);
                let v8 = ProposerFeeRefunded{
                    proposal_id  : 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::proposal::get_id<T0, T1>(arg0),
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

