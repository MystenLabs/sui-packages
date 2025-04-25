module 0x6e815f46579a2c86506480e344c757d2ab5beccb9bdc9a9b857118cfae3c2b00::wave_staking_v2 {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        version: u8,
        start_at: u64,
        end_at: u64,
        last_reward_time: u64,
        reward_per_second: u64,
        acc_reward_per_share: u256,
        total_staked_balance: 0x2::balance::Balance<T0>,
        total_reward_balance: 0x2::balance::Balance<T1>,
        lock_duration: u64,
        is_paused: bool,
        stake_factor: u64,
    }

    struct UserInfo has store {
        stake_amount: u64,
        reward_debt: u256,
        pending_reward: u64,
        lock_at: u64,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct PoolUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        reward_per_second: u64,
        end_at: u64,
        is_paused: bool,
    }

    struct RewardAdded has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct Staked has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct Withdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardWithdrawnByAdmin has copy, drop {
        pool_id: 0x2::object::ID,
        receiver: address,
        amount: u64,
    }

    public fun add_reward<T0, T1>(arg0: &OwnerCap, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        assert!(arg1.version <= 1, 4);
        let v0 = RewardAdded{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg1),
            amount  : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<RewardAdded>(v0);
        0x2::balance::join<T1>(&mut arg1.total_reward_balance, 0x2::coin::into_balance<T1>(arg2));
    }

    entry fun admin_withdraw_reward<T0, T1>(arg0: &OwnerCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version <= 1, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::balance::value<T1>(&arg1.total_reward_balance) >= arg2, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.total_reward_balance, arg2), arg3), v0);
        let v1 = RewardWithdrawnByAdmin{
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg1),
            receiver : v0,
            amount   : arg2,
        };
        0x2::event::emit<RewardWithdrawnByAdmin>(v1);
    }

    fun cal_acc_reward_per_share(arg0: u256, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u256 {
        if (arg1 == 0) {
            return arg0
        };
        let v0 = (0x1::u64::min(arg6, arg2) as u256);
        if (arg2 == 0) {
            v0 = (arg6 as u256);
        };
        if (v0 < (arg5 as u256)) {
            return arg0
        };
        arg0 + (v0 - (arg5 as u256)) * (arg3 as u256) * (arg4 as u256) / (arg1 as u256)
    }

    fun cal_pending_reward(arg0: u64, arg1: u64, arg2: u256, arg3: u256) : u64 {
        (((arg0 as u256) * arg3 / (arg1 as u256) - arg2) as u64)
    }

    fun calculate_reward_debt(arg0: u64, arg1: u64, arg2: u256) : u256 {
        (arg0 as u256) * arg2 / (arg1 as u256)
    }

    public fun create_pool<T0, T1>(arg0: &OwnerCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        let v1 = Pool<T0, T1>{
            id                   : v0,
            version              : 1,
            start_at             : arg1,
            end_at               : arg2,
            last_reward_time     : arg1,
            reward_per_second    : arg3,
            acc_reward_per_share : 0,
            total_staked_balance : 0x2::balance::zero<T0>(),
            total_reward_balance : 0x2::balance::zero<T1>(),
            lock_duration        : arg4,
            is_paused            : false,
            stake_factor         : 0x1::u64::pow(10, arg5),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
        let v2 = PoolCreated{pool_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<PoolCreated>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate<T0, T1>(arg0: &OwnerCap, arg1: &mut Pool<T0, T1>) {
        assert!(arg1.version < 1, 7);
        arg1.version = 1;
    }

    public fun pending_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::dynamic_field::borrow<address, UserInfo>(&arg0.id, 0x2::tx_context::sender(arg2));
        0x1::u64::min(cal_pending_reward(v0.stake_amount, arg0.stake_factor, v0.reward_debt, cal_acc_reward_per_share(arg0.acc_reward_per_share, 0x2::balance::value<T0>(&arg0.total_staked_balance), arg0.end_at, arg0.reward_per_second, arg0.stake_factor, arg0.last_reward_time, 0x2::clock::timestamp_ms(arg1) / 1000)) + v0.pending_reward, 0x2::balance::value<T1>(&arg0.total_reward_balance))
    }

    public fun stake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 4);
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(arg0.end_at == 0 || arg0.end_at > v0, 6);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 1);
        let v2 = 0x2::tx_context::sender(arg3);
        if (!0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg0.id, v2)) {
            let v3 = UserInfo{
                stake_amount   : 0,
                reward_debt    : 0,
                pending_reward : 0,
                lock_at        : 0,
            };
            0x2::dynamic_field::add<address, UserInfo>(&mut arg0.id, v2, v3);
        };
        update_pool<T0, T1>(arg0, arg2);
        let v4 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg0.id, v2);
        if (v4.stake_amount > 0) {
            v4.pending_reward = v4.pending_reward + cal_pending_reward(v4.stake_amount, arg0.stake_factor, v4.reward_debt, arg0.acc_reward_per_share);
        };
        v4.lock_at = v0;
        v4.stake_amount = v4.stake_amount + v1;
        v4.reward_debt = calculate_reward_debt(v4.stake_amount, arg0.stake_factor, arg0.acc_reward_per_share);
        0x2::balance::join<T0>(&mut arg0.total_staked_balance, 0x2::coin::into_balance<T0>(arg1));
        let v5 = Staked{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
            user      : v2,
            amount    : v1,
            timestamp : v0,
        };
        0x2::event::emit<Staked>(v5);
    }

    fun update_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (arg0.last_reward_time >= v0 || arg0.start_at > v0) {
            return
        };
        let v1 = 0x2::balance::value<T0>(&arg0.total_staked_balance);
        if (v1 == 0) {
            arg0.last_reward_time = v0;
            return
        };
        let v2 = cal_acc_reward_per_share(arg0.acc_reward_per_share, v1, arg0.end_at, arg0.reward_per_second, arg0.stake_factor, arg0.last_reward_time, v0);
        if (arg0.acc_reward_per_share == v2) {
            return
        };
        arg0.acc_reward_per_share = v2;
        arg0.last_reward_time = v0;
    }

    public entry fun update_pool_config<T0, T1>(arg0: &OwnerCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) {
        assert!(arg1.version <= 1, 4);
        update_pool<T0, T1>(arg1, arg6);
        arg1.reward_per_second = arg2;
        arg1.end_at = arg4;
        arg1.start_at = arg3;
        arg1.is_paused = arg5;
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        if (arg1.start_at > v0 && arg3 > v0) {
            arg1.last_reward_time = arg3;
        };
        let v1 = PoolUpdated{
            pool_id           : 0x2::object::id<Pool<T0, T1>>(arg1),
            reward_per_second : arg2,
            end_at            : arg4,
            is_paused         : arg5,
        };
        0x2::event::emit<PoolUpdated>(v1);
    }

    public fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.version <= 1, 4);
        assert!(!arg0.is_paused, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        update_pool<T0, T1>(arg0, arg2);
        assert!(0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg0.id, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v1.lock_at + arg0.lock_duration <= v2 || v2 >= arg0.end_at, 5);
        assert!(arg1 > 0, 1);
        assert!(v1.stake_amount >= arg1, 2);
        let v3 = 0x1::u64::min(v1.pending_reward + cal_pending_reward(v1.stake_amount, arg0.stake_factor, v1.reward_debt, arg0.acc_reward_per_share), 0x2::balance::value<T1>(&arg0.total_reward_balance));
        let v4 = 0x2::coin::zero<T0>(arg3);
        let v5 = 0x2::coin::zero<T1>(arg3);
        if (v3 != 0) {
            0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(&mut v5), 0x2::balance::split<T1>(&mut arg0.total_reward_balance, v3));
        };
        v1.stake_amount = v1.stake_amount - arg1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut v4), 0x2::balance::split<T0>(&mut arg0.total_staked_balance, arg1));
        v1.reward_debt = calculate_reward_debt(v1.stake_amount, arg0.stake_factor, arg0.acc_reward_per_share);
        v1.pending_reward = 0;
        let v6 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v7 = RewardClaimed{
            pool_id   : v6,
            user      : v0,
            amount    : v3,
            timestamp : v2,
        };
        0x2::event::emit<RewardClaimed>(v7);
        let v8 = Withdrawn{
            pool_id   : v6,
            user      : v0,
            amount    : arg1,
            timestamp : v2,
        };
        0x2::event::emit<Withdrawn>(v8);
        (v4, v5)
    }

    // decompiled from Move bytecode v6
}

