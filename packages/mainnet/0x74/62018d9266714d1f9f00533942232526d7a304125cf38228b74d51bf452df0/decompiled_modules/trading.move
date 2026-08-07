module 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::trading {
    struct PoolEntry has drop, store {
        pool_id: 0x2::object::ID,
        counterpart: 0x1::type_name::TypeName,
        token_is_a: bool,
    }

    struct TradingConfig has store {
        pools: 0x2::table::Table<0x1::type_name::TypeName, PoolEntry>,
        max_slippage_bps: u64,
    }

    struct SwapExecuted has copy, drop {
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        min_out: u64,
        expected_out: u64,
        pool_id: 0x2::object::ID,
        a2b: bool,
        timestamp_ms: u64,
    }

    struct PoolWhitelisted has copy, drop {
        token: 0x1::type_name::TypeName,
        counterpart: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
        token_is_a: bool,
    }

    struct PoolRemoved has copy, drop {
        token: 0x1::type_name::TypeName,
    }

    struct SlippageUpdated has copy, drop {
        max_slippage_bps: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : TradingConfig {
        TradingConfig{
            pools            : 0x2::table::new<0x1::type_name::TypeName, PoolEntry>(arg0),
            max_slippage_bps : 100,
        }
    }

    fun assert_whitelisted<T0>(arg0: &TradingConfig, arg1: 0x2::object::ID, arg2: bool) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PoolEntry>(&arg0.pools, v0), 401);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, PoolEntry>(&arg0.pools, v0);
        assert!(v1.pool_id == arg1, 402);
        assert!(v1.token_is_a == arg2, 406);
    }

    public fun counterpart_of(arg0: &TradingConfig, arg1: 0x1::type_name::TypeName) : 0x1::type_name::TypeName {
        assert!(0x2::table::contains<0x1::type_name::TypeName, PoolEntry>(&arg0.pools, arg1), 401);
        0x2::table::borrow<0x1::type_name::TypeName, PoolEntry>(&arg0.pools, arg1).counterpart
    }

    public fun has_pool(arg0: &TradingConfig, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, PoolEntry>(&arg0.pools, arg1)
    }

    public fun max_slippage_bps(arg0: &TradingConfig) : u64 {
        arg0.max_slippage_bps
    }

    public(friend) fun min_out(arg0: &TradingConfig, arg1: u64) : u64 {
        arg1 * (10000 - arg0.max_slippage_bps) / 10000
    }

    public fun pool_id_for(arg0: &TradingConfig, arg1: 0x1::type_name::TypeName) : 0x2::object::ID {
        assert!(0x2::table::contains<0x1::type_name::TypeName, PoolEntry>(&arg0.pools, arg1), 401);
        0x2::table::borrow<0x1::type_name::TypeName, PoolEntry>(&arg0.pools, arg1).pool_id
    }

    public(friend) fun remove_pool<T0>(arg0: &mut TradingConfig) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, PoolEntry>(&arg0.pools, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, PoolEntry>(&mut arg0.pools, v0);
            let v1 = PoolRemoved{token: v0};
            0x2::event::emit<PoolRemoved>(v1);
        };
    }

    public(friend) fun sell_a_for_b<T0, T1>(arg0: &TradingConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 > 0, 404);
        assert_whitelisted<T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), true);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg5);
        let v4 = v3;
        let v5 = v2;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 405);
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v4);
        let v6 = 0x2::balance::value<T1>(&v5);
        let v7 = min_out(arg0, arg4);
        assert!(v6 >= v7, 400);
        let v8 = SwapExecuted{
            token_in     : 0x1::type_name::get<T0>(),
            token_out    : 0x1::type_name::get<T1>(),
            amount_in    : v0,
            amount_out   : v6,
            min_out      : v7,
            expected_out : arg4,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            a2b          : true,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<SwapExecuted>(v8);
        v5
    }

    public(friend) fun sell_a_for_b_manual<T0, T1>(arg0: &TradingConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg3);
        assert!(v0 > 0, 404);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg5);
        let v4 = v3;
        let v5 = v2;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 405);
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v4);
        let v6 = 0x2::balance::value<T1>(&v5);
        assert!(v6 >= arg4, 400);
        let v7 = SwapExecuted{
            token_in     : 0x1::type_name::get<T0>(),
            token_out    : 0x1::type_name::get<T1>(),
            amount_in    : v0,
            amount_out   : v6,
            min_out      : arg4,
            expected_out : 0,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            a2b          : true,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<SwapExecuted>(v7);
        v5
    }

    public(friend) fun sell_b_for_a<T0, T1>(arg0: &TradingConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg3);
        assert!(v0 > 0, 404);
        assert_whitelisted<T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), false);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg5);
        let v4 = v3;
        let v5 = v1;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 405);
        0x2::balance::destroy_zero<T1>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v4);
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = min_out(arg0, arg4);
        assert!(v6 >= v7, 400);
        let v8 = SwapExecuted{
            token_in     : 0x1::type_name::get<T1>(),
            token_out    : 0x1::type_name::get<T0>(),
            amount_in    : v0,
            amount_out   : v6,
            min_out      : v7,
            expected_out : arg4,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            a2b          : false,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<SwapExecuted>(v8);
        v5
    }

    public(friend) fun sell_b_for_a_manual<T0, T1>(arg0: &TradingConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg3);
        assert!(v0 > 0, 404);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg5);
        let v4 = v3;
        let v5 = v1;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 405);
        0x2::balance::destroy_zero<T1>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v4);
        let v6 = 0x2::balance::value<T0>(&v5);
        assert!(v6 >= arg4, 400);
        let v7 = SwapExecuted{
            token_in     : 0x1::type_name::get<T1>(),
            token_out    : 0x1::type_name::get<T0>(),
            amount_in    : v0,
            amount_out   : v6,
            min_out      : arg4,
            expected_out : 0,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            a2b          : false,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<SwapExecuted>(v7);
        v5
    }

    public(friend) fun set_max_slippage(arg0: &mut TradingConfig, arg1: u64) {
        assert!(arg1 >= 10 && arg1 <= 2000, 403);
        arg0.max_slippage_bps = arg1;
        let v0 = SlippageUpdated{max_slippage_bps: arg1};
        0x2::event::emit<SlippageUpdated>(v0);
    }

    public fun token_is_a(arg0: &TradingConfig, arg1: 0x1::type_name::TypeName) : bool {
        assert!(0x2::table::contains<0x1::type_name::TypeName, PoolEntry>(&arg0.pools, arg1), 401);
        0x2::table::borrow<0x1::type_name::TypeName, PoolEntry>(&arg0.pools, arg1).token_is_a
    }

    public(friend) fun whitelist_pool<T0, T1>(arg0: &mut TradingConfig, arg1: 0x2::object::ID, arg2: bool) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        if (0x2::table::contains<0x1::type_name::TypeName, PoolEntry>(&arg0.pools, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, PoolEntry>(&mut arg0.pools, v0);
        };
        let v2 = PoolEntry{
            pool_id     : arg1,
            counterpart : v1,
            token_is_a  : arg2,
        };
        0x2::table::add<0x1::type_name::TypeName, PoolEntry>(&mut arg0.pools, v0, v2);
        let v3 = PoolWhitelisted{
            token       : v0,
            counterpart : v1,
            pool_id     : arg1,
            token_is_a  : arg2,
        };
        0x2::event::emit<PoolWhitelisted>(v3);
    }

    // decompiled from Move bytecode v7
}

