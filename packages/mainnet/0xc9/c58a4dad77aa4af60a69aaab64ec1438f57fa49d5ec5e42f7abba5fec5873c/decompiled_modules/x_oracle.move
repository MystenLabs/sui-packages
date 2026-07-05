module 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::x_oracle {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct X_ORACLE has drop {
        dummy_field: bool,
    }

    struct BaseToken has copy, drop, store {
        id: u8,
    }

    struct XOracle has key {
        id: 0x2::object::UID,
        price_delay_tolerance_ms: u64,
        prices: 0x2::table::Table<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>>,
        version: u64,
    }

    struct PythPriceFeedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PythProFeedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StorkFeedRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminRefRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AssetRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PricesDelayToleranceMsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeedCheckersPassKey has copy, drop, store {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : XOracle {
        let v0 = XOracle{
            id                       : 0x2::object::new(arg0),
            price_delay_tolerance_ms : 5000,
            prices                   : 0x2::table::new<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>>(arg0),
            version                  : 2,
        };
        0x2::table::add<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>>(&mut v0.prices, usd(), 0x2::table::new<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>(arg0));
        v0
    }

    public(friend) fun sui() : BaseToken {
        BaseToken{id: 1}
    }

    public(friend) fun asset_registry(arg0: &XOracle) : &0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::AssetConfig> {
        let v0 = AssetRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow<AssetRegistryKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::AssetConfig>>(&arg0.id, v0)
    }

    public(friend) fun admin_ref_feed_registry(arg0: &XOracle) : &0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::reference::AdminReference> {
        let v0 = AdminRefRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow<AdminRefRegistryKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::reference::AdminReference>>(&arg0.id, v0)
    }

    public(friend) fun admin_ref_feed_registry_mut(arg0: &mut XOracle) : &mut 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::reference::AdminReference> {
        let v0 = AdminRefRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AdminRefRegistryKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::reference::AdminReference>>(&mut arg0.id, v0)
    }

    public(friend) fun asset_registry_mut(arg0: &mut XOracle) : &mut 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::AssetConfig> {
        let v0 = AssetRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AssetRegistryKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::AssetConfig>>(&mut arg0.id, v0)
    }

    public fun base_token_from_u8(arg0: u8) : BaseToken {
        let v0 = &arg0;
        let v1 = 0;
        if (v0 == &v1) {
            usd()
        } else {
            let v3 = 1;
            assert!(v0 == &v3, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::unknown_oracle_base_token());
            sui()
        }
    }

    public(friend) fun cached_spot_update_time(arg0: &XOracle, arg1: BaseToken, arg2: 0x1::type_name::TypeName) : u64 {
        assert!(0x2::table::contains<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>>(&arg0.prices, arg1), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::base_token_not_supported());
        let v0 = 0x2::table::borrow<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>>(&arg0.prices, arg1);
        if (0x2::table::contains<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>(v0, arg2)) {
            0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::update_time(0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::spot(0x2::table::borrow<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>(v0, arg2)))
        } else {
            0
        }
    }

    public(friend) fun check_coin_configured_in_source(arg0: &XOracle, arg1: 0x1::type_name::TypeName, arg2: u8) {
        let v0 = if (arg2 == 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::pyth_source()) {
            0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::has_asset<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::pyth_adaptor::PythProFeedInfo>(pyth_pro_feeds(arg0), arg1)
        } else if (arg2 == 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::stork_source()) {
            0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::has_asset<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::stork_feed::StorkFeedInfo>(stork_feed_registry(arg0), arg1)
        } else {
            assert!(arg2 == 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::admin_ref_source(), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::unknown_source());
            0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::has_asset<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::reference::AdminReference>(admin_ref_feed_registry(arg0), arg1)
        };
        assert!(v0, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::source_feed_not_configured());
    }

    public(friend) fun clear_cached_price(arg0: &mut XOracle, arg1: BaseToken, arg2: 0x1::type_name::TypeName) {
        assert!(0x2::table::contains<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>>(&arg0.prices, arg1), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::base_token_not_supported());
        let v0 = 0x2::table::borrow_mut<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>>(&mut arg0.prices, arg1);
        if (0x2::table::contains<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>(v0, arg2)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>(v0, arg2);
        };
    }

    public fun ensure_secondary_checks_passed(arg0: &XOracle, arg1: 0x1::type_name::TypeName) {
        ensure_version_matches(arg0);
        let v0 = feed_checkers_pass(arg0);
        assert!(0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::has_asset<bool>(v0, arg1) && *0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::borrow<bool>(v0, arg1), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::feed_checks_not_passed());
        let v1 = 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::base_token_id(0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::borrow<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::AssetConfig>(asset_registry(arg0), arg1));
        let v2 = &v1;
        let v3 = 0;
        if (v2 == &v3) {
        } else {
            let v4 = 1;
            assert!(v2 == &v4, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::unknown_oracle_base_token());
            let v5 = 0x1::type_name::with_defining_ids<0x2::sui::SUI>();
            assert!(0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::has_asset<bool>(v0, v5) && *0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::borrow<bool>(v0, v5), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::feed_checks_not_passed());
        };
    }

    public(friend) fun ensure_version_matches(arg0: &XOracle) {
        assert!(arg0.version == 2, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::version_not_match());
    }

    public(friend) fun feed_checkers_pass(arg0: &XOracle) : &0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<bool> {
        let v0 = FeedCheckersPassKey{dummy_field: false};
        0x2::dynamic_field::borrow<FeedCheckersPassKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<bool>>(&arg0.id, v0)
    }

    public(friend) fun get_usd_price(arg0: &XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed {
        let v0 = 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::base_token_id(0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::borrow<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::AssetConfig>(asset_registry(arg0), arg1));
        let v1 = &v0;
        let v2 = 0;
        let v3 = if (v1 == &v2) {
            *load_price(arg0, usd(), arg1)
        } else {
            let v4 = 1;
            assert!(v1 == &v4, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::unknown_oracle_base_token());
            let v5 = 0x1::type_name::with_defining_ids<0x2::sui::SUI>();
            let v6 = price_delay_tolerance_ms(arg0, v5);
            let v7 = load_price(arg0, usd(), v5);
            let v8 = 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::spot(v7);
            0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::ensure_timestamp_not_stale(v8, v6, arg2);
            let v9 = 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::ema(v7);
            0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::ensure_timestamp_not_stale(v9, v6, arg2);
            let v10 = load_price(arg0, sui(), arg1);
            0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::new(0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::multiply(0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::spot(v10), v8), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::multiply(0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::ema(v10), v9))
        };
        let v11 = v3;
        let v12 = price_delay_tolerance_ms(arg0, arg1);
        0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::ensure_timestamp_not_stale(0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::ema(&v11), v12, arg2);
        0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::ensure_timestamp_not_stale(0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::spot(&v11), v12, arg2);
        v11
    }

    fun init(arg0: X_ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<X_ORACLE>(arg0, arg1);
        let v0 = new(arg1);
        0x2::transfer::share_object<XOracle>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init_v1_registries(arg0: &mut XOracle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PythProFeedKey{dummy_field: false};
        0x2::dynamic_field::add<PythProFeedKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::pyth_adaptor::PythProFeedInfo>>(&mut arg0.id, v0, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::new_registry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::pyth_adaptor::PythProFeedInfo>(arg1));
        let v1 = StorkFeedRegistryKey{dummy_field: false};
        0x2::dynamic_field::add<StorkFeedRegistryKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::stork_feed::StorkFeedInfo>>(&mut arg0.id, v1, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::new_registry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::stork_feed::StorkFeedInfo>(arg1));
        let v2 = AssetRegistryKey{dummy_field: false};
        0x2::dynamic_field::add<AssetRegistryKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::AssetConfig>>(&mut arg0.id, v2, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::new_registry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset::AssetConfig>(arg1));
        let v3 = AdminRefRegistryKey{dummy_field: false};
        0x2::dynamic_field::add<AdminRefRegistryKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::reference::AdminReference>>(&mut arg0.id, v3, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::new_registry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::reference::AdminReference>(arg1));
        let v4 = FeedCheckersPassKey{dummy_field: false};
        0x2::dynamic_field::add<FeedCheckersPassKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<bool>>(&mut arg0.id, v4, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::new_registry<bool>(arg1));
        let v5 = PricesDelayToleranceMsKey{dummy_field: false};
        0x2::dynamic_field::add<PricesDelayToleranceMsKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<u64>>(&mut arg0.id, v5, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::new_registry<u64>(arg1));
        0x2::table::add<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>>(&mut arg0.prices, sui(), 0x2::table::new<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>(arg1));
    }

    fun load_price(arg0: &XOracle, arg1: BaseToken, arg2: 0x1::type_name::TypeName) : &0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed {
        let v0 = 0x2::table::borrow<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>>(&arg0.prices, arg1);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>(v0, arg2), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::oracle_price_not_found_error());
        0x2::table::borrow<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>(v0, arg2)
    }

    public(friend) fun migrate(arg0: &mut XOracle, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.version < 2, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::version_not_match());
        arg0.version = 2;
        if (2 == 1) {
            init_v1_registries(arg0, arg1);
        };
        2
    }

    public fun price(arg0: &XOracle, arg1: 0x1::type_name::TypeName, arg2: BaseToken) : &0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed {
        abort 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::deprecated()
    }

    public(friend) fun price_delay_tolerance_ms(arg0: &XOracle, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = prices_delay_tolerance_ms(arg0);
        if (0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::has_asset<u64>(v0, arg1)) {
            *0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::borrow<u64>(v0, arg1)
        } else {
            arg0.price_delay_tolerance_ms
        }
    }

    public(friend) fun prices_delay_tolerance_ms(arg0: &XOracle) : &0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<u64> {
        let v0 = PricesDelayToleranceMsKey{dummy_field: false};
        0x2::dynamic_field::borrow<PricesDelayToleranceMsKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<u64>>(&arg0.id, v0)
    }

    public(friend) fun prices_delay_tolerance_ms_mut(arg0: &mut XOracle) : &mut 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<u64> {
        let v0 = PricesDelayToleranceMsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PricesDelayToleranceMsKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<u64>>(&mut arg0.id, v0)
    }

    public(friend) fun pyth_pro_feeds(arg0: &XOracle) : &0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::pyth_adaptor::PythProFeedInfo> {
        let v0 = PythProFeedKey{dummy_field: false};
        0x2::dynamic_field::borrow<PythProFeedKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::pyth_adaptor::PythProFeedInfo>>(&arg0.id, v0)
    }

    public(friend) fun pyth_pro_feeds_mut(arg0: &mut XOracle) : &mut 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::pyth_adaptor::PythProFeedInfo> {
        let v0 = PythProFeedKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PythProFeedKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::pyth_adaptor::PythProFeedInfo>>(&mut arg0.id, v0)
    }

    public(friend) fun stork_feed_registry(arg0: &XOracle) : &0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::stork_feed::StorkFeedInfo> {
        let v0 = StorkFeedRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow<StorkFeedRegistryKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::stork_feed::StorkFeedInfo>>(&arg0.id, v0)
    }

    public(friend) fun stork_feed_registry_mut(arg0: &mut XOracle) : &mut 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::stork_feed::StorkFeedInfo> {
        let v0 = StorkFeedRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<StorkFeedRegistryKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::stork_feed::StorkFeedInfo>>(&mut arg0.id, v0)
    }

    public(friend) fun update_feed_check_passed(arg0: &mut XOracle, arg1: 0x1::type_name::TypeName, arg2: bool) {
        let v0 = FeedCheckersPassKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<FeedCheckersPassKey, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::XOracleAssetRegistry<bool>>(&mut arg0.id, v0);
        if (0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::has_asset<bool>(v1, arg1)) {
            *0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::borrow_mut<bool>(v1, arg1) = arg2;
        } else {
            0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry::set<bool>(v1, arg1, arg2);
        };
    }

    public(friend) fun update_price_delay_tolerance_ms(arg0: &mut XOracle, arg1: u64) {
        assert!(arg1 <= 1800000, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::invalid_delay_tolerance());
        arg0.price_delay_tolerance_ms = arg1;
    }

    public(friend) fun update_price_feed(arg0: &mut XOracle, arg1: BaseToken, arg2: 0x1::type_name::TypeName, arg3: 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeedComponent, arg4: 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeedComponent) {
        let v0 = 0x2::table::borrow_mut<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>>(&mut arg0.prices, arg1);
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>(v0, arg2)) {
            0x2::table::add<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>(v0, arg2, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::new(arg3, arg4));
        } else {
            0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::set(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeed>(v0, arg2), arg3, arg4);
        };
    }

    public fun usd() : BaseToken {
        BaseToken{id: 0}
    }

    // decompiled from Move bytecode v7
}

