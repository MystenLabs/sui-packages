module 0x48f601401950feba696e1c59b7e7275181922cf311486ef69ee2c40d7b65f0cd::staking_pool {
    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        total_staked: u64,
        staked_balance: 0x2::balance::Balance<T0>,
        reward_per_token_stored: u128,
        reward_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct StakePosition<phantom T0> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        amount: u64,
        reward_debt: u128,
        accrued_rewards: u64,
    }

    struct RewardsDeposited has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct Staked has copy, drop {
        pool_id: 0x2::object::ID,
        staker: address,
        amount: u64,
    }

    struct Unstaked has copy, drop {
        pool_id: 0x2::object::ID,
        staker: address,
        amount: u64,
        rewards: u64,
    }

    struct RewardsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        staker: address,
        amount: u64,
    }

    public fun claim<T0>(arg0: &mut StakingPool<T0>, arg1: &mut StakePosition<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<StakingPool<T0>>(arg0), 2);
        let v0 = arg1.accrued_rewards + pending_rewards<T0>(arg0, arg1);
        assert!(v0 > 0, 3);
        arg1.accrued_rewards = 0;
        arg1.reward_debt = arg0.reward_per_token_stored;
        let v1 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_balance, v0), arg2), v1);
        let v2 = RewardsClaimed{
            pool_id : 0x2::object::id<StakingPool<T0>>(arg0),
            staker  : v1,
            amount  : v0,
        };
        0x2::event::emit<RewardsClaimed>(v2);
    }

    public fun claimable<T0>(arg0: &StakingPool<T0>, arg1: &StakePosition<T0>) : u64 {
        arg1.accrued_rewards + pending_rewards<T0>(arg0, arg1)
    }

    public(friend) fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = StakingPool<T0>{
            id                      : 0x2::object::new(arg0),
            total_staked            : 0,
            staked_balance          : 0x2::balance::zero<T0>(),
            reward_per_token_stored : 0,
            reward_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<StakingPool<T0>>(v0);
        0x2::object::id<StakingPool<T0>>(&v0)
    }

    public fun deposit_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        if (arg0.total_staked > 0 && v0 > 0) {
            arg0.reward_per_token_stored = arg0.reward_per_token_stored + (v0 as u128) * 1000000000 / (arg0.total_staked as u128);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = RewardsDeposited{
            pool_id : 0x2::object::id<StakingPool<T0>>(arg0),
            amount  : v0,
        };
        0x2::event::emit<RewardsDeposited>(v1);
    }

    fun pending_rewards<T0>(arg0: &StakingPool<T0>, arg1: &StakePosition<T0>) : u64 {
        let v0 = arg0.reward_per_token_stored - arg1.reward_debt;
        if (v0 == 0) {
            return 0
        };
        (((arg1.amount as u128) * v0 / 1000000000) as u64)
    }

    public fun position_amount<T0>(arg0: &StakePosition<T0>) : u64 {
        arg0.amount
    }

    public fun position_pool_id<T0>(arg0: &StakePosition<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun reward_per_token_stored<T0>(arg0: &StakingPool<T0>) : u128 {
        arg0.reward_per_token_stored
    }

    public fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = StakePosition<T0>{
            id              : 0x2::object::new(arg2),
            pool_id         : 0x2::object::id<StakingPool<T0>>(arg0),
            amount          : v0,
            reward_debt     : arg0.reward_per_token_stored,
            accrued_rewards : 0,
        };
        0x2::balance::join<T0>(&mut arg0.staked_balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_staked = arg0.total_staked + v0;
        let v2 = 0x2::tx_context::sender(arg2);
        0x2::transfer::transfer<StakePosition<T0>>(v1, v2);
        let v3 = Staked{
            pool_id : 0x2::object::id<StakingPool<T0>>(arg0),
            staker  : v2,
            amount  : v0,
        };
        0x2::event::emit<Staked>(v3);
    }

    public fun total_staked<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.total_staked
    }

    public fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: StakePosition<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<StakingPool<T0>>(arg0), 2);
        let v0 = arg1.accrued_rewards + pending_rewards<T0>(arg0, &arg1);
        let StakePosition {
            id              : v1,
            pool_id         : _,
            amount          : v3,
            reward_debt     : _,
            accrued_rewards : _,
        } = arg1;
        0x2::object::delete(v1);
        arg0.total_staked = arg0.total_staked - v3;
        let v6 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked_balance, v3), arg2), v6);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_balance, v0), arg2), v6);
        };
        let v7 = Unstaked{
            pool_id : 0x2::object::id<StakingPool<T0>>(arg0),
            staker  : v6,
            amount  : v3,
            rewards : v0,
        };
        0x2::event::emit<Unstaked>(v7);
    }

    // decompiled from Move bytecode v6
}

