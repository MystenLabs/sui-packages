module 0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::liquidity_init_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct CreatePoolWithMint<phantom T0, phantom T1, phantom T2> has drop {
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
        asset_amount: 0x1::option::Option<u64>,
        fee_bps: u64,
        launch_fee_duration_ms: u64,
        lp_treasury_cap_id: 0x2::object::ID,
        lp_currency_id: 0x2::object::ID,
    }

    public fun add_create_pool_with_mint_spec<T0, T1, T2>(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: u64, arg5: 0x2::object::ID, arg6: 0x2::object::ID) {
        assert!(arg3 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_amm_fee_bps(), 2);
        assert!(0x1::string::length(&arg1) > 0, 1);
        let v0 = CreatePoolWithMintAction{
            stable_resource_name   : arg1,
            asset_amount           : arg2,
            fee_bps                : arg3,
            launch_fee_duration_ms : arg4,
            lp_treasury_cap_id     : arg5,
            lp_currency_id         : arg6,
        };
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<CreatePoolWithMint<T0, T1, T2>>(), 0x2::bcs::to_bytes<CreatePoolWithMintAction>(&v0), 1));
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_string(&mut v1, b"stable_resource_name", arg1);
        let v2 = if (0x1::option::is_some<u64>(&arg2)) {
            *0x1::option::borrow<u64>(&arg2)
        } else {
            0
        };
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_u64(&mut v1, b"asset_amount", v2);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_bool(&mut v1, b"asset_amount_auto", 0x1::option::is_none<u64>(&arg2));
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_u64(&mut v1, b"fee_bps", arg3);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_u64(&mut v1, b"launch_fee_duration_ms", arg4);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_id(&mut v1, b"lp_treasury_cap_id", arg5);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_id(&mut v1, b"lp_currency_id", arg6);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v1, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<CreatePoolWithMint<T0, T1, T2>>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun add_remove_liquidity_to_resources_spec<T0, T1, T2>(arg0: &mut 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::Builder, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: bool) {
        let v0 = 0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::liquidity_actions::new_remove_liquidity_to_resources_action<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::add(arg0, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::liquidity_actions::RemoveLiquidityToResources<T0, T1, T2>>(), 0x2::bcs::to_bytes<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::liquidity_actions::RemoveLiquidityToResourcesAction<T0, T1, T2>>(&v0), 1));
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::new_builder();
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_id(&mut v1, b"pool_id", arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_u64(&mut v1, b"lp_amount", arg2);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_u64(&mut v1, b"min_asset_amount", arg3);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_u64(&mut v1, b"min_stable_amount", arg4);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_string(&mut v1, b"lp_resource_name", arg5);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_string(&mut v1, b"asset_output_name", arg6);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_string(&mut v1, b"stable_output_name", arg7);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::add_bool(&mut v1, b"for_dissolution", arg8);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_events::emit_action_params(v1, 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_type(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::source_id(arg0), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::liquidity_actions::RemoveLiquidityToResources<T0, T1, T2>>())), 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::action_spec_builder::next_action_index(arg0));
    }

    public fun dispatch_create_pool_with_mint<T0: store, T1, T2, T3, T4: copy + drop>(arg0: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg1: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg2: &CreatePoolWithMintAction, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::TreasuryCap<T3>, arg5: &0x2::coin_registry::Currency<T3>, arg6: T4, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::object::id<0x2::coin::TreasuryCap<T3>>(&arg4) == arg2.lp_treasury_cap_id, 4);
        assert!(0x2::object::id<0x2::coin_registry::Currency<T3>>(arg5) == arg2.lp_currency_id, 5);
        init_create_pool_with_mint_from_coin<T0, T1, T2, T3, T4>(arg0, arg1, arg3, arg2.asset_amount, arg2.fee_bps, arg2.launch_fee_duration_ms, arg4, arg5, arg6, arg7, arg8)
    }

    public fun do_init_create_pool_with_mint<T0: store, T1: store, T2, T3, T4, T5: copy + drop>(arg0: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::executable::Executable<T1>, arg1: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg2: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg3: 0x2::coin::TreasuryCap<T4>, arg4: &0x2::coin_registry::Currency<T4>, arg5: &0x2::clock::Clock, arg6: T5, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::assert_execution_authorized<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_specs<T1>(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::executable::intent<T1>(arg0)), 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::executable::action_idx<T1>(arg0));
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_validation::assert_action_type<CreatePoolWithMint<T2, T3, T4>>(v1);
        assert!(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_spec_version(v1) == 1, 3);
        let v2 = 0x2::bcs::new(*0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_spec_data(v1));
        let v3 = if (0x2::bcs::peel_bool(&mut v2)) {
            0x1::option::some<u64>(0x2::bcs::peel_u64(&mut v2))
        } else {
            0x1::option::none<u64>()
        };
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x2::object::id<0x2::coin::TreasuryCap<T4>>(&arg3) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2)), 4);
        assert!(0x2::object::id<0x2::coin_registry::Currency<T4>>(arg4) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2)), 5);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        let v5 = ExecutionProgressWitness{dummy_field: false};
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::executable::increment_action_idx<T1, CreatePoolWithMint<T2, T3, T4>, ExecutionProgressWitness>(arg0, arg2, v5);
        init_create_pool_with_mint_from_coin<T0, T2, T3, T4, T5>(arg1, arg2, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::executable_resources::take_coin<T3, T1, ExecutionProgressWitness>(arg0, arg2, v4, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2))), v3, 0x2::bcs::peel_u64(&mut v2), 0x2::bcs::peel_u64(&mut v2), arg3, arg4, arg6, arg5, arg7)
    }

    public(friend) fun init_create_pool<T0: store, T1, T2, T3, T4: copy + drop>(arg0: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg1: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::TreasuryCap<T3>, arg5: &0x2::coin_registry::Currency<T3>, arg6: u64, arg7: u64, arg8: T4, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::coin::value<T1>(&arg2) > 0, 1);
        assert!(0x2::coin::value<T2>(&arg3) > 0, 1);
        assert!(arg6 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_amm_fee_bps(), 2);
        let v0 = if (arg7 > 0) {
            0x1::option::some<0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::fee_scheduler::FeeSchedule>(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::fee_scheduler::new_schedule(0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_launch_fee_bps(), arg7))
        } else {
            0x1::option::none<0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::fee_scheduler::FeeSchedule>()
        };
        let (v1, v2) = 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::new<T1, T2, T3>(arg4, arg5, arg6, v0, 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::oracle_conditional_threshold_bps(), 0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::futarchy_config::conditional_liquidity_ratio_percent(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::config<0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::futarchy_config::FutarchyConfig>(arg0)), arg9, arg10);
        let v3 = v1;
        let (v4, v5, v6) = 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::add_liquidity<T1, T2, T3>(&mut v3, arg2, arg3, 0, arg9, arg10);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x2::object::id<0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::UnifiedSpotPool<T1, T2, T3>>(&v3);
        0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::share<T1, T2, T3>(v3, v2);
        let v10 = DaoSpotPoolCreated{
            dao_id                 : 0x2::object::id<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account>(arg0),
            pool_id                : v9,
            asset_type             : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            stable_type            : 0x1::type_name::into_string(0x1::type_name::get<T2>()),
            lp_type                : 0x1::type_name::into_string(0x1::type_name::get<T3>()),
            initial_asset_reserve  : 0x2::coin::value<T1>(&arg2),
            initial_stable_reserve : 0x2::coin::value<T2>(&arg3),
            fee_bps                : arg6,
        };
        0x2::event::emit<DaoSpotPoolCreated>(v10);
        let v11 = 0x1::string::utf8(b"treasury");
        0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::vault::deposit_approved<T0, T3>(arg0, arg1, v11, v4);
        if (0x2::coin::value<T1>(&v8) > 0) {
            0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::vault::deposit_approved<T0, T1>(arg0, arg1, v11, v8);
        } else {
            0x2::coin::destroy_zero<T1>(v8);
        };
        if (0x2::coin::value<T2>(&v7) > 0) {
            0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::vault::deposit_approved<T0, T2>(arg0, arg1, v11, v7);
        } else {
            0x2::coin::destroy_zero<T2>(v7);
        };
        0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::futarchy_config::set_spot_pool_id(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::config_mut_authorized<0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::futarchy_config::FutarchyConfig>(arg0, arg1, 0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::futarchy_actions_version::current()), v9);
        v9
    }

    public(friend) fun init_create_pool_with_mint_from_coin<T0: store, T1, T2, T3, T4: copy + drop>(arg0: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg1: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg2: 0x2::coin::Coin<T2>, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: u64, arg6: 0x2::coin::TreasuryCap<T3>, arg7: &0x2::coin_registry::Currency<T3>, arg8: T4, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T2>(&arg2);
        assert!(v0 > 0, 1);
        assert!(arg4 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_amm_fee_bps(), 2);
        let v1 = if (0x1::option::is_none<u64>(&arg3)) {
            let v2 = 0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::futarchy_config::get_launchpad_initial_price(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::config<0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::futarchy_config::FutarchyConfig>(arg0));
            assert!(0x1::option::is_some<u128>(&v2), 1);
            let v3 = *0x1::option::borrow<u128>(&v2);
            assert!(v3 > 0, 1);
            let v4 = (v0 as u128) * (0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::price_precision_scale() as u128) / v3;
            assert!(v4 <= 18446744073709551615, 1);
            (v4 as u64)
        } else {
            *0x1::option::borrow<u64>(&arg3)
        };
        assert!(v1 > 0, 1);
        let v5 = 0x30705bcf8eb9c97dfd72e5abc1dde6bfde560972a4f44b5cd1cef8da7cf168b1::currency::mint_with_package_witness<T1>(arg0, arg1, v1, 0x54ca0905efa287d8bd40d7bc13be27c1841d8ff86708298c914cfa6a08138990::futarchy_actions_version::current(), arg10);
        init_create_pool<T0, T1, T2, T3, T4>(arg0, arg1, v5, arg2, arg6, arg7, arg4, arg5, arg8, arg9, arg10)
    }

    // decompiled from Move bytecode v6
}

