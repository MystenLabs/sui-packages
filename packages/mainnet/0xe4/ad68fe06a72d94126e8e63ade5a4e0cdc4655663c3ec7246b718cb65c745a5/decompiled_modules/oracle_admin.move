module 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_admin {
    struct PriceDelayToleranceUpdated has copy, drop {
        oracle: 0x2::object::ID,
        delay_ms: u64,
        who: address,
        timestamp: u64,
    }

    struct NewPythPriceFeed has copy, drop {
        oracle: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        pyth_feed_id: vector<u8>,
    }

    struct NewAssetConfig has copy, drop {
        oracle: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        primary_source_id: u8,
        check_source_id: u8,
        lower_bound_bps: u64,
        upper_bound_bps: u64,
        max_update_time_gap_ms: u64,
        base_token_id: u8,
        who: address,
        timestamp: u64,
    }

    struct AssetPriceDelayToleranceUpdated has copy, drop {
        oracle: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        delay_ms: u64,
        who: address,
        timestamp: u64,
    }

    public fun migrate(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::AdminCap, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle) : u64 {
        abort 0
    }

    public fun migrate_v1(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::AdminCap, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::migrate(arg1, arg2)
    }

    public fun register_pyth_feed<T0>(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::AdminCap, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: u64) {
        abort 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::deprecated()
    }

    public fun update_price_delay_tolerance_ms(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::AdminCap, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::ensure_version_matches(arg1);
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::update_price_delay_tolerance_ms(arg1, arg2);
        let v0 = PriceDelayToleranceUpdated{
            oracle    : 0x2::object::id<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle>(arg1),
            delay_ms  : arg2,
            who       : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<PriceDelayToleranceUpdated>(v0);
    }

    public fun update_price_delay_tolerance_ms_for_asset<T0>(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::AdminCap, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 15768000000, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::invalid_delay_tolerance());
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::ensure_version_matches(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::prices_delay_tolerance_ms_mut(arg1);
        if (0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset_registry::has_asset<u64>(v1, v0)) {
            *0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset_registry::borrow_mut<u64>(v1, v0) = arg2;
        } else {
            0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset_registry::set<u64>(v1, v0, arg2);
        };
        let v2 = AssetPriceDelayToleranceUpdated{
            oracle    : 0x2::object::id<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle>(arg1),
            asset     : v0,
            delay_ms  : arg2,
            who       : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<AssetPriceDelayToleranceUpdated>(v2);
    }

    public fun upsert_asset_config<T0>(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::AdminCap, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::ensure_version_matches(arg1);
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::base_token_from_u8(arg2);
        assert!(arg3 != 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset::admin_ref_source(), 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::not_allowed_as_primary());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::check_coin_configured_in_source(arg1, v0, arg3);
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::check_coin_configured_in_source(arg1, v0, arg4);
        let v1 = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::asset_registry_mut(arg1);
        if (0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset_registry::has_asset<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset::AssetConfig>(v1, v0)) {
            let v2 = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset_registry::borrow_mut<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset::AssetConfig>(v1, v0);
            *v2 = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset::new_asset_config(arg2, arg3, arg4, arg5, arg6, arg7);
            0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::clear_cached_price(arg1, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::base_token_from_u8(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset::base_token_id(v2)), v0);
        } else {
            0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset_registry::set<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset::AssetConfig>(v1, v0, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset::new_asset_config(arg2, arg3, arg4, arg5, arg6, arg7));
        };
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::clear_unused_source_feeds(arg1, v0, arg3, arg4);
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::clear_cached_price(arg1, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::base_token_from_u8(arg2), v0);
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::update_feed_check_passed(arg1, v0, false);
        let v3 = NewAssetConfig{
            oracle                 : 0x2::object::id<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle>(arg1),
            asset                  : v0,
            primary_source_id      : arg3,
            check_source_id        : arg4,
            lower_bound_bps        : arg5,
            upper_bound_bps        : arg6,
            max_update_time_gap_ms : arg7,
            base_token_id          : arg2,
            who                    : 0x2::tx_context::sender(arg9),
            timestamp              : 0x2::clock::timestamp_ms(arg8) / 1000,
        };
        0x2::event::emit<NewAssetConfig>(v3);
    }

    // decompiled from Move bytecode v7
}

