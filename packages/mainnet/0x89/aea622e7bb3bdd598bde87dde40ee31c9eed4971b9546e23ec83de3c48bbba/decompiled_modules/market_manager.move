module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager {
    struct MarketKey has copy, drop, store {
        propbook_underlying_id: u32,
        expiry: u64,
    }

    struct MarketManager has store {
        underlying_configs: 0x2::table::Table<u32, UnderlyingMarketConfig>,
        market_ids: 0x2::table::Table<MarketKey, 0x2::object::ID>,
    }

    struct CadenceConfig has copy, drop, store {
        tick_size: u64,
        admission_tick_size: u64,
        max_expiry_allocation: u64,
        initial_expiry_cash: u64,
        window_size: u64,
    }

    struct DeployableMarket has copy, drop {
        expiry: u64,
        cadence: CadenceConfig,
    }

    struct UnderlyingMarketConfig has copy, drop, store {
        cadences: vector<CadenceConfig>,
        last_deployed_expiries: vector<u64>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : MarketManager {
        MarketManager{
            underlying_configs : 0x2::table::new<u32, UnderlyingMarketConfig>(arg0),
            market_ids         : 0x2::table::new<MarketKey, 0x2::object::ID>(arg0),
        }
    }

    public(friend) fun admission_tick_size(arg0: &DeployableMarket) : u64 {
        arg0.cadence.admission_tick_size
    }

    fun assert_cadence_config(arg0: &CadenceConfig) {
        let CadenceConfig {
            tick_size             : v0,
            admission_tick_size   : v1,
            max_expiry_allocation : v2,
            initial_expiry_cash   : v3,
            window_size           : v4,
        } = *arg0;
        let v5 = if (v0 == 0) {
            if (v1 == 0) {
                if (v2 == 0) {
                    if (v3 == 0) {
                        v4 == 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v5) {
            return
        };
        let v6 = if (v0 > 0) {
            if (v1 > 0) {
                if (v2 > 0) {
                    if (v3 > 0) {
                        v4 > 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 7);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_market_tick_size_bounds(v0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_market_tick_size_bounds(v1);
        assert!(v1 >= v0, 7);
        assert!(v1 % v0 == 0, 7);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_cadence_window_size(v4);
        assert!(v3 >= 1000000000, 7);
        assert!(v3 <= v2, 7);
    }

    public fun cadence_admission_tick_size(arg0: &CadenceConfig) : u64 {
        arg0.admission_tick_size
    }

    public(friend) fun cadence_config(arg0: &MarketManager, arg1: u32, arg2: u8) : CadenceConfig {
        *0x1::vector::borrow<CadenceConfig>(&underlying_config(arg0, arg1).cadences, cadence_index(arg2))
    }

    public(friend) fun cadence_configs(arg0: &MarketManager, arg1: u32) : vector<CadenceConfig> {
        underlying_config(arg0, arg1).cadences
    }

    public fun cadence_enabled(arg0: &CadenceConfig) : bool {
        arg0.window_size > 0
    }

    fun cadence_index(arg0: u8) : u64 {
        assert!(arg0 <= 5, 4);
        (arg0 as u64)
    }

    public fun cadence_initial_expiry_cash(arg0: &CadenceConfig) : u64 {
        arg0.initial_expiry_cash
    }

    public fun cadence_max_expiry_allocation(arg0: &CadenceConfig) : u64 {
        arg0.max_expiry_allocation
    }

    public(friend) fun cadence_period_ms(arg0: u8) : u64 {
        if (arg0 == 0) {
            60000
        } else if (arg0 == 1) {
            300000
        } else if (arg0 == 2) {
            3600000
        } else if (arg0 == 3) {
            86400000
        } else if (arg0 == 4) {
            604800000
        } else {
            assert!(arg0 == 5, 4);
            2592000000
        }
    }

    public fun cadence_tick_size(arg0: &CadenceConfig) : u64 {
        arg0.tick_size
    }

    public fun cadence_window_size(arg0: &CadenceConfig) : u64 {
        arg0.window_size
    }

    fun disabled_cadence() : CadenceConfig {
        CadenceConfig{
            tick_size             : 0,
            admission_tick_size   : 0,
            max_expiry_allocation : 0,
            initial_expiry_cash   : 0,
            window_size           : 0,
        }
    }

    fun disabled_cadences() : vector<CadenceConfig> {
        let v0 = 0x1::vector::empty<CadenceConfig>();
        let v1 = &mut v0;
        0x1::vector::push_back<CadenceConfig>(v1, disabled_cadence());
        0x1::vector::push_back<CadenceConfig>(v1, disabled_cadence());
        0x1::vector::push_back<CadenceConfig>(v1, disabled_cadence());
        0x1::vector::push_back<CadenceConfig>(v1, disabled_cadence());
        0x1::vector::push_back<CadenceConfig>(v1, disabled_cadence());
        0x1::vector::push_back<CadenceConfig>(v1, disabled_cadence());
        v0
    }

    public(friend) fun expiry(arg0: &DeployableMarket) : u64 {
        arg0.expiry
    }

    public(friend) fun expiry_market_id(arg0: &MarketManager, arg1: u32, arg2: u64) : 0x1::option::Option<0x2::object::ID> {
        let v0 = MarketKey{
            propbook_underlying_id : arg1,
            expiry                 : arg2,
        };
        if (0x2::table::contains<MarketKey, 0x2::object::ID>(&arg0.market_ids, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<MarketKey, 0x2::object::ID>(&arg0.market_ids, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun has_higher_rank_overlap(arg0: &UnderlyingMarketConfig, arg1: u8, arg2: u64) : bool {
        let v0 = arg1 + 1;
        while ((v0 as u64) < 0x1::vector::length<CadenceConfig>(&arg0.cadences)) {
            if (0x1::vector::borrow<CadenceConfig>(&arg0.cadences, cadence_index(v0)).window_size > 0 && arg2 % cadence_period_ms(v0) == 0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun initial_expiry_cash(arg0: &DeployableMarket) : u64 {
        arg0.cadence.initial_expiry_cash
    }

    public(friend) fun max_expiry_allocation(arg0: &DeployableMarket) : u64 {
        arg0.cadence.max_expiry_allocation
    }

    public(friend) fun next_deployable_market(arg0: &MarketManager, arg1: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg2: u32, arg3: u8, arg4: &0x2::clock::Clock) : DeployableMarket {
        let v0 = cadence_index(arg3);
        let v1 = underlying_config(arg0, arg2);
        let v2 = 0x1::vector::borrow<CadenceConfig>(&v1.cadences, v0);
        assert!(v2.window_size > 0, 2);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = cadence_period_ms(arg3);
        let v5 = 0x1::u64::max(*0x1::vector::borrow<u64>(&v1.last_deployed_expiries, v0) + v4, (v3 / v4 + 1) * v4);
        while (v5 <= v3 + v2.window_size * v4) {
            let v6 = MarketKey{
                propbook_underlying_id : arg2,
                expiry                 : v5,
            };
            if (has_higher_rank_overlap(v1, arg3, v5) || 0x2::table::contains<MarketKey, 0x2::object::ID>(&arg0.market_ids, v6)) {
                v5 = v5 + v4;
                continue
            };
            let v7 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::propbook_pyth_id_for_underlying(arg1, arg2);
            assert!(0x1::option::is_some<0x2::object::ID>(&v7), 8);
            let v8 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::propbook_block_scholes_store_pair_for_underlying(arg1, arg2);
            assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::BlockScholesStorePair>(&v8), 9);
            return DeployableMarket{
                expiry  : v5,
                cadence : *v2,
            }
        };
        abort 5
    }

    public(friend) fun record_expiry_creation(arg0: &mut MarketManager, arg1: u32, arg2: u8, arg3: u64, arg4: 0x2::object::ID) {
        let v0 = cadence_index(arg2);
        assert!(arg3 % cadence_period_ms(arg2) == 0, 6);
        assert!(arg3 > *0x1::vector::borrow<u64>(&underlying_config(arg0, arg1).last_deployed_expiries, v0), 6);
        let v1 = MarketKey{
            propbook_underlying_id : arg1,
            expiry                 : arg3,
        };
        assert!(!0x2::table::contains<MarketKey, 0x2::object::ID>(&arg0.market_ids, v1), 3);
        0x2::table::add<MarketKey, 0x2::object::ID>(&mut arg0.market_ids, v1, arg4);
        *0x1::vector::borrow_mut<u64>(&mut underlying_config_mut(arg0, arg1).last_deployed_expiries, v0) = arg3;
    }

    public(friend) fun register_underlying(arg0: &mut MarketManager, arg1: u32) {
        assert!(!0x2::table::contains<u32, UnderlyingMarketConfig>(&arg0.underlying_configs, arg1), 1);
        let v0 = UnderlyingMarketConfig{
            cadences               : disabled_cadences(),
            last_deployed_expiries : vector[0, 0, 0, 0, 0, 0],
        };
        0x2::table::add<u32, UnderlyingMarketConfig>(&mut arg0.underlying_configs, arg1, v0);
    }

    public(friend) fun set_template_cadence_config(arg0: &mut MarketManager, arg1: u32, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = CadenceConfig{
            tick_size             : arg3,
            admission_tick_size   : arg4,
            max_expiry_allocation : arg5,
            initial_expiry_cash   : arg6,
            window_size           : arg7,
        };
        assert_cadence_config(&v0);
        *0x1::vector::borrow_mut<CadenceConfig>(&mut underlying_config_mut(arg0, arg1).cadences, cadence_index(arg2)) = v0;
    }

    public(friend) fun tick_size(arg0: &DeployableMarket) : u64 {
        arg0.cadence.tick_size
    }

    fun underlying_config(arg0: &MarketManager, arg1: u32) : &UnderlyingMarketConfig {
        assert!(0x2::table::contains<u32, UnderlyingMarketConfig>(&arg0.underlying_configs, arg1), 0);
        0x2::table::borrow<u32, UnderlyingMarketConfig>(&arg0.underlying_configs, arg1)
    }

    fun underlying_config_mut(arg0: &mut MarketManager, arg1: u32) : &mut UnderlyingMarketConfig {
        assert!(0x2::table::contains<u32, UnderlyingMarketConfig>(&arg0.underlying_configs, arg1), 0);
        0x2::table::borrow_mut<u32, UnderlyingMarketConfig>(&mut arg0.underlying_configs, arg1)
    }

    // decompiled from Move bytecode v7
}

