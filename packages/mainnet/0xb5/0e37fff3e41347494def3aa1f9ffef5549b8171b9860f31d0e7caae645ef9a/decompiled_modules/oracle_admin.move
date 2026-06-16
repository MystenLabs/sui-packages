module 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_admin {
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

    struct NewStorkFeed has copy, drop {
        feed_id: vector<u8>,
        ema_feed_id: vector<u8>,
        asset: 0x1::type_name::TypeName,
        who: address,
        timestamp: u64,
    }

    struct NewRWAConfig has copy, drop {
        oracle: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        who: address,
        timestamp: u64,
    }

    struct AssetPriceDelayToleranceUpdated has copy, drop {
        oracle: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        base_token: u8,
        delay_ms: u64,
        who: address,
        timestamp: u64,
    }

    public fun create_bound(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::AdminCap, arg1: u64, arg2: u64) : 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedValueChecker {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::new(arg1, arg2)
    }

    public fun migrate(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::AdminCap, arg1: &mut 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle) : u64 {
        abort 0
    }

    public fun migrate_v1(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::AdminCap, arg1: &mut 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::migrate(arg1, arg2)
    }

    public fun register_pyth_feed<T0>(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::AdminCap, arg1: &mut 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: u64) {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::ensure_version_matches(arg1);
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::pyth_adaptor::register_pyth_feed<T0>(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::pyth_price_feeds_mut(arg1), arg2, arg3, arg4);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = NewPythPriceFeed{
            oracle       : 0x2::object::id<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle>(arg1),
            asset        : 0x1::type_name::with_defining_ids<T0>(),
            pyth_feed_id : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1),
        };
        0x2::event::emit<NewPythPriceFeed>(v2);
    }

    public fun update_price_delay_tolerance_ms(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::AdminCap, arg1: &mut 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::ensure_version_matches(arg1);
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::update_price_delay_tolerance_ms(arg1, arg2);
        let v0 = PriceDelayToleranceUpdated{
            oracle    : 0x2::object::id<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle>(arg1),
            delay_ms  : arg2,
            who       : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<PriceDelayToleranceUpdated>(v0);
    }

    public fun update_price_delay_tolerance_ms_for_asset<T0>(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::AdminCap, arg1: &mut 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::ensure_version_matches(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::table::borrow_mut<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::BaseToken, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<u64>>(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::prices_delay_tolerance_ms_mut(arg1), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::base_token_from_u8(arg2));
        if (0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::has_asset<u64>(v1, v0)) {
            *0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::borrow_mut<u64>(v1, v0) = arg3;
        } else {
            0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::set<u64>(v1, v0, arg3);
        };
        let v2 = AssetPriceDelayToleranceUpdated{
            oracle     : 0x2::object::id<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle>(arg1),
            asset      : v0,
            base_token : arg2,
            delay_ms   : arg3,
            who        : 0x2::tx_context::sender(arg5),
            timestamp  : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<AssetPriceDelayToleranceUpdated>(v2);
    }

    public fun upsert_rwa_config<T0>(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::AdminCap, arg1: &mut 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg2: 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedValueChecker, arg3: 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedValueChecker, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::ensure_version_matches(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::rwa_registry_mut(arg1);
        if (0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::has_asset<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedAssetConfig>(v1, v0)) {
            0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::set_bounds(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::borrow_mut<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedAssetConfig>(v1, v0), arg2, arg3);
        } else {
            0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::set<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedAssetConfig>(v1, v0, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::new_config(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::stork_source(), arg2, arg3));
        };
        let v2 = NewRWAConfig{
            oracle    : 0x2::object::id<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle>(arg1),
            asset     : v0,
            who       : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<NewRWAConfig>(v2);
    }

    public fun upsert_stork_feed<T0>(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::AdminCap, arg1: &mut 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::ensure_version_matches(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::pyth_adaptor::PythFeedData>(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::pyth_price_feeds(arg1), v0), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::asset_source_conflict());
        let v1 = 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::stork_feed_registry_mut(arg1);
        if (0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::has_asset<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::StorkFeedInfo>(v1, v0)) {
            0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::update_feed_ids(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::borrow_mut<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::StorkFeedInfo>(v1, v0), arg2, arg3);
        } else {
            0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::set<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::StorkFeedInfo>(v1, v0, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::new(arg2, arg3));
        };
        let v2 = NewStorkFeed{
            feed_id     : arg2,
            ema_feed_id : arg3,
            asset       : v0,
            who         : 0x2::tx_context::sender(arg5),
            timestamp   : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<NewStorkFeed>(v2);
    }

    // decompiled from Move bytecode v7
}

