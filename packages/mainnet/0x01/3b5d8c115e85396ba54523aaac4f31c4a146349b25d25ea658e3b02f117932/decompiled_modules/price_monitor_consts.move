module 0x82fd97f4ab360844693e9bfe655765a7bd1351f18e2a89b2a1eaf694b4390778::price_monitor_consts {
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
        7200000
    }

    public fun get_max_price_history_size() : u64 {
        50
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

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    // decompiled from Move bytecode v6
}

