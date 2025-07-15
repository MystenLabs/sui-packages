module 0xd09d84f63f4dfd3b7c73a85f45469073c469eff4dee8c84b32d6fd69f090aa78::chop_locker {
    struct ChopLockerAdmin has key {
        id: 0x2::object::UID,
    }

    struct PoolConfig<phantom T0> has key {
        id: 0x2::object::UID,
        total_staked: u64,
        reward_balance: 0x2::balance::Balance<T0>,
    }

    struct Lock<phantom T0> has store, key {
        id: 0x2::object::UID,
        staked: 0x2::balance::Balance<T0>,
        start_time: u64,
        end_time: u64,
        locked_in_apy: u64,
        token_type: 0x1::string::String,
        rewards_locked: 0x2::balance::Balance<T0>,
    }

    public fun calculate_apy<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: &0x2::balance::Balance<T0>, arg3: u64) : u64 {
        assert!(0x2::balance::value<T0>(arg2) > 0, 2);
        let v0 = 365;
        if (arg1 == 0) {
            let v2 = 0x2::balance::value<T0>(arg2) / v0 / v0 * (100 * arg3 / 90 + 50) * 1000 / 1000000000 * 365 * 100;
            if (v2 > 50000000) {
                50000000
            } else {
                v2
            }
        } else {
            let v3 = 1;
            if (v3 > (50000000 as u128)) {
                (v3 as u64)
            } else {
                (v3 as u64)
            }
        }
    }

    public entry fun fund_rewards<T0>(arg0: &ChopLockerAdmin, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut PoolConfig<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg2.reward_balance, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg1, arg3, arg4)));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ChopLockerAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ChopLockerAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun lock_tokens<T0>(arg0: &mut PoolConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        arg0.total_staked = arg0.total_staked + v0;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::object::new(arg5);
        let v3 = &mut arg0.reward_balance;
        let v4 = withdraw_from_balance<T0>(v3, 1, arg5);
        let v5 = Lock<T0>{
            id             : v2,
            staked         : 0x2::coin::into_balance<T0>(arg1),
            start_time     : v1,
            end_time       : v1 + arg3,
            locked_in_apy  : calculate_apy<T0>(0x2::coin::balance<T0>(&arg1), 3000000000, &arg0.reward_balance, arg3 / 86400000 + 1),
            token_type     : arg4,
            rewards_locked : v4,
        };
        0x2::transfer::transfer<Lock<T0>>(v5, 0x2::tx_context::sender(arg5));
    }

    public fun new_pool_config<T0>(arg0: &ChopLockerAdmin, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolConfig<T0>{
            id             : 0x2::object::new(arg2),
            total_staked   : 0,
            reward_balance : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::share_object<PoolConfig<T0>>(v0);
    }

    public fun withdraw_from_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 3);
        0x2::balance::split<T0>(arg0, arg1)
    }

    public entry fun withdraw_tokens<T0>(arg0: Lock<T0>, arg1: &mut PoolConfig<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time, 1);
        let Lock {
            id             : v0,
            staked         : v1,
            start_time     : _,
            end_time       : _,
            locked_in_apy  : _,
            token_type     : _,
            rewards_locked : v6,
        } = arg0;
        let v7 = v1;
        0x2::object::delete(v0);
        arg1.total_staked = arg1.total_staked - 0x2::balance::value<T0>(&v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

