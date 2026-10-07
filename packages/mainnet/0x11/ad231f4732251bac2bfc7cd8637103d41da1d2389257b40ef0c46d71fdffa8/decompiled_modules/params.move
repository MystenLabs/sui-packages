module 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params {
    public(friend) fun admin_execution_window_ms() : u64 {
        7 * 86400000
    }

    public(friend) fun admin_timelock_ms() : u64 {
        72 * 3600000
    }

    public(friend) fun claim_window_ms() : u64 {
        30 * 86400000
    }

    public(friend) fun contest_cooldown_ms() : u64 {
        30 * 86400000
    }

    public(friend) fun default_cto_delay_ms() : u64 {
        3 * 86400000
    }

    public(friend) fun default_cto_window_ms() : u64 {
        3 * 86400000
    }

    public(friend) fun default_review_ms() : u64 {
        30 * 60000
    }

    public(friend) fun default_snipe_window_ms() : u64 {
        5 * 1000
    }

    public(friend) fun default_vesting_ms() : u64 {
        1825 * 86400000
    }

    public(friend) fun dividends_idle_ms() : u64 {
        30 * 86400000
    }

    public(friend) fun fallback_interval_ms() : u64 {
        10 * 60000
    }

    public(friend) fun farm_day_ms() : u64 {
        1 * 86400000
    }

    public(friend) fun identity_admin_delay_ms() : u64 {
        3 * 86400000
    }

    public(friend) fun max_cto_ms() : u64 {
        30 * 86400000
    }

    public(friend) fun max_period_lag_ms() : u64 {
        10 * 60000
    }

    public(friend) fun max_review_ms() : u64 {
        7 * 86400000
    }

    public(friend) fun max_snipe_window_ms() : u64 {
        60 * 1000
    }

    public(friend) fun max_vesting_ms() : u64 {
        3650 * 86400000
    }

    public(friend) fun min_cto_delay_ms() : u64 {
        3 * 86400000
    }

    public(friend) fun min_cto_window_ms() : u64 {
        1 * 86400000
    }

    public(friend) fun min_period_ms() : u64 {
        10 * 60000
    }

    public(friend) fun min_review_ms() : u64 {
        15 * 60000
    }

    public(friend) fun min_vesting_ms() : u64 {
        1 * 86400000
    }

    public(friend) fun pause_ms() : u64 {
        72 * 3600000
    }

    // decompiled from Move bytecode v7
}

