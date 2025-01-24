module 0x24547a7c5ac57004b782f9c3c550e530319d2d25cbb0f8a13f8fa4f5ead92d48::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        enabled: bool,
        last_updated_time: u64,
        staked_amount: u64,
        reward: 0x2::balance::Balance<T1>,
        start_time: u64,
        end_time: u64,
        acc_reward_per_share: u128,
        lock_duration: u64,
    }

    struct Credential<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        lock_until: u64,
        acc_reward_per_share: u128,
        stake: 0x2::balance::Balance<T0>,
    }

    struct CreatePoolEvent<phantom T0, phantom T1> has copy, drop {
        id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
        lock_duration: u64,
    }

    struct SetEnabledEvent<phantom T0, phantom T1> has copy, drop {
        enabled: bool,
    }

    struct SetStartTimeEvent<phantom T0, phantom T1> has copy, drop {
        start_time: u64,
    }

    struct SetEndTimeEvent<phantom T0, phantom T1> has copy, drop {
        end_time: u64,
    }

    struct SetLockDurationEvent<phantom T0, phantom T1> has copy, drop {
        lock_duration: u64,
    }

    struct AddRewardEvent<phantom T0, phantom T1> has copy, drop {
        reward_amount: u64,
    }

    struct WithdrawRewardEvent<phantom T0, phantom T1> has copy, drop {
        withdraw_amount: u64,
    }

    struct DepositEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        deposit_amount: u64,
        lock_until: u64,
    }

    struct WithdrawEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        withdraw_amount: u64,
        reward_amount: u64,
    }

    public entry fun add_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 < arg0.end_time, 8);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0, 4);
        refresh_pool<T0, T1>(arg0, v0);
        0x2::coin::put<T1>(&mut arg0.reward, arg2);
        let v2 = AddRewardEvent<T0, T1>{reward_amount: v1};
        0x2::event::emit<AddRewardEvent<T0, T1>>(v2);
    }

    public entry fun clear_empty_credential<T0, T1>(arg0: Credential<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.stake) == 0, 9);
        let Credential {
            id                   : v0,
            pool_id              : _,
            lock_until           : _,
            acc_reward_per_share : _,
            stake                : v4,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v4);
    }

    public entry fun create_pool<T0, T1>(arg0: &0x24547a7c5ac57004b782f9c3c550e530319d2d25cbb0f8a13f8fa4f5ead92d48::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg1) / 1000, 1);
        assert!(arg3 > arg2, 2);
        let v0 = 0x2::object::new(arg5);
        let v1 = Pool<T0, T1>{
            id                   : v0,
            enabled              : true,
            last_updated_time    : arg2,
            staked_amount        : 0,
            reward               : 0x2::balance::zero<T1>(),
            start_time           : arg2,
            end_time             : arg3,
            acc_reward_per_share : 0,
            lock_duration        : arg4,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
        let v2 = CreatePoolEvent<T0, T1>{
            id            : 0x2::object::uid_to_inner(&v0),
            start_time    : arg2,
            end_time      : arg3,
            lock_duration : arg4,
        };
        0x2::event::emit<CreatePoolEvent<T0, T1>>(v2);
    }

    public entry fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 3);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v1 < arg0.end_time, 8);
        refresh_pool<T0, T1>(arg0, v1);
        let v2 = v1 + arg0.lock_duration;
        let v3 = Credential<T0, T1>{
            id                   : 0x2::object::new(arg3),
            pool_id              : 0x2::object::uid_to_inner(&arg0.id),
            lock_until           : v2,
            acc_reward_per_share : arg0.acc_reward_per_share,
            stake                : 0x2::coin::into_balance<T0>(arg2),
        };
        arg0.staked_amount = arg0.staked_amount + v0;
        let v4 = 0x2::tx_context::sender(arg3);
        0x2::transfer::transfer<Credential<T0, T1>>(v3, v4);
        let v5 = DepositEvent<T0, T1>{
            user           : v4,
            deposit_amount : v0,
            lock_until     : v2,
        };
        0x2::event::emit<DepositEvent<T0, T1>>(v5);
    }

    fun pay_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    fun refresh_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        if (arg1 == arg0.last_updated_time || arg1 < arg0.start_time) {
            return
        };
        if (arg0.last_updated_time == arg0.end_time) {
            return
        };
        if (arg0.staked_amount == 0) {
            return
        };
        if (arg1 > arg0.end_time) {
            arg1 = arg0.end_time;
        };
        arg0.last_updated_time = arg1;
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + (0x2::balance::value<T1>(&arg0.reward) as u128) * ((arg1 - arg0.last_updated_time) as u128) / ((arg0.end_time - arg0.last_updated_time) as u128) * 1000000000000000000 / (arg0.staked_amount as u128);
    }

    public entry fun set_enabled<T0, T1>(arg0: &0x24547a7c5ac57004b782f9c3c550e530319d2d25cbb0f8a13f8fa4f5ead92d48::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: bool) {
        arg1.enabled = arg2;
        let v0 = SetEnabledEvent<T0, T1>{enabled: arg2};
        0x2::event::emit<SetEnabledEvent<T0, T1>>(v0);
    }

    public entry fun set_end_time<T0, T1>(arg0: &0x24547a7c5ac57004b782f9c3c550e530319d2d25cbb0f8a13f8fa4f5ead92d48::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v0 < arg1.end_time, 8);
        assert!(arg3 > v0 && arg3 > arg1.start_time, 2);
        refresh_pool<T0, T1>(arg1, v0);
        arg1.end_time = arg3;
        let v1 = SetEndTimeEvent<T0, T1>{end_time: arg3};
        0x2::event::emit<SetEndTimeEvent<T0, T1>>(v1);
    }

    public entry fun set_lock_duration<T0, T1>(arg0: &0x24547a7c5ac57004b782f9c3c550e530319d2d25cbb0f8a13f8fa4f5ead92d48::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64) {
        arg1.lock_duration = arg2;
        let v0 = SetLockDurationEvent<T0, T1>{lock_duration: arg2};
        0x2::event::emit<SetLockDurationEvent<T0, T1>>(v0);
    }

    public entry fun set_start_time<T0, T1>(arg0: &0x24547a7c5ac57004b782f9c3c550e530319d2d25cbb0f8a13f8fa4f5ead92d48::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v0 < arg1.start_time, 7);
        assert!(arg3 >= v0 && arg3 < arg1.end_time, 1);
        refresh_pool<T0, T1>(arg1, v0);
        arg1.start_time = arg3;
        let v1 = SetStartTimeEvent<T0, T1>{start_time: arg3};
        0x2::event::emit<SetStartTimeEvent<T0, T1>>(v1);
    }

    public entry fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut Credential<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.pool_id == 0x2::object::id<Pool<T0, T1>>(arg0), 10);
        assert!(arg0.enabled, 0);
        let v0 = 0x2::balance::value<T0>(&arg2.stake);
        assert!(v0 >= arg3, 5);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v1 >= 0x1::u64::min(arg2.lock_until, arg0.end_time), 6);
        refresh_pool<T0, T1>(arg0, v1);
        arg2.acc_reward_per_share = arg0.acc_reward_per_share;
        arg0.staked_amount = arg0.staked_amount - arg3;
        let v2 = 0x2::tx_context::sender(arg4);
        pay_from_balance<T0>(0x2::balance::split<T0>(&mut arg2.stake, arg3), v2, arg4);
        let v3 = WithdrawEvent<T0, T1>{
            user            : v2,
            withdraw_amount : arg3,
            reward_amount   : (((arg0.acc_reward_per_share - arg2.acc_reward_per_share) * (v0 as u128) / 1000000000000000000) as u64),
        };
        0x2::event::emit<WithdrawEvent<T0, T1>>(v3);
    }

    public entry fun withdraw_reward<T0, T1>(arg0: &0x24547a7c5ac57004b782f9c3c550e530319d2d25cbb0f8a13f8fa4f5ead92d48::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        pay_from_balance<T1>(0x2::balance::split<T1>(&mut arg1.reward, arg2), v0, arg3);
        let v1 = WithdrawRewardEvent<T0, T1>{withdraw_amount: arg2};
        0x2::event::emit<WithdrawRewardEvent<T0, T1>>(v1);
    }

    // decompiled from Move bytecode v6
}

