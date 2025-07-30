module 0x2651df1ad9b9835f4ac3ad527b63d40e60fa2fcf56715ec7a1b27fdd0a6fc1f9::chop6900_locker {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct LockerAdminCap has key {
        id: 0x2::object::UID,
        locker_address: address,
        locker_coin_type: 0x1::string::String,
        reward_coin_type: 0x1::string::String,
    }

    struct LockerDappConfig has key {
        id: 0x2::object::UID,
        locker_coin_types: vector<0x1::string::String>,
        locker_addresses: vector<address>,
        reward_coin_types: vector<0x1::string::String>,
        fee_wallet: address,
    }

    struct LockerConfig<phantom T0> has key {
        id: 0x2::object::UID,
        total_locked: u64,
        total_rewards: u64,
        reward_balance: 0x2::balance::Balance<T0>,
        locker_coin_type: 0x1::string::String,
        reward_coin_type: 0x1::string::String,
        locker_coin_decimals: u8,
        reward_coin_decimals: u8,
        active_lockers: u64,
        total_weighted_locker: u64,
        max_apy: u64,
    }

    struct Locker<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        locked: 0x2::balance::Balance<T0>,
        started_at: u64,
        ended_at: u64,
        locked_in_apy: u64,
        locker_coin_type: 0x1::string::String,
        reward_coin_type: 0x1::string::String,
        rewards_locked: 0x2::balance::Balance<T1>,
        locker_config: address,
        locker_size_at_creation: u64,
        adjusted_reward_rate: u64,
    }

    public fun calculate_adjusted_reward_rate(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 * calculate_depletion_factor(arg1, arg2)) as u128) / 1000000000) as u64)
    }

    public fun calculate_apy(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 > 1) {
            arg0 - 1
        } else {
            0
        };
        1000000000 + (arg1 - 1000000000) * v0 / (365 - 1)
    }

    public fun calculate_base_reward_rate(arg0: u64, arg1: u64) : u64 {
        arg1 * arg0 / 365
    }

    public fun calculate_depletion_factor(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        (sqrt((arg0 as u128) * 1000000000 / 10 / (arg1 as u128)) as u64)
    }

    public fun calculate_normalization_factor(arg0: u8, arg1: u8) : u128 {
        if (arg0 > arg1) {
            let v1 = 1;
            let v2 = 0;
            while (v2 < ((arg0 - arg1) as u8)) {
                v1 = v1 * 10;
                v2 = v2 + 1;
            };
            v1
        } else if (arg0 < arg1) {
            let v3 = 1;
            let v4 = 0;
            while (v4 < ((arg1 - arg0) as u8)) {
                v3 = v3 * 10;
                v4 = v4 + 1;
            };
            v3
        } else {
            1
        }
    }

    public entry fun claim_early_rewards<T0, T1>(arg0: &mut Locker<T0, T1>, arg1: &mut LockerConfig<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (v0 > arg0.started_at) {
            v0 - arg0.started_at
        } else {
            0
        };
        let v2 = arg0.ended_at - arg0.started_at;
        let v3 = if (v1 >= v2) {
            0
        } else {
            ((v2 - v1) as u128) * calculate_normalization_factor(0, arg1.reward_coin_decimals) / (v2 as u128)
        };
        let v4 = 0x2::balance::value<T1>(&arg0.rewards_locked);
        assert!(v4 > 0, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.rewards_locked, v4 - v4 * 500000000 * (v3 as u64) / 1000000000 / 1000000000), arg3), 0x2::tx_context::sender(arg3));
        let v5 = 0x2::balance::split<T1>(&mut arg0.rewards_locked, 0);
        arg1.total_rewards = arg1.total_rewards + 0x2::balance::value<T1>(&v5);
        0x2::balance::join<T1>(&mut arg1.reward_balance, v5);
    }

    public entry fun fund_rewards<T0>(arg0: &LockerAdminCap, arg1: &mut LockerConfig<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.locker_address == 0x2::object::uid_to_address(&arg1.id), 6);
        arg1.total_rewards = arg1.total_rewards + 0x2::coin::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg1.reward_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun fund_rewards_override<T0>(arg0: &LockerAdminCap, arg1: &mut LockerConfig<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.reward_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun get_decimal_adjusted_value(arg0: u64, arg1: u8) : (u64, u64) {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg1) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        (arg0 / v0, arg0 % v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = LockerDappConfig{
            id                : 0x2::object::new(arg0),
            locker_coin_types : 0x1::vector::empty<0x1::string::String>(),
            locker_addresses  : 0x1::vector::empty<address>(),
            reward_coin_types : 0x1::vector::empty<0x1::string::String>(),
            fee_wallet        : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<LockerDappConfig>(v1);
    }

    public entry fun lock_coins<T0, T1>(arg0: &mut LockerConfig<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = arg3 / 86400000 + 1;
        assert!(v0 > 0, 2);
        assert!(v1 >= 1 && v1 <= 365, 10);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0;
        let v4 = if (0x2::balance::value<T1>(&arg0.reward_balance) > 0) {
            arg0.total_locked = arg0.total_locked + v0;
            let v5 = calculate_adjusted_reward_rate(calculate_base_reward_rate(v1, calculate_apy(v1, arg0.max_apy)), 0x2::balance::value<T1>(&arg0.reward_balance), arg0.total_rewards);
            v3 = v5;
            let v6 = normalize_value(v0, arg0.locker_coin_decimals, arg0.reward_coin_decimals);
            let v7 = v6 * (v5 as u128) / 1000000000;
            let v8 = v6 / 1000000000 * (v5 as u128);
            let v9 = (arg0.total_weighted_locker as u128) + v8;
            let v10 = if (v9 > 0) {
                (v8 as u128) * (0x2::balance::value<T1>(&arg0.reward_balance) as u128) / (v9 as u128)
            } else {
                (0x2::balance::value<T1>(&arg0.reward_balance) as u128)
            };
            let v11 = if (v7 < v10) {
                v7
            } else {
                v10
            };
            assert!(v11 <= (0x2::balance::value<T1>(&arg0.reward_balance) as u128), 11);
            arg0.total_weighted_locker = (v9 as u64);
            let v12 = &mut arg0.reward_balance;
            withdraw_from_balance<T1>(v12, (v11 as u64), arg4)
        } else {
            let v13 = &mut arg0.reward_balance;
            withdraw_from_balance<T1>(v13, 0, arg4)
        };
        let v14 = v4;
        let v15 = Locker<T0, T1>{
            id                      : 0x2::object::new(arg4),
            locked                  : 0x2::coin::into_balance<T0>(arg1),
            started_at              : v2,
            ended_at                : v2 + arg3,
            locked_in_apy           : ((((365 / v1) as u128) * (0x2::balance::value<T1>(&v14) as u128) * 100000 / normalize_value(v0, arg0.locker_coin_decimals, arg0.reward_coin_decimals)) as u64),
            locker_coin_type        : arg0.locker_coin_type,
            reward_coin_type        : arg0.reward_coin_type,
            rewards_locked          : v14,
            locker_config           : 0x2::object::uid_to_address(&arg0.id),
            locker_size_at_creation : 0x2::balance::value<T1>(&arg0.reward_balance),
            adjusted_reward_rate    : v3,
        };
        arg0.active_lockers = arg0.active_lockers + 1;
        0x2::transfer::transfer<Locker<T0, T1>>(v15, 0x2::tx_context::sender(arg4));
    }

    public fun new_pool_config<T0>(arg0: &mut LockerDappConfig, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: u8, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<0x1::string::String>(&arg0.locker_coin_types, &arg3), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > 2 * 1000000000, 12);
        let v0 = LockerConfig<T0>{
            id                    : 0x2::object::new(arg8),
            total_locked          : 0,
            total_rewards         : 0x2::coin::value<T0>(&arg1),
            reward_balance        : 0x2::coin::into_balance<T0>(arg1),
            locker_coin_type      : arg3,
            reward_coin_type      : arg4,
            locker_coin_decimals  : arg5,
            reward_coin_decimals  : arg6,
            active_lockers        : 0,
            total_weighted_locker : 0,
            max_apy               : arg7,
        };
        let v1 = LockerAdminCap{
            id               : 0x2::object::new(arg8),
            locker_address   : 0x2::object::uid_to_address(&v0.id),
            locker_coin_type : arg3,
            reward_coin_type : arg4,
        };
        0x1::vector::insert<0x1::string::String>(&mut arg0.locker_coin_types, arg3, 0);
        if (!0x1::vector::contains<0x1::string::String>(&arg0.reward_coin_types, &arg4)) {
            0x1::vector::insert<0x1::string::String>(&mut arg0.reward_coin_types, arg4, 0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.fee_wallet);
        0x2::transfer::transfer<LockerAdminCap>(v1, 0x2::tx_context::sender(arg8));
        0x2::transfer::share_object<LockerConfig<T0>>(v0);
    }

    public fun normalize_value(arg0: u64, arg1: u8, arg2: u8) : u128 {
        if (arg1 > arg2) {
            (arg0 as u128) / calculate_normalization_factor(arg1, arg2)
        } else if (arg1 < arg2) {
            (arg0 as u128) * calculate_normalization_factor(arg1, arg2)
        } else {
            (arg0 as u128)
        }
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

    public entry fun withdraw_coins<T0, T1>(arg0: &mut LockerDappConfig, arg1: Locker<T0, T1>, arg2: &mut LockerConfig<T1>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg1.ended_at, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) > 1000000000 / 4, 12);
        let Locker {
            id                      : v0,
            locked                  : v1,
            started_at              : _,
            ended_at                : _,
            locked_in_apy           : _,
            locker_coin_type        : _,
            reward_coin_type        : _,
            rewards_locked          : v7,
            locker_config           : _,
            locker_size_at_creation : _,
            adjusted_reward_rate    : _,
        } = arg1;
        let v11 = v1;
        0x2::object::delete(v0);
        arg2.total_locked = arg2.total_locked - 0x2::balance::value<T0>(&v11);
        arg2.active_lockers = arg2.active_lockers - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.fee_wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg5), 0x2::tx_context::sender(arg5));
    }

    fun withdraw_from_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 3);
        0x2::balance::split<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

