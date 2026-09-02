module 0x5ab27e275f349447c34592868d34f5a03b93ee4d8e884a516b798e6fc85f8404::lp_lock {
    struct LpLock<T0: store + key> has key {
        id: 0x2::object::UID,
        position: 0x1::option::Option<T0>,
        pool_id: 0x2::object::ID,
        unlock_ms: u64,
        locked_at_ms: u64,
        beneficiary: address,
        creator: address,
        liquidity_at_lock: u128,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_at_lock: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        amount_a_at_lock: u64,
        amount_b_at_lock: u64,
    }

    struct LpLocked has copy, drop {
        lock_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        liquidity: u128,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_at_lock: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        amount_a: u64,
        amount_b: u64,
        unlock_ms: u64,
        creator: address,
        beneficiary: address,
    }

    struct LpClaimed has copy, drop {
        lock_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        beneficiary: address,
    }

    struct LpExtended has copy, drop {
        lock_id: 0x2::object::ID,
        old_unlock_ms: u64,
        new_unlock_ms: u64,
    }

    struct LpDestroyed has copy, drop {
        lock_id: 0x2::object::ID,
        beneficiary: address,
    }

    struct FeesCollected has copy, drop {
        lock_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        amount_a: u64,
        amount_b: u64,
        beneficiary: address,
    }

    struct RewardsCollected has copy, drop {
        lock_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        beneficiary: address,
    }

    struct LiquidityAdded has copy, drop {
        lock_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        delta: u128,
        new_liquidity: u128,
        amount_a: u64,
        amount_b: u64,
        payer: address,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 3);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == arg0.pool_id, 7);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position), arg5, arg8);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        assert!(v2 <= arg6 && v3 <= arg7, 9);
        assert!(0x2::coin::value<T0>(&arg3) >= v2, 8);
        assert!(0x2::coin::value<T1>(&arg4) >= v3, 8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v2, arg9)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v3, arg9)), v1);
        let v4 = LiquidityAdded{
            lock_id       : 0x2::object::id<LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0),
            pool_id       : arg0.pool_id,
            delta         : arg5,
            new_liquidity : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_liquidity(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)))),
            amount_a      : v2,
            amount_b      : v3,
            payer         : v0,
        };
        0x2::event::emit<LiquidityAdded>(v4);
        pay<T0>(arg3, v0);
        pay<T1>(arg4, v0);
    }

    public fun collect_fee<T0, T1>(arg0: &LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 3);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == arg0.pool_id, 7);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), true);
        let v2 = v1;
        let v3 = v0;
        let v4 = FeesCollected{
            lock_id     : 0x2::object::id<LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0),
            pool_id     : arg0.pool_id,
            coin_type_a : 0x1::type_name::with_defining_ids<T0>(),
            coin_type_b : 0x1::type_name::with_defining_ids<T1>(),
            amount_a    : 0x2::balance::value<T0>(&v3),
            amount_b    : 0x2::balance::value<T1>(&v2),
            beneficiary : arg0.beneficiary,
        };
        0x2::event::emit<FeesCollected>(v4);
        pay<T0>(0x2::coin::from_balance<T0>(v3, arg3), arg0.beneficiary);
        pay<T1>(0x2::coin::from_balance<T1>(v2, arg3), arg0.beneficiary);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 3);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == arg0.pool_id, 7);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), arg3, true, arg4);
        let v1 = RewardsCollected{
            lock_id     : 0x2::object::id<LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0),
            pool_id     : arg0.pool_id,
            reward_type : 0x1::type_name::with_defining_ids<T2>(),
            amount      : 0x2::balance::value<T2>(&v0),
            beneficiary : arg0.beneficiary,
        };
        0x2::event::emit<RewardsCollected>(v1);
        pay<T2>(0x2::coin::from_balance<T2>(v0, arg5), arg0.beneficiary);
    }

    public fun pool_id<T0: store + key>(arg0: &LpLock<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun amounts_at_lock<T0: store + key>(arg0: &LpLock<T0>) : (u64, u64) {
        (arg0.amount_a_at_lock, arg0.amount_b_at_lock)
    }

    public fun beneficiary<T0: store + key>(arg0: &LpLock<T0>) : address {
        arg0.beneficiary
    }

    public fun claim<T0: store + key>(arg0: &mut LpLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms, 0);
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        assert!(0x1::option::is_some<T0>(&arg0.position), 3);
        let v0 = 0x1::option::extract<T0>(&mut arg0.position);
        let v1 = LpClaimed{
            lock_id     : 0x2::object::id<LpLock<T0>>(arg0),
            position_id : 0x2::object::id<T0>(&v0),
            beneficiary : arg0.beneficiary,
        };
        0x2::event::emit<LpClaimed>(v1);
        0x2::transfer::public_transfer<T0>(v0, arg0.beneficiary);
    }

    public fun creator<T0: store + key>(arg0: &LpLock<T0>) : address {
        arg0.creator
    }

    public fun destroy_claimed<T0: store + key>(arg0: LpLock<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.beneficiary, 1);
        assert!(0x1::option::is_none<T0>(&arg0.position), 0);
        let v0 = LpDestroyed{
            lock_id     : 0x2::object::id<LpLock<T0>>(&arg0),
            beneficiary : arg0.beneficiary,
        };
        0x2::event::emit<LpDestroyed>(v0);
        let LpLock {
            id                : v1,
            position          : v2,
            pool_id           : _,
            unlock_ms         : _,
            locked_at_ms      : _,
            beneficiary       : _,
            creator           : _,
            liquidity_at_lock : _,
            tick_lower        : _,
            tick_upper        : _,
            tick_at_lock      : _,
            amount_a_at_lock  : _,
            amount_b_at_lock  : _,
        } = arg0;
        0x1::option::destroy_none<T0>(v2);
        0x2::object::delete(v1);
    }

    public fun extend<T0: store + key>(arg0: &mut LpLock<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        assert!(0x1::option::is_some<T0>(&arg0.position), 3);
        assert!(arg1 > arg0.unlock_ms, 4);
        let v0 = LpExtended{
            lock_id       : 0x2::object::id<LpLock<T0>>(arg0),
            old_unlock_ms : arg0.unlock_ms,
            new_unlock_ms : arg1,
        };
        0x2::event::emit<LpExtended>(v0);
        arg0.unlock_ms = arg1;
    }

    public fun is_claimed<T0: store + key>(arg0: &LpLock<T0>) : bool {
        0x1::option::is_none<T0>(&arg0.position)
    }

    public fun liquidity<T0, T1>(arg0: &LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == arg0.pool_id, 7);
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)) {
            0
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_liquidity(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position))))
        }
    }

    public fun liquidity_at_lock<T0: store + key>(arg0: &LpLock<T0>) : u128 {
        arg0.liquidity_at_lock
    }

    public fun lock<T0, T1>(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg4), 2);
        assert!(arg3 != @0x0, 5);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg0) == v0, 7);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg1, v1);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_tick_range(v2);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_liquidity(v2);
        assert!(v5 > 0, 6);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T0, T1>(arg1, v1);
        let v9 = LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>{
            id                : 0x2::object::new(arg5),
            position          : 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0),
            pool_id           : v0,
            unlock_ms         : arg2,
            locked_at_ms      : 0x2::clock::timestamp_ms(arg4),
            beneficiary       : arg3,
            creator           : 0x2::tx_context::sender(arg5),
            liquidity_at_lock : v5,
            tick_lower        : v3,
            tick_upper        : v4,
            tick_at_lock      : v6,
            amount_a_at_lock  : v7,
            amount_b_at_lock  : v8,
        };
        let v10 = LpLocked{
            lock_id      : 0x2::object::id<LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(&v9),
            position_id  : v1,
            pool_id      : v0,
            coin_type_a  : 0x1::type_name::with_defining_ids<T0>(),
            coin_type_b  : 0x1::type_name::with_defining_ids<T1>(),
            liquidity    : v5,
            tick_lower   : v3,
            tick_upper   : v4,
            tick_at_lock : v6,
            amount_a     : v7,
            amount_b     : v8,
            unlock_ms    : arg2,
            creator      : 0x2::tx_context::sender(arg5),
            beneficiary  : arg3,
        };
        0x2::event::emit<LpLocked>(v10);
        0x2::transfer::share_object<LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(v9);
    }

    public fun lock_self<T0, T1>(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        lock<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4);
    }

    public fun locked_at_ms<T0: store + key>(arg0: &LpLock<T0>) : u64 {
        arg0.locked_at_ms
    }

    fun pay<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public fun tick_at_lock<T0: store + key>(arg0: &LpLock<T0>) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.tick_at_lock
    }

    public fun tick_range<T0: store + key>(arg0: &LpLock<T0>) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        (arg0.tick_lower, arg0.tick_upper)
    }

    public fun unlock_ms<T0: store + key>(arg0: &LpLock<T0>) : u64 {
        arg0.unlock_ms
    }

    // decompiled from Move bytecode v7
}

