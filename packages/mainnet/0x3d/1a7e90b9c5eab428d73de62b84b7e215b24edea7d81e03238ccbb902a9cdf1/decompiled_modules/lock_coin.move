module 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin {
    struct LockedCoin<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        locked_start_time: u64,
        locked_until_time: u64,
    }

    struct LockCoinEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
        locked_until_time: u64,
    }

    struct UnlockCoinEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        locked_coin: 0x2::object::ID,
        locked_until_time: u64,
    }

    public fun value<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &LockedCoin<T0>) : u64 {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        0x2::balance::value<T0>(&arg1.balance)
    }

    public(friend) fun lock_coin<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        assert!(arg2 >= 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::utils::now_timestamp(arg5), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::invalid_lock_time());
        assert!(arg3 > arg2, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::invalid_lock_time());
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = LockCoinEvent{
            token_type        : 0x1::type_name::with_defining_ids<T0>(),
            amount            : 0x2::balance::value<T0>(&v0),
            recipient         : arg4,
            locked_until_time : arg3,
        };
        0x2::event::emit<LockCoinEvent>(v1);
        new_from_balance<T0>(v0, arg2, arg3, arg4, arg6)
    }

    public(friend) fun destory_lock<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: LockedCoin<T0>) : (0x2::balance::Balance<T0>, 0x2::object::ID) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        let LockedCoin {
            id                : v0,
            balance           : v1,
            locked_start_time : _,
            locked_until_time : _,
        } = arg1;
        let v4 = v0;
        0x2::object::delete(v4);
        (v1, 0x2::object::uid_to_inner(&v4))
    }

    public fun lock_time<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &LockedCoin<T0>) : u64 {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        arg1.locked_until_time
    }

    fun new_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg4);
        let v1 = LockedCoin<T0>{
            id                : v0,
            balance           : arg0,
            locked_start_time : arg1,
            locked_until_time : arg2,
        };
        0x2::transfer::transfer<LockedCoin<T0>>(v1, arg3);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun unlock_coin<T0>(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: LockedCoin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        let LockedCoin {
            id                : v0,
            balance           : v1,
            locked_start_time : _,
            locked_until_time : v3,
        } = arg1;
        let v4 = v1;
        let v5 = v0;
        assert!(v3 <= 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::utils::now_timestamp(arg2), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::coin_still_locked());
        0x2::object::delete(v5);
        let v6 = UnlockCoinEvent{
            token_type        : 0x1::type_name::with_defining_ids<T0>(),
            amount            : 0x2::balance::value<T0>(&v4),
            locked_coin       : 0x2::object::uid_to_inner(&v5),
            locked_until_time : v3,
        };
        0x2::event::emit<UnlockCoinEvent>(v6);
        v4
    }

    // decompiled from Move bytecode v6
}

