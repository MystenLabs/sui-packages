module 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        enabled: bool,
        last_updated_time: u64,
        staked_amount: u64,
        reward_vault: 0x2::balance::Balance<T1>,
        reward_rate: u128,
        start_time: u64,
        end_time: u64,
        acc_reward_per_share: u128,
        lock_duration: u64,
    }

    struct Credential<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        lock_until: u64,
        acc_reward_per_share: u128,
        stake: 0x2::balance::Balance<T0>,
    }

    struct PoolVersion has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun add_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0, T1>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 < arg0.end_time, 8);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0, 4);
        assert!((0x2::balance::value<T1>(&arg0.reward_vault) as u128) + (v1 as u128) <= 340282366920938463463374607431768211455, 11);
        refresh_pool<T0, T1>(arg0, v0);
        0x2::coin::put<T1>(&mut arg0.reward_vault, arg2);
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::add_reward<T0, T1>(v1);
    }

    public fun create_pool<T0, T1>(arg0: &0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg1) / 1000, 1);
        assert!(arg3 > arg2, 2);
        let v0 = 0x2::object::new(arg5);
        let v1 = Pool<T0, T1>{
            id                   : v0,
            enabled              : true,
            last_updated_time    : arg2,
            staked_amount        : 0,
            reward_vault         : 0x2::balance::zero<T1>(),
            reward_rate          : 0,
            start_time           : arg2,
            end_time             : arg3,
            acc_reward_per_share : 0,
            lock_duration        : arg4,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::create_pool<T0, T1>(0x2::object::uid_to_inner(&v0), arg2, arg3, arg4);
    }

    public fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 0);
        check_version<T0, T1>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 >= arg0.start_time, 10);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 3);
        assert!(v0 < arg0.end_time, 8);
        refresh_pool<T0, T1>(arg0, v0);
        let v2 = v0 + arg0.lock_duration;
        let v3 = Credential<T0, T1>{
            id                   : 0x2::object::new(arg3),
            lock_until           : v2,
            acc_reward_per_share : arg0.acc_reward_per_share,
            stake                : 0x2::coin::into_balance<T0>(arg2),
        };
        arg0.staked_amount = arg0.staked_amount + v1;
        let v4 = 0x2::tx_context::sender(arg3);
        0x2::transfer::transfer<Credential<T0, T1>>(v3, v4);
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::deposit<T0, T1>(v4, v1, v2);
    }

    public fun force_withdraw<T0, T1>(arg0: &0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.enabled, 12);
        let v0 = 0x2::balance::value<T1>(&arg1.reward_vault);
        pay_from_balance<T1>(0x2::balance::split<T1>(&mut arg1.reward_vault, v0), arg2, arg3);
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::force_withdraw<T0, T1>(v0, arg2);
    }

    public fun set_enabled<T0, T1>(arg0: &mut 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::AclControl, arg1: vector<u8>, arg2: &mut Pool<T0, T1>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::has_role(arg0, arg1, 0x2::tx_context::sender(arg4)), 3001);
        check_version<T0, T1>(arg2);
        arg2.enabled = arg3;
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::set_enabled<T0, T1>(arg3);
    }

    public fun set_end_time<T0, T1>(arg0: &mut 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::AclControl, arg1: vector<u8>, arg2: &mut Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::has_role(arg0, arg1, 0x2::tx_context::sender(arg5)), 3001);
        check_version<T0, T1>(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v0 < arg2.end_time, 8);
        assert!(arg4 > v0 && arg4 > arg2.start_time, 2);
        refresh_pool<T0, T1>(arg2, v0);
        arg2.end_time = arg4;
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::set_end_time<T0, T1>(arg4);
    }

    public fun set_lock_duration<T0, T1>(arg0: &0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::AclControl, arg1: vector<u8>, arg2: &mut Pool<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::has_role(arg0, arg1, 0x2::tx_context::sender(arg4)), 3001);
        check_version<T0, T1>(arg2);
        arg2.lock_duration = arg3;
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::set_lock_duration<T0, T1>(arg3);
    }

    public fun set_reward_rate<T0, T1>(arg0: &mut 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::AclControl, arg1: vector<u8>, arg2: &mut Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u128, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::has_role(arg0, arg1, 0x2::tx_context::sender(arg6)), 3001);
        check_version<T0, T1>(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        refresh_pool<T0, T1>(arg2, v0);
        assert!(arg5 > v0, 2);
        arg2.reward_rate = arg4;
        arg2.end_time = arg5;
        arg2.last_updated_time = v0;
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::set_reward_rate<T0, T1>(arg4, arg5);
    }

    public fun set_start_time<T0, T1>(arg0: &mut 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::AclControl, arg1: vector<u8>, arg2: &mut Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::has_role(arg0, arg1, 0x2::tx_context::sender(arg5)), 3001);
        check_version<T0, T1>(arg2);
        assert!(v0 < arg2.start_time, 7);
        assert!(arg4 >= v0 && arg4 < arg2.end_time, 1);
        refresh_pool<T0, T1>(arg2, v0);
        arg2.start_time = arg4;
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::set_start_time<T0, T1>(arg4);
    }

    public fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: Credential<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0, T1>(arg0);
        let v0 = &mut arg2;
        let v1 = claim_rewards_ptb<T0, T1>(arg0, arg1, v0, arg4);
        let v2 = &mut arg2;
        let v3 = withdraw_ptb<T0, T1>(arg0, arg1, v2, arg3, arg4);
        let v4 = 0x2::tx_context::sender(arg4);
        pay_from_balance<T1>(0x2::coin::into_balance<T1>(v1), v4, arg4);
        pay_from_balance<T0>(0x2::coin::into_balance<T0>(v3), v4, arg4);
        if (0x2::balance::value<T0>(&arg2.stake) == 0) {
            destory_credential<T0, T1>(arg2);
        } else {
            0x2::transfer::transfer<Credential<T0, T1>>(arg2, v4);
        };
    }

    public fun bump_pool_version<T0, T1>(arg0: &0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg1.id, b"POOL_VERSION")) {
            let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, PoolVersion>(&mut arg1.id, b"POOL_VERSION");
            let v1 = v0.version;
            let v2 = v1 + 1;
            assert!(v2 <= 2, 13);
            v0.version = v2;
            0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::pool_version_updated<T0, T1>(v1, v2);
        } else {
            let v3 = PoolVersion{
                id      : 0x2::object::new(arg2),
                version : 2,
            };
            0x2::dynamic_object_field::add<vector<u8>, PoolVersion>(&mut arg1.id, b"POOL_VERSION", v3);
            0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::pool_version_updated<T0, T1>(0, 2);
        };
    }

    fun check_version<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"POOL_VERSION"), 14);
        assert!(0x2::dynamic_object_field::borrow<vector<u8>, PoolVersion>(&arg0.id, b"POOL_VERSION").version <= 2, 13);
    }

    public fun claim_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut Credential<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0, T1>(arg0);
        let v0 = claim_rewards_ptb<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        pay_from_balance<T1>(0x2::coin::into_balance<T1>(v0), v1, arg3);
    }

    public fun claim_rewards_ptb<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut Credential<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.enabled, 0);
        check_version<T0, T1>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 >= 0x1::u64::min(arg2.lock_until, arg0.end_time), 6);
        refresh_pool<T0, T1>(arg0, v0);
        let v1 = ((((arg0.acc_reward_per_share - arg2.acc_reward_per_share) as u256) * (0x2::balance::value<T0>(&arg2.stake) as u256) / (1000000000000000000 as u256)) as u128);
        assert!(v1 <= 340282366920938463463374607431768211455, 11);
        arg2.acc_reward_per_share = arg0.acc_reward_per_share;
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::claim_reward<T0, T1>(0x2::tx_context::sender(arg3), (v1 as u64));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_vault, min_reward<T1>(&arg0.reward_vault, (v1 as u64))), arg3)
    }

    public fun clear_empty_credential<T0, T1>(arg0: Credential<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0.stake) == 0) {
            destory_credential<T0, T1>(arg0);
        } else {
            0x2::transfer::transfer<Credential<T0, T1>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    fun destory_credential<T0, T1>(arg0: Credential<T0, T1>) {
        assert!(0x2::balance::value<T0>(&arg0.stake) == 0, 9);
        let Credential {
            id                   : v0,
            lock_until           : _,
            acc_reward_per_share : _,
            stake                : v3,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v3);
    }

    fun min_reward<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : u64 {
        if (arg1 > 0x2::balance::value<T0>(arg0)) {
            return 0x2::balance::value<T0>(arg0)
        };
        arg1
    }

    fun pay_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    fun refresh_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        if (arg1 <= arg0.last_updated_time || arg1 < arg0.start_time) {
            return
        };
        let v0 = if (arg0.end_time < arg0.last_updated_time) {
            arg0.last_updated_time
        } else {
            arg0.end_time
        };
        let v1 = if (arg1 > v0) {
            v0
        } else {
            arg1
        };
        let v2 = if (v1 > arg0.last_updated_time) {
            if (arg0.staked_amount > 0) {
                arg0.reward_rate > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            let v3 = v1 - arg0.last_updated_time;
            assert!(340282366920938463463374607431768211455 / arg0.reward_rate >= (v3 as u128), 11);
            let v4 = (((((v3 as u128) * arg0.reward_rate) as u256) * (1000000000000000000 as u256) / (arg0.staked_amount as u256)) as u128);
            assert!(v4 <= 340282366920938463463374607431768211455, 11);
            assert!(340282366920938463463374607431768211455 - v4 >= arg0.acc_reward_per_share, 11);
            arg0.acc_reward_per_share = arg0.acc_reward_per_share + v4;
        };
        arg0.last_updated_time = v1;
    }

    public fun withdraw_ptb<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut Credential<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.enabled, 0);
        check_version<T0, T1>(arg0);
        assert!(0x2::balance::value<T0>(&arg2.stake) >= arg3, 5);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 >= 0x1::u64::min(arg2.lock_until, arg0.end_time), 6);
        refresh_pool<T0, T1>(arg0, v0);
        arg0.staked_amount = arg0.staked_amount - arg3;
        0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event::withdraw<T0, T1>(0x2::tx_context::sender(arg4), arg3, 0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.stake, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

