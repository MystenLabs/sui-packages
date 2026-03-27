module 0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::protective_bid_init_actions {
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

    public fun add_create_protective_bid_spec<T0, T1>(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
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
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<CreateProtectiveBid<T0, T1>>(), 0x2::bcs::to_bytes<CreateProtectiveBidAction>(&v0), 1));
        let v1 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder();
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_string(&mut v1, b"vault_cap_resource_name", arg1);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v1, b"reserved_amount", arg2);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v1, b"nav_discount_bps", arg3);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v1, b"base_fee_bps", arg4);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v1, b"surge_fee_bps", arg5);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v1, b"surge_duration_ms", arg6);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v1, b"dao_amm_asset_principal", arg7);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v1, b"dao_amm_stable_principal", arg8);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v1, b"release_duration_ms", arg9);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(v1, 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<CreateProtectiveBid<T0, T1>>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    public fun do_create_protective_bid<T0, T1, T2: store, T3: drop>(arg0: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::executable::Executable<T2>, arg1: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg2: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: T3, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::assert_execution_authorized<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::ActionSpec>(0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::action_specs<T2>(0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::executable::intent<T2>(arg0)), 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::executable::action_idx<T2>(arg0));
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_validation::assert_action_type<CreateProtectiveBid<T0, T1>>(v1);
        assert!(0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::action_spec_version(v1) == 1, 1);
        let v2 = 0x2::bcs::new(*0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::action_spec_data(v1));
        let v3 = 0x2::bcs::peel_u64(&mut v2);
        let v4 = 0x2::bcs::peel_u64(&mut v2);
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        let v6 = 0x2::bcs::peel_u64(&mut v2);
        let v7 = 0x2::bcs::peel_u64(&mut v2);
        let v8 = 0x2::bcs::peel_u64(&mut v2);
        let v9 = 0x2::bcs::peel_u64(&mut v2);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::bcs_validation::validate_all_bytes_consumed(v2);
        let v10 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::config<0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::futarchy_config::FutarchyConfig>(arg1);
        let v11 = 0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::futarchy_config::stable_type(v10);
        let v12 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        let v13 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()));
        assert!(0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::futarchy_config::asset_type(v10) == &v12, 6);
        assert!(v11 == &v13, 6);
        let v14 = 0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::futarchy_config::get_spot_pool_id(v10);
        assert!(0x1::option::is_some<0x2::object::ID>(&v14), 5);
        let v15 = *0x1::option::borrow<0x2::object::ID>(&v14);
        let v16 = ExecutionProgressWitness{dummy_field: false};
        let v17 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::executable_resources::take_object<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::VaultAdminCap, T2, ExecutionProgressWitness>(arg0, arg2, v16, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)));
        let v18 = 0x2::object::id<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account>(arg1);
        assert!(0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::admin_cap_account_id(&v17) == v18, 8);
        let v19 = if (v8 == 0 && v9 == 0) {
            0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::protective_bid::create<T0, T1>(v18, v15, v5, v6, v7, 0x2::bcs::peel_u64(&mut v2), v17, v3, v4, arg3, arg5)
        } else {
            assert!(v8 > 0 && v9 > 0, 7);
            0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::protective_bid::create_with_principal<T0, T1>(v18, v15, v5, v6, v7, 0x2::bcs::peel_u64(&mut v2), v8, v9, v17, v3, v4, arg3, arg5)
        };
        let v20 = v19;
        let v21 = 0x2::object::id<0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::protective_bid::ProtectiveBid<T0, T1>>(&v20);
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
        0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::protective_bid_registry::set_from_execution<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v23, v21, v15);
        0x2::transfer::public_share_object<0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::protective_bid::ProtectiveBid<T0, T1>>(v20);
        let v24 = ExecutionProgressWitness{dummy_field: false};
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::executable::increment_action_idx<T2, CreateProtectiveBid<T0, T1>, ExecutionProgressWitness>(arg0, arg2, v24);
        v21
    }

    // decompiled from Move bytecode v6
}

