module 0x9b21d97979345362266d80f30acee2e739a025d803d54d56948e287aab46c3f5::locker {
    struct LockedPosition has key {
        id: 0x2::object::UID,
        position: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position,
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct CollectorCap has store, key {
        id: 0x2::object::UID,
        locker_id: 0x2::object::ID,
    }

    struct PositionLocked has copy, drop {
        locker_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct FeesCollected has copy, drop {
        locker_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct RewardsCollected has copy, drop {
        locker_id: 0x2::object::ID,
        amount: u64,
    }

    public fun collect_fee<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut LockedPosition, arg4: &CollectorCap) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert_collect_args<T0, T1>(arg2, arg3, arg4);
        let (v0, v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, &mut arg3.position);
        let v4 = FeesCollected{
            locker_id : 0x2::object::id<LockedPosition>(arg3),
            amount_a  : v0,
            amount_b  : v1,
        };
        0x2::event::emit<FeesCollected>(v4);
        (v2, v3)
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut LockedPosition, arg4: &CollectorCap) : 0x2::balance::Balance<T2> {
        assert_collect_args<T0, T1>(arg2, arg3, arg4);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3.position);
        let v1 = RewardsCollected{
            locker_id : 0x2::object::id<LockedPosition>(arg3),
            amount    : 0x2::balance::value<T2>(&v0),
        };
        0x2::event::emit<RewardsCollected>(v1);
        v0
    }

    public fun pool_id(arg0: &LockedPosition) : 0x2::object::ID {
        arg0.pool_id
    }

    fun assert_collect_args<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &LockedPosition, arg2: &CollectorCap) {
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0) == arg1.pool_id, 1);
        assert!(0x2::object::id<CollectorCap>(arg2) == arg1.cap_id, 2);
        assert!(arg2.locker_id == 0x2::object::id<LockedPosition>(arg1), 2);
    }

    public fun cap_id(arg0: &LockedPosition) : 0x2::object::ID {
        arg0.cap_id
    }

    public fun collect_fee_to_sender<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut LockedPosition, arg4: &CollectorCap, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = collect_fee<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x2::tx_context::sender(arg5);
        send_balance<T0>(v0, v2, arg5);
        let v3 = 0x2::tx_context::sender(arg5);
        send_balance<T1>(v1, v3, arg5);
    }

    public fun collect_reward_to_sender<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut LockedPosition, arg4: &CollectorCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        send_balance<T2>(collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4), v0, arg5);
    }

    public fun lock_position<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: &mut 0x2::tx_context::TxContext) : CollectorCap {
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(&arg1) == v0, 1);
        let v1 = LockedPosition{
            id       : 0x2::object::new(arg2),
            position : arg1,
            pool_id  : v0,
            cap_id   : 0x2::object::id_from_address(@0x0),
        };
        let v2 = 0x2::object::id<LockedPosition>(&v1);
        let v3 = CollectorCap{
            id        : 0x2::object::new(arg2),
            locker_id : v2,
        };
        let v4 = 0x2::object::id<CollectorCap>(&v3);
        v1.cap_id = v4;
        let v5 = PositionLocked{
            locker_id   : v2,
            pool_id     : v0,
            position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg1),
            cap_id      : v4,
        };
        0x2::event::emit<PositionLocked>(v5);
        0x2::transfer::share_object<LockedPosition>(v1);
        v3
    }

    public fun locker_id(arg0: &CollectorCap) : 0x2::object::ID {
        arg0.locker_id
    }

    fun send_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    // decompiled from Move bytecode v7
}

