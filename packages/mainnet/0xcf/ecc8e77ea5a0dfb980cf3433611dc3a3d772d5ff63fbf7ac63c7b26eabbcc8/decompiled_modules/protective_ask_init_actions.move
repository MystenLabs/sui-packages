module 0xcfecc8e77ea5a0dfb980cf3433611dc3a3d772d5ff63fbf7ac63c7b26eabbcc8::protective_ask_init_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct CreateProtectiveAsk<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct ProtectiveAskCreatedViaGovernance has copy, drop {
        ask_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        price_per_token: u64,
        max_mint_amount: u64,
    }

    struct CreateProtectiveAskAction has copy, drop, store {
        price_per_token: u64,
        max_mint_amount: u64,
        release_duration_ms: u64,
    }

    public fun add_create_protective_ask_spec<T0, T1>(arg0: &mut 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::Builder, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 > 0, 5);
        assert!(arg2 > 0, 2);
        let v0 = CreateProtectiveAskAction{
            price_per_token     : arg1,
            max_mint_amount     : arg2,
            release_duration_ms : arg3,
        };
        0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::add(arg0, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<CreateProtectiveAsk<T0, T1>>(), 0x2::bcs::to_bytes<CreateProtectiveAskAction>(&v0), 1));
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::new_builder();
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v1, b"price_per_token", arg1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v1, b"max_mint_amount", arg2);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v1, b"release_duration_ms", arg3);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::emit_action_params(v1, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_type(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_id(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<CreateProtectiveAsk<T0, T1>>())), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::next_action_index(arg0));
    }

    public fun do_create_protective_ask<T0, T1, T2: store, T3: drop>(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<T2>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0x2::clock::Clock, arg5: T3, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::assert_execution_authorized<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<T2>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<T2>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<T2>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<CreateProtectiveAsk<T0, T1>>(v1);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v1) == 1, 1);
        let v2 = 0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v1));
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(v4 > 0, 2);
        assert!(v3 > 0, 5);
        let v5 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config<0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::FutarchyConfig>(arg1);
        let v6 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::stable_type(v5);
        let v7 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        let v8 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()));
        assert!(0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::asset_type(v5) == &v7, 4);
        assert!(v6 == &v8, 4);
        let v9 = 0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::futarchy_config::get_spot_pool_id(v5);
        assert!(0x1::option::is_some<0x2::object::ID>(&v9), 3);
        let v10 = *0x1::option::borrow<0x2::object::ID>(&v9);
        let v11 = 0x2::object::id<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account>(arg1);
        let v12 = 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask::create<T0, T1>(v11, v10, v3, v4, 0x2::bcs::peel_u64(&mut v2), 0xcfecc8e77ea5a0dfb980cf3433611dc3a3d772d5ff63fbf7ac63c7b26eabbcc8::liquidity_actions::new_spot_pool_mutation_auth(arg3, v10), arg4, arg6);
        let v13 = 0x2::object::id<0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask::ProtectiveAsk<T0, T1>>(&v12);
        let v14 = ProtectiveAskCreatedViaGovernance{
            ask_id          : v13,
            account_id      : v11,
            pool_id         : v10,
            price_per_token : v3,
            max_mint_amount : v4,
        };
        0x2::event::emit<ProtectiveAskCreatedViaGovernance>(v14);
        let v15 = ExecutionProgressWitness{dummy_field: false};
        0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask_registry::set_from_execution<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v15, v13, v10);
        0x2::transfer::public_share_object<0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::protective_ask::ProtectiveAsk<T0, T1>>(v12);
        let v16 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<T2, CreateProtectiveAsk<T0, T1>, ExecutionProgressWitness>(arg0, arg2, v16);
        v13
    }

    // decompiled from Move bytecode v6
}

