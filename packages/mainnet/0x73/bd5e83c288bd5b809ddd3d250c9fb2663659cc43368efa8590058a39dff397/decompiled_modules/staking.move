module 0x73bd5e83c288bd5b809ddd3d250c9fb2663659cc43368efa8590058a39dff397::staking {
    struct CreateStakePoolEvent has copy, drop {
        staking_pool_id: 0x2::object::ID,
    }

    struct CreateStakeLockEvent has copy, drop {
        staking_lock_id: 0x2::object::ID,
        amount: u64,
        lock_time: u64,
        staking_start_timestamp: u64,
    }

    struct ExtendStakeLockEvent has copy, drop {
        staking_lock_id: 0x2::object::ID,
        amount: u64,
        lock_time: u64,
        staking_start_timestamp: u64,
    }

    struct WithdrawStakeEvent has copy, drop {
        staking_lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>,
        locks: vector<u64>,
        multipliers: vector<u64>,
        tier_levels: vector<u64>,
        investment_lock_time: u64,
        investment_lock_penalty: u64,
        minimum_amount: u64,
        penalty_receiver: address,
    }

    struct StakingLock has store, key {
        id: 0x2::object::UID,
        amount: u64,
        staking_start_timestamp: u64,
        lock_time: u64,
        multiplier: u64,
        last_distribution_timestamp: u64,
    }

    entry fun extend_stake(arg0: &mut StakingPool, arg1: &mut StakingLock, arg2: u64, arg3: u64, arg4: vector<0x2::coin::Coin<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        stake_coins(arg0, arg1, get_coin_from_vec(arg4, arg3, arg6), arg2, arg5);
        let v0 = ExtendStakeLockEvent{
            staking_lock_id         : 0x2::object::uid_to_inner(&arg1.id),
            amount                  : arg1.amount,
            lock_time               : arg1.lock_time,
            staking_start_timestamp : arg1.staking_start_timestamp,
        };
        0x2::event::emit<ExtendStakeLockEvent>(v0);
    }

    fun get_coin_from_vec(arg0: vector<0x2::coin::Coin<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP> {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>>(&mut arg0);
        0x2::pay::join_vec<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>(&mut v0, arg0);
        assert!(0x2::coin::value<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>(&v0) >= arg1, 3);
        if (0x2::coin::value<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>>(v0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>(v0);
        };
        0x2::coin::split<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>(&mut v0, arg1, arg2)
    }

    public fun get_stake_value(arg0: &StakingLock, arg1: &0x2::clock::Clock) : u64 {
        if (is_locked(arg0, arg1)) {
            arg0.amount * arg0.multiplier / 100
        } else {
            arg0.amount
        }
    }

    public fun get_tier_level(arg0: &StakingLock, arg1: &StakingPool, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        while (v0 < get_tier_levels_count(arg1) && get_stake_value(arg0, arg2) > *0x1::vector::borrow<u64>(&arg1.tier_levels, v0)) {
            v0 = v0 + 1;
        };
        v0
    }

    public fun get_tier_levels_count(arg0: &StakingPool) : u64 {
        0x1::vector::length<u64>(&arg0.tier_levels)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                      : 0x2::object::new(arg0),
            vault                   : 0x2::balance::zero<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>(),
            locks                   : 0x1::vector::empty<u64>(),
            multipliers             : 0x1::vector::empty<u64>(),
            tier_levels             : 0x1::vector::empty<u64>(),
            investment_lock_time    : 1296000000,
            investment_lock_penalty : 15,
            minimum_amount          : 2499999999999,
            penalty_receiver        : 0x2::tx_context::sender(arg0),
        };
        0x1::vector::push_back<u64>(&mut v0.locks, 0);
        0x1::vector::push_back<u64>(&mut v0.locks, 7776000000);
        0x1::vector::push_back<u64>(&mut v0.locks, 15552000000);
        0x1::vector::push_back<u64>(&mut v0.locks, 31104000000);
        0x1::vector::push_back<u64>(&mut v0.multipliers, 100);
        0x1::vector::push_back<u64>(&mut v0.multipliers, 130);
        0x1::vector::push_back<u64>(&mut v0.multipliers, 150);
        0x1::vector::push_back<u64>(&mut v0.multipliers, 200);
        0x1::vector::push_back<u64>(&mut v0.tier_levels, 4999999999999);
        0x1::vector::push_back<u64>(&mut v0.tier_levels, 9999999999999);
        0x1::vector::push_back<u64>(&mut v0.tier_levels, 29999999999999);
        0x1::vector::push_back<u64>(&mut v0.tier_levels, 49999999999999);
        0x1::vector::push_back<u64>(&mut v0.tier_levels, 99999999999999);
        0x1::vector::push_back<u64>(&mut v0.tier_levels, 18446744073709551615);
        let v1 = CreateStakePoolEvent{staking_pool_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<CreateStakePoolEvent>(v1);
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public fun is_locked(arg0: &StakingLock, arg1: &0x2::clock::Clock) : bool {
        arg0.staking_start_timestamp + arg0.lock_time > 0x2::clock::timestamp_ms(arg1)
    }

    entry fun new_stake(arg0: &mut StakingPool, arg1: u64, arg2: u64, arg3: vector<0x2::coin::Coin<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= arg0.minimum_amount, 3);
        let v0 = StakingLock{
            id                          : 0x2::object::new(arg5),
            amount                      : 0,
            staking_start_timestamp     : 0,
            lock_time                   : 0,
            multiplier                  : 0,
            last_distribution_timestamp : 0,
        };
        let v1 = get_coin_from_vec(arg3, arg2, arg5);
        let v2 = &mut v0;
        stake_coins(arg0, v2, v1, arg1, arg4);
        let v3 = CreateStakeLockEvent{
            staking_lock_id         : 0x2::object::uid_to_inner(&v0.id),
            amount                  : v0.amount,
            lock_time               : v0.lock_time,
            staking_start_timestamp : v0.staking_start_timestamp,
        };
        0x2::event::emit<CreateStakeLockEvent>(v3);
        0x2::transfer::public_transfer<StakingLock>(v0, 0x2::tx_context::sender(arg5));
    }

    entry fun set_penalty_receiver(arg0: &0x73bd5e83c288bd5b809ddd3d250c9fb2663659cc43368efa8590058a39dff397::launchpad::Launchpad, arg1: &mut StakingPool, arg2: address) {
        arg1.penalty_receiver = arg2;
    }

    fun stake_coins(arg0: &mut StakingPool, arg1: &mut StakingLock, arg2: 0x2::coin::Coin<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = *0x1::vector::borrow<u64>(&arg0.locks, arg3);
        if (is_locked(arg1, arg4)) {
            assert!(v0 >= arg1.lock_time, 1);
        };
        arg1.lock_time = v0;
        arg1.multiplier = *0x1::vector::borrow<u64>(&arg0.multipliers, arg3);
        arg1.staking_start_timestamp = 0x2::clock::timestamp_ms(arg4);
        arg1.amount = arg1.amount + 0x2::coin::value<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>(&arg2);
        0x2::balance::join<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>(&mut arg0.vault, 0x2::coin::into_balance<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>(arg2));
    }

    public(friend) fun update_last_distribution_timestamp(arg0: &mut StakingLock, arg1: u64) {
        arg0.last_distribution_timestamp = arg1;
    }

    entry fun withdraw(arg0: &mut StakingPool, arg1: StakingLock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.staking_start_timestamp + arg1.lock_time < 0x2::clock::timestamp_ms(arg2), 2);
        let v0 = 0x2::coin::take<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>(&mut arg0.vault, arg1.amount, arg3);
        if (arg1.last_distribution_timestamp + arg0.investment_lock_time > 0x2::clock::timestamp_ms(arg2)) {
            let v1 = if (arg1.last_distribution_timestamp > 0x2::clock::timestamp_ms(arg2)) {
                arg1.amount * arg0.investment_lock_penalty / 100
            } else {
                (((((arg1.last_distribution_timestamp + arg0.investment_lock_time - 0x2::clock::timestamp_ms(arg2)) / 1000) as u128) * ((arg1.amount * arg0.investment_lock_penalty / 100) as u128) * 10000000 / ((arg0.investment_lock_time / 1000) as u128) / 10000000) as u64)
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>>(0x2::coin::split<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>(&mut v0, v1, arg3), arg0.penalty_receiver);
        };
        let StakingLock {
            id                          : v2,
            amount                      : _,
            staking_start_timestamp     : _,
            lock_time                   : _,
            multiplier                  : _,
            last_distribution_timestamp : _,
        } = arg1;
        let v8 = v2;
        let v9 = WithdrawStakeEvent{
            staking_lock_id : 0x2::object::uid_to_inner(&v8),
            amount          : arg1.amount,
        };
        0x2::event::emit<WithdrawStakeEvent>(v9);
        0x2::object::delete(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xef54e9ef646151c30cc73e8ced324f01a7ea9bbeef8ef862d1fb94a5dd7431b4::SUIP::SUIP>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

