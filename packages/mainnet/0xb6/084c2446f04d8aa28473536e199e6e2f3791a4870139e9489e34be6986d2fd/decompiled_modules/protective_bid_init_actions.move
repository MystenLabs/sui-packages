module 0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::protective_bid_init_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct CreateProtectiveBid<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct ProtectiveBidCreatedViaGovernance has copy, drop {
        bid_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        base_fee_bps: u64,
        surge_fee_bps: u64,
        surge_duration_ms: u64,
        reserved_amount: u64,
        nav_discount_bps: u64,
    }

    struct CreateProtectiveBidAction has copy, drop, store {
        vault_cap_resource_name: 0x1::string::String,
        reserved_amount: u64,
        nav_discount_bps: u64,
        base_fee_bps: u64,
        surge_fee_bps: u64,
        surge_duration_ms: u64,
        dao_amm_asset_principal: u64,
        dao_amm_stable_principal: u64,
        release_duration_ms: u64,
    }

    public fun add_create_protective_bid_spec<T0, T1>(arg0: &mut 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        if (arg7 != 0 || arg8 != 0) {
            assert!(arg7 > 0 && arg8 > 0, 7);
        };
        let v0 = CreateProtectiveBidAction{
            vault_cap_resource_name  : arg1,
            reserved_amount          : arg2,
            nav_discount_bps         : arg3,
            base_fee_bps             : arg4,
            surge_fee_bps            : arg5,
            surge_duration_ms        : arg6,
            dao_amm_asset_principal  : arg7,
            dao_amm_stable_principal : arg8,
            release_duration_ms      : arg9,
        };
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::add(arg0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<CreateProtectiveBid<T0, T1>>(), 0x2::bcs::to_bytes<CreateProtectiveBidAction>(&v0), 1));
        let v1 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::new_builder();
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_string(&mut v1, b"vault_cap_resource_name", arg1);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v1, b"reserved_amount", arg2);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v1, b"nav_discount_bps", arg3);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v1, b"base_fee_bps", arg4);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v1, b"surge_fee_bps", arg5);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v1, b"surge_duration_ms", arg6);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v1, b"dao_amm_asset_principal", arg7);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v1, b"dao_amm_stable_principal", arg8);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v1, b"release_duration_ms", arg9);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::emit_action_params(v1, 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_type(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_id(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<CreateProtectiveBid<T0, T1>>())), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::next_action_index(arg0));
    }

    public fun do_create_protective_bid<T0, T1, T2: store, T3: drop>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::Executable<T2>, arg1: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: T3, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::assert_execution_authorized<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_specs<T2>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::intent<T2>(arg0)), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::action_idx<T2>(arg0));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_validation::assert_action_type<CreateProtectiveBid<T0, T1>>(v1);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_version(v1) == 1, 1);
        let v2 = 0x2::bcs::new(*0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_data(v1));
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        let v6 = 0x2::bcs::peel_u64(&mut v2);
        let v7 = 0x2::bcs::peel_u64(&mut v2);
        let v8 = 0x2::bcs::peel_u64(&mut v2);
        let v9 = 0x2::bcs::peel_u64(&mut v2);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::bcs_validation::validate_all_bytes_consumed(v2);
        let v10 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg1);
        let v11 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::stable_type(v10);
        let v12 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        let v13 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()));
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::asset_type(v10) == &v12, 6);
        assert!(v11 == &v13, 6);
        let v14 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::get_spot_pool_id(v10);
        assert!(0x1::option::is_some<0x2::object::ID>(&v14), 5);
        let v15 = *0x1::option::borrow<0x2::object::ID>(&v14);
        let v16 = ExecutionProgressWitness{dummy_field: false};
        let v17 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable_resources::take_object<0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::VaultAdminCap, T2, ExecutionProgressWitness>(arg0, arg2, v16, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
        let v18 = 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg1);
        assert!(0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::admin_cap_account_id(&v17) == v18, 8);
        let v19 = if (v8 == 0 && v9 == 0) {
            0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::protective_bid::create<T0, T1>(v18, v15, v5, v6, v7, 0x2::bcs::peel_u64(&mut v2), v17, v3, v4, arg3, arg5)
        } else {
            assert!(v8 > 0 && v9 > 0, 7);
            0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::protective_bid::create_with_principal<T0, T1>(v18, v15, v5, v6, v7, 0x2::bcs::peel_u64(&mut v2), v8, v9, v17, v3, v4, arg3, arg5)
        };
        let v20 = v19;
        let v21 = 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::protective_bid::ProtectiveBid<T0, T1>>(&v20);
        let v22 = ProtectiveBidCreatedViaGovernance{
            bid_id            : v21,
            account_id        : v18,
            pool_id           : v15,
            base_fee_bps      : v5,
            surge_fee_bps     : v6,
            surge_duration_ms : v7,
            reserved_amount   : v3,
            nav_discount_bps  : v4,
        };
        0x2::event::emit<ProtectiveBidCreatedViaGovernance>(v22);
        let v23 = ExecutionProgressWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::protective_bid_registry::set_from_execution<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v23, v21, v15);
        0x2::transfer::public_share_object<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::protective_bid::ProtectiveBid<T0, T1>>(v20);
        let v24 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::increment_action_idx<T2, CreateProtectiveBid<T0, T1>, ExecutionProgressWitness>(arg0, arg2, v24);
        v21
    }

    // decompiled from Move bytecode v6
}

