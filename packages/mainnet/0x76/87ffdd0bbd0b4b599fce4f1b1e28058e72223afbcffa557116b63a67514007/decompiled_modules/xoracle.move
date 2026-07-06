module 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::xoracle {
    struct RegisterPythFeedWish<phantom T0> has copy, drop, store {
        spot_confidence_tolerance_bps: u64,
        ema_confidence_tolerance_bps: u64,
        price_info_object_id: 0x2::object::ID,
        x_oracle_id: 0x2::object::ID,
    }

    struct CreateBatchAssetsUpdate {
        x_oracle_id: 0x2::object::ID,
        updates: 0x2::vec_map::VecMap<0x1::type_name::TypeName, AssetXOracleUpdate>,
    }

    struct FulfillBatchAssetsUpdate {
        x_oracle_id: 0x2::object::ID,
        updates: 0x2::vec_map::VecMap<0x1::type_name::TypeName, AssetXOracleUpdate>,
    }

    struct PendingOracleBatch has store {
        x_oracle_id: 0x2::object::ID,
        updates: 0x2::vec_map::VecMap<0x1::type_name::TypeName, AssetXOracleUpdate>,
    }

    struct AssetXOracleUpdate has drop, store {
        pyth: 0x1::option::Option<PythFeedParams>,
        stork: 0x1::option::Option<StorkFeedParams>,
        admin_ref: 0x1::option::Option<AdminRefParams>,
        config: 0x1::option::Option<AssetConfigParams>,
        delay_tolerance_ms: 0x1::option::Option<u64>,
    }

    struct PythFeedParams has copy, drop, store {
        pyth_pro_feed_id: u32,
        expected_channel_id: u8,
        min_publisher_count: u16,
        spot_confidence_tolerance_bps: u64,
        ema_confidence_tolerance_bps: u64,
    }

    struct StorkFeedParams has copy, drop, store {
        feed_id: vector<u8>,
        ema_feed_id: vector<u8>,
    }

    struct AdminRefParams has copy, drop, store {
        spot: u64,
        ema: u64,
    }

    struct AssetConfigParams has copy, drop, store {
        base_token_id: u8,
        primary_source_id: u8,
        check_source_id: u8,
        lower_bound_bps: u64,
        upper_bound_bps: u64,
        max_update_time_gap_ms: u64,
    }

    struct BatchCommitted has copy, drop {
        x_oracle_id: 0x2::object::ID,
    }

    struct BatchFulfilled has copy, drop {
        x_oracle_id: 0x2::object::ID,
    }

    struct BatchCancelled has copy, drop {
        x_oracle_id: 0x2::object::ID,
    }

    public fun migrate_v1(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: &mut 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::ProtocolApp, arg3: &mut 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::LeverageApp, arg4: CreateBatchAssetsUpdate, arg5: &mut 0x2::tx_context::TxContext) : FulfillBatchAssetsUpdate {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_can_summon_shenron(arg0);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        ensure_x_oracle_match(arg1, &arg4.x_oracle_id);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::upgrade_xoracle::migrate_v1(arg0, arg1, arg2, arg3, arg5);
        let CreateBatchAssetsUpdate {
            x_oracle_id : v0,
            updates     : v1,
        } = arg4;
        let v2 = FulfillBatchAssetsUpdate{
            x_oracle_id : v0,
            updates     : v1,
        };
        assert_migration_batch(&v2);
        let v3 = BatchFulfilled{x_oracle_id: v0};
        0x2::event::emit<BatchFulfilled>(v3);
        v2
    }

    public fun add_admin_ref<T0>(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: CreateBatchAssetsUpdate, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : CreateBatchAssetsUpdate {
        preflight_without_version_check(arg0, arg1, arg2.x_oracle_id, arg5);
        let v0 = &mut arg2.updates;
        let v1 = AdminRefParams{
            spot : arg3,
            ema  : arg4,
        };
        0x1::option::fill<AdminRefParams>(&mut borrow_or_create_asset_update<T0>(v0).admin_ref, v1);
        arg2
    }

    public fun add_asset_config<T0>(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: CreateBatchAssetsUpdate, arg3: u8, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) : CreateBatchAssetsUpdate {
        preflight_without_version_check(arg0, arg1, arg2.x_oracle_id, arg9);
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::base_token_from_u8(arg3);
        let v0 = &mut arg2.updates;
        let v1 = AssetConfigParams{
            base_token_id          : arg3,
            primary_source_id      : arg4,
            check_source_id        : arg5,
            lower_bound_bps        : arg6,
            upper_bound_bps        : arg7,
            max_update_time_gap_ms : arg8,
        };
        0x1::option::fill<AssetConfigParams>(&mut borrow_or_create_asset_update<T0>(v0).config, v1);
        arg2
    }

    public fun add_delay_tolerance<T0>(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: CreateBatchAssetsUpdate, arg3: u64, arg4: &0x2::tx_context::TxContext) : CreateBatchAssetsUpdate {
        preflight_without_version_check(arg0, arg1, arg2.x_oracle_id, arg4);
        let v0 = &mut arg2.updates;
        0x1::option::fill<u64>(&mut borrow_or_create_asset_update<T0>(v0).delay_tolerance_ms, arg3);
        arg2
    }

    public fun add_pyth_feed<T0>(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: CreateBatchAssetsUpdate, arg3: u32, arg4: u8, arg5: u16, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) : CreateBatchAssetsUpdate {
        preflight_without_version_check(arg0, arg1, arg2.x_oracle_id, arg8);
        let v0 = &mut arg2.updates;
        let v1 = PythFeedParams{
            pyth_pro_feed_id              : arg3,
            expected_channel_id           : arg4,
            min_publisher_count           : arg5,
            spot_confidence_tolerance_bps : arg6,
            ema_confidence_tolerance_bps  : arg7,
        };
        0x1::option::fill<PythFeedParams>(&mut borrow_or_create_asset_update<T0>(v0).pyth, v1);
        arg2
    }

    public fun add_stork_feed<T0>(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: CreateBatchAssetsUpdate, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) : CreateBatchAssetsUpdate {
        preflight_without_version_check(arg0, arg1, arg2.x_oracle_id, arg5);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::errors::invalid_feed_length());
        assert!(0x1::vector::length<u8>(&arg4) == 32, 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::errors::invalid_feed_length());
        let v0 = &mut arg2.updates;
        let v1 = StorkFeedParams{
            feed_id     : arg3,
            ema_feed_id : arg4,
        };
        0x1::option::fill<StorkFeedParams>(&mut borrow_or_create_asset_update<T0>(v0).stork, v1);
        arg2
    }

    public fun admin_set_ref_price<T0>(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::admin_ref_feed::admin_set_ref_price<T0>(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::x_oracle_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    fun assert_migration_batch(arg0: &FulfillBatchAssetsUpdate) {
        let v0 = migration_specs();
        assert!(0x2::vec_map::length<0x1::type_name::TypeName, AssetXOracleUpdate>(&arg0.updates) == 0x2::vec_map::length<vector<u8>, AssetXOracleUpdate>(&v0), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::errors::unexpected_migration_asset());
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<0x1::type_name::TypeName, AssetXOracleUpdate>(&arg0.updates)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, AssetXOracleUpdate>(&arg0.updates, v1);
            let v4 = 0x1::ascii::into_bytes(0x1::type_name::into_string(*v2));
            assert!(0x2::vec_map::contains<vector<u8>, AssetXOracleUpdate>(&v0, &v4), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::errors::unexpected_migration_asset());
            let v5 = 0x2::vec_map::get<vector<u8>, AssetXOracleUpdate>(&v0, &v4);
            assert!(pyth_pins_match(&v3.pyth, &v5.pyth) && v3.config == v5.config, 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::errors::migration_config_mismatch());
            v1 = v1 + 1;
        };
    }

    fun borrow_or_create_asset_update<T0>(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, AssetXOracleUpdate>) : &mut AssetXOracleUpdate {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, AssetXOracleUpdate>(arg0, &v0)) {
            let v1 = AssetXOracleUpdate{
                pyth               : 0x1::option::none<PythFeedParams>(),
                stork              : 0x1::option::none<StorkFeedParams>(),
                admin_ref          : 0x1::option::none<AdminRefParams>(),
                config             : 0x1::option::none<AssetConfigParams>(),
                delay_tolerance_ms : 0x1::option::none<u64>(),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, AssetXOracleUpdate>(arg0, v0, v1);
        };
        0x2::vec_map::get_mut<0x1::type_name::TypeName, AssetXOracleUpdate>(arg0, &v0)
    }

    public fun cancel_x_oracle_batch(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg1));
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        let PendingOracleBatch {
            x_oracle_id : v0,
            updates     : _,
        } = 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::into_inner<PendingOracleBatch>(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::take_locked_update<0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::TimeLock<PendingOracleBatch>>(arg0, 0x1::type_name::with_defining_ids<PendingOracleBatch>()));
        let v2 = BatchCancelled{x_oracle_id: v0};
        0x2::event::emit<BatchCancelled>(v2);
    }

    public fun commit_x_oracle_batch(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: CreateBatchAssetsUpdate, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        preflight(arg0, arg1, arg2.x_oracle_id, arg4);
        let CreateBatchAssetsUpdate {
            x_oracle_id : v0,
            updates     : v1,
        } = arg2;
        let v2 = PendingOracleBatch{
            x_oracle_id : v0,
            updates     : v1,
        };
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::store_locked_update<0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::TimeLock<PendingOracleBatch>>(arg0, 0x1::type_name::with_defining_ids<PendingOracleBatch>(), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::new_time_locked<PendingOracleBatch>(v2, arg3, 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::time_lock_duration_seconds(arg0), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::time_lock_expriration_seconds(arg0)));
        let v3 = BatchCommitted{x_oracle_id: v0};
        0x2::event::emit<BatchCommitted>(v3);
    }

    fun ensure_x_oracle_match(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg1: &0x2::object::ID) {
        assert!(0x2::object::id<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle>(arg0) == *arg1, 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::errors::invalid_x_oracle());
    }

    public fun finish_fulfill_x_oracle_batch(arg0: FulfillBatchAssetsUpdate) {
        let FulfillBatchAssetsUpdate {
            x_oracle_id : _,
            updates     : v1,
        } = arg0;
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, AssetXOracleUpdate>(v1);
    }

    public fun fulfill_asset<T0>(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: FulfillBatchAssetsUpdate, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : FulfillBatchAssetsUpdate {
        preflight(arg0, arg1, arg2.x_oracle_id, arg4);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, AssetXOracleUpdate>(&mut arg2.updates, &v0);
        let AssetXOracleUpdate {
            pyth               : v3,
            stork              : v4,
            admin_ref          : v5,
            config             : v6,
            delay_tolerance_ms : v7,
        } = v2;
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = v3;
        if (0x1::option::is_some<PythFeedParams>(&v12)) {
            let PythFeedParams {
                pyth_pro_feed_id              : v13,
                expected_channel_id           : v14,
                min_publisher_count           : v15,
                spot_confidence_tolerance_bps : v16,
                ema_confidence_tolerance_bps  : v17,
            } = 0x1::option::destroy_some<PythFeedParams>(v12);
            0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::pyth_update::register_pyth_feed<T0>(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::x_oracle_admin_cap(arg0), arg1, v13, v14, v15, v16, v17);
        } else {
            0x1::option::destroy_none<PythFeedParams>(v12);
        };
        if (0x1::option::is_some<StorkFeedParams>(&v11)) {
            let StorkFeedParams {
                feed_id     : v18,
                ema_feed_id : v19,
            } = 0x1::option::destroy_some<StorkFeedParams>(v11);
            0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::stork_oracle::upsert_stork_feed<T0>(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::x_oracle_admin_cap(arg0), arg1, v18, v19, arg3, arg4);
        } else {
            0x1::option::destroy_none<StorkFeedParams>(v11);
        };
        if (0x1::option::is_some<AdminRefParams>(&v10)) {
            let AdminRefParams {
                spot : v20,
                ema  : v21,
            } = 0x1::option::destroy_some<AdminRefParams>(v10);
            0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::admin_ref_feed::admin_set_ref_price<T0>(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::x_oracle_admin_cap(arg0), arg1, v20, v21, arg3, arg4);
        } else {
            0x1::option::destroy_none<AdminRefParams>(v10);
        };
        if (0x1::option::is_some<AssetConfigParams>(&v9)) {
            let AssetConfigParams {
                base_token_id          : v22,
                primary_source_id      : v23,
                check_source_id        : v24,
                lower_bound_bps        : v25,
                upper_bound_bps        : v26,
                max_update_time_gap_ms : v27,
            } = 0x1::option::destroy_some<AssetConfigParams>(v9);
            0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_admin::upsert_asset_config<T0>(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::x_oracle_admin_cap(arg0), arg1, v22, v23, v24, v25, v26, v27, arg3, arg4);
        } else {
            0x1::option::destroy_none<AssetConfigParams>(v9);
        };
        if (0x1::option::is_some<u64>(&v8)) {
            0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_admin::update_price_delay_tolerance_ms_for_asset<T0>(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::x_oracle_admin_cap(arg0), arg1, 0x1::option::destroy_some<u64>(v8), arg3, arg4);
        } else {
            0x1::option::destroy_none<u64>(v8);
        };
        arg2
    }

    public fun fulfill_register_pyth_feed_wish<T0>(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        abort 0
    }

    fun mig_entry(arg0: u64, arg1: u64, arg2: u32, arg3: u8, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64) : AssetXOracleUpdate {
        let v0 = PythFeedParams{
            pyth_pro_feed_id              : arg2,
            expected_channel_id           : 0,
            min_publisher_count           : 0,
            spot_confidence_tolerance_bps : arg0,
            ema_confidence_tolerance_bps  : arg1,
        };
        let v1 = AssetConfigParams{
            base_token_id          : arg3,
            primary_source_id      : arg4,
            check_source_id        : arg5,
            lower_bound_bps        : arg6,
            upper_bound_bps        : arg7,
            max_update_time_gap_ms : arg8,
        };
        AssetXOracleUpdate{
            pyth               : 0x1::option::some<PythFeedParams>(v0),
            stork              : 0x1::option::none<StorkFeedParams>(),
            admin_ref          : 0x1::option::none<AdminRefParams>(),
            config             : 0x1::option::some<AssetConfigParams>(v1),
            delay_tolerance_ms : 0x1::option::none<u64>(),
        }
    }

    fun migration_specs() : 0x2::vec_map::VecMap<vector<u8>, AssetXOracleUpdate> {
        let v0 = 0x2::vec_map::empty<vector<u8>, AssetXOracleUpdate>();
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI", mig_entry(200, 100, 11, 0, 1, 2, 500, 500, 15000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC", mig_entry(100, 50, 7, 0, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT", mig_entry(100, 50, 8, 0, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"960b531667636f39e85867775f52f6b1f220a058c4de786905bdf761e06a56bb::usdy::USDY", mig_entry(100, 80, 276, 0, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"e14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB", mig_entry(400, 200, 2320, 0, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"f16e6b723f242ec745dfd7634ad072c42d5c1d9ac9d62a39c381303eaa57693a::fdusd::FDUSD", mig_entry(100, 50, 88, 0, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI", mig_entry(100, 50, 3049, 0, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE", mig_entry(100, 50, 2998, 0, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"bde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI", mig_entry(400, 200, 3244, 1, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"d1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI", mig_entry(200, 100, 736, 1, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"f325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI", mig_entry(200, 100, 3245, 1, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT", mig_entry(200, 100, 2349, 1, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI", mig_entry(100, 100, 11, 0, 1, 2, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"34469c8accdd673df02600265cbbad3688577f0e716866e257f88d448d463492::eearn::EEARN", mig_entry(100, 50, 3161, 0, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"66629328922d609cf15af779719e248ae0e63fe0b9d9739623f763b33a9c97da::esui::ESUI", mig_entry(400, 200, 3180, 0, 1, 2, 1000, 1000, 15000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"89b0d4407f17cc1b1294464f28e176e29816a40612f7a553313ea0a797a5f803::ethird::ETHIRD", mig_entry(100, 50, 3179, 0, 1, 255, 500, 500, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"aafb102dd0902f5055cadecd687fb5b71ca82ef0e0285d90afde828ec58ca96b::btc::BTC", mig_entry(100, 50, 1, 0, 1, 2, 500, 500, 15000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"d0e89b2af5e4910726fbcd8b8dd37bb79b29e5f83f7491bca830e94f7f226d29::eth::ETH", mig_entry(100, 50, 2, 0, 1, 2, 500, 500, 15000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM", mig_entry(400, 200, 3207, 0, 1, 2, 500, 500, 15000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"876a4b7bce8aeaef60464c11f4026903e9afacab79b9b142686158aa86560b50::xbtc::XBTC", mig_entry(100, 50, 1598, 0, 1, 2, 1000, 1000, 15000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::lbtc::LBTC", mig_entry(200, 100, 468, 0, 1, 2, 1000, 1000, 15000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"deeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP", mig_entry(400, 200, 173, 0, 1, 255, 9999, 9999, 1209600000));
        0x2::vec_map::insert<vector<u8>, AssetXOracleUpdate>(&mut v0, b"356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL", mig_entry(400, 200, 624, 0, 1, 255, 9999, 9999, 1209600000));
        v0
    }

    fun preflight(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        preflight_without_version_check(arg0, arg1, arg2, arg3);
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_version_matches(arg0);
    }

    fun preflight_without_version_check(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_can_summon_shenron(arg0);
        ensure_x_oracle_match(arg1, &arg2);
    }

    fun pyth_pins_match(arg0: &0x1::option::Option<PythFeedParams>, arg1: &0x1::option::Option<PythFeedParams>) : bool {
        if (0x1::option::is_none<PythFeedParams>(arg0) || 0x1::option::is_none<PythFeedParams>(arg1)) {
            return 0x1::option::is_none<PythFeedParams>(arg0) && 0x1::option::is_none<PythFeedParams>(arg1)
        };
        let v0 = 0x1::option::borrow<PythFeedParams>(arg0);
        let v1 = 0x1::option::borrow<PythFeedParams>(arg1);
        if (v0.pyth_pro_feed_id == v1.pyth_pro_feed_id) {
            if (v0.spot_confidence_tolerance_bps == v1.spot_confidence_tolerance_bps) {
                v0.ema_confidence_tolerance_bps == v1.ema_confidence_tolerance_bps
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun start_fulfill_x_oracle_batch(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : FulfillBatchAssetsUpdate {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        let v0 = 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::take_locked_update<0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::TimeLock<PendingOracleBatch>>(arg0, 0x1::type_name::with_defining_ids<PendingOracleBatch>());
        assert!(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::is_active<PendingOracleBatch>(&v0, arg2), 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::errors::time_locked_not_active());
        let PendingOracleBatch {
            x_oracle_id : v1,
            updates     : v2,
        } = 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::time_lock::into_inner<PendingOracleBatch>(v0);
        let v3 = v1;
        ensure_x_oracle_match(arg1, &v3);
        let v4 = BatchFulfilled{x_oracle_id: v3};
        0x2::event::emit<BatchFulfilled>(v4);
        FulfillBatchAssetsUpdate{
            x_oracle_id : v3,
            updates     : v2,
        }
    }

    public fun start_x_oracle_batch_update(arg0: &0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: &0x2::tx_context::TxContext) : CreateBatchAssetsUpdate {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_can_summon_shenron(arg0);
        CreateBatchAssetsUpdate{
            x_oracle_id : 0x2::object::id<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle>(arg1),
            updates     : 0x2::vec_map::empty<0x1::type_name::TypeName, AssetXOracleUpdate>(),
        }
    }

    public fun update_price_delay_tolerance_ms(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::ensure_functional(arg0);
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_admin::update_price_delay_tolerance_ms(0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::x_oracle_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun wish_register_pyth_feed<T0>(arg0: &mut 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::governance::DragonBallCollector, arg1: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: u64, arg3: u64, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v7
}

