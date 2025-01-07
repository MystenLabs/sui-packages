module 0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserPosition<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        staked_amount: u64,
        last_acc_reward_per_share: u128,
    }

    struct GlobalStorage has key {
        id: 0x2::object::UID,
        pools: 0x2::object_bag::ObjectBag,
        position_manager: 0x2::object_bag::ObjectBag,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        reward_remaining: u64,
        stake: 0x2::coin::Coin<T0>,
        reward: 0x2::coin::Coin<T1>,
        last_update_time: u64,
        acc_reward_per_share: u128,
    }

    struct PositionManager<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        all_positions: 0x2::object_table::ObjectTable<address, UserPosition<T0, T1>>,
    }

    struct EventCreatePoolList has copy, drop {
        id: 0x2::object::ID,
    }

    struct EventCreatePool<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        pos_manager_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
        reward: u64,
    }

    struct EventStake<phantom T0, phantom T1> has copy, drop {
        user: address,
        stake_amount: u64,
        user_reward_amount: u64,
        user_staked_amount: u64,
        total_staked_amount: u64,
        reward_remaining: u64,
        acc_reward_per_share: u128,
        timestamp: u64,
    }

    struct EventUnstake<phantom T0, phantom T1> has copy, drop {
        user: address,
        unstake_amount: u64,
        user_reward_amount: u64,
        user_staked_amount: u64,
        total_amount_staked: u64,
        reward_remaining: u64,
        acc_reward_per_share: u128,
        timestamp: u64,
    }

    struct EventClaim<phantom T0, phantom T1> has copy, drop {
        user: address,
        reward_amount: u64,
        total_amount_staked: u64,
        reward_remaining: u64,
        acc_reward_per_share: u128,
        timestamp: u64,
    }

    struct EventEarlyEnd<phantom T0, phantom T1> has copy, drop {
        admin: address,
        reward_return: u64,
        timestamp: u64,
    }

    struct EventIncreaseRewardAndTime<phantom T0, phantom T1> has copy, drop {
        admin: address,
        start_time: u64,
        end_time: u64,
        reward_remaining: u64,
        total_amount_staked: u64,
        acc_reward_per_share: u128,
        timestamp: u64,
    }

    struct EventDecreaseRewardAndTime<phantom T0, phantom T1> has copy, drop {
        admin: address,
        start_time: u64,
        end_time: u64,
        reward_remaining: u64,
        total_amount_staked: u64,
        acc_reward_per_share: u128,
        timestamp: u64,
    }

    public fun stake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut GlobalStorage, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = &mut arg1.pools;
        let v1 = borrow_mut_pool<T0, T1>(v0);
        let v2 = &mut arg1.position_manager;
        let v3 = borrow_mut_position_manager<T0, T1>(v2);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 10005);
        let v4 = 0x2::clock::timestamp_ms(arg0);
        assert!(v1.end_time > v4, 10006);
        let v5 = cal_update_pool_stake<T0, T1>(v1, v4);
        let v6 = 0x2::coin::value<T0>(&arg2);
        0x2::coin::join<T0>(&mut v5.stake, arg2);
        if (!is_staking<T0, T1>(v3, 0x2::tx_context::sender(arg3))) {
            let v7 = UserPosition<T0, T1>{
                id                        : 0x2::object::new(arg3),
                staked_amount             : v6,
                last_acc_reward_per_share : v5.acc_reward_per_share,
            };
            mark_staking<T0, T1>(v3, 0x2::tx_context::sender(arg3), v7);
            let v8 = EventStake<T0, T1>{
                user                 : 0x2::tx_context::sender(arg3),
                stake_amount         : v6,
                user_reward_amount   : 0,
                user_staked_amount   : v6,
                total_staked_amount  : 0x2::coin::value<T0>(&v5.stake),
                reward_remaining     : v5.reward_remaining,
                acc_reward_per_share : v5.acc_reward_per_share,
                timestamp            : v4,
            };
            0x2::event::emit<EventStake<T0, T1>>(v8);
            return 0x2::coin::zero<T1>(arg3)
        };
        let v9 = get_staking<T0, T1>(v3, 0x2::tx_context::sender(arg3));
        let v10 = cal_pending_rewards<T0, T1>(v5, v9);
        v9.staked_amount = v9.staked_amount + v6;
        v9.last_acc_reward_per_share = v5.acc_reward_per_share;
        let v11 = EventStake<T0, T1>{
            user                 : 0x2::tx_context::sender(arg3),
            stake_amount         : v6,
            user_reward_amount   : v10,
            user_staked_amount   : v9.staked_amount,
            total_staked_amount  : 0x2::coin::value<T0>(&v5.stake),
            reward_remaining     : v5.reward_remaining,
            acc_reward_per_share : v5.acc_reward_per_share,
            timestamp            : v4,
        };
        0x2::event::emit<EventStake<T0, T1>>(v11);
        0x2::coin::split<T1>(&mut v5.reward, v10, arg3)
    }

    public fun acc_reward_per_share<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.acc_reward_per_share
    }

    fun borrow_mut_pool<T0, T1>(arg0: &mut 0x2::object_bag::ObjectBag) : &mut Pool<T0, T1> {
        0x2::object_bag::borrow_mut<0x1::type_name::TypeName, Pool<T0, T1>>(arg0, 0x1::type_name::get<Pool<T0, T1>>())
    }

    fun borrow_mut_position_manager<T0, T1>(arg0: &mut 0x2::object_bag::ObjectBag) : &mut PositionManager<T0, T1> {
        0x2::object_bag::borrow_mut<0x1::type_name::TypeName, PositionManager<T0, T1>>(arg0, 0x1::type_name::get<PositionManager<T0, T1>>())
    }

    fun borrow_position_manager<T0, T1>(arg0: &0x2::object_bag::ObjectBag) : &PositionManager<T0, T1> {
        0x2::object_bag::borrow<0x1::type_name::TypeName, PositionManager<T0, T1>>(arg0, 0x1::type_name::get<PositionManager<T0, T1>>())
    }

    fun cal_pending_rewards<T0, T1>(arg0: &Pool<T0, T1>, arg1: &UserPosition<T0, T1>) : u64 {
        (((arg1.staked_amount as u128) * (arg0.acc_reward_per_share - arg1.last_acc_reward_per_share) / 1000000000000) as u64)
    }

    fun cal_update_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : &mut Pool<T0, T1> {
        let v0 = 0x2::coin::value<T0>(&arg0.stake);
        if (v0 == 0) {
            arg0.last_update_time = arg1;
            return arg0
        };
        let v1 = (arg0.reward_remaining as u128);
        if (arg1 < arg0.end_time) {
            v1 = ((arg1 - arg0.last_update_time) as u128) * (arg0.reward_remaining as u128) / ((arg0.end_time as u128) - (arg0.last_update_time as u128));
        };
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + v1 * 1000000000000 / (v0 as u128);
        let v2 = arg0.reward_remaining - (v1 as u64);
        assert!(v2 <= 0x2::coin::value<T1>(&arg0.reward), 10007);
        arg0.reward_remaining = v2;
        arg0.last_update_time = arg1;
        arg0
    }

    fun cal_update_pool_stake<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : &mut Pool<T0, T1> {
        if (arg1 <= arg0.last_update_time || arg0.last_update_time >= arg0.end_time) {
            return arg0
        };
        cal_update_pool<T0, T1>(arg0, arg1)
    }

    public fun claim<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut GlobalStorage, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = &mut arg1.pools;
        let v1 = borrow_mut_pool<T0, T1>(v0);
        let v2 = &mut arg1.position_manager;
        let v3 = borrow_mut_position_manager<T0, T1>(v2);
        let v4 = 0x2::clock::timestamp_ms(arg0);
        let v5 = cal_update_pool_stake<T0, T1>(v1, v4);
        let v6 = get_staking<T0, T1>(v3, 0x2::tx_context::sender(arg2));
        let v7 = cal_pending_rewards<T0, T1>(v5, v6);
        v6.last_acc_reward_per_share = v5.acc_reward_per_share;
        let v8 = EventClaim<T0, T1>{
            user                 : 0x2::tx_context::sender(arg2),
            reward_amount        : v7,
            total_amount_staked  : 0x2::coin::value<T0>(&v5.stake),
            reward_remaining     : v5.reward_remaining,
            acc_reward_per_share : v5.acc_reward_per_share,
            timestamp            : v4,
        };
        0x2::event::emit<EventClaim<T0, T1>>(v8);
        0x2::coin::split<T1>(&mut v5.reward, v7, arg2)
    }

    public fun create_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut GlobalStorage, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<Pool<T0, T1>>();
        assert!(!0x2::object_bag::contains_with_type<0x1::type_name::TypeName, Pool<T0, T1>>(&arg1.pools, v0), 10001);
        let v1 = 0x1::type_name::get<PositionManager<T0, T1>>();
        assert!(!0x2::object_bag::contains_with_type<0x1::type_name::TypeName, PositionManager<T0, T1>>(&arg1.pools, v1), 10013);
        assert!(arg2 >= 86400000, 10002);
        assert!(arg2 <= 31536000000, 10003);
        assert!(0x2::coin::value<T1>(&arg3) > 0, 10004);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = v2 + arg2;
        let v4 = 0x2::coin::value<T1>(&arg3);
        let v5 = Pool<T0, T1>{
            id                   : 0x2::object::new(arg4),
            start_time           : v2,
            end_time             : v3,
            reward_remaining     : v4,
            stake                : 0x2::coin::zero<T0>(arg4),
            reward               : arg3,
            last_update_time     : v2,
            acc_reward_per_share : 0,
        };
        0x2::object_bag::add<0x1::type_name::TypeName, Pool<T0, T1>>(&mut arg1.pools, v0, v5);
        let v6 = PositionManager<T0, T1>{
            id            : 0x2::object::new(arg4),
            all_positions : 0x2::object_table::new<address, UserPosition<T0, T1>>(arg4),
        };
        0x2::object_bag::add<0x1::type_name::TypeName, PositionManager<T0, T1>>(&mut arg1.position_manager, v1, v6);
        let v7 = EventCreatePool<T0, T1>{
            pool_id        : 0x2::object::id<Pool<T0, T1>>(&v5),
            pos_manager_id : 0x2::object::id<PositionManager<T0, T1>>(&v6),
            start_time     : v2,
            end_time       : v3,
            reward         : v4,
        };
        0x2::event::emit<EventCreatePool<T0, T1>>(v7);
    }

    public entry fun decrease_reward_and_time<T0, T1>(arg0: &AdminCap, arg1: &mut GlobalStorage, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.pools;
        let v1 = borrow_mut_pool<T0, T1>(v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        cal_update_pool<T0, T1>(v1, v2);
        if (arg3 > 0) {
            assert!(v1.reward_remaining >= arg3, 10016);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v1.reward, arg3, arg5), 0x2::tx_context::sender(arg5));
            v1.reward_remaining = v1.reward_remaining - arg3;
            if (v1.reward_remaining == 0) {
                v1.end_time = v2;
            };
        };
        assert!(0x2::coin::value<T1>(&v1.reward) >= v1.reward_remaining, 10017);
        if (arg4 > 0) {
            assert!(arg4 < v1.end_time, 10015);
            v1.end_time = v1.end_time - arg4;
            assert!(v1.end_time > v2, 10015);
        };
        if (v1.reward_remaining > 0) {
            assert!(v1.end_time > v2, 10015);
        };
        if (v1.end_time > v2) {
            assert!(v1.end_time - v1.start_time <= 31536000000, 10015);
            assert!(v1.end_time - v1.start_time >= 86400000, 10015);
        };
        let v3 = EventIncreaseRewardAndTime<T0, T1>{
            admin                : 0x2::tx_context::sender(arg5),
            start_time           : v1.start_time,
            end_time             : v1.end_time,
            reward_remaining     : v1.reward_remaining,
            total_amount_staked  : 0x2::coin::value<T0>(&v1.stake),
            acc_reward_per_share : v1.acc_reward_per_share,
            timestamp            : v2,
        };
        0x2::event::emit<EventIncreaseRewardAndTime<T0, T1>>(v3);
    }

    public fun early_end<T0, T1>(arg0: &AdminCap, arg1: &mut GlobalStorage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = &mut arg1.pools;
        let v1 = borrow_mut_pool<T0, T1>(v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0x2::coin::split<T1>(&mut v1.reward, v1.reward_remaining, arg3);
        v1.end_time = v2;
        v1.reward_remaining = 0;
        let v4 = EventEarlyEnd<T0, T1>{
            admin         : 0x2::tx_context::sender(arg3),
            reward_return : 0x2::coin::value<T1>(&v3),
            timestamp     : v2,
        };
        0x2::event::emit<EventEarlyEnd<T0, T1>>(v4);
        v3
    }

    public fun end_time<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.end_time
    }

    fun get_staking<T0, T1>(arg0: &mut PositionManager<T0, T1>, arg1: address) : &mut UserPosition<T0, T1> {
        assert!(is_staking<T0, T1>(arg0, arg1), 10008);
        0x2::object_table::borrow_mut<address, UserPosition<T0, T1>>(&mut arg0.all_positions, arg1)
    }

    public entry fun increase_reward_and_time<T0, T1>(arg0: &AdminCap, arg1: &mut GlobalStorage, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.pools;
        let v1 = borrow_mut_pool<T0, T1>(v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        cal_update_pool<T0, T1>(v1, v2);
        let v3 = 0x2::coin::value<T1>(&arg3);
        if (v3 > 0) {
            0x2::coin::join<T1>(&mut v1.reward, arg3);
            v1.reward_remaining = v1.reward_remaining + v3;
        } else {
            0x2::coin::destroy_zero<T1>(arg3);
        };
        if (arg4 > 0) {
            if (v2 >= v1.end_time) {
                v1.start_time = v2;
                v1.end_time = v2 + arg4;
            } else {
                v1.end_time = v1.end_time + arg4;
            };
        };
        if (v1.reward_remaining > 0) {
            assert!(v1.end_time > v2, 10015);
        };
        if (v1.end_time > v2) {
            assert!(v1.end_time - v1.start_time <= 31536000000, 10015);
            assert!(v1.end_time - v1.start_time >= 86400000, 10015);
        };
        let v4 = EventIncreaseRewardAndTime<T0, T1>{
            admin                : 0x2::tx_context::sender(arg5),
            start_time           : v1.start_time,
            end_time             : v1.end_time,
            reward_remaining     : v1.reward_remaining,
            total_amount_staked  : 0x2::coin::value<T0>(&v1.stake),
            acc_reward_per_share : v1.acc_reward_per_share,
            timestamp            : v2,
        };
        0x2::event::emit<EventIncreaseRewardAndTime<T0, T1>>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = GlobalStorage{
            id               : v0,
            pools            : 0x2::object_bag::new(arg0),
            position_manager : 0x2::object_bag::new(arg0),
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        let v3 = EventCreatePoolList{id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<EventCreatePoolList>(v3);
        0x2::transfer::share_object<GlobalStorage>(v1);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun is_staking<T0, T1>(arg0: &PositionManager<T0, T1>, arg1: address) : bool {
        0x2::object_table::contains<address, UserPosition<T0, T1>>(&arg0.all_positions, arg1)
    }

    public fun last_acc_reward_per_share<T0, T1>(arg0: &UserPosition<T0, T1>) : u128 {
        arg0.last_acc_reward_per_share
    }

    public fun last_time_update<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.last_update_time
    }

    fun mark_staking<T0, T1>(arg0: &mut PositionManager<T0, T1>, arg1: address, arg2: UserPosition<T0, T1>) {
        assert!(!is_staking<T0, T1>(arg0, arg1), 10009);
        0x2::object_table::add<address, UserPosition<T0, T1>>(&mut arg0.all_positions, arg1, arg2);
    }

    public fun reward_remain<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.reward_remaining
    }

    public fun staked_amount<T0, T1>(arg0: &UserPosition<T0, T1>) : u64 {
        arg0.staked_amount
    }

    public fun start_time<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.start_time
    }

    public fun unstake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut GlobalStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2 > 0, 10011);
        let v0 = &mut arg1.pools;
        let v1 = borrow_mut_pool<T0, T1>(v0);
        let v2 = &mut arg1.position_manager;
        let v3 = borrow_mut_position_manager<T0, T1>(v2);
        let v4 = 0x2::clock::timestamp_ms(arg0);
        let v5 = cal_update_pool<T0, T1>(v1, v4);
        let v6 = get_staking<T0, T1>(v3, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= v6.staked_amount, 10014);
        let v7 = cal_pending_rewards<T0, T1>(v5, v6);
        v6.staked_amount = v6.staked_amount - arg2;
        v6.last_acc_reward_per_share = v5.acc_reward_per_share;
        let v8 = EventUnstake<T0, T1>{
            user                 : 0x2::tx_context::sender(arg3),
            unstake_amount       : arg2,
            user_reward_amount   : (v7 as u64),
            user_staked_amount   : v6.staked_amount,
            total_amount_staked  : 0x2::coin::value<T0>(&v5.stake),
            reward_remaining     : v5.reward_remaining,
            acc_reward_per_share : v5.acc_reward_per_share,
            timestamp            : v4,
        };
        0x2::event::emit<EventUnstake<T0, T1>>(v8);
        (0x2::coin::split<T0>(&mut v5.stake, arg2, arg3), 0x2::coin::split<T1>(&mut v5.reward, v7, arg3))
    }

    // decompiled from Move bytecode v6
}

