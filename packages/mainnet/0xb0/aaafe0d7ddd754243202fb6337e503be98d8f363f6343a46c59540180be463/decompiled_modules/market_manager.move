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

    public(friend) fun add_period(arg0: &mut vector<u64>, arg1: u64) : u8 {
        let v0 = if (arg1 > 0) {
            if (arg1 % 60000 == 0) {
                arg1 <= 31536000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        assert!(!0x1::vector::contains<u64>(arg0, &arg1), 12);
        assert!(0x1::vector::length<u64>(arg0) < 16, 10);
        0x1::vector::push_back<u64>(arg0, arg1);
        ((0x1::vector::length<u64>(arg0) - 1) as u8)
    }

    public(friend) fun admission_tick_size(arg0: &DeployableMarket) : u64 {
        arg0.cadence.admission_tick_size
    }

    public(friend) fun base_per() : vector<u64> {
        vector[60000, 300000, 3600000, 86400000, 604800000, 2592000000]
    }

    fun cad_at(arg0: &UnderlyingMarketConfig, arg1: u64) : CadenceConfig {
        if (arg1 < 0x1::vector::length<CadenceConfig>(&arg0.cadences)) {
            *0x1::vector::borrow<CadenceConfig>(&arg0.cadences, arg1)
        } else {
            cad_disabled()
        }
    }

    fun cad_disabled() : CadenceConfig {
        CadenceConfig{
            tick_size             : 0,
            admission_tick_size   : 0,
            max_expiry_allocation : 0,
            initial_expiry_cash   : 0,
            window_size           : 0,
        }
    }

    fun cad_index(arg0: &vector<u64>, arg1: u8) : u64 {
        assert!((arg1 as u64) < 0x1::vector::length<u64>(arg0), 4);
        (arg1 as u64)
    }

    public(friend) fun cad_period(arg0: &vector<u64>, arg1: u8) : u64 {
        *0x1::vector::borrow<u64>(arg0, cad_index(arg0, arg1))
    }

    public fun cadence_admission_tick_size(arg0: &CadenceConfig) : u64 {
        arg0.admission_tick_size
    }

    public(friend) fun cadence_config(arg0: &MarketManager, arg1: &vector<u64>, arg2: u32, arg3: u8) : CadenceConfig {
        cad_at(und_config(arg0, arg2), cad_index(arg1, arg3))
    }

    public(friend) fun cadence_configs(arg0: &MarketManager, arg1: &vector<u64>, arg2: u32) : vector<CadenceConfig> {
        let v0 = und_config(arg0, arg2);
        let v1 = 0x1::vector::empty<CadenceConfig>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg1)) {
            0x1::vector::push_back<CadenceConfig>(&mut v1, cad_at(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun cadence_enabled(arg0: &CadenceConfig) : bool {
        arg0.window_size > 0
    }

    public fun cadence_initial_expiry_cash(arg0: &CadenceConfig) : u64 {
        arg0.initial_expiry_cash
    }

    public fun cadence_max_expiry_allocation(arg0: &CadenceConfig) : u64 {
        arg0.max_expiry_allocation
    }

    public fun cadence_tick_size(arg0: &CadenceConfig) : u64 {
        arg0.tick_size
    }

    public fun cadence_window_size(arg0: &CadenceConfig) : u64 {
        arg0.window_size
    }

    fun chk_cadence(arg0: &CadenceConfig) {
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
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_ticks(v0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_ticks(v1);
        assert!(v1 >= v0, 7);
        assert!(v1 % v0 == 0, 7);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_cad(v4);
        assert!(v3 <= v2, 7);
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

    public(friend) fun init_cash(arg0: &DeployableMarket) : u64 {
        arg0.cadence.initial_expiry_cash
    }

    fun mark_at(arg0: &UnderlyingMarketConfig, arg1: u64) : u64 {
        if (arg1 < 0x1::vector::length<u64>(&arg0.last_deployed_expiries)) {
            *0x1::vector::borrow<u64>(&arg0.last_deployed_expiries, arg1)
        } else {
            0
        }
    }

    public(friend) fun max_alloc(arg0: &DeployableMarket) : u64 {
        arg0.cadence.max_expiry_allocation
    }

    public(friend) fun next_deploy(arg0: &MarketManager, arg1: &vector<u64>, arg2: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg3: u32, arg4: u8, arg5: &0x2::clock::Clock) : DeployableMarket {
        let v0 = cad_index(arg1, arg4);
        let v1 = und_config(arg0, arg3);
        let v2 = cad_at(v1, v0);
        assert!(v2.window_size > 0, 2);
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = *0x1::vector::borrow<u64>(arg1, v0);
        let v5 = 0x1::u64::max(mark_at(v1, v0) + v4, (v3 / v4 + 1) * v4);
        while (v5 <= v3 + v2.window_size * v4) {
            let v6 = MarketKey{
                propbook_underlying_id : arg3,
                expiry                 : v5,
            };
            if (rank_overlap(v1, arg1, v4, v5) || 0x2::table::contains<MarketKey, 0x2::object::ID>(&arg0.market_ids, v6)) {
                v5 = v5 + v4;
                continue
            };
            let v7 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::propbook_pyth_id_for_underlying(arg2, arg3);
            assert!(0x1::option::is_some<0x2::object::ID>(&v7), 8);
            let v8 = 0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::propbook_block_scholes_store_pair_for_underlying(arg2, arg3);
            assert!(0x1::option::is_some<0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::BlockScholesStorePair>(&v8), 9);
            return DeployableMarket{
                expiry  : v5,
                cadence : v2,
            }
        };
        abort 5
    }

    public(friend) fun note_expiry(arg0: &mut MarketManager, arg1: &vector<u64>, arg2: u32, arg3: u8, arg4: u64, arg5: 0x2::object::ID) {
        let v0 = cad_index(arg1, arg3);
        assert!(arg4 % *0x1::vector::borrow<u64>(arg1, v0) == 0, 6);
        assert!(arg4 > mark_at(und_config(arg0, arg2), v0), 6);
        let v1 = MarketKey{
            propbook_underlying_id : arg2,
            expiry                 : arg4,
        };
        assert!(!0x2::table::contains<MarketKey, 0x2::object::ID>(&arg0.market_ids, v1), 3);
        0x2::table::add<MarketKey, 0x2::object::ID>(&mut arg0.market_ids, v1, arg5);
        let v2 = und_cfg_mut(arg0, arg2);
        pad_rows(v2, v0 + 1);
        *0x1::vector::borrow_mut<u64>(&mut v2.last_deployed_expiries, v0) = arg4;
    }

    fun pad_rows(arg0: &mut UnderlyingMarketConfig, arg1: u64) {
        while (0x1::vector::length<CadenceConfig>(&arg0.cadences) < arg1) {
            0x1::vector::push_back<CadenceConfig>(&mut arg0.cadences, cad_disabled());
        };
        while (0x1::vector::length<u64>(&arg0.last_deployed_expiries) < arg1) {
            0x1::vector::push_back<u64>(&mut arg0.last_deployed_expiries, 0);
        };
    }

    fun rank_overlap(arg0: &UnderlyingMarketConfig, arg1: &vector<u64>, arg2: u64, arg3: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CadenceConfig>(&arg0.cadences)) {
            let v1 = *0x1::vector::borrow<u64>(arg1, v0);
            let v2 = if (v1 > arg2) {
                if (0x1::vector::borrow<CadenceConfig>(&arg0.cadences, v0).window_size > 0) {
                    arg3 % v1 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun register_underlying(arg0: &mut MarketManager, arg1: u32) {
        assert!(!0x2::table::contains<u32, UnderlyingMarketConfig>(&arg0.underlying_configs, arg1), 1);
        let v0 = 0x1::vector::empty<CadenceConfig>();
        let v1 = base_per();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            0x1::vector::push_back<CadenceConfig>(&mut v0, cad_disabled());
            v2 = v2 + 1;
        };
        let v3 = vector[];
        let v4 = base_per();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v4)) {
            0x1::vector::push_back<u64>(&mut v3, 0);
            v5 = v5 + 1;
        };
        let v6 = UnderlyingMarketConfig{
            cadences               : v0,
            last_deployed_expiries : v3,
        };
        0x2::table::add<u32, UnderlyingMarketConfig>(&mut arg0.underlying_configs, arg1, v6);
    }

    public(friend) fun set_template_cadence_config(arg0: &mut MarketManager, arg1: &vector<u64>, arg2: u32, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = CadenceConfig{
            tick_size             : arg4,
            admission_tick_size   : arg5,
            max_expiry_allocation : arg6,
            initial_expiry_cash   : arg7,
            window_size           : arg8,
        };
        chk_cadence(&v0);
        let v1 = cad_index(arg1, arg3);
        let v2 = und_cfg_mut(arg0, arg2);
        let v3 = win_sum(v2);
        pad_rows(v2, v1 + 1);
        *0x1::vector::borrow_mut<CadenceConfig>(&mut v2.cadences, v1) = v0;
        assert!(win_sum_ok(v3, win_sum(v2)), 13);
    }

    public(friend) fun tick_size(arg0: &DeployableMarket) : u64 {
        arg0.cadence.tick_size
    }

    fun und_cfg_mut(arg0: &mut MarketManager, arg1: u32) : &mut UnderlyingMarketConfig {
        assert!(0x2::table::contains<u32, UnderlyingMarketConfig>(&arg0.underlying_configs, arg1), 0);
        0x2::table::borrow_mut<u32, UnderlyingMarketConfig>(&mut arg0.underlying_configs, arg1)
    }

    fun und_config(arg0: &MarketManager, arg1: u32) : &UnderlyingMarketConfig {
        assert!(0x2::table::contains<u32, UnderlyingMarketConfig>(&arg0.underlying_configs, arg1), 0);
        0x2::table::borrow<u32, UnderlyingMarketConfig>(&arg0.underlying_configs, arg1)
    }

    fun win_sum(arg0: &UnderlyingMarketConfig) : u64 {
        let v0 = 0;
        let v1 = &arg0.cadences;
        let v2 = 0;
        while (v2 < 0x1::vector::length<CadenceConfig>(v1)) {
            v0 = v0 + 0x1::vector::borrow<CadenceConfig>(v1, v2).window_size;
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun win_sum_ok(arg0: u64, arg1: u64) : bool {
        arg1 <= 24 || arg1 <= arg0
    }

    // decompiled from Move bytecode v7
}

