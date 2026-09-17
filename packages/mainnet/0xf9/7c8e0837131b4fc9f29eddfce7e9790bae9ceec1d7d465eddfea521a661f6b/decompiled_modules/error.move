module 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::error {
    public fun liquidity_mining_invalid_start_time() : u64 {
        5
    }

    public fun liquidity_mining_invalid_time() : u64 {
        6
    }

    public fun liquidity_mining_invalid_type() : u64 {
        8
    }

    public fun liquidity_mining_max_concurrent_pool_rewards_violated() : u64 {
        7
    }

    public fun liquidity_mining_no_reward_to_claim() : u64 {
        9
    }

    public fun liquidity_mining_not_all_rewards_claimed() : u64 {
        4
    }

    public fun liquidity_mining_pool_initialized() : u64 {
        2
    }

    public fun liquidity_mining_pool_not_initialized() : u64 {
        1
    }

    public fun liquidity_mining_pool_reward_period_not_over() : u64 {
        3
    }

    public fun version_mismatch() : u64 {
        11
    }

    public fun wrong_miner() : u64 {
        10
    }

    // decompiled from Move bytecode v7
}

