module 0x33a04c672381c1de7178f56221e4ebfc4712675feecc2a0b70c25efbb500fc25::lp_lock {
    struct LpLock<T0: store + key> has key {
        id: 0x2::object::UID,
        agent: address,
        position: T0,
        locked_at_ms: u64,
        unlock_at_ms: u64,
    }

    struct LpLocked has copy, drop {
        lock_id: 0x2::object::ID,
        agent: address,
        position_id: 0x2::object::ID,
        locked_at_ms: u64,
        unlock_at_ms: u64,
    }

    struct FeesClaimed has copy, drop {
        lock_id: 0x2::object::ID,
        agent: address,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        amount_a: u64,
        amount_b: u64,
        timestamp_ms: u64,
    }

    struct RewardClaimed has copy, drop {
        lock_id: 0x2::object::ID,
        agent: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp_ms: u64,
    }

    struct LpWithdrawn has copy, drop {
        lock_id: 0x2::object::ID,
        agent: address,
        position_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    public fun collect_fee<T0, T1>(arg0: &LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg0.position, true);
        let v2 = v1;
        let v3 = v0;
        send_or_destroy<T0>(0x2::coin::from_balance<T0>(v3, arg4), arg0.agent);
        send_or_destroy<T1>(0x2::coin::from_balance<T1>(v2, arg4), arg0.agent);
        let v4 = FeesClaimed{
            lock_id      : 0x2::object::id<LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0),
            agent        : arg0.agent,
            coin_type_a  : 0x1::type_name::with_defining_ids<T0>(),
            coin_type_b  : 0x1::type_name::with_defining_ids<T1>(),
            amount_a     : 0x2::balance::value<T0>(&v3),
            amount_b     : 0x2::balance::value<T1>(&v2),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeesClaimed>(v4);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, &arg0.position, arg3, true, arg4);
        send_or_destroy<T2>(0x2::coin::from_balance<T2>(v0, arg5), arg0.agent);
        let v1 = RewardClaimed{
            lock_id      : 0x2::object::id<LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0),
            agent        : arg0.agent,
            coin_type    : 0x1::type_name::with_defining_ids<T2>(),
            amount       : 0x2::balance::value<T2>(&v0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RewardClaimed>(v1);
    }

    public fun agent<T0: store + key>(arg0: &LpLock<T0>) : address {
        arg0.agent
    }

    public fun lock<T0: store + key>(arg0: T0, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = LpLock<T0>{
            id           : 0x2::object::new(arg3),
            agent        : arg1,
            position     : arg0,
            locked_at_ms : v0,
            unlock_at_ms : v0 + 315360000000,
        };
        let v2 = 0x2::object::id<LpLock<T0>>(&v1);
        let v3 = LpLocked{
            lock_id      : v2,
            agent        : arg1,
            position_id  : 0x2::object::id<T0>(&v1.position),
            locked_at_ms : v0,
            unlock_at_ms : v0 + 315360000000,
        };
        0x2::event::emit<LpLocked>(v3);
        0x2::transfer::share_object<LpLock<T0>>(v1);
        v2
    }

    public fun locked_at_ms<T0: store + key>(arg0: &LpLock<T0>) : u64 {
        arg0.locked_at_ms
    }

    public fun position_id<T0: store + key>(arg0: &LpLock<T0>) : 0x2::object::ID {
        0x2::object::id<T0>(&arg0.position)
    }

    fun send_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public fun unlock_at_ms<T0: store + key>(arg0: &LpLock<T0>) : u64 {
        arg0.unlock_at_ms
    }

    public fun withdraw<T0: store + key>(arg0: LpLock<T0>, arg1: &0x2::clock::Clock) {
        let LpLock {
            id           : v0,
            agent        : v1,
            position     : v2,
            locked_at_ms : _,
            unlock_at_ms : v4,
        } = arg0;
        let v5 = v2;
        let v6 = v0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v4, 0);
        let v7 = LpWithdrawn{
            lock_id      : 0x2::object::uid_to_inner(&v6),
            agent        : v1,
            position_id  : 0x2::object::id<T0>(&v5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<LpWithdrawn>(v7);
        0x2::transfer::public_transfer<T0>(v5, v1);
        0x2::object::delete(v6);
    }

    // decompiled from Move bytecode v7
}

