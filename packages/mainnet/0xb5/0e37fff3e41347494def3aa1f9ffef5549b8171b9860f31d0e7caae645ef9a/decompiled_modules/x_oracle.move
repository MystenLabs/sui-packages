module 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle {
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
        prices: 0x2::table::Table<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed>>,
        version: u64,
    }

    struct PythPriceFeedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StorkFeedRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RWARegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PricesDelayToleranceMsKey has copy, drop, store {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : XOracle {
        let v0 = XOracle{
            id                       : 0x2::object::new(arg0),
            price_delay_tolerance_ms : 5000,
            prices                   : 0x2::table::new<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed>>(arg0),
            version                  : 1,
        };
        0x2::table::add<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed>>(&mut v0.prices, usd(), 0x2::table::new<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed>(arg0));
        let v1 = PythPriceFeedKey{dummy_field: false};
        0x2::dynamic_field::add<PythPriceFeedKey, 0x2::table::Table<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::pyth_adaptor::PythFeedData>>(&mut v0.id, v1, 0x2::table::new<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::pyth_adaptor::PythFeedData>(arg0));
        v0
    }

    public fun base_token_from_u8(arg0: u8) : BaseToken {
        let v0 = 0;
        assert!(&arg0 == &v0, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::unknown_oracle_base_token());
        usd()
    }

    public(friend) fun ensure_version_matches(arg0: &XOracle) {
        assert!(arg0.version == 1, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::version_not_match());
    }

    fun init(arg0: X_ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<X_ORACLE>(arg0, arg1);
        let v0 = new(arg1);
        0x2::transfer::share_object<XOracle>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init_v1_registries(arg0: &mut XOracle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StorkFeedRegistryKey{dummy_field: false};
        0x2::dynamic_field::add<StorkFeedRegistryKey, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::StorkFeedInfo>>(&mut arg0.id, v0, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::new_registry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::StorkFeedInfo>(arg1));
        let v1 = RWARegistryKey{dummy_field: false};
        0x2::dynamic_field::add<RWARegistryKey, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedAssetConfig>>(&mut arg0.id, v1, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::new_registry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedAssetConfig>(arg1));
        let v2 = 0x2::table::new<BaseToken, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<u64>>(arg1);
        0x2::table::add<BaseToken, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<u64>>(&mut v2, usd(), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::new_registry<u64>(arg1));
        let v3 = PricesDelayToleranceMsKey{dummy_field: false};
        0x2::dynamic_field::add<PricesDelayToleranceMsKey, 0x2::table::Table<BaseToken, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<u64>>>(&mut arg0.id, v3, v2);
    }

    fun load_price(arg0: &XOracle, arg1: BaseToken, arg2: 0x1::type_name::TypeName) : &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed {
        let v0 = 0x2::table::borrow<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed>>(&arg0.prices, arg1);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed>(v0, arg2), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::oracle_price_not_found_error());
        0x2::table::borrow<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed>(v0, arg2)
    }

    public(friend) fun migrate(arg0: &mut XOracle, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.version < 1, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::version_not_match());
        arg0.version = 1;
        if (1 == 1) {
            init_v1_registries(arg0, arg1);
        };
        1
    }

    public fun price(arg0: &XOracle, arg1: 0x1::type_name::TypeName, arg2: BaseToken) : &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed {
        let BaseToken { id: v0 } = arg2;
        let v1 = 0;
        assert!(&v0 == &v1, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::unknown_oracle_base_token());
        load_price(arg0, usd(), arg1)
    }

    public(friend) fun price_delay_tolerance_ms(arg0: &XOracle, arg1: BaseToken, arg2: 0x1::type_name::TypeName) : u64 {
        let v0 = 0x2::table::borrow<BaseToken, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<u64>>(prices_delay_tolerance_ms(arg0), arg1);
        if (0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::has_asset<u64>(v0, arg2)) {
            *0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::borrow<u64>(v0, arg2)
        } else {
            arg0.price_delay_tolerance_ms
        }
    }

    public(friend) fun prices_delay_tolerance_ms(arg0: &XOracle) : &0x2::table::Table<BaseToken, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<u64>> {
        let v0 = PricesDelayToleranceMsKey{dummy_field: false};
        0x2::dynamic_field::borrow<PricesDelayToleranceMsKey, 0x2::table::Table<BaseToken, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<u64>>>(&arg0.id, v0)
    }

    public(friend) fun prices_delay_tolerance_ms_mut(arg0: &mut XOracle) : &mut 0x2::table::Table<BaseToken, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<u64>> {
        let v0 = PricesDelayToleranceMsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PricesDelayToleranceMsKey, 0x2::table::Table<BaseToken, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<u64>>>(&mut arg0.id, v0)
    }

    public(friend) fun pyth_price_feeds(arg0: &XOracle) : &0x2::table::Table<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::pyth_adaptor::PythFeedData> {
        let v0 = PythPriceFeedKey{dummy_field: false};
        0x2::dynamic_field::borrow<PythPriceFeedKey, 0x2::table::Table<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::pyth_adaptor::PythFeedData>>(&arg0.id, v0)
    }

    public(friend) fun pyth_price_feeds_mut(arg0: &mut XOracle) : &mut 0x2::table::Table<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::pyth_adaptor::PythFeedData> {
        let v0 = PythPriceFeedKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PythPriceFeedKey, 0x2::table::Table<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::pyth_adaptor::PythFeedData>>(&mut arg0.id, v0)
    }

    public(friend) fun refresh_usd_price<T0>(arg0: &mut XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::pyth_adaptor::PythFeedData>(pyth_price_feeds(arg0), v0);
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::pyth_adaptor::assert_pyth_price_info_object(v1, arg1);
        let (v2, v3) = 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::pyth_adaptor::get_pyth_price(arg1, v1, arg2);
        update_price_feed(arg0, usd(), v0, v3, v2);
    }

    public(friend) fun rwa_registry(arg0: &XOracle) : &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedAssetConfig> {
        let v0 = RWARegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow<RWARegistryKey, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedAssetConfig>>(&arg0.id, v0)
    }

    public(friend) fun rwa_registry_mut(arg0: &mut XOracle) : &mut 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedAssetConfig> {
        let v0 = RWARegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RWARegistryKey, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedAssetConfig>>(&mut arg0.id, v0)
    }

    public(friend) fun stork_feed_registry(arg0: &XOracle) : &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::StorkFeedInfo> {
        let v0 = StorkFeedRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow<StorkFeedRegistryKey, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::StorkFeedInfo>>(&arg0.id, v0)
    }

    public(friend) fun stork_feed_registry_mut(arg0: &mut XOracle) : &mut 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::StorkFeedInfo> {
        let v0 = StorkFeedRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<StorkFeedRegistryKey, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::XOracleAssetRegistry<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::StorkFeedInfo>>(&mut arg0.id, v0)
    }

    public(friend) fun update_price_delay_tolerance_ms(arg0: &mut XOracle, arg1: u64) {
        assert!(arg1 <= 1800000, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::invalid_delay_tolerance());
        arg0.price_delay_tolerance_ms = arg1;
    }

    public(friend) fun update_price_feed(arg0: &mut XOracle, arg1: BaseToken, arg2: 0x1::type_name::TypeName, arg3: 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeedComponent, arg4: 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeedComponent) {
        let v0 = 0x2::table::borrow_mut<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed>>(&mut arg0.prices, arg1);
        if (!0x2::table::contains<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed>(v0, arg2)) {
            0x2::table::add<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed>(v0, arg2, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::new(arg3, arg4));
        } else {
            0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::set(0x2::table::borrow_mut<0x1::type_name::TypeName, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeed>(v0, arg2), arg3, arg4);
        };
    }

    public fun usd() : BaseToken {
        BaseToken{id: 0}
    }

    // decompiled from Move bytecode v7
}

