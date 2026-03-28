module 0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::liquidity_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct AddLiquidity<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct Swap<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct UpdatePoolFee<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct RemoveLiquidityToResources<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct SpotPoolMutationWitness has drop {
        dummy_field: bool,
    }

    struct GovernanceLiquidityAdded has copy, drop {
        account_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        asset_amount: u64,
        stable_amount: u64,
        min_lp_out: u64,
    }

    struct GovernanceLiquidityRemoved has copy, drop {
        account_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_amount: u64,
        for_dissolution: bool,
    }

    struct GovernanceSwapExecuted has copy, drop {
        account_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        swap_asset: bool,
        amount_in: u64,
        min_amount_out: u64,
    }

    struct GovernancePoolFeeUpdated has copy, drop {
        account_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        new_fee_bps: u64,
    }

    struct AddLiquidityAction<phantom T0, phantom T1, phantom T2> has copy, drop, store {
        pool_id: 0x2::object::ID,
        asset_amount: u64,
        stable_amount: u64,
        min_lp_out: u64,
        asset_resource_name: 0x1::string::String,
        stable_resource_name: 0x1::string::String,
    }

    struct SwapAction<phantom T0, phantom T1, phantom T2> has copy, drop, store {
        pool_id: 0x2::object::ID,
        swap_asset: bool,
        amount_in: u64,
        min_amount_out: u64,
        input_resource_name: 0x1::string::String,
    }

    struct UpdatePoolFeeAction<phantom T0, phantom T1, phantom T2> has copy, drop, store {
        pool_id: 0x2::object::ID,
        new_fee_bps: u64,
    }

    struct RemoveLiquidityToResourcesAction<phantom T0, phantom T1, phantom T2> has copy, drop, store {
        pool_id: 0x2::object::ID,
        lp_amount: u64,
        min_asset_amount: u64,
        min_stable_amount: u64,
        lp_resource_name: 0x1::string::String,
        asset_output_name: 0x1::string::String,
        stable_output_name: 0x1::string::String,
        for_dissolution: bool,
    }

    public fun add_liquidity_marker<T0, T1, T2>() : AddLiquidity<T0, T1, T2> {
        AddLiquidity<T0, T1, T2>{dummy_field: false}
    }

    public fun do_add_liquidity<T0, T1, T2, T3: store>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::Executable<T3>, arg1: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg3: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::assert_execution_authorized<T3, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_specs<T3>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::intent<T3>(arg0)), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::action_idx<T3>(arg0));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_validation::assert_action_type<AddLiquidity<T0, T1, T2>>(v1);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_version(v1) == 1, 8);
        let v2 = 0x2::bcs::new(*0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_data(v1));
        let v3 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2));
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        let v6 = 0x2::bcs::peel_u64(&mut v2);
        let v7 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        let v8 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(v4 > 0, 1);
        assert!(v5 > 0, 1);
        assert!(0x1::string::length(&v7) > 0, 9);
        assert!(0x1::string::length(&v8) > 0, 9);
        assert!(v3 == 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg3), 4);
        let v9 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::get_spot_pool_id(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg1));
        assert!(0x1::option::is_some<0x2::object::ID>(&v9), 12);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v9) == 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg3), 13);
        let v10 = ExecutionProgressWitness{dummy_field: false};
        let v11 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable_resources::take_coin<T0, T3, ExecutionProgressWitness>(arg0, arg2, v10, v7);
        let v12 = ExecutionProgressWitness{dummy_field: false};
        let v13 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable_resources::take_coin<T1, T3, ExecutionProgressWitness>(arg0, arg2, v12, v8);
        assert!(0x2::coin::value<T0>(&v11) == v4, 1);
        assert!(0x2::coin::value<T1>(&v13) == v5, 1);
        let (v14, v15, v16) = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::add_liquidity<T0, T1, T2>(arg3, v11, v13, v6, arg4, arg5);
        let v17 = v16;
        let v18 = v15;
        let v19 = 0x1::string::utf8(b"treasury");
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::deposit_approved<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, T2>(arg1, arg2, v19, v14);
        if (0x2::coin::value<T0>(&v18) > 0) {
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::deposit_approved<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, T0>(arg1, arg2, v19, v18);
        } else {
            0x2::coin::destroy_zero<T0>(v18);
        };
        if (0x2::coin::value<T1>(&v17) > 0) {
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::deposit_approved<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, T1>(arg1, arg2, v19, v17);
        } else {
            0x2::coin::destroy_zero<T1>(v17);
        };
        let v20 = GovernanceLiquidityAdded{
            account_id    : 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg1),
            pool_id       : v3,
            asset_amount  : v4,
            stable_amount : v5,
            min_lp_out    : v6,
        };
        0x2::event::emit<GovernanceLiquidityAdded>(v20);
        let v21 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::increment_action_idx<T3, AddLiquidity<T0, T1, T2>, ExecutionProgressWitness>(arg0, arg2, v21);
    }

    public fun do_remove_liquidity_to_resources<T0, T1, T2, T3: store>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::Executable<T3>, arg1: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg3: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::assert_execution_authorized<T3, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_specs<T3>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::intent<T3>(arg0)), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::action_idx<T3>(arg0));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_validation::assert_action_type<RemoveLiquidityToResources<T0, T1, T2>>(v1);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_version(v1) == 1, 8);
        let v2 = 0x2::bcs::new(*0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_data(v1));
        let v3 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2));
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        let v6 = 0x2::bcs::peel_u64(&mut v2);
        let v7 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        let v8 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        let v9 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        let v10 = 0x2::bcs::peel_bool(&mut v2);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(v4 > 0, 1);
        assert!(0x1::string::length(&v7) > 0, 9);
        assert!(0x1::string::length(&v8) > 0, 9);
        assert!(0x1::string::length(&v9) > 0, 9);
        assert!(v3 == 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg4), 4);
        let v11 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg1);
        let v12 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::get_spot_pool_id(v11);
        assert!(0x1::option::is_some<0x2::object::ID>(&v12), 12);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v12) == 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg4), 13);
        let v13 = ExecutionProgressWitness{dummy_field: false};
        let v14 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable_resources::take_coin<T2, T3, ExecutionProgressWitness>(arg0, arg2, v13, v7);
        assert!(0x2::coin::value<T2>(&v14) == v4, 1);
        let (v15, v16) = if (v10) {
            assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::operational_state(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::dao_state(v11)) == 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::state_terminated(), 11);
            0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::remove_liquidity_for_dissolution<T0, T1, T2>(arg4, v14, true, new_spot_pool_mutation_auth(arg3, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg4)), arg5)
        } else {
            0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::remove_liquidity<T0, T1, T2>(arg4, v14, v5, v6, arg5)
        };
        let v17 = v16;
        let v18 = v15;
        assert!(0x2::coin::value<T0>(&v18) >= v5, 1);
        assert!(0x2::coin::value<T1>(&v17) >= v6, 1);
        let v19 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable_resources::provide_coin<T0, T3, ExecutionProgressWitness>(arg0, arg2, v19, v8, v18, arg5);
        let v20 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable_resources::provide_coin<T1, T3, ExecutionProgressWitness>(arg0, arg2, v20, v9, v17, arg5);
        let v21 = GovernanceLiquidityRemoved{
            account_id      : 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg1),
            pool_id         : v3,
            lp_amount       : v4,
            for_dissolution : v10,
        };
        0x2::event::emit<GovernanceLiquidityRemoved>(v21);
        let v22 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::increment_action_idx<T3, RemoveLiquidityToResources<T0, T1, T2>, ExecutionProgressWitness>(arg0, arg2, v22);
    }

    public fun do_swap<T0, T1, T2, T3: store>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::Executable<T3>, arg1: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg3: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::assert_execution_authorized<T3, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_specs<T3>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::intent<T3>(arg0)), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::action_idx<T3>(arg0));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_validation::assert_action_type<Swap<T0, T1, T2>>(v1);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_version(v1) == 1, 8);
        let v2 = 0x2::bcs::new(*0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_data(v1));
        let v3 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2));
        let v4 = 0x2::bcs::peel_bool(&mut v2);
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        let v6 = 0x2::bcs::peel_u64(&mut v2);
        let v7 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(v5 > 0, 1);
        assert!(0x1::string::length(&v7) > 0, 9);
        assert!(v3 == 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg3), 4);
        let v8 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::get_spot_pool_id(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg1));
        assert!(0x1::option::is_some<0x2::object::ID>(&v8), 12);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v8) == 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg3), 13);
        if (v4) {
            let v9 = ExecutionProgressWitness{dummy_field: false};
            let v10 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable_resources::take_coin<T0, T3, ExecutionProgressWitness>(arg0, arg2, v9, v7);
            assert!(0x2::coin::value<T0>(&v10) == v5, 1);
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::deposit_approved<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, T1>(arg1, arg2, 0x1::string::utf8(b"treasury"), 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::swap_asset_for_stable<T0, T1, T2>(arg3, v10, v6, arg4, arg5));
        } else {
            let v11 = ExecutionProgressWitness{dummy_field: false};
            let v12 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable_resources::take_coin<T1, T3, ExecutionProgressWitness>(arg0, arg2, v11, v7);
            assert!(0x2::coin::value<T1>(&v12) == v5, 1);
            0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::deposit_approved<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig, T0>(arg1, arg2, 0x1::string::utf8(b"treasury"), 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::swap_stable_for_asset<T0, T1, T2>(arg3, v12, v6, arg4, arg5));
        };
        let v13 = GovernanceSwapExecuted{
            account_id     : 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg1),
            pool_id        : v3,
            swap_asset     : v4,
            amount_in      : v5,
            min_amount_out : v6,
        };
        0x2::event::emit<GovernanceSwapExecuted>(v13);
        let v14 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::increment_action_idx<T3, Swap<T0, T1, T2>, ExecutionProgressWitness>(arg0, arg2, v14);
    }

    public fun do_update_pool_fee<T0, T1, T2, T3: store>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::Executable<T3>, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg3: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::assert_execution_authorized<T3, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_specs<T3>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::intent<T3>(arg0)), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::action_idx<T3>(arg0));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_validation::assert_action_type<UpdatePoolFee<T0, T1, T2>>(v1);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_version(v1) == 1, 8);
        let v2 = 0x2::bcs::new(*0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_data(v1));
        let v3 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2));
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(v3 == 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg4), 4);
        let v5 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::get_spot_pool_id(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg1));
        assert!(0x1::option::is_some<0x2::object::ID>(&v5), 12);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v5) == 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg4), 13);
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::set_fee_bps<T0, T1, T2>(arg4, v4, new_spot_pool_mutation_auth(arg3, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg4)));
        let v6 = GovernancePoolFeeUpdated{
            account_id  : 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg1),
            pool_id     : v3,
            new_fee_bps : v4,
        };
        0x2::event::emit<GovernancePoolFeeUpdated>(v6);
        let v7 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::increment_action_idx<T3, UpdatePoolFee<T0, T1, T2>, ExecutionProgressWitness>(arg0, arg2, v7);
    }

    public fun get_asset_amount<T0, T1, T2>(arg0: &AddLiquidityAction<T0, T1, T2>) : u64 {
        arg0.asset_amount
    }

    public fun get_min_lp_amount<T0, T1, T2>(arg0: &AddLiquidityAction<T0, T1, T2>) : u64 {
        arg0.min_lp_out
    }

    public fun get_new_fee_bps<T0, T1, T2>(arg0: &UpdatePoolFeeAction<T0, T1, T2>) : u64 {
        arg0.new_fee_bps
    }

    public fun get_pool_id<T0, T1, T2>(arg0: &AddLiquidityAction<T0, T1, T2>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun get_stable_amount<T0, T1, T2>(arg0: &AddLiquidityAction<T0, T1, T2>) : u64 {
        arg0.stable_amount
    }

    public fun get_update_fee_pool_id<T0, T1, T2>(arg0: &UpdatePoolFeeAction<T0, T1, T2>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun new_add_liquidity_action<T0, T1, T2>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String) : AddLiquidityAction<T0, T1, T2> {
        assert!(arg1 > 0, 1);
        assert!(arg2 > 0, 1);
        assert!(0x1::string::length(&arg4) > 0, 9);
        assert!(0x1::string::length(&arg5) > 0, 9);
        AddLiquidityAction<T0, T1, T2>{
            pool_id              : arg0,
            asset_amount         : arg1,
            stable_amount        : arg2,
            min_lp_out           : arg3,
            asset_resource_name  : arg4,
            stable_resource_name : arg5,
        }
    }

    public fun new_remove_liquidity_to_resources_action<T0, T1, T2>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: bool) : RemoveLiquidityToResourcesAction<T0, T1, T2> {
        assert!(arg1 > 0, 1);
        assert!(0x1::string::length(&arg4) > 0, 9);
        assert!(0x1::string::length(&arg5) > 0, 9);
        assert!(0x1::string::length(&arg6) > 0, 9);
        assert!(arg5 != arg6, 14);
        RemoveLiquidityToResourcesAction<T0, T1, T2>{
            pool_id            : arg0,
            lp_amount          : arg1,
            min_asset_amount   : arg2,
            min_stable_amount  : arg3,
            lp_resource_name   : arg4,
            asset_output_name  : arg5,
            stable_output_name : arg6,
            for_dissolution    : arg7,
        }
    }

    public(friend) fun new_spot_pool_mutation_auth(arg0: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg1: 0x2::object::ID) : 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationAuth {
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg0, v0, arg1)
    }

    public fun new_swap_action<T0, T1, T2>(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64, arg4: 0x1::string::String) : SwapAction<T0, T1, T2> {
        assert!(arg2 > 0, 1);
        assert!(0x1::string::length(&arg4) > 0, 9);
        SwapAction<T0, T1, T2>{
            pool_id             : arg0,
            swap_asset          : arg1,
            amount_in           : arg2,
            min_amount_out      : arg3,
            input_resource_name : arg4,
        }
    }

    public fun new_update_pool_fee_action<T0, T1, T2>(arg0: 0x2::object::ID, arg1: u64) : UpdatePoolFeeAction<T0, T1, T2> {
        assert!(arg1 <= 0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::max_amm_fee_bps(), 10);
        UpdatePoolFeeAction<T0, T1, T2>{
            pool_id     : arg0,
            new_fee_bps : arg1,
        }
    }

    public fun remove_liquidity_to_resources_marker<T0, T1, T2>() : RemoveLiquidityToResources<T0, T1, T2> {
        RemoveLiquidityToResources<T0, T1, T2>{dummy_field: false}
    }

    public fun swap_marker<T0, T1, T2>() : Swap<T0, T1, T2> {
        Swap<T0, T1, T2>{dummy_field: false}
    }

    public fun update_pool_fee_marker<T0, T1, T2>() : UpdatePoolFee<T0, T1, T2> {
        UpdatePoolFee<T0, T1, T2>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

