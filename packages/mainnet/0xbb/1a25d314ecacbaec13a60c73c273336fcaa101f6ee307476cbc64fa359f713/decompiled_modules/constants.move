module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::constants {
    public fun bps_scaling() : u64 {
        10000
    }

    public fun default_base_spread() : u64 {
        10000000
    }

    public fun default_max_exposure_per_market_pct() : u64 {
        200000000
    }

    public fun default_max_total_exposure_pct() : u64 {
        800000000
    }

    public fun default_min_lockup_ms() : u64 {
        86400000
    }

    public fun default_oracle_staleness_ms() : u64 {
        30000
    }

    public fun direction_down() : u8 {
        1
    }

    public fun direction_up() : u8 {
        0
    }

    public fun float_scaling() : u64 {
        1000000000
    }

    public fun grace_period_ms() : u64 {
        604800000
    }

    public fun max_strikes_quantity() : u64 {
        20
    }

    public fun ms_per_day() : u64 {
        86400000
    }

    public fun ms_per_hour() : u64 {
        3600000
    }

    public fun ms_per_minute() : u64 {
        60000
    }

    public fun ms_per_second() : u64 {
        1000
    }

    public fun ms_per_year() : u64 {
        31536000000
    }

    public fun usdc_unit() : u64 {
        1000000
    }

    // decompiled from Move bytecode v6
}

