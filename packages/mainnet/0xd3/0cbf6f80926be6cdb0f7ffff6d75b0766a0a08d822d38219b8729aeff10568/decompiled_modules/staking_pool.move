module 0xd30cbf6f80926be6cdb0f7ffff6d75b0766a0a08d822d38219b8729aeff10568::staking_pool {
    struct StakingPool has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>,
        reward_pool: 0x2::balance::Balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>,
        stakers: 0x2::table::Table<address, StakerInfo>,
        total_stakers: u64,
        total_rewards_distributed: u128,
        reward_per_token_stored: u128,
        last_update_time: u64,
        total_rewards_added: u128,
        is_paused: bool,
        min_stake_duration_ms: u64,
    }

    struct StakerInfo has drop, store {
        amount_staked: u128,
        stake_start_time: u64,
        reward_per_token_paid: u128,
        rewards_earned: u128,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Staked has copy, drop {
        staker: address,
        amount: u128,
        total_staked: u128,
        timestamp: u64,
    }

    struct Unstaked has copy, drop {
        staker: address,
        amount: u128,
        rewards_claimed: u128,
        total_staked: u128,
        timestamp: u64,
    }

    struct RewardsClaimed has copy, drop {
        staker: address,
        amount: u128,
        timestamp: u64,
    }

    struct RewardsDeposited has copy, drop {
        amount: u128,
        reward_per_token_increase: u128,
        total_staked: u128,
        timestamp: u64,
    }

    struct PoolPaused has copy, drop {
        timestamp: u64,
    }

    struct PoolUnpaused has copy, drop {
        timestamp: u64,
    }

    struct MinStakeDurationUpdated has copy, drop {
        old_duration: u64,
        new_duration: u64,
        timestamp: u64,
    }

    struct EmergencyWithdrawal has copy, drop {
        admin: address,
        amount: u64,
        timestamp: u64,
    }

    fun claim_pending_rewards(arg0: &mut StakingPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, arg1);
        let v1 = v0.rewards_earned;
        assert!(v1 > 0, 4);
        assert!(v1 <= 18446744073709551615, 11);
        let v2 = (v1 as u64);
        assert!(0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.reward_pool) >= v2, 6);
        v0.rewards_earned = 0;
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>>(0x2::coin::from_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(0x2::balance::split<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg0.reward_pool, v2), arg2), arg1);
        v1
    }

    public entry fun claim_rewards(arg0: &mut StakingPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, StakerInfo>(&arg0.stakers, v0), 1);
        update_reward_per_token_stats(arg0, 0x2::clock::timestamp_ms(arg1));
        update_user_rewards(arg0, v0);
        let v1 = RewardsClaimed{
            staker    : v0,
            amount    : claim_pending_rewards(arg0, v0, arg2),
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<RewardsClaimed>(v1);
    }

    public entry fun deposit_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>, arg2: &0x2::clock::Clock) {
        let v0 = (0x2::coin::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg1) as u128);
        assert!(v0 > 0, 9);
        let v1 = (0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.total_staked) as u128);
        let v2 = 0;
        if (v1 > 0) {
            let v3 = mul_div_down(v0, 1000000000000000000, v1);
            v2 = v3;
            assert!(arg0.reward_per_token_stored + v3 <= 340282366920938463463374607431768211455, 11);
            arg0.reward_per_token_stored = arg0.reward_per_token_stored + v3;
        };
        arg0.total_rewards_added = arg0.total_rewards_added + v0;
        0x2::balance::join<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg0.reward_pool, 0x2::coin::into_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(arg1));
        let v4 = RewardsDeposited{
            amount                    : v0,
            reward_per_token_increase : v2,
            total_staked              : v1,
            timestamp                 : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RewardsDeposited>(v4);
    }

    public entry fun emergency_withdraw_rewards(arg0: &AdminCap, arg1: &mut StakingPool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 9);
        assert!(0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg1.reward_pool) >= arg2, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>>(0x2::coin::from_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(0x2::balance::split<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg1.reward_pool, arg2), arg4), v0);
        let v1 = EmergencyWithdrawal{
            admin     : v0,
            amount    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EmergencyWithdrawal>(v1);
    }

    public fun estimate_apy(arg0: &StakingPool, arg1: u128) : u128 {
        let v0 = (0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.total_staked) as u128);
        if (v0 == 0) {
            return 0
        };
        mul_div_down(arg1, 10000, v0)
    }

    public fun get_last_update_time(arg0: &StakingPool) : u64 {
        arg0.last_update_time
    }

    public fun get_min_stake_duration(arg0: &StakingPool) : u64 {
        arg0.min_stake_duration_ms
    }

    public fun get_pool_stats(arg0: &StakingPool) : (u128, u128, u64, u128, u128, bool, u64) {
        ((0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.total_staked) as u128), (0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.reward_pool) as u128), arg0.total_stakers, arg0.total_rewards_distributed, arg0.total_rewards_added, arg0.is_paused, arg0.min_stake_duration_ms)
    }

    public fun get_reward_per_token_stored(arg0: &StakingPool) : u128 {
        arg0.reward_per_token_stored
    }

    public fun get_reward_pool_balance(arg0: &StakingPool) : u128 {
        (0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.reward_pool) as u128)
    }

    public fun get_staked_amount(arg0: &StakingPool, arg1: address) : u128 {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.stakers, arg1)) {
            return 0
        };
        0x2::table::borrow<address, StakerInfo>(&arg0.stakers, arg1).amount_staked
    }

    public fun get_time_until_unstake(arg0: &StakingPool, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.stakers, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, StakerInfo>(&arg0.stakers, arg1).stake_start_time + arg0.min_stake_duration_ms;
        if (arg2 >= v0) {
            0
        } else {
            v0 - arg2
        }
    }

    public fun get_total_pending_rewards(arg0: &StakingPool, arg1: address) : u128 {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.stakers, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, StakerInfo>(&arg0.stakers, arg1);
        v0.rewards_earned + update_user_rewards_dry_run(arg0, v0)
    }

    public fun get_total_staked(arg0: &StakingPool) : u128 {
        (0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.total_staked) as u128)
    }

    public fun get_user_info(arg0: &StakingPool, arg1: address) : (u128, u64, u128, u128) {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.stakers, arg1)) {
            return (0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, StakerInfo>(&arg0.stakers, arg1);
        (v0.amount_staked, v0.stake_start_time, v0.reward_per_token_paid, v0.rewards_earned)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                        : 0x2::object::new(arg0),
            total_staked              : 0x2::balance::zero<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(),
            reward_pool               : 0x2::balance::zero<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(),
            stakers                   : 0x2::table::new<address, StakerInfo>(arg0),
            total_stakers             : 0,
            total_rewards_distributed : 0,
            reward_per_token_stored   : 0,
            last_update_time          : 0,
            total_rewards_added       : 0,
            is_paused                 : false,
            min_stake_duration_ms     : 259200000,
        };
        0x2::transfer::share_object<StakingPool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &StakingPool) : bool {
        arg0.is_paused
    }

    fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 10);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= (340282366920938463463374607431768211455 as u256), 11);
        (v0 as u128)
    }

    public entry fun pause_pool(arg0: &AdminCap, arg1: &mut StakingPool, arg2: &0x2::clock::Clock) {
        arg1.is_paused = true;
        let v0 = PoolPaused{timestamp: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<PoolPaused>(v0);
    }

    public entry fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = (0x2::coin::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg1) as u128);
        assert!(v0 > 0, 5);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        update_reward_per_token_stats(arg0, v2);
        if (0x2::table::contains<address, StakerInfo>(&arg0.stakers, v1)) {
            update_user_rewards(arg0, v1);
            let v3 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, v1);
            assert!(v3.amount_staked + v0 <= 340282366920938463463374607431768211455, 11);
            v3.amount_staked = v3.amount_staked + v0;
            v3.stake_start_time = v2;
        } else {
            let v4 = StakerInfo{
                amount_staked         : v0,
                stake_start_time      : v2,
                reward_per_token_paid : arg0.reward_per_token_stored,
                rewards_earned        : 0,
            };
            0x2::table::add<address, StakerInfo>(&mut arg0.stakers, v1, v4);
            arg0.total_stakers = arg0.total_stakers + 1;
        };
        0x2::balance::join<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg0.total_staked, 0x2::coin::into_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(arg1));
        let v5 = Staked{
            staker       : v1,
            amount       : v0,
            total_staked : (0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.total_staked) as u128),
            timestamp    : v2,
        };
        0x2::event::emit<Staked>(v5);
    }

    fun try_claim_pending_rewards(arg0: &mut StakingPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, arg1);
        let v1 = v0.rewards_earned;
        if (v1 == 0) {
            return 0
        };
        if (v1 > 18446744073709551615) {
            return 0
        };
        let v2 = (v1 as u64);
        if (0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.reward_pool) < v2) {
            return 0
        };
        v0.rewards_earned = 0;
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>>(0x2::coin::from_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(0x2::balance::split<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg0.reward_pool, v2), arg2), arg1);
        v1
    }

    public entry fun unpause_pool(arg0: &AdminCap, arg1: &mut StakingPool, arg2: &0x2::clock::Clock) {
        arg1.is_paused = false;
        let v0 = PoolUnpaused{timestamp: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<PoolUnpaused>(v0);
    }

    public entry fun unstake(arg0: &mut StakingPool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        assert!(arg1 > 0, 9);
        let v0 = (arg1 as u128);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<address, StakerInfo>(&arg0.stakers, v1), 1);
        let v3 = 0x2::table::borrow<address, StakerInfo>(&arg0.stakers, v1);
        assert!(v2 >= v3.stake_start_time + arg0.min_stake_duration_ms, 3);
        assert!(v3.amount_staked >= v0, 2);
        update_reward_per_token_stats(arg0, v2);
        update_user_rewards(arg0, v1);
        let v4 = try_claim_pending_rewards(arg0, v1, arg3);
        let v5 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>>(0x2::coin::from_balance<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(0x2::balance::split<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&mut arg0.total_staked, arg1), arg3), v1);
        v5.amount_staked = v5.amount_staked - v0;
        if (v5.amount_staked > 0) {
            v5.stake_start_time = v2;
        } else {
            0x2::table::remove<address, StakerInfo>(&mut arg0.stakers, v1);
            arg0.total_stakers = arg0.total_stakers - 1;
        };
        let v6 = Unstaked{
            staker          : v1,
            amount          : v0,
            rewards_claimed : v4,
            total_staked    : (0x2::balance::value<0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest::NEST>(&arg0.total_staked) as u128),
            timestamp       : v2,
        };
        0x2::event::emit<Unstaked>(v6);
    }

    public entry fun update_min_stake_duration(arg0: &AdminCap, arg1: &mut StakingPool, arg2: u64, arg3: &0x2::clock::Clock) {
        arg1.min_stake_duration_ms = arg2;
        let v0 = MinStakeDurationUpdated{
            old_duration : arg1.min_stake_duration_ms,
            new_duration : arg2,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MinStakeDurationUpdated>(v0);
    }

    fun update_reward_per_token_stats(arg0: &mut StakingPool, arg1: u64) {
        arg0.last_update_time = arg1;
    }

    fun update_user_rewards(arg0: &mut StakingPool, arg1: address) {
        let v0 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, arg1);
        if (v0.reward_per_token_paid >= arg0.reward_per_token_stored) {
            return
        };
        let v1 = mul_div_down(v0.amount_staked, arg0.reward_per_token_stored - v0.reward_per_token_paid, 1000000000000000000);
        assert!(v0.rewards_earned + v1 <= 340282366920938463463374607431768211455, 11);
        v0.rewards_earned = v0.rewards_earned + v1;
        v0.reward_per_token_paid = arg0.reward_per_token_stored;
    }

    fun update_user_rewards_dry_run(arg0: &StakingPool, arg1: &StakerInfo) : u128 {
        if (arg1.reward_per_token_paid >= arg0.reward_per_token_stored) {
            return 0
        };
        mul_div_down(arg1.amount_staked, arg0.reward_per_token_stored - arg1.reward_per_token_paid, 1000000000000000000)
    }

    // decompiled from Move bytecode v6
}

