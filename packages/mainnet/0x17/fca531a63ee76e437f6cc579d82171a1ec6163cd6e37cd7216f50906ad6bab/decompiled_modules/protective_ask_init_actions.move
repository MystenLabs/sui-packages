module 0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::protective_ask_init_actions {
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
        mint_cap_resource_name: 0x1::string::String,
        price_per_token: u64,
        max_mint_amount: u64,
        release_duration_ms: u64,
    }

    public fun add_create_protective_ask_spec<T0, T1>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 > 0, 5);
        assert!(arg3 > 0, 2);
        let v0 = CreateProtectiveAskAction{
            mint_cap_resource_name : arg1,
            price_per_token        : arg2,
            max_mint_amount        : arg3,
            release_duration_ms    : arg4,
        };
        let v1 = CreateProtectiveAsk<T0, T1>{dummy_field: false};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<CreateProtectiveAsk<T0, T1>>(v1, 0x2::bcs::to_bytes<CreateProtectiveAskAction>(&v0), 1));
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder();
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v2, b"mint_cap_resource_name", arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v2, b"price_per_token", arg2);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v2, b"max_mint_amount", arg3);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v2, b"release_duration_ms", arg4);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(v2, 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<CreateProtectiveAsk<T0, T1>>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    public fun do_create_protective_ask<T0, T1, T2: store, T3: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T2>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0x2::clock::Clock, arg5: T3, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::assert_execution_authorized<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<T2>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<T2>(arg0)), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::action_idx<T2>(arg0));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::assert_action_type<CreateProtectiveAsk<T0, T1>>(v1);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_version(v1) == 1, 1);
        let v2 = 0x2::bcs::new(*0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_data(v1));
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(v4 > 0, 2);
        assert!(v3 > 0, 5);
        let v5 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg1);
        let v6 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::stable_type(v5);
        let v7 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        let v8 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()));
        assert!(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::asset_type(v5) == &v7, 4);
        assert!(v6 == &v8, 4);
        let v9 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::get_spot_pool_id(v5);
        assert!(0x1::option::is_some<0x2::object::ID>(&v9), 3);
        let v10 = *0x1::option::borrow<0x2::object::ID>(&v9);
        let v11 = 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1);
        let v12 = ExecutionProgressWitness{dummy_field: false};
        let v13 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable_resources::take_object<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>, T2, ExecutionProgressWitness>(arg0, arg2, v12, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
        assert!(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::mint_admin_cap_account_id<T0>(&v13) == v11, 6);
        let v14 = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask::create<T0, T1>(v11, v10, v3, v4, 0x2::bcs::peel_u64(&mut v2), v13, 0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::liquidity_actions::new_spot_pool_mutation_auth(arg3, v10), arg4, arg6);
        let v15 = 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask::ProtectiveAsk<T0, T1>>(&v14);
        let v16 = ProtectiveAskCreatedViaGovernance{
            ask_id          : v15,
            account_id      : v11,
            pool_id         : v10,
            price_per_token : v3,
            max_mint_amount : v4,
        };
        0x2::event::emit<ProtectiveAskCreatedViaGovernance>(v16);
        let v17 = ExecutionProgressWitness{dummy_field: false};
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask_registry::set_from_execution<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v17, v15, v10);
        0x2::transfer::public_share_object<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::protective_ask::ProtectiveAsk<T0, T1>>(v14);
        let v18 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::increment_action_idx<T2, CreateProtectiveAsk<T0, T1>, ExecutionProgressWitness>(arg0, arg2, v18);
        v15
    }

    // decompiled from Move bytecode v7
}

