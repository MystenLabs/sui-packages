module 0x1b7eb2a396b4af0333dd5dd3ec4b765087fc05c4c0bdfe42ea512ef0db691471::errors {
    public fun bad_pool_params() : u64 {
        26
    }

    public fun below_threshold() : u64 {
        10
    }

    public fun empty_stake() : u64 {
        21
    }

    public fun insufficient_points() : u64 {
        2
    }

    public fun invalid_earned() : u64 {
        0
    }

    public fun invalid_record_cap() : u64 {
        3
    }

    public fun length_mismatch() : u64 {
        1
    }

    public fun liquidity_mining_invalid_start_time() : u64 {
        30
    }

    public fun liquidity_mining_invalid_time() : u64 {
        31
    }

    public fun liquidity_mining_invalid_type() : u64 {
        33
    }

    public fun liquidity_mining_max_concurrent_pool_rewards_violated() : u64 {
        32
    }

    public fun liquidity_mining_no_reward_to_claim() : u64 {
        34
    }

    public fun liquidity_mining_not_all_rewards_claimed() : u64 {
        36
    }

    public fun liquidity_mining_pool_reward_period_not_over() : u64 {
        35
    }

    public fun liquidity_mining_share_not_zero() : u64 {
        37
    }

    public fun not_configured() : u64 {
        12
    }

    public fun nothing_to_withdraw() : u64 {
        24
    }

    public fun pool_already_exists() : u64 {
        28
    }

    public fun pool_ended() : u64 {
        22
    }

    public fun pool_not_ended() : u64 {
        20
    }

    public fun pool_not_found() : u64 {
        27
    }

    public fun reward_outside_season() : u64 {
        29
    }

    public fun season_mismatch() : u64 {
        23
    }

    public fun weekly_cap_reached() : u64 {
        11
    }

    public fun wrong_pool() : u64 {
        25
    }

    public fun wrong_version() : u64 {
        100
    }

    // decompiled from Move bytecode v7
}

