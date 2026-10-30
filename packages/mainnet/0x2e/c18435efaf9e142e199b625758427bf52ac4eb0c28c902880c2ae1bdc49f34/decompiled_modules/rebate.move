module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::rebate {
    struct RebateBudget<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        funds: 0x2::balance::Balance<T0>,
        funded_total: u64,
        counted: 0x2::table::Table<address, u64>,
        live: bool,
    }

    struct RebateLock<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        budget: 0x2::object::ID,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        rebate: 0x2::balance::Balance<T0>,
        start_ms: u64,
    }

    struct RebateEvent has copy, drop {
        owner: address,
        kind: u8,
        counted_usdc: u64,
        rebate: u64,
    }

    public fun add_with_rebate<T0, T1>(arg0: &mut RebateBudget<T0, T1>, arg1: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Junction, arg2: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::JunctionHalt, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::assert_live(arg1, arg2);
        assert!(arg0.live, 606);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg4) == arg0.pool && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg5) == arg0.pool, 607);
        assert!(price_ok(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg4)), 608);
        let v0 = 0x2::coin::value<T1>(&arg6);
        assert!(v0 > 0, 609);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T0>(arg3, arg4, &mut arg5, v0, true, arg8);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T0>(&v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T0>(arg3, arg4, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, v2, arg9)), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg7, v3, arg9)), v1);
        assert!(v2 > 0 || v3 > 0, 609);
        let v4 = (v2 as u128) + (v3 as u128) * (1000 as u128) / 1000000;
        let v5 = 0x2::tx_context::sender(arg9);
        let v6 = if (0x2::table::contains<address, u64>(&arg0.counted, v5)) {
            *0x2::table::borrow<address, u64>(&arg0.counted, v5)
        } else {
            0
        };
        assert!(v6 < 618000000, 601);
        let v7 = ((618000000 - v6) as u128);
        let v8 = if (v4 > v7) {
            v7
        } else {
            v4
        };
        let v9 = (v8 as u64);
        let v10 = rebate_for(v9);
        assert!(0x2::balance::value<T0>(&arg0.funds) >= v10, 602);
        if (0x2::table::contains<address, u64>(&arg0.counted, v5)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.counted, v5) = v6 + v9;
        } else {
            0x2::table::add<address, u64>(&mut arg0.counted, v5, v9);
        };
        if (0x2::coin::value<T1>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg6, v5);
        } else {
            0x2::coin::destroy_zero<T1>(arg6);
        };
        if (0x2::coin::value<T0>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, v5);
        } else {
            0x2::coin::destroy_zero<T0>(arg7);
        };
        let v11 = RebateLock<T0>{
            id       : 0x2::object::new(arg9),
            owner    : v5,
            budget   : 0x2::object::id<RebateBudget<T0, T1>>(arg0),
            position : arg5,
            rebate   : 0x2::balance::split<T0>(&mut arg0.funds, v10),
            start_ms : 0x2::clock::timestamp_ms(arg8),
        };
        let v12 = RebateEvent{
            owner        : v5,
            kind         : 0,
            counted_usdc : v9,
            rebate       : v10,
        };
        0x2::event::emit<RebateEvent>(v12);
        0x2::transfer::transfer<RebateLock<T0>>(v11, v5);
    }

    public fun claim<T0, T1>(arg0: RebateLock<T0>, arg1: &RebateBudget<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T0>) {
        let RebateLock {
            id       : v0,
            owner    : v1,
            budget   : v2,
            position : v3,
            rebate   : v4,
            start_ms : v5,
        } = arg0;
        let v6 = v4;
        assert!(v2 == 0x2::object::id<RebateBudget<T0, T1>>(arg1), 605);
        assert!(0x2::tx_context::sender(arg3) == v1, 603);
        assert!(0x2::clock::timestamp_ms(arg2) >= v5 + 2592000000, 604);
        let v7 = RebateEvent{
            owner        : v1,
            kind         : 1,
            counted_usdc : 0,
            rebate       : 0x2::balance::value<T0>(&v6),
        };
        0x2::event::emit<RebateEvent>(v7);
        0x2::object::delete(v0);
        (v3, 0x2::coin::from_balance<T0>(v6, arg3))
    }

    public fun counted_by<T0, T1>(arg0: &RebateBudget<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.counted, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.counted, arg1)
        } else {
            0
        }
    }

    public fun create<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1);
        assert!(0x2::object::id_to_address(&v0) == 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::pinned_pool(), 607);
        create_inner<T0, T1>(arg1, arg2, arg3);
    }

    fun create_inner<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) <= 1618000000000, 600);
        let v0 = RebateBudget<T0, T1>{
            id           : 0x2::object::new(arg2),
            pool         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg0),
            funds        : 0x2::coin::into_balance<T0>(arg1),
            funded_total : 0x2::coin::value<T0>(&arg1),
            counted      : 0x2::table::new<address, u64>(arg2),
            live         : false,
        };
        0x2::transfer::share_object<RebateBudget<T0, T1>>(v0);
    }

    public fun fund<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut RebateBudget<T0, T1>, arg2: 0x2::coin::Coin<T0>) {
        arg1.funded_total = arg1.funded_total + 0x2::coin::value<T0>(&arg2);
        assert!(arg1.funded_total <= 1618000000000, 600);
        0x2::balance::join<T0>(&mut arg1.funds, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun funds<T0, T1>(arg0: &RebateBudget<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public(friend) fun go_live<T0, T1>(arg0: &mut RebateBudget<T0, T1>) {
        arg0.live = true;
    }

    public fun is_live<T0, T1>(arg0: &RebateBudget<T0, T1>) : bool {
        arg0.live
    }

    public fun lock_rebate<T0>(arg0: &RebateLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rebate)
    }

    public fun pool_of<T0, T1>(arg0: &RebateBudget<T0, T1>) : 0x2::object::ID {
        arg0.pool
    }

    fun price_ok(arg0: u128) : bool {
        let v0 = if (arg0 > 583337266871351588485) {
            arg0 - 583337266871351588485
        } else {
            583337266871351588485 - arg0
        };
        v0 * 10000 <= 583337266871351588485 * 50
    }

    public fun rebate_for(arg0: u64) : u64 {
        (((arg0 as u128) * (600 as u128) / 10000 * 1000000 / (1000 as u128)) as u64)
    }

    public fun sqrt_at_0001() : u128 {
        583337266871351588485
    }

    public fun withdraw_early<T0, T1>(arg0: RebateLock<T0>, arg1: &mut RebateBudget<T0, T1>, arg2: &0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let RebateLock {
            id       : v0,
            owner    : v1,
            budget   : v2,
            position : v3,
            rebate   : v4,
            start_ms : _,
        } = arg0;
        let v6 = v4;
        assert!(v2 == 0x2::object::id<RebateBudget<T0, T1>>(arg1), 605);
        assert!(0x2::tx_context::sender(arg2) == v1, 603);
        let v7 = RebateEvent{
            owner        : v1,
            kind         : 2,
            counted_usdc : 0,
            rebate       : 0x2::balance::value<T0>(&v6),
        };
        0x2::event::emit<RebateEvent>(v7);
        0x2::balance::join<T0>(&mut arg1.funds, v6);
        0x2::object::delete(v0);
        v3
    }

    // decompiled from Move bytecode v7
}

