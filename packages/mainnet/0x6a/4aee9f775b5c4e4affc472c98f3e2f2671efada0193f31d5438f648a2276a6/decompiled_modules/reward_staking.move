module 0x6a4aee9f775b5c4e4affc472c98f3e2f2671efada0193f31d5438f648a2276a6::reward_staking {
    struct TokensStaked has copy, drop {
        user: address,
        amount: u64,
    }

    struct TokensUnstaked has copy, drop {
        user: address,
        amount: u64,
        reward: u64,
    }

    struct TokensEmergencyUnstake has copy, drop {
        user: address,
        amount: u64,
        reward: u64,
    }

    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        lock_duration: u64,
        reward_pool: 0x2::balance::Balance<T0>,
        total_staked: u64,
        minimum_staking_threshold: u64,
        emergency_withdrawn_tax_bank: 0x2::balance::Balance<T0>,
    }

    struct Deposit<phantom T0> has store, key {
        id: 0x2::object::UID,
        user: address,
        staked_amount: 0x2::balance::Balance<T0>,
        claimed_reward: u64,
        pool_lock_duration: u64,
        unlock_time: u64,
        is_withdrawn: bool,
        emergency_withdrawn: bool,
    }

    struct StakerProfile has store, key {
        id: 0x2::object::UID,
        user: address,
        staked_30days: u64,
        staked_90days: u64,
        staked_180days: u64,
        staked_365days: u64,
        total_staked_across_all_pools: u64,
    }

    struct StakingDeployerCap has key {
        id: 0x2::object::UID,
    }

    public fun calculate_rewards(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 1000000000;
        (((arg0 as u128) * (v0 as u128) / (arg1 as u128) * (arg2 as u128) / (v0 as u128)) as u64)
    }

    public entry fun create_default_pools<T0>(arg0: &StakingDeployerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0>{
            id                           : 0x2::object::new(arg1),
            lock_duration                : 2592000,
            reward_pool                  : 0x2::balance::zero<T0>(),
            total_staked                 : 0,
            minimum_staking_threshold    : 1 * 1000000000 / 10,
            emergency_withdrawn_tax_bank : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<StakingPool<T0>>(v0);
        let v1 = StakingPool<T0>{
            id                           : 0x2::object::new(arg1),
            lock_duration                : 7776000,
            reward_pool                  : 0x2::balance::zero<T0>(),
            total_staked                 : 0,
            minimum_staking_threshold    : 1 * 1000000000 / 10,
            emergency_withdrawn_tax_bank : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<StakingPool<T0>>(v1);
        let v2 = StakingPool<T0>{
            id                           : 0x2::object::new(arg1),
            lock_duration                : 15552000,
            reward_pool                  : 0x2::balance::zero<T0>(),
            total_staked                 : 0,
            minimum_staking_threshold    : 1 * 1000000000 / 10,
            emergency_withdrawn_tax_bank : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<StakingPool<T0>>(v2);
        let v3 = StakingPool<T0>{
            id                           : 0x2::object::new(arg1),
            lock_duration                : 31536000,
            reward_pool                  : 0x2::balance::zero<T0>(),
            total_staked                 : 0,
            minimum_staking_threshold    : 1 * 1000000000 / 10,
            emergency_withdrawn_tax_bank : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<StakingPool<T0>>(v3);
    }

    public entry fun create_staker_profile(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakerProfile{
            id                            : 0x2::object::new(arg0),
            user                          : 0x2::tx_context::sender(arg0),
            staked_30days                 : 0,
            staked_90days                 : 0,
            staked_180days                : 0,
            staked_365days                : 0,
            total_staked_across_all_pools : 0,
        };
        0x2::transfer::transfer<StakerProfile>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun emergency_withdraw_coins<T0>(arg0: &mut StakingPool<T0>, arg1: &mut StakerProfile, arg2: &mut Deposit<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.is_withdrawn == false, 4);
        if (arg0.lock_duration == 2592000) {
            arg1.staked_30days = arg1.staked_30days - 0x2::balance::value<T0>(&arg2.staked_amount);
        } else if (arg0.lock_duration == 7776000) {
            arg1.staked_90days = arg1.staked_90days - 0x2::balance::value<T0>(&arg2.staked_amount);
        } else if (arg0.lock_duration == 15552000) {
            arg1.staked_180days = arg1.staked_180days - 0x2::balance::value<T0>(&arg2.staked_amount);
        } else if (arg0.lock_duration == 31536000) {
            arg1.staked_365days = arg1.staked_365days - 0x2::balance::value<T0>(&arg2.staked_amount);
        };
        arg1.total_staked_across_all_pools = arg1.total_staked_across_all_pools - 0x2::balance::value<T0>(&arg2.staked_amount);
        arg0.total_staked = arg0.total_staked - 0x2::balance::value<T0>(&arg2.staked_amount);
        let v0 = 0x2::balance::value<T0>(&arg2.staked_amount);
        let v1 = v0 * 20000 / 100000;
        0x2::balance::join<T0>(&mut arg0.emergency_withdrawn_tax_bank, 0x2::balance::split<T0>(&mut arg2.staked_amount, v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.staked_amount, v0 - v1), arg3), 0x2::tx_context::sender(arg3));
        arg2.is_withdrawn = true;
        arg2.emergency_withdrawn = true;
        let v2 = TokensEmergencyUnstake{
            user   : 0x2::tx_context::sender(arg3),
            amount : 0x2::balance::value<T0>(&arg2.staked_amount),
            reward : 0,
        };
        0x2::event::emit<TokensEmergencyUnstake>(v2);
    }

    public entry fun fund_reward_pool<T0>(arg0: &mut StakingDeployerCap, arg1: &mut StakingPool<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        0x2::balance::join<T0>(&mut arg1.reward_pool, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg3));
    }

    public entry fun get_deposit_claimed_reward<T0>(arg0: &Deposit<T0>) : u64 {
        arg0.claimed_reward
    }

    public entry fun get_deposit_is_withdrawn<T0>(arg0: &Deposit<T0>) : bool {
        arg0.is_withdrawn
    }

    public entry fun get_deposit_staked_amount<T0>(arg0: &Deposit<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.staked_amount)
    }

    public entry fun get_deposit_unlock_time<T0>(arg0: &Deposit<T0>) : u64 {
        arg0.unlock_time
    }

    public entry fun get_deposit_user<T0>(arg0: &Deposit<T0>) : address {
        arg0.user
    }

    public entry fun get_pool_lock_duration<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.lock_duration
    }

    public entry fun get_pool_reward_pool<T0>(arg0: &StakingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward_pool)
    }

    public entry fun get_pool_total_staked<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.total_staked
    }

    public entry fun get_staker_profile_staked_180days(arg0: &StakerProfile) : u64 {
        arg0.staked_180days
    }

    public entry fun get_staker_profile_staked_30days(arg0: &StakerProfile) : u64 {
        arg0.staked_30days
    }

    public entry fun get_staker_profile_staked_365days(arg0: &StakerProfile) : u64 {
        arg0.staked_365days
    }

    public entry fun get_staker_profile_staked_90days(arg0: &StakerProfile) : u64 {
        arg0.staked_90days
    }

    public entry fun get_staker_profile_total_staked_across_all_pools(arg0: &StakerProfile) : u64 {
        arg0.total_staked_across_all_pools
    }

    public entry fun get_staker_profile_user(arg0: &StakerProfile) : address {
        arg0.user
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingDeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<StakingDeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun stake_coins<T0>(arg0: &mut StakingPool<T0>, arg1: &mut StakerProfile, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(arg3 >= arg0.minimum_staking_threshold, 3);
        if (arg0.lock_duration == 2592000) {
            arg1.staked_30days = arg1.staked_30days + arg3;
        } else if (arg0.lock_duration == 7776000) {
            arg1.staked_90days = arg1.staked_90days + arg3;
        } else if (arg0.lock_duration == 15552000) {
            arg1.staked_180days = arg1.staked_180days + arg3;
        } else if (arg0.lock_duration == 31536000) {
            arg1.staked_365days = arg1.staked_365days + arg3;
        };
        arg1.total_staked_across_all_pools = arg1.total_staked_across_all_pools + arg3;
        arg0.total_staked = arg0.total_staked + arg3;
        let v0 = Deposit<T0>{
            id                  : 0x2::object::new(arg5),
            user                : 0x2::tx_context::sender(arg5),
            staked_amount       : 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg3),
            claimed_reward      : 0,
            pool_lock_duration  : arg0.lock_duration,
            unlock_time         : 0x2::clock::timestamp_ms(arg4) / 1000 + arg0.lock_duration,
            is_withdrawn        : false,
            emergency_withdrawn : false,
        };
        0x2::transfer::public_transfer<Deposit<T0>>(v0, 0x2::tx_context::sender(arg5));
        let v1 = TokensStaked{
            user   : 0x2::tx_context::sender(arg5),
            amount : arg3,
        };
        0x2::event::emit<TokensStaked>(v1);
    }

    public entry fun unstake_coins<T0>(arg0: &mut StakingPool<T0>, arg1: &mut StakerProfile, arg2: &mut Deposit<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.is_withdrawn == false, 4);
        assert!(arg2.unlock_time <= 0x2::clock::timestamp_ms(arg3) / 1000, 5);
        let v0 = calculate_rewards(0x2::balance::value<T0>(&arg2.staked_amount), arg0.total_staked, 0x2::balance::value<T0>(&arg0.reward_pool));
        let v1 = 0x2::balance::value<T0>(&arg2.staked_amount);
        if (arg0.lock_duration == 2592000) {
            arg1.staked_30days = arg1.staked_30days - v1;
        } else if (arg0.lock_duration == 7776000) {
            arg1.staked_90days = arg1.staked_90days - v1;
        } else if (arg0.lock_duration == 15552000) {
            arg1.staked_180days = arg1.staked_180days - v1;
        } else if (arg0.lock_duration == 31536000) {
            arg1.staked_365days = arg1.staked_365days - v1;
        };
        arg1.total_staked_across_all_pools = arg1.total_staked_across_all_pools - v1;
        arg0.total_staked = arg0.total_staked - v1;
        let v2 = 0x2::balance::split<T0>(&mut arg0.reward_pool, v0);
        0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut arg2.staked_amount, v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg4), 0x2::tx_context::sender(arg4));
        arg2.is_withdrawn = true;
        arg2.claimed_reward = v0;
        let v3 = TokensUnstaked{
            user   : 0x2::tx_context::sender(arg4),
            amount : 0x2::balance::value<T0>(&arg2.staked_amount),
            reward : v0,
        };
        0x2::event::emit<TokensUnstaked>(v3);
    }

    public entry fun withdraw_emergency_fees<T0>(arg0: &mut StakingDeployerCap, arg1: &mut StakingPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.emergency_withdrawn_tax_bank, 0x2::balance::value<T0>(&arg1.emergency_withdrawn_tax_bank)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

