module 0xad13a1de8665386765abd6fa18a9eebf031e128663ca80bb9ac4ab0e9f45b081::price_monitor_consts {
    public fun get_anomaly_cooldown_period_ms() : u64 {
        300000
    }

    public fun get_anomaly_flag_deviation() : u8 {
        1
    }

    public fun get_anomaly_flag_none() : u8 {
        0
    }

    public fun get_anomaly_flag_statistical() : u8 {
        2
    }

    public fun get_anomaly_level_critical() : u8 {
        2
    }

    public fun get_anomaly_level_emergency() : u8 {
        3
    }

    public fun get_anomaly_level_normal() : u8 {
        0
    }

    public fun get_anomaly_level_warning() : u8 {
        1
    }

    public fun get_basis_points_denominator() : u64 {
        10000
    }

    public fun get_critical_anomaly_threshold() : u64 {
        3
    }

    public fun get_critical_deviation_bps() : u64 {
        5000
    }

    public fun get_critical_history_deviation_bps() : u64 {
        2000
    }

    public fun get_critical_zscore_threshold() : u64 {
        30000
    }

    public fun get_emergency_anomaly_threshold() : u64 {
        2
    }

    public fun get_emergency_deviation_bps() : u64 {
        7500
    }

    public fun get_emergency_history_deviation_bps() : u64 {
        3000
    }

    public fun get_emergency_zscore_threshold() : u64 {
        40000
    }

    public fun get_enable_critical_escalation() : bool {
        false
    }

    public fun get_enable_emergency_escalation() : bool {
        true
    }

    public fun get_enable_oracle_history_validation() : bool {
        true
    }

    public fun get_enable_oracle_pool_validation() : bool {
        true
    }

    public fun get_enable_statistical_validation() : bool {
        true
    }

    public fun get_max_price_age_ms() : u64 {
        60000
    }

    public fun get_max_price_history_age_ms() : u64 {
        3600000
    }

    public fun get_max_price_history_size() : u64 {
        70
    }

    public fun get_min_price_interval_ms() : u64 {
        60000
    }

    public fun get_min_prices_for_analysis() : u64 {
        10
    }

    public fun get_q64_shift() : u128 {
        18446744073709551616
    }

    public fun get_warning_deviation_bps() : u64 {
        2500
    }

    public fun get_warning_history_deviation_bps() : u64 {
        1000
    }

    public fun get_warning_zscore_threshold() : u64 {
        25000
    }

    public fun get_zscore_scaling_factor() : u64 {
        100
    }

    // decompiled from Move bytecode v6
}

