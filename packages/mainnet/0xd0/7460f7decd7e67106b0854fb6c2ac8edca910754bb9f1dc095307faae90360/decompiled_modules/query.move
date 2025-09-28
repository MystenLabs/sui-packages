module 0xa0acf49ef1568ec8e28b3aa55596b9ea5a189ea8930f8d5e5f6cf83aea9d8a3c::query {
    struct PoolInfoEvent has copy, drop, store {
        liquidity: u128,
        sqrt_price: u128,
        tick: u32,
        timestamp_ms: u64,
    }

    struct AvailableBalancesEvent has copy, drop, store {
        coins: vector<0x1::type_name::TypeName>,
        balances: vector<u64>,
        timestamp_ms: u64,
    }

    struct GetCurrentDepthEvent has copy, drop, store {
        ask: vector<0xa0acf49ef1568ec8e28b3aa55596b9ea5a189ea8930f8d5e5f6cf83aea9d8a3c::arbitrager::Level>,
        bid: vector<0xa0acf49ef1568ec8e28b3aa55596b9ea5a189ea8930f8d5e5f6cf83aea9d8a3c::arbitrager::Level>,
        timestamp_ms: u64,
    }

    public fun all_balances(arg0: &0xa0acf49ef1568ec8e28b3aa55596b9ea5a189ea8930f8d5e5f6cf83aea9d8a3c::arbitrager::Bot, arg1: &0x2::clock::Clock) {
        let (v0, v1) = 0xa0acf49ef1568ec8e28b3aa55596b9ea5a189ea8930f8d5e5f6cf83aea9d8a3c::arbitrager::all_balances(arg0);
        let v2 = AvailableBalancesEvent{
            coins        : v0,
            balances     : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AvailableBalancesEvent>(v2);
    }

    public fun available_balance<T0>(arg0: &0xa0acf49ef1568ec8e28b3aa55596b9ea5a189ea8930f8d5e5f6cf83aea9d8a3c::arbitrager::Bot, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 0xa0acf49ef1568ec8e28b3aa55596b9ea5a189ea8930f8d5e5f6cf83aea9d8a3c::arbitrager::available_balance<T0>(arg0));
        let v2 = AvailableBalancesEvent{
            coins        : v0,
            balances     : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AvailableBalancesEvent>(v2);
    }

    public fun available_balances<T0, T1>(arg0: &0xa0acf49ef1568ec8e28b3aa55596b9ea5a189ea8930f8d5e5f6cf83aea9d8a3c::arbitrager::Bot, arg1: &0x2::clock::Clock) {
        let (v0, v1) = 0xa0acf49ef1568ec8e28b3aa55596b9ea5a189ea8930f8d5e5f6cf83aea9d8a3c::arbitrager::available_balances<T0, T1>(arg0);
        let v2 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::type_name::TypeName>(v3, 0x1::type_name::with_defining_ids<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v3, 0x1::type_name::with_defining_ids<T1>());
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, v0);
        0x1::vector::push_back<u64>(v5, v1);
        let v6 = AvailableBalancesEvent{
            coins        : v2,
            balances     : v4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AvailableBalancesEvent>(v6);
    }

    public fun get_pool_current_depth<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0xa0acf49ef1568ec8e28b3aa55596b9ea5a189ea8930f8d5e5f6cf83aea9d8a3c::arbitrager::get_pool_current_depth<T0, T1>(arg0, arg1, arg2);
        let v2 = GetCurrentDepthEvent{
            ask          : v0,
            bid          : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<GetCurrentDepthEvent>(v2);
    }

    public fun pool_info<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = PoolInfoEvent{
            liquidity    : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0),
            sqrt_price   : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
            tick         : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0)),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PoolInfoEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

