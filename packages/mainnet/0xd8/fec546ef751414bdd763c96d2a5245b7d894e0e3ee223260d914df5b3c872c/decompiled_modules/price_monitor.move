module 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor {
    struct PriceMonitorConfig has drop, store {
        warning_deviation_bps: u64,
        critical_deviation_bps: u64,
        emergency_deviation_bps: u64,
        warning_zscore_threshold: u64,
        critical_zscore_threshold: u64,
        emergency_zscore_threshold: u64,
        critical_anomaly_threshold: u64,
        emergency_anomaly_threshold: u64,
        anomaly_cooldown_period_ms: u64,
        max_price_age_ms: u64,
        max_price_history_age_ms: u64,
        min_price_interval_ms: u64,
        max_price_history_size: u64,
        min_prices_for_analysis: u64,
        enable_oracle_pool_validation: bool,
        enable_oracle_history_validation: bool,
        enable_statistical_validation: bool,
        enable_critical_escalation: bool,
        enable_emergency_escalation: bool,
    }

    struct PricePoint has copy, drop, store {
        oracle_price_q64: u128,
        pool_price_q64: u128,
        deviation_bps: u64,
        z_score: u128,
        timestamp_ms: u64,
        anomaly_level: u8,
        anomaly_flags: u8,
    }

    struct PriceMonitor has store, key {
        id: 0x2::object::UID,
        version: u64,
        config: PriceMonitorConfig,
        aggregator_to_pools: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
        price_history: 0x2::linked_table::LinkedTable<u64, PricePoint>,
        max_history_size: u64,
        anomaly_count: u64,
        consecutive_anomalies: u64,
        is_emergency_paused: bool,
        pause_timestamp_ms: u64,
        last_anomaly_level: u8,
        last_anomaly_timestamp_ms: u64,
        admins: 0x2::vec_set::VecSet<address>,
        bag: 0x2::bag::Bag,
    }

    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventOraclePoolAnomalyDetected has copy, drop, store {
        monitor_id: 0x2::object::ID,
        oracle_price_q64: u128,
        pool_price_q64: u128,
        deviation_bps: u64,
        anomaly_level: u8,
        anomaly_flags: u8,
        timestamp_ms: u64,
    }

    struct EventOracleHistoryAnomalyDetected has copy, drop, store {
        monitor_id: 0x2::object::ID,
        oracle_price_q64: u128,
        deviation_bps: u64,
        anomaly_level: u8,
        anomaly_flags: u8,
        timestamp_ms: u64,
    }

    struct EventStatisticalAnomalyDetected has copy, drop, store {
        monitor_id: 0x2::object::ID,
        oracle_price_q64: u128,
        z_score: u128,
        anomaly_level: u8,
        anomaly_flags: u8,
        timestamp_ms: u64,
    }

    struct EventCircuitBreakerActivated has copy, drop, store {
        monitor_id: 0x2::object::ID,
        level: u8,
        timestamp_ms: u64,
    }

    struct EventCircuitBreakerDeactivated has copy, drop, store {
        monitor_id: 0x2::object::ID,
        level: u8,
        timestamp_ms: u64,
    }

    struct EventPriceHistoryUpdated has copy, drop, store {
        monitor_id: 0x2::object::ID,
        history_length: u64,
        timestamp_ms: u64,
    }

    struct DeviationValidationResult has copy, drop {
        deviation_bps: u64,
        anomaly_level: u8,
        anomaly_flags: u8,
    }

    struct StatisticalValidationResult has drop {
        z_score: u128,
        anomaly_level: u8,
        anomaly_flags: u8,
    }

    struct CircuitBreakerResult has drop, store {
        level: u8,
        should_activate: bool,
        should_escalate: bool,
    }

    struct PriceValidationResult has copy, drop {
        escalation_activation: bool,
        is_valid: bool,
        price_q64: u128,
    }

    struct CircuitBreakerStatus has copy, drop {
        is_paused: bool,
        last_anomaly_level: u8,
        pause_timestamp_ms: u64,
        anomaly_count: u64,
        consecutive_anomalies: u64,
    }

    struct PriceStatistics has drop {
        mean_price_q64: u128,
        std_dev_q64: u128,
        history_length: u64,
        min_prices_required: u64,
    }

    public fun add_admin(arg0: &SuperAdminCap, arg1: &mut PriceMonitor, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        check_admin(arg1, 0x2::tx_context::sender(arg3));
        assert!(!0x2::vec_set::contains<address>(&arg1.admins, &arg2), 93002007804597346);
        0x2::vec_set::insert<address>(&mut arg1.admins, arg2);
    }

    public fun add_aggregator(arg0: &mut PriceMonitor, arg1: 0x2::object::ID, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg3));
        let v0 = if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.aggregator_to_pools, arg1)) {
            0x2::table::remove<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.aggregator_to_pools, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&arg2, v1));
            v1 = v1 + 1;
        };
        0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.aggregator_to_pools, arg1, v0);
    }

    public fun add_pool_to_aggregator(arg0: &mut PriceMonitor, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.aggregator_to_pools, arg1), 96897698040023643);
        assert!(!is_pool_associated_with_aggregator(arg0, arg1, arg2), 94979479040750757);
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.aggregator_to_pools, arg1), arg2);
    }

    fun add_price_to_history(arg0: &mut PriceMonitor, arg1: PricePoint) {
        let v0 = 0x2::linked_table::front<u64, PricePoint>(&arg0.price_history);
        if (0x1::option::is_some<u64>(v0)) {
            if (arg1.timestamp_ms < 0x2::linked_table::borrow<u64, PricePoint>(&arg0.price_history, *0x1::option::borrow<u64>(v0)).timestamp_ms + arg0.config.min_price_interval_ms) {
                return
            };
        };
        0x2::linked_table::push_front<u64, PricePoint>(&mut arg0.price_history, arg1.timestamp_ms, arg1);
        if (0x2::linked_table::length<u64, PricePoint>(&arg0.price_history) > arg0.max_history_size) {
            let (_, _) = 0x2::linked_table::pop_back<u64, PricePoint>(&mut arg0.price_history);
        };
    }

    fun calculate_deviation_bps(arg0: u128, arg1: u128) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v1 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v0, (0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_basis_points_denominator() as u128), arg1);
        let v2 = if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            v1
        };
        (v2 as u64)
    }

    fun calculate_price_statistics(arg0: &PriceMonitor) : (u128, u128) {
        if (0x2::linked_table::length<u64, PricePoint>(&arg0.price_history) == 0) {
            return (0, 0)
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::linked_table::front<u64, PricePoint>(&arg0.price_history);
        while (0x1::option::is_some<u64>(v2)) {
            let v3 = 0x1::option::borrow<u64>(v2);
            v0 = v0 + 0x2::linked_table::borrow<u64, PricePoint>(&arg0.price_history, *v3).oracle_price_q64;
            v1 = v1 + 1;
            v2 = 0x2::linked_table::next<u64, PricePoint>(&arg0.price_history, *v3);
        };
        if (v1 == 0) {
            return (0, 0)
        };
        let v4 = v0 / (v1 as u128);
        let v5 = 0;
        v2 = 0x2::linked_table::front<u64, PricePoint>(&arg0.price_history);
        while (0x1::option::is_some<u64>(v2)) {
            let v6 = 0x1::option::borrow<u64>(v2);
            let v7 = 0x2::linked_table::borrow<u64, PricePoint>(&arg0.price_history, *v6);
            let v8 = if (v7.oracle_price_q64 > v4) {
                v7.oracle_price_q64 - v4
            } else {
                v4 - v7.oracle_price_q64
            };
            v5 = v5 + v8 * v8;
            v2 = 0x2::linked_table::next<u64, PricePoint>(&arg0.price_history, *v6);
        };
        (v4, integer_sqrt(v5 / (v1 as u128)))
    }

    fun calculate_z_score(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(v0, (0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_basis_points_denominator() as u128), arg2)
    }

    public fun check_admin(arg0: &PriceMonitor, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg1), 93200562390235020);
    }

    public fun checked_package_version(arg0: &PriceMonitor) {
        assert!(arg0.version == 1, 93406283690864906);
    }

    fun clean_old_prices_from_history(arg0: &mut PriceMonitor, arg1: u64) {
        let v0 = arg0.config.max_price_history_age_ms;
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::linked_table::back<u64, PricePoint>(&arg0.price_history);
        while (0x1::option::is_some<u64>(v1)) {
            if (arg1 < 0x2::linked_table::borrow<u64, PricePoint>(&arg0.price_history, *0x1::option::borrow<u64>(v1)).timestamp_ms + v0) {
                break
            };
            let (_, _) = 0x2::linked_table::pop_back<u64, PricePoint>(&mut arg0.price_history);
            v1 = 0x2::linked_table::back<u64, PricePoint>(&arg0.price_history);
        };
    }

    public fun create_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: bool, arg16: bool, arg17: bool, arg18: bool) : PriceMonitorConfig {
        PriceMonitorConfig{
            warning_deviation_bps            : arg0,
            critical_deviation_bps           : arg1,
            emergency_deviation_bps          : arg2,
            warning_zscore_threshold         : arg3,
            critical_zscore_threshold        : arg4,
            emergency_zscore_threshold       : arg5,
            critical_anomaly_threshold       : arg6,
            emergency_anomaly_threshold      : arg7,
            anomaly_cooldown_period_ms       : arg8,
            max_price_age_ms                 : arg9,
            max_price_history_age_ms         : arg10,
            min_price_interval_ms            : arg11,
            max_price_history_size           : arg12,
            min_prices_for_analysis          : arg13,
            enable_oracle_pool_validation    : arg14,
            enable_oracle_history_validation : arg15,
            enable_statistical_validation    : arg16,
            enable_critical_escalation       : arg17,
            enable_emergency_escalation      : arg18,
        }
    }

    fun create_price_point(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: u64, arg5: u8, arg6: u8) : PricePoint {
        PricePoint{
            oracle_price_q64 : arg0,
            pool_price_q64   : arg1,
            deviation_bps    : arg2,
            z_score          : arg3,
            timestamp_ms     : arg4,
            anomaly_level    : arg5,
            anomaly_flags    : arg6,
        }
    }

    public fun emergency_pause(arg0: &mut PriceMonitor, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.is_emergency_paused = true;
        arg0.pause_timestamp_ms = 0x2::clock::timestamp_ms(arg1);
        arg0.last_anomaly_level = 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_emergency();
        let v0 = EventCircuitBreakerActivated{
            monitor_id   : 0x2::object::id<PriceMonitor>(arg0),
            level        : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_emergency(),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EventCircuitBreakerActivated>(v0);
    }

    public fun emergency_resume(arg0: &mut PriceMonitor, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.is_emergency_paused = false;
        arg0.pause_timestamp_ms = 0;
        arg0.last_anomaly_level = 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal();
        arg0.consecutive_anomalies = 0;
        let v0 = EventCircuitBreakerDeactivated{
            monitor_id   : 0x2::object::id<PriceMonitor>(arg0),
            level        : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal(),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EventCircuitBreakerDeactivated>(v0);
    }

    fun emit_validation_events(arg0: &PriceMonitor, arg1: &DeviationValidationResult, arg2: &StatisticalValidationResult, arg3: &DeviationValidationResult, arg4: &CircuitBreakerResult, arg5: u128, arg6: u128, arg7: u64) {
        if (arg1.anomaly_level > 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal()) {
            let v0 = EventOraclePoolAnomalyDetected{
                monitor_id       : 0x2::object::id<PriceMonitor>(arg0),
                oracle_price_q64 : arg5,
                pool_price_q64   : arg6,
                deviation_bps    : arg1.deviation_bps,
                anomaly_level    : arg1.anomaly_level,
                anomaly_flags    : arg1.anomaly_flags,
                timestamp_ms     : arg7,
            };
            0x2::event::emit<EventOraclePoolAnomalyDetected>(v0);
        };
        if (arg3.anomaly_level > 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal()) {
            let v1 = EventOracleHistoryAnomalyDetected{
                monitor_id       : 0x2::object::id<PriceMonitor>(arg0),
                oracle_price_q64 : arg5,
                deviation_bps    : arg3.deviation_bps,
                anomaly_level    : arg3.anomaly_level,
                anomaly_flags    : arg3.anomaly_flags,
                timestamp_ms     : arg7,
            };
            0x2::event::emit<EventOracleHistoryAnomalyDetected>(v1);
        };
        if (arg2.anomaly_level > 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal()) {
            let v2 = EventStatisticalAnomalyDetected{
                monitor_id       : 0x2::object::id<PriceMonitor>(arg0),
                oracle_price_q64 : arg5,
                z_score          : arg2.z_score,
                anomaly_level    : arg2.anomaly_level,
                anomaly_flags    : arg2.anomaly_flags,
                timestamp_ms     : arg7,
            };
            0x2::event::emit<EventStatisticalAnomalyDetected>(v2);
        };
        if (arg4.should_activate) {
            let v3 = EventCircuitBreakerActivated{
                monitor_id   : 0x2::object::id<PriceMonitor>(arg0),
                level        : arg4.level,
                timestamp_ms : arg7,
            };
            0x2::event::emit<EventCircuitBreakerActivated>(v3);
        };
        let v4 = EventPriceHistoryUpdated{
            monitor_id     : 0x2::object::id<PriceMonitor>(arg0),
            history_length : 0x2::linked_table::length<u64, PricePoint>(&arg0.price_history),
            timestamp_ms   : arg7,
        };
        0x2::event::emit<EventPriceHistoryUpdated>(v4);
    }

    fun evaluate_circuit_breaker(arg0: &PriceMonitor, arg1: &DeviationValidationResult, arg2: &DeviationValidationResult, arg3: &StatisticalValidationResult, arg4: u64) : CircuitBreakerResult {
        let v0 = (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::max(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::max((arg1.anomaly_level as u128), (arg3.anomaly_level as u128)), (arg2.anomaly_level as u128)) as u8);
        CircuitBreakerResult{
            level           : v0,
            should_activate : v0 != 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal(),
            should_escalate : should_escalate_circuit_breaker(arg0, v0, arg4),
        }
    }

    public fun get_circuit_breaker_status(arg0: &PriceMonitor) : CircuitBreakerStatus {
        CircuitBreakerStatus{
            is_paused             : arg0.is_emergency_paused,
            last_anomaly_level    : arg0.last_anomaly_level,
            pause_timestamp_ms    : arg0.pause_timestamp_ms,
            anomaly_count         : arg0.anomaly_count,
            consecutive_anomalies : arg0.consecutive_anomalies,
        }
    }

    public fun get_config(arg0: &PriceMonitor) : &PriceMonitorConfig {
        &arg0.config
    }

    public fun get_escalation_activation(arg0: &PriceValidationResult) : bool {
        arg0.escalation_activation
    }

    public fun get_is_valid(arg0: &PriceValidationResult) : bool {
        arg0.is_valid
    }

    fun get_pool_price_q64<T0, T1, T2>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>) : u128 {
        let v0 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = ((0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::full_mul(v0, v0) >> 64) as u128);
        let v2 = v1;
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<T2>()) {
            v2 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(((1 << 64) as u128), ((1 << 64) as u128), v1);
        };
        assert!(v2 > 0, 99740389568845675);
        v2
    }

    public fun get_price_q64(arg0: &PriceValidationResult) : u128 {
        arg0.price_q64
    }

    public fun get_price_statistics(arg0: &PriceMonitor) : PriceStatistics {
        let v0 = 0x2::linked_table::length<u64, PricePoint>(&arg0.price_history);
        if (v0 < arg0.config.min_prices_for_analysis) {
            return PriceStatistics{
                mean_price_q64      : 0,
                std_dev_q64         : 0,
                history_length      : v0,
                min_prices_required : arg0.config.min_prices_for_analysis,
            }
        };
        let (v1, v2) = calculate_price_statistics(arg0);
        PriceStatistics{
            mean_price_q64      : v1,
            std_dev_q64         : v2,
            history_length      : v0,
            min_prices_required : arg0.config.min_prices_for_analysis,
        }
    }

    public fun get_time_checked_price_q64(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: &0x2::clock::Clock) : u128 {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg0);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::timestamp_ms(v0) + 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_max_price_age_ms() > 0x2::clock::timestamp_ms(arg1), 93470312203956742);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v1), 92834672437062811);
        0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(v1), 18446744073709551616, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::pow_10(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::dec(v1)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceMonitorConfig{
            warning_deviation_bps            : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_warning_deviation_bps(),
            critical_deviation_bps           : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_critical_deviation_bps(),
            emergency_deviation_bps          : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_emergency_deviation_bps(),
            warning_zscore_threshold         : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_warning_zscore_threshold(),
            critical_zscore_threshold        : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_critical_zscore_threshold(),
            emergency_zscore_threshold       : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_emergency_zscore_threshold(),
            critical_anomaly_threshold       : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_critical_anomaly_threshold(),
            emergency_anomaly_threshold      : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_emergency_anomaly_threshold(),
            anomaly_cooldown_period_ms       : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_cooldown_period_ms(),
            max_price_age_ms                 : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_max_price_age_ms(),
            max_price_history_age_ms         : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_max_price_history_age_ms(),
            min_price_interval_ms            : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_min_price_interval_ms(),
            max_price_history_size           : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_max_price_history_size(),
            min_prices_for_analysis          : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_min_prices_for_analysis(),
            enable_oracle_pool_validation    : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_enable_oracle_pool_validation(),
            enable_oracle_history_validation : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_enable_oracle_history_validation(),
            enable_statistical_validation    : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_enable_statistical_validation(),
            enable_critical_escalation       : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_enable_critical_escalation(),
            enable_emergency_escalation      : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_enable_emergency_escalation(),
        };
        let v1 = PriceMonitor{
            id                        : 0x2::object::new(arg0),
            version                   : 1,
            config                    : v0,
            aggregator_to_pools       : 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg0),
            price_history             : 0x2::linked_table::new<u64, PricePoint>(arg0),
            max_history_size          : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_max_price_history_size(),
            anomaly_count             : 0,
            consecutive_anomalies     : 0,
            is_emergency_paused       : false,
            pause_timestamp_ms        : 0,
            last_anomaly_level        : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal(),
            last_anomaly_timestamp_ms : 0,
            admins                    : 0x2::vec_set::empty<address>(),
            bag                       : 0x2::bag::new(arg0),
        };
        0x2::vec_set::insert<address>(&mut v1.admins, 0x2::tx_context::sender(arg0));
        let v2 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuperAdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PriceMonitor>(v1);
    }

    fun integer_sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 == 1) {
            return 1
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun is_admin(arg0: &PriceMonitor, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_pool_associated_with_aggregator(arg0: &PriceMonitor, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.aggregator_to_pools, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(&arg0.aggregator_to_pools, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun monitor_id(arg0: &PriceMonitor) : 0x2::object::ID {
        0x2::object::id<PriceMonitor>(arg0)
    }

    public fun remove_admin(arg0: &SuperAdminCap, arg1: &mut PriceMonitor, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        check_admin(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_set::contains<address>(&arg1.admins, &arg2), 93002007804597346);
        0x2::vec_set::remove<address>(&mut arg1.admins, &arg2);
    }

    public fun remove_aggregator(arg0: &mut PriceMonitor, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        0x2::table::remove<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.aggregator_to_pools, arg1);
    }

    public fun remove_pool_from_aggregator(arg0: &mut PriceMonitor, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.aggregator_to_pools, arg1), 96897698040023643);
        assert!(is_pool_associated_with_aggregator(arg0, arg1, arg2), 94979479040750757);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.aggregator_to_pools, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                0x1::vector::remove<0x2::object::ID>(v0, v1);
                break
            };
            v1 = v1 + 1;
        };
    }

    fun should_escalate_circuit_breaker(arg0: &PriceMonitor, arg1: u8, arg2: u64) : bool {
        if (arg1 == 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal() || arg1 == 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_warning()) {
            return false
        };
        if (arg2 - arg0.last_anomaly_timestamp_ms < arg0.config.anomaly_cooldown_period_ms) {
            return false
        };
        let v0 = if (arg1 == 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_critical()) {
            if (arg0.consecutive_anomalies + 1 >= arg0.config.critical_anomaly_threshold) {
                arg0.config.enable_critical_escalation
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return true
        };
        let v1 = if (arg1 == 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_emergency()) {
            if (arg0.consecutive_anomalies + 1 >= arg0.config.emergency_anomaly_threshold) {
                arg0.config.enable_emergency_escalation
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            return true
        };
        false
    }

    public fun update_anomaly_thresholds(arg0: &mut PriceMonitor, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg4));
        arg0.config.critical_anomaly_threshold = arg1;
        arg0.config.emergency_anomaly_threshold = arg2;
        arg0.config.anomaly_cooldown_period_ms = arg3;
    }

    public fun update_config(arg0: &mut PriceMonitor, arg1: PriceMonitorConfig, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.config = arg1;
    }

    public fun update_deviation_thresholds(arg0: &mut PriceMonitor, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg4));
        arg0.config.warning_deviation_bps = arg1;
        arg0.config.critical_deviation_bps = arg2;
        arg0.config.emergency_deviation_bps = arg3;
    }

    public fun update_escalation_toggles(arg0: &mut PriceMonitor, arg1: bool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg3));
        arg0.config.enable_critical_escalation = arg1;
        arg0.config.enable_emergency_escalation = arg2;
    }

    fun update_monitor_state(arg0: &mut PriceMonitor, arg1: &CircuitBreakerResult, arg2: u64) {
        if (arg1.should_escalate) {
            arg0.is_emergency_paused = true;
            arg0.pause_timestamp_ms = arg2;
        } else {
            arg0.is_emergency_paused = false;
        };
        if (arg1.should_activate) {
            arg0.consecutive_anomalies = arg0.consecutive_anomalies + 1;
            arg0.anomaly_count = arg0.anomaly_count + 1;
        } else {
            arg0.consecutive_anomalies = 0;
        };
        arg0.last_anomaly_level = arg1.level;
    }

    public fun update_time_config(arg0: &mut PriceMonitor, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg6));
        arg0.config.max_price_age_ms = arg1;
        arg0.config.max_price_history_age_ms = arg2;
        arg0.config.min_price_interval_ms = arg3;
        arg0.config.max_price_history_size = arg4;
        arg0.config.min_prices_for_analysis = arg5;
        arg0.max_history_size = arg4;
    }

    public fun update_validation_toggles(arg0: &mut PriceMonitor, arg1: bool, arg2: bool, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg4));
        arg0.config.enable_oracle_pool_validation = arg1;
        arg0.config.enable_oracle_history_validation = arg2;
        arg0.config.enable_statistical_validation = arg3;
    }

    public fun update_zscore_thresholds(arg0: &mut PriceMonitor, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg4));
        arg0.config.warning_zscore_threshold = arg1;
        arg0.config.critical_zscore_threshold = arg2;
        arg0.config.emergency_zscore_threshold = arg3;
    }

    fun validate_oracle_history_deviation(arg0: &PriceMonitor, arg1: u128) : DeviationValidationResult {
        if (0x2::linked_table::length<u64, PricePoint>(&arg0.price_history) == 0) {
            return DeviationValidationResult{
                deviation_bps : 0,
                anomaly_level : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal(),
                anomaly_flags : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_none(),
            }
        };
        let v0 = 0x2::linked_table::front<u64, PricePoint>(&arg0.price_history);
        if (0x1::option::is_none<u64>(v0)) {
            return DeviationValidationResult{
                deviation_bps : 0,
                anomaly_level : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal(),
                anomaly_flags : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_none(),
            }
        };
        let v1 = calculate_deviation_bps(arg1, 0x2::linked_table::borrow<u64, PricePoint>(&arg0.price_history, *0x1::option::borrow<u64>(v0)).oracle_price_q64);
        let v2 = if (v1 >= 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_emergency_history_deviation_bps()) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_emergency()
        } else if (v1 >= 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_critical_history_deviation_bps()) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_critical()
        } else if (v1 >= 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_warning_history_deviation_bps()) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_warning()
        } else {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal()
        };
        let v3 = if (v2 > 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal()) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_deviation()
        } else {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_none()
        };
        DeviationValidationResult{
            deviation_bps : v1,
            anomaly_level : v2,
            anomaly_flags : v3,
        }
    }

    fun validate_oracle_pool_deviation(arg0: &PriceMonitor, arg1: u128, arg2: u128) : DeviationValidationResult {
        let v0 = calculate_deviation_bps(arg1, arg2);
        let v1 = if (v0 >= arg0.config.emergency_deviation_bps) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_emergency()
        } else if (v0 >= arg0.config.critical_deviation_bps) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_critical()
        } else if (v0 >= arg0.config.warning_deviation_bps) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_warning()
        } else {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal()
        };
        let v2 = if (v1 > 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal()) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_deviation()
        } else {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_none()
        };
        DeviationValidationResult{
            deviation_bps : v0,
            anomaly_level : v1,
            anomaly_flags : v2,
        }
    }

    public fun validate_price<T0, T1, T2>(arg0: &mut PriceMonitor, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : PriceValidationResult {
        checked_package_version(arg0);
        assert!(is_pool_associated_with_aggregator(arg0, 0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg1), 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>>(arg2)), 94979479040750757);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = get_time_checked_price_q64(arg1, arg3);
        let v2 = get_pool_price_q64<T0, T1, T2>(arg2);
        clean_old_prices_from_history(arg0, v0);
        let v3 = if (arg0.config.enable_oracle_pool_validation) {
            validate_oracle_pool_deviation(arg0, v1, v2)
        } else {
            DeviationValidationResult{deviation_bps: 0, anomaly_level: 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal(), anomaly_flags: 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_none()}
        };
        let v4 = v3;
        let v5 = if (arg0.config.enable_oracle_history_validation) {
            validate_oracle_history_deviation(arg0, v1)
        } else {
            DeviationValidationResult{deviation_bps: 0, anomaly_level: 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal(), anomaly_flags: 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_none()}
        };
        let v6 = v5;
        let v7 = if (arg0.config.enable_statistical_validation) {
            validate_statistical_anomaly(arg0, v1)
        } else {
            StatisticalValidationResult{z_score: 0, anomaly_level: 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal(), anomaly_flags: 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_none()}
        };
        let v8 = v7;
        add_price_to_history(arg0, create_price_point(v1, v2, v4.deviation_bps, v8.z_score, v0, (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::max((v4.anomaly_level as u128), (v6.anomaly_level as u128)) as u8), (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::max((v4.anomaly_flags as u128), (v6.anomaly_flags as u128)) as u8)));
        let v9 = evaluate_circuit_breaker(arg0, &v4, &v6, &v8, v0);
        emit_validation_events(arg0, &v4, &v8, &v6, &v9, v1, v2, v0);
        update_monitor_state(arg0, &v9, v0);
        PriceValidationResult{
            escalation_activation : v9.should_escalate,
            is_valid              : v9.level == 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal(),
            price_q64             : v1,
        }
    }

    fun validate_statistical_anomaly(arg0: &PriceMonitor, arg1: u128) : StatisticalValidationResult {
        if (0x2::linked_table::length<u64, PricePoint>(&arg0.price_history) < arg0.config.min_prices_for_analysis) {
            return StatisticalValidationResult{
                z_score       : 0,
                anomaly_level : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal(),
                anomaly_flags : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_none(),
            }
        };
        let (v0, v1) = calculate_price_statistics(arg0);
        if (v1 == 0) {
            return StatisticalValidationResult{
                z_score       : 0,
                anomaly_level : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal(),
                anomaly_flags : 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_none(),
            }
        };
        let v2 = calculate_z_score(arg1, v0, v1);
        let v3 = if (v2 >= (arg0.config.emergency_zscore_threshold as u128)) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_emergency()
        } else if (v2 >= (arg0.config.critical_zscore_threshold as u128)) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_critical()
        } else if (v2 >= (arg0.config.warning_zscore_threshold as u128)) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_warning()
        } else {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal()
        };
        let v4 = if (v3 > 0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_level_normal()) {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_statistical()
        } else {
            0x424fcceba8cf9080644621c7d176cadf599767bd22e92845373677937a097da2::price_monitor_consts::get_anomaly_flag_none()
        };
        StatisticalValidationResult{
            z_score       : v2,
            anomaly_level : v3,
            anomaly_flags : v4,
        }
    }

    // decompiled from Move bytecode v6
}

