module 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors {
    public fun assert_cooldown(arg0: u64) {
        assert!(arg0 >= 43200000, 103);
    }

    public fun assert_heartbeat_age(arg0: u64) {
        assert!(arg0 <= 7200000, 109);
    }

    public fun assert_min_apy(arg0: u64) {
        assert!(arg0 >= 10, 102);
    }

    public fun assert_min_tvl(arg0: u64) {
        assert!(arg0 >= 1000000000000, 106);
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
        assert!(arg0 >= 50, 101);
    }

    public fun assert_timelock_delay(arg0: u64) {
        assert!(arg0 >= 172800000, 105);
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
        7200000
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
        10
    }

    public fun min_cooldown_floor() : u64 {
        43200000
    }

    public fun min_spread_floor() : u64 {
        50
    }

    public fun min_timelock_ms() : u64 {
        172800000
    }

    public fun min_tvl_floor() : u64 {
        1000000000000
    }

    // decompiled from Move bytecode v6
}

