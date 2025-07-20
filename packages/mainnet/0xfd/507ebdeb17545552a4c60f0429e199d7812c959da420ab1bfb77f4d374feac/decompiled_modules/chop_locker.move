module 0xfd507ebdeb17545552a4c60f0429e199d7812c959da420ab1bfb77f4d374feac::chop_locker {
    struct ChopLockerAdmin has key {
        id: 0x2::object::UID,
    }

    struct PoolAdmin has key {
        id: 0x2::object::UID,
        poolAddy: address,
        token_type: 0x1::string::String,
    }

    struct PoolDirectory has key {
        id: 0x2::object::UID,
        token_types: vector<0x1::string::String>,
    }

    struct PoolConfig<phantom T0> has key {
        id: 0x2::object::UID,
        total_staked: u64,
        total_rewards_added_by_admin: u64,
        reward_balance: 0x2::balance::Balance<T0>,
        token_type: 0x1::string::String,
        active_lockers: u64,
        total_weighted_stake: u64,
        maxAPY: u64,
    }

    struct Lock<phantom T0> has store, key {
        id: 0x2::object::UID,
        staked: 0x2::balance::Balance<T0>,
        start_time: u64,
        end_time: u64,
        locked_in_apy: u64,
        token_type: 0x1::string::String,
        rewards_locked: 0x2::balance::Balance<T0>,
        pool_config: address,
        pool_size_at_creation: u64,
        adjusted_reward_rate: u64,
    }

    fun calculate_adjusted_reward_rate(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 * calculate_depletion_factor(arg1, arg2)) as u128) / 1000000000) as u64)
    }

    fun calculate_apy(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 > 1) {
            arg0 - 1
        } else {
            0
        };
        1000000000 + (arg1 - 1000000000) * v0 / (365 - 1)
    }

    fun calculate_base_reward_rate(arg0: u64, arg1: u64) : u64 {
        arg1 * arg0 / 365
    }

    fun calculate_depletion_factor(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        (sqrt((arg0 as u128) * 1000000000 / 10 / (arg1 as u128)) as u64)
    }

    public entry fun fund_rewards<T0>(arg0: &PoolAdmin, arg1: &mut PoolConfig<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.poolAddy == 0x2::object::uid_to_address(&arg1.id), 6);
        arg1.total_rewards_added_by_admin = arg1.total_rewards_added_by_admin + 0x2::coin::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg1.reward_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun fund_rewards_override<T0>(arg0: &ChopLockerAdmin, arg1: &mut PoolConfig<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.reward_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ChopLockerAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ChopLockerAdmin>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PoolDirectory{
            id          : 0x2::object::new(arg0),
            token_types : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<PoolDirectory>(v1);
    }

    public entry fun lock_tokens<T0>(arg0: &mut PoolConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = arg3 / 86400000 + 1;
        assert!(v0 > 0, 2);
        assert!(v1 >= 1 && v1 <= 365, 10);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0;
        let v4 = if (0x2::balance::value<T0>(&arg0.reward_balance) > 0) {
            arg0.total_staked = arg0.total_staked + v0;
            let v5 = calculate_adjusted_reward_rate(calculate_base_reward_rate(v1, calculate_apy(v1, arg0.maxAPY)), 0x2::balance::value<T0>(&arg0.reward_balance), arg0.total_rewards_added_by_admin);
            v3 = v5;
            let v6 = (v0 as u128) * (v5 as u128) / 1000000000;
            let v7 = (v0 as u128) / 1000000000 * (v5 as u128);
            let v8 = (arg0.total_weighted_stake as u128) + v7;
            let v9 = if (v8 > 0) {
                (v7 as u128) * (0x2::balance::value<T0>(&arg0.reward_balance) as u128) / (v8 as u128)
            } else {
                (0x2::balance::value<T0>(&arg0.reward_balance) as u128)
            };
            let v10 = if (v6 < v9) {
                v6
            } else {
                v9
            };
            assert!(v10 <= (0x2::balance::value<T0>(&arg0.reward_balance) as u128), 11);
            let v11 = &mut arg0.reward_balance;
            let v4 = withdraw_from_balance<T0>(v11, (v10 as u64), arg5);
            arg0.total_weighted_stake = (v8 as u64);
            v4
        } else {
            let v12 = &mut arg0.reward_balance;
            withdraw_from_balance<T0>(v12, 0, arg5)
        };
        let v13 = Lock<T0>{
            id                    : 0x2::object::new(arg5),
            staked                : 0x2::coin::into_balance<T0>(arg1),
            start_time            : v2,
            end_time              : v2 + arg3,
            locked_in_apy         : 365 / v1 * 0x2::balance::value<T0>(&v4) / v0,
            token_type            : arg4,
            rewards_locked        : v4,
            pool_config           : 0x2::object::uid_to_address(&arg0.id),
            pool_size_at_creation : 0x2::balance::value<T0>(&arg0.reward_balance),
            adjusted_reward_rate  : v3,
        };
        arg0.active_lockers = arg0.active_lockers + 1;
        0x2::transfer::transfer<Lock<T0>>(v13, 0x2::tx_context::sender(arg5));
    }

    public fun new_pool_config<T0>(arg0: &mut PoolDirectory, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<0x1::string::String>(&arg0.token_types, &arg2), 5);
        let v0 = 0x2::object::new(arg4);
        let v1 = PoolConfig<T0>{
            id                           : v0,
            total_staked                 : 0,
            total_rewards_added_by_admin : 0x2::coin::value<T0>(&arg1),
            reward_balance               : 0x2::coin::into_balance<T0>(arg1),
            token_type                   : arg2,
            active_lockers               : 0,
            total_weighted_stake         : 0,
            maxAPY                       : arg3,
        };
        let v2 = PoolAdmin{
            id         : 0x2::object::new(arg4),
            poolAddy   : 0x2::object::uid_to_address(&v0),
            token_type : arg2,
        };
        0x1::vector::insert<0x1::string::String>(&mut arg0.token_types, arg2, 0);
        0x2::transfer::transfer<PoolAdmin>(v2, 0x2::tx_context::sender(arg4));
        0x2::transfer::share_object<PoolConfig<T0>>(v1);
    }

    public entry fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 == 1) {
            return 1
        };
        let v0 = 1000000;
        let v1 = arg0 / 2;
        let v2 = 20;
        while (v2 > 0) {
            let v3 = (v1 + arg0 * v0 / v1) / 2;
            if (v3 == v1) {
                break
            };
            v1 = v3;
            v2 = v2 - 1;
        };
        v1 * v0 / 1000000
    }

    fun withdraw_from_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 3);
        0x2::balance::split<T0>(arg0, arg1)
    }

    public entry fun withdraw_tokens<T0>(arg0: Lock<T0>, arg1: &mut PoolConfig<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time, 1);
        let Lock {
            id                    : v0,
            staked                : v1,
            start_time            : _,
            end_time              : _,
            locked_in_apy         : _,
            token_type            : _,
            rewards_locked        : v6,
            pool_config           : _,
            pool_size_at_creation : _,
            adjusted_reward_rate  : _,
        } = arg0;
        let v10 = v1;
        0x2::object::delete(v0);
        arg1.total_staked = arg1.total_staked - 0x2::balance::value<T0>(&v10);
        arg1.active_lockers = arg1.active_lockers - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

