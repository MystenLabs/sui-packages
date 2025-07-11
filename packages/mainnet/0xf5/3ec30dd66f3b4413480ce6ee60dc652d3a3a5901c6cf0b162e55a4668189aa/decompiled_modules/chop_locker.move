module 0xf53ec30dd66f3b4413480ce6ee60dc652d3a3a5901c6cf0b162e55a4668189aa::chop_locker {
    struct ChopLockerAdmin has key {
        id: 0x2::object::UID,
    }

    struct PoolConfig<phantom T0> has key {
        id: 0x2::object::UID,
        base_apy: u64,
        current_apy: u64,
        apy_daily_increment: u64,
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
    }

    public fun calculate_apy<T0>(arg0: &mut PoolConfig<T0>) : u64 {
        let v0 = arg0.total_staked;
        if (v0 == 0) {
            arg0.current_apy = arg0.base_apy;
            arg0.base_apy
        } else {
            let v2 = (arg0.base_apy as u128) / (1 + (v0 as u128) / 1000000000);
            arg0.current_apy = (v2 as u64);
            (v2 as u64)
        }
    }

    public fun calculate_rewards<T0>(arg0: &Lock<T0>, arg1: &mut PoolConfig<T0>, arg2: &0x2::clock::Clock) : u64 {
        (((0x2::balance::value<T0>(&arg0.staked) as u128) * (calculate_apy<T0>(arg1) as u128) * ((0x2::clock::timestamp_ms(arg2) - arg0.start_time) as u128) / 315576000000000) as u64)
    }

    public entry fun claim_rewards<T0>(arg0: &mut Lock<T0>, arg1: &mut PoolConfig<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_rewards<T0>(arg0, arg1, arg2);
        assert!(v0 > 0, 2);
        assert!(0x2::balance::value<T0>(&arg1.reward_balance) >= v0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.reward_balance, v0, arg3), 0x2::tx_context::sender(arg3));
        arg0.start_time = 0x2::clock::timestamp_ms(arg2);
    }

    public entry fun fund_rewards<T0>(arg0: &ChopLockerAdmin, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut PoolConfig<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg2.reward_balance, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg1, arg3, arg4)));
    }

    public fun get_apy<T0>(arg0: &mut PoolConfig<T0>) : u64 {
        calculate_apy<T0>(arg0)
    }

    public fun increase_by_basis_points(arg0: u64, arg1: u64) : u64 {
        arg0 + arg0 * arg1 / 10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ChopLockerAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ChopLockerAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun lock_tokens<T0>(arg0: &mut PoolConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        arg0.total_staked = arg0.total_staked + v0;
        let v1 = calculate_apy<T0>(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = Lock<T0>{
            id            : 0x2::object::new(arg5),
            staked        : 0x2::coin::into_balance<T0>(arg1),
            start_time    : v2,
            end_time      : v2 + arg3,
            locked_in_apy : increase_by_basis_points(v1, (arg3 / 86400000 + 1) * arg0.apy_daily_increment),
            token_type    : arg4,
        };
        0x2::transfer::transfer<Lock<T0>>(v3, 0x2::tx_context::sender(arg5));
    }

    public fun new_pool_config<T0>(arg0: &ChopLockerAdmin, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolConfig<T0>{
            id                  : 0x2::object::new(arg4),
            base_apy            : arg2,
            current_apy         : arg2,
            apy_daily_increment : arg3,
            total_staked        : 0,
            reward_balance      : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::share_object<PoolConfig<T0>>(v0);
    }

    public entry fun withdraw_tokens<T0>(arg0: Lock<T0>, arg1: &mut PoolConfig<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time, 1);
        let Lock {
            id            : v0,
            staked        : v1,
            start_time    : _,
            end_time      : _,
            locked_in_apy : _,
            token_type    : _,
        } = arg0;
        let v6 = v1;
        0x2::object::delete(v0);
        arg1.total_staked = arg1.total_staked - 0x2::balance::value<T0>(&v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

