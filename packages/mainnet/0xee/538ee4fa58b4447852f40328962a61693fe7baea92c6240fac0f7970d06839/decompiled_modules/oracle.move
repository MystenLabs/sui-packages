module 0xee538ee4fa58b4447852f40328962a61693fe7baea92c6240fac0f7970d06839::oracle {
    struct PriceOracle has store, key {
        id: 0x2::object::UID,
        symbol: vector<u8>,
        price: u64,
        confidence: u64,
        timestamp: u64,
        expo: u8,
        ema_price: u64,
        ema_confidence: u64,
        source: vector<u8>,
        is_active: bool,
    }

    struct OracleRegistry has key {
        id: 0x2::object::UID,
        oracles: 0x2::table::Table<vector<u8>, address>,
        aggregation_method: u8,
        admin: address,
        emergency_mode: bool,
        total_updates: u64,
        last_health_check: u64,
    }

    struct PriceUpdate has store, key {
        id: 0x2::object::UID,
        oracle_symbol: vector<u8>,
        old_price: u64,
        new_price: u64,
        confidence: u64,
        timestamp: u64,
        updater: address,
    }

    struct AggregatedPrice has store, key {
        id: 0x2::object::UID,
        symbol: vector<u8>,
        price: u64,
        confidence: u64,
        timestamp: u64,
        source_count: u64,
        twap_1h: u64,
        twap_24h: u64,
        volatility: u64,
    }

    struct PriceUpdated has copy, drop {
        symbol: vector<u8>,
        price: u64,
        confidence: u64,
        timestamp: u64,
        source: vector<u8>,
    }

    struct PriceAggregated has copy, drop {
        symbol: vector<u8>,
        aggregated_price: u64,
        confidence: u64,
        source_count: u64,
        method: u8,
    }

    struct OracleCreated has copy, drop {
        symbol: vector<u8>,
        oracle_address: address,
        source: vector<u8>,
        creator: address,
    }

    struct EmergencyModeActivated has copy, drop {
        reason: vector<u8>,
        timestamp: u64,
        admin: address,
    }

    struct PriceAnomaly has copy, drop {
        symbol: vector<u8>,
        current_price: u64,
        previous_price: u64,
        deviation_percentage: u64,
        timestamp: u64,
    }

    public entry fun activate_emergency_mode(arg0: &mut OracleRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        arg0.emergency_mode = true;
        let v0 = EmergencyModeActivated{
            reason    : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
            admin     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EmergencyModeActivated>(v0);
    }

    fun calculate_average_price(arg0: &vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(arg0, v2);
            v2 = v2 + 1;
        };
        v1 / v0
    }

    fun calculate_median_price(arg0: &vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 == 0) {
            return 0
        };
        if (v0 == 1) {
            return *0x1::vector::borrow<u64>(arg0, 0)
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(arg0, v2);
            v2 = v2 + 1;
        };
        v1 / v0
    }

    fun calculate_price_deviation(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg1 > arg0) {
            arg1 - arg0
        } else {
            arg0 - arg1
        };
        v0 * 10000 / arg0
    }

    fun calculate_price_volatility(arg0: &vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 < 2) {
            return 0
        };
        let v1 = calculate_average_price(arg0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(arg0, v3);
            let v5 = if (v4 > v1) {
                v4 - v1
            } else {
                v1 - v4
            };
            v2 = v2 + v5 * v5;
            v3 = v3 + 1;
        };
        sqrt_u64(v2 / v0)
    }

    public entry fun calculate_twap(arg0: &PriceOracle, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = min_u64((0x2::clock::timestamp_ms(arg2) - arg0.timestamp) * 10000 / arg1 * 60 * 60 * 1000, 10000);
        (arg0.ema_price * v0 + arg0.price * (10000 - v0)) / 10000
    }

    fun calculate_weighted_average_price(arg0: &vector<u64>, arg1: &vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(arg1, v3);
            v1 = v1 + *0x1::vector::borrow<u64>(arg0, v3) * v4;
            v2 = v2 + v4;
            v3 = v3 + 1;
        };
        if (v2 == 0) {
            return 0
        };
        v1 / v2
    }

    public entry fun create_aggregated_price(arg0: &OracleRegistry, arg1: vector<u8>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 > 0, 6);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 3);
        let v1 = if (arg0.aggregation_method == 1) {
            calculate_median_price(&arg2)
        } else if (arg0.aggregation_method == 2) {
            calculate_weighted_average_price(&arg2, &arg3)
        } else {
            calculate_average_price(&arg2)
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg3, v3);
            v3 = v3 + 1;
        };
        let v4 = v2 / v0;
        let v5 = AggregatedPrice{
            id           : 0x2::object::new(arg5),
            symbol       : arg1,
            price        : v1,
            confidence   : v4,
            timestamp    : 0x2::clock::timestamp_ms(arg4),
            source_count : v0,
            twap_1h      : v1,
            twap_24h     : v1,
            volatility   : calculate_price_volatility(&arg2),
        };
        let v6 = PriceAggregated{
            symbol           : arg1,
            aggregated_price : v1,
            confidence       : v4,
            source_count     : v0,
            method           : arg0.aggregation_method,
        };
        0x2::event::emit<PriceAggregated>(v6);
        0x2::transfer::share_object<AggregatedPrice>(v5);
    }

    public entry fun create_oracle(arg0: &mut OracleRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg6), 1);
        let v0 = PriceOracle{
            id             : 0x2::object::new(arg6),
            symbol         : arg1,
            price          : arg3,
            confidence     : 10000,
            timestamp      : 0x2::clock::timestamp_ms(arg5),
            expo           : arg4,
            ema_price      : arg3,
            ema_confidence : 10000,
            source         : arg2,
            is_active      : true,
        };
        let v1 = 0x2::object::uid_to_address(&v0.id);
        0x2::table::add<vector<u8>, address>(&mut arg0.oracles, arg1, v1);
        let v2 = OracleCreated{
            symbol         : arg1,
            oracle_address : v1,
            source         : arg2,
            creator        : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<OracleCreated>(v2);
        0x2::transfer::share_object<PriceOracle>(v0);
    }

    public fun get_ema_price(arg0: &PriceOracle) : (u64, u64) {
        (arg0.ema_price, arg0.ema_confidence)
    }

    public fun get_oracle_info(arg0: &PriceOracle) : (vector<u8>, u64, u64, u64, bool) {
        (arg0.symbol, arg0.price, arg0.confidence, arg0.timestamp, arg0.is_active)
    }

    public entry fun get_price(arg0: &PriceOracle, arg1: &0x2::clock::Clock) : (u64, u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.timestamp <= 300000, 2);
        assert!(arg0.is_active, 6);
        (arg0.price, arg0.confidence, arg0.timestamp)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleRegistry{
            id                 : 0x2::object::new(arg0),
            oracles            : 0x2::table::new<vector<u8>, address>(arg0),
            aggregation_method : 2,
            admin              : 0x2::tx_context::sender(arg0),
            emergency_mode     : false,
            total_updates      : 0,
            last_health_check  : 0,
        };
        0x2::transfer::share_object<OracleRegistry>(v0);
    }

    public fun is_price_fresh(arg0: &PriceOracle, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) - arg0.timestamp <= 300000
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun sqrt_u64(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        if (v0 < arg0) {
            v0
        } else {
            arg0
        }
    }

    public entry fun update_price(arg0: &mut OracleRegistry, arg1: &mut PriceOracle, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 >= 8500, 5);
        assert!(arg2 > 0, 3);
        let v1 = calculate_price_deviation(arg1.price, arg2);
        if (v1 > 1000) {
            let v2 = PriceAnomaly{
                symbol               : arg1.symbol,
                current_price        : arg2,
                previous_price       : arg1.price,
                deviation_percentage : v1,
                timestamp            : v0,
            };
            0x2::event::emit<PriceAnomaly>(v2);
            if (arg0.emergency_mode) {
                abort 4
            };
        };
        let v3 = 2000;
        arg1.ema_price = (arg1.ema_price * (10000 - v3) + arg2 * v3) / 10000;
        arg1.ema_confidence = (arg1.ema_confidence * (10000 - v3) + arg3 * v3) / 10000;
        arg1.price = arg2;
        arg1.confidence = arg3;
        arg1.timestamp = v0;
        arg0.total_updates = arg0.total_updates + 1;
        let v4 = PriceUpdate{
            id            : 0x2::object::new(arg5),
            oracle_symbol : arg1.symbol,
            old_price     : arg1.price,
            new_price     : arg2,
            confidence    : arg3,
            timestamp     : v0,
            updater       : 0x2::tx_context::sender(arg5),
        };
        let v5 = PriceUpdated{
            symbol     : arg1.symbol,
            price      : arg2,
            confidence : arg3,
            timestamp  : v0,
            source     : arg1.source,
        };
        0x2::event::emit<PriceUpdated>(v5);
        0x2::transfer::transfer<PriceUpdate>(v4, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

