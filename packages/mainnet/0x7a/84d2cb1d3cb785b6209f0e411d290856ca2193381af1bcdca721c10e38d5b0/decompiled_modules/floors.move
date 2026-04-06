module 0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::floors {
    public fun assert_cooldown(arg0: u64) {
        assert!(arg0 >= 1, 103);
    }

    public fun assert_heartbeat_age(arg0: u64) {
        assert!(arg0 <= 86400000, 109);
    }

    public fun assert_min_apy(arg0: u64) {
        assert!(arg0 >= 0, 102);
    }

    public fun assert_min_tvl(arg0: u64) {
        assert!(arg0 >= 0, 106);
    }

    public fun assert_rewards_fee(arg0: u64) {
        assert!(arg0 <= 2000, 100);
    }

    public fun assert_slippage(arg0: u64, arg1: bool) {
        if (arg1) {
            assert!(arg0 <= 1000, 104);
        } else {
            assert!(arg0 <= 50, 104);
        };
    }

    public fun assert_spread(arg0: u64) {
        assert!(arg0 >= 0, 101);
    }

    public fun assert_timelock_delay(arg0: u64) {
        assert!(arg0 >= 1, 105);
    }

    public fun assert_tvl_delta(arg0: u64) {
        assert!(arg0 <= 2000, 108);
    }

    public fun assert_vote_lock_duration(arg0: u64) {
        assert!(arg0 <= 2592000000, 107);
    }

    public fun max_emergency_slippage_ceil() : u64 {
        1000
    }

    public fun max_heartbeat_age_ms() : u64 {
        86400000
    }

    public fun max_rewards_fee_ceil() : u64 {
        2000
    }

    public fun max_slippage_ceil() : u64 {
        50
    }

    public fun max_tvl_delta_ceil() : u64 {
        2000
    }

    public fun max_vote_lock_ms() : u64 {
        2592000000
    }

    public fun min_apy_floor() : u64 {
        0
    }

    public fun min_cooldown_floor() : u64 {
        1
    }

    public fun min_spread_floor() : u64 {
        0
    }

    public fun min_timelock_ms() : u64 {
        1
    }

    public fun min_tvl_floor() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

