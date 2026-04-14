module 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracles {
    struct OracleRegistry has store, key {
        id: 0x2::object::UID,
        config: OracleRegistryConfig,
        price_identifiers: vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>,
        lazer_feed_ids: vector<u32>,
    }

    struct NewRegistryEvent has copy, drop, store {
        registry_id: 0x2::object::ID,
        pyth_max_staleness_threshold_s: u64,
        pyth_max_confidence_interval_pct: u64,
    }

    struct OracleRegistryConfig has store {
        pyth_max_staleness_threshold_s: u64,
        pyth_max_confidence_interval_pct: u64,
    }

    struct OraclePriceUpdate has drop {
        oracle_registry_id: 0x2::object::ID,
        oracle_index: u64,
        price: 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracle_decimal::OracleDecimal,
        ema_price: 0x1::option::Option<0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracle_decimal::OracleDecimal>,
        confidence: u64,
        price_magnitude: u64,
    }

    public fun new(arg0: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg1: OracleRegistryConfig, arg2: &mut 0x2::tx_context::TxContext) : OracleRegistry {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg0);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_oracle_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = OracleRegistry{
            id                : 0x2::object::new(arg2),
            config            : arg1,
            price_identifiers : 0x1::vector::empty<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(),
            lazer_feed_ids    : vector[],
        };
        let v1 = NewRegistryEvent{
            registry_id                      : 0x2::object::id<OracleRegistry>(&v0),
            pyth_max_staleness_threshold_s   : v0.config.pyth_max_staleness_threshold_s,
            pyth_max_confidence_interval_pct : v0.config.pyth_max_confidence_interval_pct,
        };
        0x2::event::emit<NewRegistryEvent>(v1);
        v0
    }

    public fun add_lazer_feed_id(arg0: &mut OracleRegistry, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg3));
        0x1::vector::push_back<u32>(&mut arg0.lazer_feed_ids, arg2);
    }

    public fun add_pyth_identifier(arg0: &mut OracleRegistry, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        0x1::vector::push_back<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut arg0.price_identifiers, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0));
    }

    public fun confidence(arg0: &OraclePriceUpdate) : u64 {
        arg0.confidence
    }

    public fun ema_price(arg0: &OraclePriceUpdate) : 0x1::option::Option<0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracle_decimal::OracleDecimal> {
        arg0.ema_price
    }

    public fun get_lazer_price(arg0: &OracleRegistry, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : OraclePriceUpdate {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        let (v0, v1, v2, v3) = 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::pyth_lazer::get_prices(arg2, arg4, *0x1::vector::borrow<u32>(&arg0.lazer_feed_ids, arg3), arg0.config.pyth_max_staleness_threshold_s, arg0.config.pyth_max_confidence_interval_pct, arg5);
        OraclePriceUpdate{
            oracle_registry_id : 0x2::object::id<OracleRegistry>(arg0),
            oracle_index       : arg3,
            price              : v0,
            ema_price          : v1,
            confidence         : v2,
            price_magnitude    : v3,
        }
    }

    public fun get_pyth_price(arg0: &OracleRegistry, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: &0x2::clock::Clock) : OraclePriceUpdate {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        let (v0, v1, v2, v3) = 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::pyth::get_prices(arg2, arg4, arg0.config.pyth_max_staleness_threshold_s, arg0.config.pyth_max_confidence_interval_pct, *0x1::vector::borrow<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&arg0.price_identifiers, arg3));
        OraclePriceUpdate{
            oracle_registry_id : 0x2::object::id<OracleRegistry>(arg0),
            oracle_index       : arg3,
            price              : v0,
            ema_price          : 0x1::option::some<0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracle_decimal::OracleDecimal>(v1),
            confidence         : v2,
            price_magnitude    : v3,
        }
    }

    public fun new_and_transfer(arg0: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg1: OracleRegistryConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<OracleRegistry>(new(arg0, arg1, arg2));
    }

    public fun new_oracle_registry_config(arg0: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : OracleRegistryConfig {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg0);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_oracle_manager_role(arg0, 0x2::tx_context::sender(arg3));
        OracleRegistryConfig{
            pyth_max_staleness_threshold_s   : arg1,
            pyth_max_confidence_interval_pct : arg2,
        }
    }

    public fun oracle_index(arg0: &OraclePriceUpdate) : u64 {
        arg0.oracle_index
    }

    public fun oracle_registry_id(arg0: &OraclePriceUpdate) : 0x2::object::ID {
        arg0.oracle_registry_id
    }

    public fun price(arg0: &OraclePriceUpdate) : 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracle_decimal::OracleDecimal {
        arg0.price
    }

    public fun price_magnitude(arg0: &OraclePriceUpdate) : u64 {
        arg0.price_magnitude
    }

    public fun set_lazer_feed_id(arg0: &mut OracleRegistry, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: u64, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg4));
        *0x1::vector::borrow_mut<u32>(&mut arg0.lazer_feed_ids, arg2) = arg3;
    }

    public fun set_pyth_identifier(arg0: &mut OracleRegistry, arg1: &0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::GlobalConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_package_version(arg1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::global_config::check_oracle_manager_role(arg1, 0x2::tx_context::sender(arg4));
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        *0x1::vector::borrow_mut<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut arg0.price_identifiers, arg3) = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
    }

    // decompiled from Move bytecode v6
}

