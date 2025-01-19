module 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::staking_pool {
    struct STAKING_POOL has drop {
        dummy_field: bool,
    }

    struct StakingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        rewards_balance: 0x2::balance::Balance<T0>,
        staked: 0x2::balance::Balance<T0>,
        reward_amount: u64,
        harvested_amount: u64,
        total_weight: u128,
        index: u128,
        last_harvest_time: u64,
        reward_end_time: u64,
        chakra_multipliers: vector<u64>,
        min_lock_time: u64,
        max_lock_time: u64,
        lock_durations: vector<u64>,
        max_time_multiplier: u64,
        enabled: bool,
    }

    struct StakedPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        stake_amount: u64,
        stake_weight: u128,
        time_multiplier: u64,
        chakra_multiplier: u64,
        net_multiplier: u64,
        index: u128,
        start_time: u64,
        end_time: u64,
        last_updated_time: u64,
        harvested_rewards: u64,
    }

    public fun claim<T0>(arg0: &mut StakingPool<T0>, arg1: &mut StakedPosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_pool_enabled<T0>(arg0);
        assert_valid_pool<T0>(arg0, arg1);
        harvest<T0>(arg0, arg2);
        harvest_position<T0>(arg0, arg1, arg2);
        let v0 = arg1.harvested_rewards;
        let v1 = 0x2::balance::value<T0>(&arg0.rewards_balance);
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards_balance, v2), arg3);
        arg1.harvested_rewards = 0;
        arg0.harvested_amount = arg0.harvested_amount - 0x2::coin::value<T0>(&v3);
        v3
    }

    public fun assert_pool_enabled<T0>(arg0: &StakingPool<T0>) {
        assert!(arg0.enabled, 5);
    }

    public fun assert_valid_pool<T0>(arg0: &StakingPool<T0>, arg1: &StakedPosition<T0>) {
        assert!(arg1.pool_id == 0x2::object::id<StakingPool<T0>>(arg0), 4);
    }

    public fun chakra_multipliers<T0>(arg0: &StakingPool<T0>) : vector<u64> {
        arg0.chakra_multipliers
    }

    public(friend) fun create_pool<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0>{
            id                  : 0x2::object::new(arg3),
            rewards_balance     : 0x2::balance::zero<T0>(),
            staked              : 0x2::coin::into_balance<T0>(arg1),
            reward_amount       : 0,
            harvested_amount    : 0,
            total_weight        : 0,
            index               : 0,
            last_harvest_time   : 0x2::clock::timestamp_ms(arg2),
            reward_end_time     : 0,
            chakra_multipliers  : 0x1::vector::empty<u64>(),
            min_lock_time       : 0,
            max_lock_time       : 0,
            lock_durations      : 0x1::vector::empty<u64>(),
            max_time_multiplier : 0,
            enabled             : false,
        };
        0x2::transfer::share_object<StakingPool<T0>>(v0);
    }

    public fun get_chakra_multiplier<T0>(arg0: &StakingPool<T0>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.chakra_multipliers, arg1)
    }

    public(friend) fun harvest<T0>(arg0: &mut StakingPool<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = &mut arg0.last_harvest_time;
        if (v0 == *v1) {
            return
        };
        if (arg0.total_weight == 0) {
            *v1 = v0;
            return
        };
        if (*v1 > arg0.reward_end_time) {
            *v1 = v0;
            return
        };
        let v2 = if (v0 > arg0.reward_end_time) {
            arg0.reward_end_time - *v1
        } else {
            v0 - *v1
        };
        let v3 = arg0.reward_end_time - *v1;
        if (v3 == 0) {
            *v1 = v0;
            return
        };
        let v4 = 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::math::mul_factor(v2, arg0.reward_amount, v3);
        if (arg0.reward_amount > v4) {
            arg0.reward_amount = arg0.reward_amount - v4;
        } else {
            arg0.reward_amount = 0;
        };
        arg0.harvested_amount = arg0.harvested_amount + v4;
        arg0.index = arg0.index + 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::math::mul_factor_u128((v4 as u128), 18446744073709551616, arg0.total_weight);
        *v1 = v0;
    }

    public(friend) fun harvest_position<T0>(arg0: &StakingPool<T0>, arg1: &mut StakedPosition<T0>, arg2: &0x2::clock::Clock) {
        assert_pool_enabled<T0>(arg0);
        if (arg1.stake_weight == 0) {
            arg1.last_updated_time = 0x2::clock::timestamp_ms(arg2);
            arg1.index = arg0.index;
            return
        };
        if (arg1.index == arg0.index || arg1.last_updated_time == arg0.last_harvest_time) {
            return
        };
        arg1.harvested_rewards = arg1.harvested_rewards + (0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::math::mul_factor_u128(arg1.stake_weight, arg0.index - arg1.index, 18446744073709551616) as u64);
        arg1.index = arg0.index;
    }

    public fun index<T0>(arg0: &StakingPool<T0>) : u128 {
        arg0.index
    }

    fun init(arg0: STAKING_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STAKING_POOL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_pool_enabled<T0>(arg0: &StakingPool<T0>) : bool {
        arg0.enabled
    }

    public fun is_valid_chakra_level<T0>(arg0: &StakingPool<T0>, arg1: u64) : bool {
        0x1::vector::length<u64>(&arg0.chakra_multipliers) > arg1
    }

    public fun is_valid_duration<T0>(arg0: &StakingPool<T0>, arg1: u64) : bool {
        0x1::vector::contains<u64>(&arg0.lock_durations, &arg1)
    }

    public fun last_update_time<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.last_harvest_time
    }

    public fun lock_durations<T0>(arg0: &StakingPool<T0>) : vector<u64> {
        arg0.lock_durations
    }

    public fun max_lock_time<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.max_lock_time
    }

    public fun max_time_multiplier<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.max_time_multiplier
    }

    public fun min_lock_time<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.min_lock_time
    }

    public fun position_info<T0>(arg0: &StakedPosition<T0>) : (0x2::object::ID, 0x2::object::ID, u64, u128, u64, u64, u64, u128, u64, u64, u64, u64) {
        (0x2::object::id<StakedPosition<T0>>(arg0), arg0.pool_id, arg0.stake_amount, arg0.stake_weight, arg0.time_multiplier, arg0.chakra_multiplier, arg0.net_multiplier, arg0.index, arg0.start_time, arg0.end_time, arg0.last_updated_time, arg0.harvested_rewards)
    }

    public fun position_weight<T0>(arg0: &StakedPosition<T0>) : u128 {
        arg0.stake_weight
    }

    public(friend) fun refill_pool<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut StakingPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        harvest<T0>(arg1, arg3);
        arg1.reward_amount = arg1.reward_amount + 0x2::coin::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg1.rewards_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun reward_end_time<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.reward_end_time
    }

    public(friend) fun set_chakra_multipliers<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut StakingPool<T0>, arg2: vector<u64>) {
        arg1.chakra_multipliers = arg2;
    }

    public(friend) fun set_enabled<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut StakingPool<T0>, arg2: bool) {
        arg1.enabled = arg2;
    }

    public(friend) fun set_lock_durations<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut StakingPool<T0>, arg2: vector<u64>) {
        arg1.lock_durations = arg2;
    }

    public(friend) fun set_max_lock_time<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut StakingPool<T0>, arg2: u64) {
        arg1.max_lock_time = arg2;
    }

    public(friend) fun set_max_time_multiplier<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut StakingPool<T0>, arg2: u64) {
        arg1.max_time_multiplier = arg2;
    }

    public(friend) fun set_min_lock_time<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut StakingPool<T0>, arg2: u64) {
        arg1.min_lock_time = arg2;
    }

    public(friend) fun set_reward_amount<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut StakingPool<T0>, arg2: u64) {
        arg1.reward_amount = arg2;
    }

    public(friend) fun set_reward_end_time<T0>(arg0: &0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::admin::AdminCap, arg1: &mut StakingPool<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        harvest<T0>(arg1, arg3);
        arg1.reward_end_time = arg2;
    }

    public(friend) fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : StakedPosition<T0> {
        assert_pool_enabled<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 1);
        assert!(is_valid_duration<T0>(arg0, arg2), 2);
        assert!(is_valid_chakra_level<T0>(arg0, arg3), 3);
        harvest<T0>(arg0, arg4);
        let (v0, v1, v2) = 0xe022ce8d35f4cb864239bd1bcba69d20e84126d32303ffe0cf8b8c5f5d99bdc0::math::compute_stake_weight(0x2::coin::value<T0>(&arg1), arg2, arg0.min_lock_time, arg0.max_lock_time, arg0.max_time_multiplier, *0x1::vector::borrow<u64>(&arg0.chakra_multipliers, arg3));
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_weight = arg0.total_weight + v0;
        let v3 = 0x2::clock::timestamp_ms(arg4);
        StakedPosition<T0>{
            id                : 0x2::object::new(arg5),
            pool_id           : 0x2::object::id<StakingPool<T0>>(arg0),
            stake_amount      : 0x2::coin::value<T0>(&arg1),
            stake_weight      : v0,
            time_multiplier   : v2,
            chakra_multiplier : *0x1::vector::borrow<u64>(&arg0.chakra_multipliers, arg3),
            net_multiplier    : v1,
            index             : arg0.index,
            start_time        : v3,
            end_time          : v3 + arg2,
            last_updated_time : v3,
            harvested_rewards : 0,
        }
    }

    public fun total_harvested<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.harvested_amount
    }

    public fun total_rewards<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.reward_amount
    }

    public fun total_staked<T0>(arg0: &StakingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.staked)
    }

    public fun total_weight<T0>(arg0: &StakingPool<T0>) : u128 {
        arg0.total_weight
    }

    public(friend) fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: StakedPosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert_pool_enabled<T0>(arg0);
        assert_valid_pool<T0>(arg0, &arg1);
        harvest<T0>(arg0, arg2);
        let v0 = &mut arg1;
        harvest_position<T0>(arg0, v0, arg2);
        let v1 = &mut arg1;
        let v2 = claim<T0>(arg0, v1, arg2, arg3);
        let StakedPosition {
            id                : v3,
            pool_id           : _,
            stake_amount      : v5,
            stake_weight      : v6,
            time_multiplier   : _,
            chakra_multiplier : _,
            net_multiplier    : _,
            index             : _,
            start_time        : _,
            end_time          : v12,
            last_updated_time : _,
            harvested_rewards : _,
        } = arg1;
        assert!(0x2::clock::timestamp_ms(arg2) >= v12, 0);
        arg0.total_weight = arg0.total_weight - v6;
        0x2::object::delete(v3);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked, v5), arg3), v2)
    }

    // decompiled from Move bytecode v6
}

