module 0x305d1a8a9e9dccb4c1fcb7ffb8228dd27bb1145696ec77c5dd0cbab550436ee9::staking {
    struct CreateStakePoolEvent has copy, drop {
        staking_pool_id: 0x2::object::ID,
    }

    struct CreateStakeLockEvent has copy, drop {
        staking_lock_id: 0x2::object::ID,
        amount: u64,
        staking_start_timestamp: u64,
    }

    struct ExtendStakeLockEvent has copy, drop {
        staking_lock_id: 0x2::object::ID,
        amount: u64,
        lock_time: u64,
        staking_start_timestamp: u64,
    }

    struct WithdrawStakeEvent has copy, drop {
        owner: address,
        staking_lock_id: 0x2::object::ID,
        amount: u64,
        staking_start_timestamp: u64,
        reward: u64,
        state_time: u64,
    }

    struct StakingPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        stake_balance: 0x2::balance::Balance<T0>,
        reward_balance: 0x2::balance::Balance<T1>,
        reward_per_nanosecs: u64,
        accum_reward: u256,
        last_updated: u64,
        stakers: 0x2::bag::Bag,
        scale: u64,
        owner: address,
        total_stake_amount: u64,
        cliamed_reward: u64,
        penalty_percentage: u64,
        end_timestamp: u64,
        version: u64,
    }

    struct StakingLock has store, key {
        id: 0x2::object::UID,
        amount: u64,
        earned_reward: u64,
        unobtainable_reward: u64,
        earned_per_token_store: u256,
        staking_start_timestamp: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun accum_rewards_since_last_updated<T0, T1>(arg0: &StakingPool<T0, T1>, arg1: u64) : u256 {
        let v0 = arg1 - arg0.last_updated;
        0x1::debug::print<u64>(&v0);
        let v1 = 0x2::balance::value<T0>(&arg0.stake_balance);
        0x1::debug::print<u64>(&v1);
        if (v1 == 0) {
            0
        } else {
            let v3 = (v0 as u256) * (arg0.reward_per_nanosecs as u256) * (arg0.scale as u256) / (v1 as u256);
            0x1::debug::print<u256>(&v3);
            v3
        }
    }

    public fun calculate_apy<T0, T1>(arg0: &mut StakingPool<T0, T1>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.stake_balance);
        if (v0 == 0) {
            0
        } else {
            arg0.reward_per_nanosecs * 60 * 60 * 24 * 30 * 12 * 1000 * 100 / v0
        }
    }

    public entry fun claim<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 999);
        let v0 = 0x2::tx_context::sender(arg2);
        update_accum_reward<T0, T1>(arg0, arg1);
        assert!(0x2::bag::contains<address>(&arg0.stakers, v0), 1004);
        let v1 = 0x2::bag::remove<address, StakingLock>(&mut arg0.stakers, v0);
        let v2 = &mut v1;
        update_user_earnings(arg0.accum_reward, arg0.scale, v2);
        let v3 = if (0x2::clock::timestamp_ms(arg1) - v1.staking_start_timestamp >= 2592000000) {
            2592000000
        } else {
            0x2::clock::timestamp_ms(arg1) - v1.staking_start_timestamp
        };
        let v4 = &mut v1;
        let v5 = inner_claim<T0, T1>(arg0, v4, arg2);
        if (v3 != 2592000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v5, 0x2::coin::value<T1>(&v5) * arg0.penalty_percentage / 100, arg2), arg0.owner);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, v0);
        };
        0x2::bag::add<address, StakingLock>(&mut arg0.stakers, v0, v1);
    }

    public entry fun create_stake<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0, T1>{
            id                  : 0x2::object::new(arg5),
            stake_balance       : 0x2::balance::zero<T0>(),
            reward_balance      : 0x2::coin::into_balance<T1>(arg1),
            reward_per_nanosecs : 0x2::coin::value<T1>(&arg1) / 2592000000,
            accum_reward        : 0,
            last_updated        : 0x2::clock::timestamp_ms(arg4),
            stakers             : 0x2::bag::new(arg5),
            scale               : 1000000000000000000,
            owner               : arg3,
            total_stake_amount  : 0,
            cliamed_reward      : 0,
            penalty_percentage  : arg2,
            end_timestamp       : 0x2::clock::timestamp_ms(arg4) + 2592000000,
            version             : 0,
        };
        let v1 = CreateStakePoolEvent{staking_pool_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<CreateStakePoolEvent>(v1);
        0x2::transfer::public_share_object<StakingPool<T0, T1>>(v0);
    }

    entry fun deposit_reward_coin<T0, T1>(arg0: &AdminCap, arg1: &mut StakingPool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg1.reward_balance, 0x2::coin::into_balance<T1>(arg2));
    }

    fun get_time_for_last_update<T0, T1>(arg0: &StakingPool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.end_timestamp < 0x2::clock::timestamp_ms(arg1)) {
            arg0.end_timestamp
        } else {
            0x2::clock::timestamp_ms(arg1)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun inner_claim<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: &mut StakingLock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = arg1.earned_reward;
        arg0.cliamed_reward = arg0.cliamed_reward + v0;
        arg1.earned_reward = 0;
        0x2::coin::take<T1>(&mut arg0.reward_balance, v0, arg2)
    }

    entry fun mergerate<T0, T1>(arg0: &AdminCap, arg1: &mut StakingPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.version = 0;
    }

    public entry fun stake<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 999);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_timestamp, 1005);
        let v0 = 0x2::tx_context::sender(arg3);
        update_accum_reward<T0, T1>(arg0, arg2);
        if (0x2::bag::contains<address>(&arg0.stakers, v0)) {
            let v1 = 0x2::bag::remove<address, StakingLock>(&mut arg0.stakers, v0);
            let v2 = &mut v1;
            update_user_earnings(arg0.accum_reward, arg0.scale, v2);
            v1.amount = v1.amount + 0x2::coin::value<T0>(&arg1);
            0x2::balance::join<T0>(&mut arg0.stake_balance, 0x2::coin::into_balance<T0>(arg1));
            let v3 = CreateStakeLockEvent{
                staking_lock_id         : 0x2::object::uid_to_inner(&v1.id),
                amount                  : v1.amount,
                staking_start_timestamp : v1.staking_start_timestamp,
            };
            0x2::event::emit<CreateStakeLockEvent>(v3);
            0x2::bag::add<address, StakingLock>(&mut arg0.stakers, v0, v1);
        } else {
            let v4 = 0x2::coin::into_balance<T0>(arg1);
            let v5 = StakingLock{
                id                      : 0x2::object::new(arg3),
                amount                  : 0x2::balance::value<T0>(&v4),
                earned_reward           : 0,
                unobtainable_reward     : 0,
                earned_per_token_store  : arg0.accum_reward,
                staking_start_timestamp : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::balance::join<T0>(&mut arg0.stake_balance, v4);
            let v6 = CreateStakeLockEvent{
                staking_lock_id         : 0x2::object::uid_to_inner(&v5.id),
                amount                  : v5.amount,
                staking_start_timestamp : v5.staking_start_timestamp,
            };
            0x2::event::emit<CreateStakeLockEvent>(v6);
            0x2::bag::add<address, StakingLock>(&mut arg0.stakers, v0, v5);
        };
    }

    fun update_accum_reward<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = get_time_for_last_update<T0, T1>(arg0, arg1);
        0x1::debug::print<u64>(&v0);
        let v1 = accum_rewards_since_last_updated<T0, T1>(arg0, v0);
        0x1::debug::print<u256>(&v1);
        arg0.last_updated = v0;
        arg0.accum_reward = arg0.accum_reward + v1;
    }

    fun update_user_earnings(arg0: u256, arg1: u64, arg2: &mut StakingLock) {
        let v0 = user_earned_since_last_update(arg0, arg1, arg2);
        arg2.earned_reward = arg2.earned_reward + v0;
        arg2.unobtainable_reward = arg2.unobtainable_reward + v0;
        arg2.earned_per_token_store = arg0;
    }

    public fun userReward<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        update_accum_reward<T0, T1>(arg0, arg1);
        let v0 = 0x2::bag::borrow_mut<address, StakingLock>(&mut arg0.stakers, 0x2::tx_context::sender(arg2));
        update_user_earnings(arg0.accum_reward, arg0.scale, v0);
        (v0.amount, v0.earned_reward)
    }

    public fun userState<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : &StakingLock {
        0x2::bag::borrow<address, StakingLock>(&arg0.stakers, 0x2::tx_context::sender(arg1))
    }

    fun user_earned_since_last_update(arg0: u256, arg1: u64, arg2: &StakingLock) : u64 {
        (((arg2.amount as u256) * ((arg0 - arg2.earned_per_token_store) as u256) / (arg1 as u256)) as u64)
    }

    public entry fun withdraw<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 999);
        update_accum_reward<T0, T1>(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::bag::remove<address, StakingLock>(&mut arg0.stakers, v0);
        let v2 = if (0x2::clock::timestamp_ms(arg2) - v1.staking_start_timestamp > 2592000000) {
            2592000000
        } else {
            0x2::clock::timestamp_ms(arg2) - v1.staking_start_timestamp
        };
        let v3 = if (arg1 == 0) {
            v1.amount
        } else {
            arg1
        };
        let v4 = &mut v1;
        update_user_earnings(arg0.accum_reward, arg0.scale, v4);
        let v5 = 0x2::coin::take<T0>(&mut arg0.stake_balance, v3, arg3);
        assert!(v1.amount >= v3, 1001);
        v1.amount = v1.amount - v3;
        v1.staking_start_timestamp = 0x2::clock::timestamp_ms(arg2);
        0x2::bag::add<address, StakingLock>(&mut arg0.stakers, v0, v1);
        if (v2 != 2592000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, v3 * arg0.penalty_percentage / 100, arg3), arg0.owner);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
        };
    }

    entry fun withdraw_reward_coin<T0, T1>(arg0: &AdminCap, arg1: &mut StakingPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.reward_balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

