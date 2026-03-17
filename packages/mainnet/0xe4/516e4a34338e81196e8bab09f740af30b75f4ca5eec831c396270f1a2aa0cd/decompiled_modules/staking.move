module 0xe4516e4a34338e81196e8bab09f740af30b75f4ca5eec831c396270f1a2aa0cd::staking {
    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        total_staked: 0x2::balance::Balance<T0>,
        reward_pool: 0x2::balance::Balance<T0>,
        total_staked_amount: u64,
        reward_rate_per_ms: u64,
        last_update_time: u64,
        reward_per_token_stored: u128,
        total_rewards_distributed: u64,
        total_burned: u64,
        paused: bool,
    }

    struct StakeReceipt<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        stake_timestamp: u64,
        reward_per_token_paid: u128,
        pending_rewards: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: address,
        admin: address,
        reward_amount: u64,
        duration_ms: u64,
    }

    struct Staked has copy, drop {
        user: address,
        amount: u64,
        total_staked: u64,
        timestamp: u64,
    }

    struct Unstaked has copy, drop {
        user: address,
        amount: u64,
        total_staked: u64,
        timestamp: u64,
    }

    struct RewardClaimed has copy, drop {
        user: address,
        gross_reward: u64,
        fee_burned: u64,
        net_reward: u64,
        fee_bps: u64,
        timestamp: u64,
    }

    struct RewardsAdded has copy, drop {
        amount: u64,
        new_total: u64,
    }

    struct FeesBurned has copy, drop {
        amount: u64,
        total_burned: u64,
    }

    entry fun add_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        assert!(arg2 > 0, 5);
        update_reward_per_token<T0>(arg0, arg3);
        0x2::balance::join<T0>(&mut arg0.reward_pool, 0x2::coin::into_balance<T0>(arg1));
        let v0 = 0x2::balance::value<T0>(&arg0.reward_pool);
        arg0.reward_rate_per_ms = (((v0 as u128) * 1000000000000 / (arg2 as u128)) as u64);
        let v1 = RewardsAdded{
            amount    : 0x2::coin::value<T0>(&arg1),
            new_total : v0,
        };
        0x2::event::emit<RewardsAdded>(v1);
    }

    fun calculate_current_rpt<T0>(arg0: &StakingPool<T0>, arg1: &0x2::clock::Clock) : u128 {
        if (arg0.total_staked_amount == 0) {
            return arg0.reward_per_token_stored
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 > arg0.last_update_time) {
            v0 - arg0.last_update_time
        } else {
            0
        };
        let v2 = (v1 as u128) * (arg0.reward_rate_per_ms as u128) / 1000000000000;
        let v3 = (0x2::balance::value<T0>(&arg0.reward_pool) as u128);
        let v4 = if (v2 > v3) {
            v3
        } else {
            v2
        };
        arg0.reward_per_token_stored + v4 * 1000000000000000000 / (arg0.total_staked_amount as u128)
    }

    fun calculate_earned<T0>(arg0: &StakingPool<T0>, arg1: &StakeReceipt<T0>) : u64 {
        arg1.pending_rewards + (((arg1.amount as u128) * (arg0.reward_per_token_stored - arg1.reward_per_token_paid) / 1000000000000000000) as u64)
    }

    fun calculate_fee_bps(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg1 > arg0) {
            arg1 - arg0
        } else {
            0
        };
        if (v0 >= 2592000000) {
            return 1000
        };
        7500 - (((v0 as u128) * ((7500 - 1000) as u128) / (2592000000 as u128)) as u64)
    }

    entry fun claim_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: &mut StakeReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.owner == v0, 2);
        update_reward_per_token<T0>(arg0, arg2);
        let v1 = calculate_earned<T0>(arg0, arg1);
        assert!(v1 > 0, 4);
        assert!(0x2::balance::value<T0>(&arg0.reward_pool) >= v1, 3);
        arg1.reward_per_token_paid = arg0.reward_per_token_stored;
        arg1.pending_rewards = 0;
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = calculate_fee_bps(arg1.stake_timestamp, v2);
        let v4 = (((v1 as u128) * (v3 as u128) / (10000 as u128)) as u64);
        let v5 = v1 - v4;
        arg1.stake_timestamp = v2;
        let v6 = 0x2::balance::split<T0>(&mut arg0.reward_pool, v1);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v4), arg3), @0x0);
            arg0.total_burned = arg0.total_burned + v4;
            let v7 = FeesBurned{
                amount       : v4,
                total_burned : arg0.total_burned,
            };
            0x2::event::emit<FeesBurned>(v7);
        };
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + v5;
        let v8 = RewardClaimed{
            user         : v0,
            gross_reward : v1,
            fee_burned   : v4,
            net_reward   : v5,
            fee_bps      : v3,
            timestamp    : v2,
        };
        0x2::event::emit<RewardClaimed>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg3), v0);
    }

    entry fun create_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 5);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = StakingPool<T0>{
            id                        : 0x2::object::new(arg3),
            admin                     : v1,
            total_staked              : 0x2::balance::zero<T0>(),
            reward_pool               : 0x2::coin::into_balance<T0>(arg0),
            total_staked_amount       : 0,
            reward_rate_per_ms        : (((v0 as u128) * 1000000000000 / (arg1 as u128)) as u64),
            last_update_time          : 0x2::clock::timestamp_ms(arg2),
            reward_per_token_stored   : 0,
            total_rewards_distributed : 0,
            total_burned              : 0,
            paused                    : false,
        };
        let v3 = PoolCreated{
            pool_id       : 0x2::object::uid_to_address(&v2.id),
            admin         : v1,
            reward_amount : v0,
            duration_ms   : arg1,
        };
        0x2::event::emit<PoolCreated>(v3);
        0x2::transfer::share_object<StakingPool<T0>>(v2);
    }

    entry fun donate_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) {
        update_reward_per_token<T0>(arg0, arg2);
        let v0 = 0x2::balance::value<T0>(&arg0.reward_pool);
        0x2::balance::join<T0>(&mut arg0.reward_pool, 0x2::coin::into_balance<T0>(arg1));
        if (arg0.reward_rate_per_ms > 0 && v0 > 0) {
            let v1 = (((v0 as u128) * 1000000000000 / (arg0.reward_rate_per_ms as u128)) as u64);
            if (v1 > 0) {
                arg0.reward_rate_per_ms = (((0x2::balance::value<T0>(&arg0.reward_pool) as u128) * 1000000000000 / (v1 as u128)) as u64);
            };
        };
        let v2 = RewardsAdded{
            amount    : 0x2::coin::value<T0>(&arg1),
            new_total : 0x2::balance::value<T0>(&arg0.reward_pool),
        };
        0x2::event::emit<RewardsAdded>(v2);
    }

    entry fun emergency_withdraw_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        update_reward_per_token<T0>(arg0, arg1);
        let v0 = 0x2::balance::value<T0>(&arg0.reward_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool, v0), arg2), arg0.admin);
        };
        arg0.reward_rate_per_ms = 0;
        arg0.paused = true;
    }

    public fun get_current_fee_bps<T0>(arg0: &StakeReceipt<T0>, arg1: &0x2::clock::Clock) : u64 {
        calculate_fee_bps(arg0.stake_timestamp, 0x2::clock::timestamp_ms(arg1))
    }

    public fun get_pending_rewards<T0>(arg0: &StakingPool<T0>, arg1: &StakeReceipt<T0>, arg2: &0x2::clock::Clock) : u64 {
        arg1.pending_rewards + (((arg1.amount as u128) * (calculate_current_rpt<T0>(arg0, arg2) - arg1.reward_per_token_paid) / 1000000000000000000) as u64)
    }

    public fun get_reward_pool_balance<T0>(arg0: &StakingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward_pool)
    }

    public fun get_stake_amount<T0>(arg0: &StakeReceipt<T0>) : u64 {
        arg0.amount
    }

    public fun get_total_burned<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.total_burned
    }

    public fun get_total_staked<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.total_staked_amount
    }

    entry fun set_paused<T0>(arg0: &mut StakingPool<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.paused = arg1;
    }

    entry fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        update_reward_per_token<T0>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg0.total_staked, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_staked_amount = arg0.total_staked_amount + v0;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = StakeReceipt<T0>{
            id                    : 0x2::object::new(arg3),
            owner                 : v2,
            amount                : v0,
            stake_timestamp       : v1,
            reward_per_token_paid : arg0.reward_per_token_stored,
            pending_rewards       : 0,
        };
        let v4 = Staked{
            user         : v2,
            amount       : v0,
            total_staked : arg0.total_staked_amount,
            timestamp    : v1,
        };
        0x2::event::emit<Staked>(v4);
        0x2::transfer::transfer<StakeReceipt<T0>>(v3, v2);
    }

    entry fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: StakeReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.owner == v0, 2);
        update_reward_per_token<T0>(arg0, arg2);
        let StakeReceipt {
            id                    : v1,
            owner                 : _,
            amount                : v3,
            stake_timestamp       : v4,
            reward_per_token_paid : v5,
            pending_rewards       : v6,
        } = arg1;
        let v7 = v6 + (((v3 as u128) * (arg0.reward_per_token_stored - v5) / 1000000000000000000) as u64);
        let v8 = 0x2::clock::timestamp_ms(arg2);
        if (v7 > 0 && 0x2::balance::value<T0>(&arg0.reward_pool) >= v7) {
            let v9 = calculate_fee_bps(v4, v8);
            let v10 = (((v7 as u128) * (v9 as u128) / (10000 as u128)) as u64);
            let v11 = v7 - v10;
            let v12 = 0x2::balance::split<T0>(&mut arg0.reward_pool, v7);
            if (v10 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, v10), arg3), @0x0);
                arg0.total_burned = arg0.total_burned + v10;
                let v13 = FeesBurned{
                    amount       : v10,
                    total_burned : arg0.total_burned,
                };
                0x2::event::emit<FeesBurned>(v13);
            };
            arg0.total_rewards_distributed = arg0.total_rewards_distributed + v11;
            let v14 = RewardClaimed{
                user         : v0,
                gross_reward : v7,
                fee_burned   : v10,
                net_reward   : v11,
                fee_bps      : v9,
                timestamp    : v8,
            };
            0x2::event::emit<RewardClaimed>(v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg3), v0);
        };
        0x2::object::delete(v1);
        arg0.total_staked_amount = arg0.total_staked_amount - v3;
        let v15 = Unstaked{
            user         : v0,
            amount       : v3,
            total_staked : arg0.total_staked_amount,
            timestamp    : v8,
        };
        0x2::event::emit<Unstaked>(v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, v3), arg3), v0);
    }

    fun update_reward_per_token<T0>(arg0: &mut StakingPool<T0>, arg1: &0x2::clock::Clock) {
        arg0.reward_per_token_stored = calculate_current_rpt<T0>(arg0, arg1);
        arg0.last_update_time = 0x2::clock::timestamp_ms(arg1);
    }

    // decompiled from Move bytecode v6
}

