module 0xb15fd9a0a1c346d1b8f69b97017164daa5565bbda54170af7ddcca5a7c1bd1fe::staking {
    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
        pool_created: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        start_time: u64,
        checkpoint_a: u64,
        end_time: u64,
        reward_per_second: u64,
        last_reward_time: u64,
        acc_reward_per_share: u128,
        total_weighted_shares: u64,
        total_reward_debt: u128,
        paused: bool,
        reward_balance: 0x2::balance::Balance<T0>,
        staked_balance: 0x2::balance::Balance<T0>,
    }

    struct StakingPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        amount: u64,
        tier: u8,
        weighted_shares: u64,
        reward_debt: u128,
        unlock_time: u64,
        staked_at: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        start_time: u64,
        checkpoint_a: u64,
        end_time: u64,
        reward_per_second: u64,
    }

    struct RewardsFunded has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        total_reward_balance: u64,
    }

    struct Staked has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        user: address,
        amount: u64,
        tier: u8,
        weighted_shares: u64,
        unlock_time: u64,
    }

    struct Unstaked has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        user: address,
        principal: u64,
        rewards: u64,
    }

    struct RewardsSwept has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct PoolPaused has copy, drop {
        pool_id: 0x2::object::ID,
        reason: vector<u8>,
    }

    struct PoolUnpaused has copy, drop {
        pool_id: 0x2::object::ID,
    }

    fun calculate_pending_rewards<T0>(arg0: &StakingPool<T0>, arg1: &StakingPosition<T0>) : u64 {
        ((arg0.acc_reward_per_share * (arg1.weighted_shares as u128) / 1000000000000000000 - arg1.reward_debt) as u64)
    }

    public fun check_reward_sufficiency<T0>(arg0: &StakingPool<T0>, arg1: &0x2::clock::Clock) : (bool, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = arg0.acc_reward_per_share;
        let v2 = v1;
        let v3 = if (v0 > arg0.end_time) {
            arg0.end_time
        } else {
            v0
        };
        let v4 = if (!arg0.paused) {
            if (v3 > arg0.last_reward_time) {
                arg0.total_weighted_shares > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            v2 = v1 + ((v3 - arg0.last_reward_time) as u128) * (arg0.reward_per_second as u128) * 1000000000000000000 / (arg0.total_weighted_shares as u128);
        };
        let v5 = v2 * (arg0.total_weighted_shares as u128) / 1000000000000000000;
        let v6 = if (v5 > arg0.total_reward_debt) {
            ((v5 - arg0.total_reward_debt) as u64)
        } else {
            0
        };
        let v7 = 0x2::balance::value<T0>(&arg0.reward_balance);
        if (v0 >= arg0.end_time) {
            return (v7 >= v6, v6, v7)
        };
        let v8 = v6 + (arg0.end_time - v0) * arg0.reward_per_second;
        (v7 >= v8, v8, v7)
    }

    public fun create_pool<T0>(arg0: &mut SuperAdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(!arg0.pool_created, 13);
        assert!(arg1 < arg2, 6);
        assert!(arg2 < arg3, 6);
        arg0.pool_created = true;
        let v0 = StakingPool<T0>{
            id                    : 0x2::object::new(arg5),
            start_time            : arg1,
            checkpoint_a          : arg2,
            end_time              : arg3,
            reward_per_second     : arg4,
            last_reward_time      : arg1,
            acc_reward_per_share  : 0,
            total_weighted_shares : 0,
            total_reward_debt     : 0,
            paused                : false,
            reward_balance        : 0x2::balance::zero<T0>(),
            staked_balance        : 0x2::balance::zero<T0>(),
        };
        let v1 = PoolCreated{
            pool_id           : 0x2::object::id<StakingPool<T0>>(&v0),
            start_time        : arg1,
            checkpoint_a      : arg2,
            end_time          : arg3,
            reward_per_second : arg4,
        };
        0x2::event::emit<PoolCreated>(v1);
        0x2::transfer::share_object<StakingPool<T0>>(v0);
        AdminCap{id: 0x2::object::new(arg5)}
    }

    public entry fun fund_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.reward_balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = RewardsFunded{
            pool_id              : 0x2::object::id<StakingPool<T0>>(arg0),
            amount               : 0x2::coin::value<T0>(&arg2),
            total_reward_balance : 0x2::balance::value<T0>(&arg0.reward_balance),
        };
        0x2::event::emit<RewardsFunded>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{
            id           : 0x2::object::new(arg0),
            pool_created : false,
        };
        0x2::transfer::transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused<T0>(arg0: &StakingPool<T0>) : bool {
        arg0.paused
    }

    public fun is_unlocked<T0>(arg0: &StakingPosition<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.unlock_time
    }

    public entry fun pause<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert!(!arg0.paused, 8);
        update_pool<T0>(arg0, 0x2::clock::timestamp_ms(arg2) / 1000);
        arg0.paused = true;
        let v0 = PoolPaused{
            pool_id : 0x2::object::id<StakingPool<T0>>(arg0),
            reason  : b"manual",
        };
        0x2::event::emit<PoolPaused>(v0);
    }

    public fun pending_rewards<T0>(arg0: &StakingPool<T0>, arg1: &StakingPosition<T0>, arg2: &0x2::clock::Clock) : u64 {
        if (arg0.paused) {
            return ((arg0.acc_reward_per_share * (arg1.weighted_shares as u128) / 1000000000000000000 - arg1.reward_debt) as u64)
        };
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = if (v0 > arg0.end_time) {
            arg0.end_time
        } else {
            v0
        };
        let v2 = arg0.acc_reward_per_share;
        let v3 = v2;
        if (v1 > arg0.last_reward_time && arg0.total_weighted_shares > 0) {
            v3 = v2 + ((v1 - arg0.last_reward_time) as u128) * (arg0.reward_per_second as u128) * 1000000000000000000 / (arg0.total_weighted_shares as u128);
        };
        ((v3 * (arg1.weighted_shares as u128) / 1000000000000000000 - arg1.reward_debt) as u64)
    }

    public fun pool_info<T0>(arg0: &StakingPool<T0>) : (u64, u64, u64, u64, u64, u64, u64, bool) {
        (arg0.start_time, arg0.checkpoint_a, arg0.end_time, arg0.reward_per_second, arg0.total_weighted_shares, 0x2::balance::value<T0>(&arg0.staked_balance), 0x2::balance::value<T0>(&arg0.reward_balance), arg0.paused)
    }

    public fun position_info<T0>(arg0: &StakingPosition<T0>) : (0x2::object::ID, u64, u8, u64, u64, u64) {
        (arg0.pool_id, arg0.amount, arg0.tier, arg0.weighted_shares, arg0.unlock_time, arg0.staked_at)
    }

    public fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakingPosition<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(!arg0.paused, 8);
        assert!(v1 > 0, 5);
        assert!(v0 >= arg0.start_time, 0);
        assert!(v0 < arg0.end_time, 1);
        assert!(arg2 == 1 || arg2 == 2, 4);
        if (arg2 == 1) {
            assert!(v0 < arg0.checkpoint_a, 2);
        };
        update_pool<T0>(arg0, v0);
        let v2 = if (arg2 == 1) {
            1
        } else {
            2
        };
        let v3 = v1 * v2;
        arg0.total_weighted_shares = arg0.total_weighted_shares + v3;
        let v4 = arg0.acc_reward_per_share * (v3 as u128) / 1000000000000000000;
        arg0.total_reward_debt = arg0.total_reward_debt + v4;
        let v5 = if (arg2 == 1) {
            arg0.checkpoint_a
        } else {
            arg0.end_time
        };
        0x2::balance::join<T0>(&mut arg0.staked_balance, 0x2::coin::into_balance<T0>(arg1));
        let v6 = StakingPosition<T0>{
            id              : 0x2::object::new(arg4),
            pool_id         : 0x2::object::id<StakingPool<T0>>(arg0),
            amount          : v1,
            tier            : arg2,
            weighted_shares : v3,
            reward_debt     : v4,
            unlock_time     : v5,
            staked_at       : v0,
        };
        let v7 = Staked{
            pool_id         : 0x2::object::id<StakingPool<T0>>(arg0),
            position_id     : 0x2::object::id<StakingPosition<T0>>(&v6),
            user            : 0x2::tx_context::sender(arg4),
            amount          : v1,
            tier            : arg2,
            weighted_shares : v3,
            unlock_time     : v5,
        };
        0x2::event::emit<Staked>(v7);
        v6
    }

    public entry fun stake_and_transfer<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = stake<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<StakingPosition<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun sweep_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 > arg0.end_time, 7);
        let v0 = 0x2::balance::value<T0>(&arg0.reward_balance);
        let v1 = RewardsSwept{
            pool_id : 0x2::object::id<StakingPool<T0>>(arg0),
            amount  : v0,
        };
        0x2::event::emit<RewardsSwept>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun tier_a() : u8 {
        1
    }

    public fun tier_b() : u8 {
        2
    }

    public entry fun unpause<T0>(arg0: &mut StakingPool<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert!(arg0.paused, 9);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = if (v0 > arg0.end_time) {
            arg0.end_time
        } else {
            v0
        };
        arg0.last_reward_time = v1;
        arg0.paused = false;
        let v2 = PoolUnpaused{pool_id: 0x2::object::id<StakingPool<T0>>(arg0)};
        0x2::event::emit<PoolUnpaused>(v2);
    }

    public entry fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: StakingPosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(arg1.pool_id == 0x2::object::id<StakingPool<T0>>(arg0), 12);
        assert!(v0 >= arg1.unlock_time, 3);
        update_pool<T0>(arg0, v0);
        let v1 = calculate_pending_rewards<T0>(arg0, &arg1);
        assert!(v1 > 0, 10);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= v1, 11);
        arg0.total_weighted_shares = arg0.total_weighted_shares - arg1.weighted_shares;
        arg0.total_reward_debt = arg0.total_reward_debt - arg1.reward_debt;
        let v2 = 0x2::balance::split<T0>(&mut arg0.staked_balance, arg1.amount);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut arg0.reward_balance, v1));
        };
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = Unstaked{
            pool_id     : 0x2::object::id<StakingPool<T0>>(arg0),
            position_id : 0x2::object::id<StakingPosition<T0>>(&arg1),
            user        : v3,
            principal   : arg1.amount,
            rewards     : v1,
        };
        0x2::event::emit<Unstaked>(v4);
        let StakingPosition {
            id              : v5,
            pool_id         : _,
            amount          : _,
            tier            : _,
            weighted_shares : _,
            reward_debt     : _,
            unlock_time     : _,
            staked_at       : _,
        } = arg1;
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg3), v3);
    }

    fun update_pool<T0>(arg0: &mut StakingPool<T0>, arg1: u64) {
        if (arg0.paused) {
            return
        };
        let v0 = if (arg1 > arg0.end_time) {
            arg0.end_time
        } else {
            arg1
        };
        if (v0 <= arg0.last_reward_time) {
            return
        };
        if (arg0.total_weighted_shares == 0) {
            arg0.last_reward_time = v0;
            return
        };
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + ((v0 - arg0.last_reward_time) as u128) * (arg0.reward_per_second as u128) * 1000000000000000000 / (arg0.total_weighted_shares as u128);
        arg0.last_reward_time = v0;
    }

    // decompiled from Move bytecode v6
}

