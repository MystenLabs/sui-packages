module 0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::protective_ask_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct CancelProtectiveAsk<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct ProtectiveAskCancelledViaGovernance has copy, drop {
        ask_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        total_minted: u64,
    }

    struct CancelProtectiveAskAction has copy, drop, store {
        ask_id: 0x2::object::ID,
    }

    public fun add_cancel_protective_ask_spec<T0, T1>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x2::object::ID) {
        let v0 = CancelProtectiveAskAction{ask_id: arg1};
        let v1 = CancelProtectiveAsk<T0, T1>{dummy_field: false};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<CancelProtectiveAsk<T0, T1>>(v1, 0x2::bcs::to_bytes<CancelProtectiveAskAction>(&v0), 1));
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder();
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_id(&mut v2, b"ask_id", arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(v2, 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<CancelProtectiveAsk<T0, T1>>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    public fun do_cancel_protective_ask<T0, T1, T2: store, T3: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T2>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &mut 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask::ProtectiveAsk<T0, T1>, arg5: T3, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::assert_execution_authorized<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<T2>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<T2>(arg0)), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::action_idx<T2>(arg0));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::assert_action_type<CancelProtectiveAsk<T0, T1>>(v1);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_version(v1) == 1, 1);
        let v2 = 0x2::bcs::new(*0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_data(v1));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask::ProtectiveAsk<T0, T1>>(arg4) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2)), 2);
        assert!(0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask::account_id<T0, T1>(arg4) == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1), 2);
        0x2::coin::destroy_zero<T1>(0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask::cancel<T0, T1>(arg4, arg1, arg2, 0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::liquidity_actions::new_spot_pool_mutation_auth(arg3, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask::pool_id<T0, T1>(arg4)), arg6));
        let v3 = ProtectiveAskCancelledViaGovernance{
            ask_id       : 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask::ProtectiveAsk<T0, T1>>(arg4),
            account_id   : 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1),
            total_minted : 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask::minted_amount<T0, T1>(arg4),
        };
        0x2::event::emit<ProtectiveAskCancelledViaGovernance>(v3);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::increment_action_idx<T2, CancelProtectiveAsk<T0, T1>, ExecutionProgressWitness>(arg0, arg2, v4);
    }

    // decompiled from Move bytecode v6
}

