module 0xcfecc8e77ea5a0dfb980cf3433611dc3a3d772d5ff63fbf7ac63c7b26eabbcc8::protective_ask_actions {
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

    public fun add_cancel_protective_ask_spec<T0, T1>(arg0: &mut 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::Builder, arg1: 0x2::object::ID) {
        let v0 = CancelProtectiveAskAction{ask_id: arg1};
        0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::add(arg0, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<CancelProtectiveAsk<T0, T1>>(), 0x2::bcs::to_bytes<CancelProtectiveAskAction>(&v0), 1));
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::new_builder();
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_id(&mut v1, b"ask_id", arg1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::emit_action_params(v1, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_type(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_id(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<CancelProtectiveAsk<T0, T1>>())), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::next_action_index(arg0));
    }

    public fun do_cancel_protective_ask<T0, T1, T2: store, T3: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T2>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &mut 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask::ProtectiveAsk<T0, T1>, arg5: T3, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::assert_execution_authorized<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T2>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T2>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T2>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<CancelProtectiveAsk<T0, T1>>(v1);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v1) == 1, 1);
        let v2 = 0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v1));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x2::object::id<0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask::ProtectiveAsk<T0, T1>>(arg4) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2)), 2);
        assert!(0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask::account_id<T0, T1>(arg4) == 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg1), 2);
        0x2::coin::destroy_zero<T1>(0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask::cancel<T0, T1>(arg4, arg1, arg2, 0xcfecc8e77ea5a0dfb980cf3433611dc3a3d772d5ff63fbf7ac63c7b26eabbcc8::liquidity_actions::new_spot_pool_mutation_auth(arg3, 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask::pool_id<T0, T1>(arg4)), arg6));
        let v3 = ProtectiveAskCancelledViaGovernance{
            ask_id       : 0x2::object::id<0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask::ProtectiveAsk<T0, T1>>(arg4),
            account_id   : 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg1),
            total_minted : 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask::minted_amount<T0, T1>(arg4),
        };
        0x2::event::emit<ProtectiveAskCancelledViaGovernance>(v3);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T2, CancelProtectiveAsk<T0, T1>, ExecutionProgressWitness>(arg0, arg2, v4);
    }

    // decompiled from Move bytecode v6
}

