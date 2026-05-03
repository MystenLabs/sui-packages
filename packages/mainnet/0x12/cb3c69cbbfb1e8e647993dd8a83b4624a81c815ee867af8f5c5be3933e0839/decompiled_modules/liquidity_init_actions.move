module 0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::liquidity_init_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct CreatePoolWithMint<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct CreatePoolFromCoins<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct DaoSpotPoolCreated has copy, drop {
        dao_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        stable_type: 0x1::ascii::String,
        lp_type: 0x1::ascii::String,
        initial_asset_reserve: u64,
        initial_stable_reserve: u64,
        fee_bps: u64,
    }

    struct CreatePoolWithMintAction has copy, drop, store {
        stable_resource_name: 0x1::string::String,
        mint_cap_resource_name: 0x1::string::String,
        asset_amount: 0x1::option::Option<u64>,
        fee_bps: u64,
        launch_fee_duration_ms: u64,
        lp_treasury_cap_id: 0x2::object::ID,
        lp_currency_id: 0x2::object::ID,
    }

    struct CreatePoolFromCoinsAction has copy, drop, store {
        executor: address,
        min_asset_amount: u64,
        min_stable_amount: u64,
        fee_bps: u64,
        launch_fee_duration_ms: u64,
        lp_treasury_cap_id: 0x2::object::ID,
        lp_currency_id: 0x2::object::ID,
    }

    public fun add_create_pool_from_coins_spec<T0, T1, T2>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::object::ID, arg7: 0x2::object::ID) {
        assert!(arg2 > 0, 1);
        assert!(arg3 > 0, 1);
        assert!(arg4 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_amm_fee_bps(), 2);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault_init_actions::add_approve_coin_type_spec<T2>(arg0, 0x1::string::utf8(b"treasury"));
        let v0 = CreatePoolFromCoinsAction{
            executor               : arg1,
            min_asset_amount       : arg2,
            min_stable_amount      : arg3,
            fee_bps                : arg4,
            launch_fee_duration_ms : arg5,
            lp_treasury_cap_id     : arg6,
            lp_currency_id         : arg7,
        };
        let v1 = CreatePoolFromCoins<T0, T1, T2>{dummy_field: false};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<CreatePoolFromCoins<T0, T1, T2>>(v1, 0x2::bcs::to_bytes<CreatePoolFromCoinsAction>(&v0), 1));
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder();
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_address(&mut v2, b"executor", arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v2, b"min_asset_amount", arg2);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v2, b"min_stable_amount", arg3);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v2, b"fee_bps", arg4);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v2, b"launch_fee_duration_ms", arg5);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_id(&mut v2, b"lp_treasury_cap_id", arg6);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_id(&mut v2, b"lp_currency_id", arg7);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(v2, 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<CreatePoolFromCoins<T0, T1, T2>>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_pool_with_mint_spec<T0, T1, T2>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: u64, arg6: 0x2::object::ID, arg7: 0x2::object::ID) {
        assert!(arg4 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_amm_fee_bps(), 2);
        assert!(0x1::string::length(&arg1) > 0, 1);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault_init_actions::add_approve_coin_type_spec<T2>(arg0, 0x1::string::utf8(b"treasury"));
        let v0 = CreatePoolWithMintAction{
            stable_resource_name   : arg1,
            mint_cap_resource_name : arg2,
            asset_amount           : arg3,
            fee_bps                : arg4,
            launch_fee_duration_ms : arg5,
            lp_treasury_cap_id     : arg6,
            lp_currency_id         : arg7,
        };
        let v1 = CreatePoolWithMint<T0, T1, T2>{dummy_field: false};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<CreatePoolWithMint<T0, T1, T2>>(v1, 0x2::bcs::to_bytes<CreatePoolWithMintAction>(&v0), 1));
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder();
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v2, b"stable_resource_name", arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v2, b"mint_cap_resource_name", arg2);
        let v3 = if (0x1::option::is_some<u64>(&arg3)) {
            *0x1::option::borrow<u64>(&arg3)
        } else {
            0
        };
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v2, b"asset_amount", v3);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_bool(&mut v2, b"asset_amount_auto", 0x1::option::is_none<u64>(&arg3));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v2, b"fee_bps", arg4);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v2, b"launch_fee_duration_ms", arg5);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_id(&mut v2, b"lp_treasury_cap_id", arg6);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_id(&mut v2, b"lp_currency_id", arg7);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(v2, 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<CreatePoolWithMint<T0, T1, T2>>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    public(friend) fun dispatch_create_pool_with_mint<T0: store, T1, T2, T3, T4: copy + drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &CreatePoolWithMintAction, arg3: 0x2::coin::Coin<T2>, arg4: 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T1>, arg5: 0x2::coin::TreasuryCap<T3>, arg6: &mut 0x2::coin_registry::Currency<T3>, arg7: T4, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::object::id<0x2::coin::TreasuryCap<T3>>(&arg5) == arg2.lp_treasury_cap_id, 4);
        assert!(0x2::object::id<0x2::coin_registry::Currency<T3>>(arg6) == arg2.lp_currency_id, 5);
        init_create_pool_with_mint_from_coin<T0, T1, T2, T3, T4>(arg0, arg1, arg3, arg4, arg2.asset_amount, arg2.fee_bps, arg2.launch_fee_duration_ms, arg5, arg6, arg7, arg8, arg9)
    }

    public fun do_init_create_pool_from_coins<T0: store, T1: store, T2, T3, T4, T5: copy + drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T1>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::Coin<T3>, arg5: 0x2::coin::TreasuryCap<T4>, arg6: &mut 0x2::coin_registry::Currency<T4>, arg7: &0x2::clock::Clock, arg8: T5, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::assert_execution_authorized<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<T1>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<T1>(arg0)), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::action_idx<T1>(arg0));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::assert_action_type<CreatePoolFromCoins<T2, T3, T4>>(v1);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_version(v1) == 1, 3);
        let v2 = 0x2::bcs::new(*0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_data(v1));
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x2::tx_context::sender(arg9) == 0x2::bcs::peel_address(&mut v2), 9);
        assert!(v3 > 0, 1);
        assert!(v4 > 0, 1);
        assert!(v5 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_amm_fee_bps(), 2);
        assert!(0x2::object::id<0x2::coin::TreasuryCap<T4>>(&arg5) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2)), 4);
        assert!(0x2::object::id<0x2::coin_registry::Currency<T4>>(arg6) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2)), 5);
        let v6 = 0x2::coin::value<T2>(&arg3);
        let v7 = 0x2::coin::value<T3>(&arg4);
        assert!(v6 >= v3, 1);
        assert!(v7 >= v4, 1);
        let v8 = (v7 as u128) * (0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::price_precision_scale() as u128) / (v6 as u128);
        assert!(v8 > 0, 1);
        let v9 = ExecutionProgressWitness{dummy_field: false};
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::set_launchpad_initial_price_from_execution<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v9, v8);
        let v10 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::increment_action_idx<T1, CreatePoolFromCoins<T2, T3, T4>, ExecutionProgressWitness>(arg0, arg2, v10);
        init_create_pool<T0, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, v5, 0x2::bcs::peel_u64(&mut v2), arg8, arg7, arg9)
    }

    public fun do_init_create_pool_with_mint<T0: store, T1: store, T2, T3, T4, T5: copy + drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T1>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: 0x2::coin::TreasuryCap<T4>, arg4: &mut 0x2::coin_registry::Currency<T4>, arg5: &0x2::clock::Clock, arg6: T5, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::assert_execution_authorized<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<T1>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<T1>(arg0)), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::action_idx<T1>(arg0));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::assert_action_type<CreatePoolWithMint<T2, T3, T4>>(v1);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_version(v1) == 1, 3);
        let v2 = 0x2::bcs::new(*0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_data(v1));
        let v3 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<u64>(0x2::bcs::peel_u64(&mut v2))
        } else {
            0x1::option::none<u64>()
        };
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x2::object::id<0x2::coin::TreasuryCap<T4>>(&arg3) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2)), 4);
        assert!(0x2::object::id<0x2::coin_registry::Currency<T4>>(arg4) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2)), 5);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let v6 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable_resources::take_object<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T2>, T1, ExecutionProgressWitness>(arg0, arg2, v5, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
        assert!(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::mint_admin_cap_account_id<T2>(&v6) == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1), 6);
        let v7 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::increment_action_idx<T1, CreatePoolWithMint<T2, T3, T4>, ExecutionProgressWitness>(arg0, arg2, v7);
        init_create_pool_with_mint_from_coin<T0, T2, T3, T4, T5>(arg1, arg2, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable_resources::take_coin<T3, T1, ExecutionProgressWitness>(arg0, arg2, v4, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2))), v6, v3, 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2), arg3, arg4, arg6, arg5, arg7)
    }

    public(friend) fun init_create_pool<T0: store, T1, T2, T3, T4: copy + drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::TreasuryCap<T3>, arg5: &mut 0x2::coin_registry::Currency<T3>, arg6: u64, arg7: u64, arg8: T4, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::coin::value<T1>(&arg2) > 0, 1);
        assert!(0x2::coin::value<T2>(&arg3) > 0, 1);
        assert!(arg6 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_amm_fee_bps(), 2);
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg0);
        let v1 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::stable_type(v0);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>())) == *0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::asset_type(v0), 7);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T2>())) == *v1, 8);
        let v2 = if (arg7 > 0) {
            0x1::option::some<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::fee_scheduler::FeeSchedule>(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::fee_scheduler::new_schedule(0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_launch_fee_bps(), arg7))
        } else {
            0x1::option::none<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::fee_scheduler::FeeSchedule>()
        };
        let (v3, v4) = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::new<T1, T2, T3>(arg4, arg5, arg6, v2, 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::oracle_conditional_threshold_bps(), 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::conditional_liquidity_ratio_percent(v0), arg9, arg10);
        let v5 = v3;
        let (v6, v7, v8) = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::add_liquidity<T1, T2, T3>(&mut v5, arg2, arg3, 0, arg9, arg10);
        let v9 = v8;
        let v10 = v7;
        let v11 = 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T1, T2, T3>>(&v5);
        0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::share<T1, T2, T3>(v5, v4);
        let v12 = DaoSpotPoolCreated{
            dao_id                 : 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0),
            pool_id                : v11,
            asset_type             : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            stable_type            : 0x1::type_name::into_string(0x1::type_name::get<T2>()),
            lp_type                : 0x1::type_name::into_string(0x1::type_name::get<T3>()),
            initial_asset_reserve  : 0x2::coin::value<T1>(&arg2),
            initial_stable_reserve : 0x2::coin::value<T2>(&arg3),
            fee_bps                : arg6,
        };
        0x2::event::emit<DaoSpotPoolCreated>(v12);
        let v13 = 0x1::string::utf8(b"treasury");
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::deposit_approved<T0, T3>(arg0, arg1, v13, v6);
        if (0x2::coin::value<T1>(&v10) > 0) {
            0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::deposit_approved<T0, T1>(arg0, arg1, v13, v10);
        } else {
            0x2::coin::destroy_zero<T1>(v10);
        };
        if (0x2::coin::value<T2>(&v9) > 0) {
            0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::vault::deposit_approved<T0, T2>(arg0, arg1, v13, v9);
        } else {
            0x2::coin::destroy_zero<T2>(v9);
        };
        let v14 = ExecutionProgressWitness{dummy_field: false};
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::set_spot_pool_id_from_account<ExecutionProgressWitness>(arg0, arg1, v11, v14);
        v11
    }

    public(friend) fun init_create_pool_with_mint_from_coin<T0: store, T1, T2, T3, T4: copy + drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::coin::Coin<T2>, arg3: 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T1>, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: u64, arg7: 0x2::coin::TreasuryCap<T3>, arg8: &mut 0x2::coin_registry::Currency<T3>, arg9: T4, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T2>(&arg2);
        assert!(v0 > 0, 1);
        assert!(arg5 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_amm_fee_bps(), 2);
        let v1 = if (0x1::option::is_none<u64>(&arg4)) {
            let v2 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::get_launchpad_initial_price(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg0));
            assert!(0x1::option::is_some<u128>(&v2), 1);
            let v3 = *0x1::option::borrow<u128>(&v2);
            assert!(v3 > 0, 1);
            let v4 = (v0 as u128) * (0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::price_precision_scale() as u128) / v3;
            assert!(v4 <= 18446744073709551615, 1);
            (v4 as u64)
        } else {
            *0x1::option::borrow<u64>(&arg4)
        };
        assert!(v1 > 0, 1);
        let v5 = 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::mint_with_admin_cap<T1>(arg0, arg1, &arg3, v1, arg11);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::destroy_currency_mint_admin_cap<T1>(arg3);
        init_create_pool<T0, T1, T2, T3, T4>(arg0, arg1, v5, arg2, arg7, arg8, arg5, arg6, arg9, arg10, arg11)
    }

    // decompiled from Move bytecode v6
}

