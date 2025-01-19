module 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_admin {
    public fun create_pool<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::create_pool<T0>(arg0, arg1, arg2, arg3);
    }

    public fun refill_pool<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::StakingPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::refill_pool<T0>(arg0, arg1, arg2, arg3);
    }

    public fun set_chakra_multipliers<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::StakingPool<T0>, arg2: vector<u64>) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::set_chakra_multipliers<T0>(arg0, arg1, arg2);
    }

    public fun set_lock_durations<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::StakingPool<T0>, arg2: vector<u64>) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::set_lock_durations<T0>(arg0, arg1, arg2);
    }

    public fun set_max_lock_time<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::StakingPool<T0>, arg2: u64) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::set_max_lock_time<T0>(arg0, arg1, arg2);
    }

    public fun set_max_time_multiplier<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::StakingPool<T0>, arg2: u64) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::set_max_time_multiplier<T0>(arg0, arg1, arg2);
    }

    public fun set_min_lock_time<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::StakingPool<T0>, arg2: u64) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::set_min_lock_time<T0>(arg0, arg1, arg2);
    }

    public fun set_pool_enabled<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::StakingPool<T0>, arg2: bool) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::set_enabled<T0>(arg0, arg1, arg2);
    }

    public fun set_reward_amount<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::StakingPool<T0>, arg2: u64) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::set_reward_amount<T0>(arg0, arg1, arg2);
    }

    public fun set_reward_end_time<T0>(arg0: &0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::admin::AdminCap, arg1: &mut 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::StakingPool<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::staking_pool::set_reward_end_time<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

