module 0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::query {
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
        ask: vector<0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::arbitrager::Level>,
        bid: vector<0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::arbitrager::Level>,
        timestamp_ms: u64,
    }

    struct PositionEvent has copy, drop, store {
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
    }

    struct FetchPositionsEvent has copy, drop, store {
        positions: vector<PositionEvent>,
    }

    public fun all_balances(arg0: &0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::arbitrager::Bot, arg1: &0x2::clock::Clock) {
        let (v0, v1) = 0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::arbitrager::all_balances(arg0);
        let v2 = AvailableBalancesEvent{
            coins        : v0,
            balances     : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AvailableBalancesEvent>(v2);
    }

    public fun available_balance<T0>(arg0: &0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::arbitrager::Bot, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::arbitrager::available_balance<T0>(arg0));
        let v2 = AvailableBalancesEvent{
            coins        : v0,
            balances     : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AvailableBalancesEvent>(v2);
    }

    public fun available_balances<T0, T1>(arg0: &0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::arbitrager::Bot, arg1: &0x2::clock::Clock) {
        let (v0, v1) = 0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::arbitrager::available_balances<T0, T1>(arg0);
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
        let (v0, v1) = 0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::arbitrager::get_pool_current_depth<T0, T1>(arg0, arg1, arg2);
        let v2 = GetCurrentDepthEvent{
            ask          : v0,
            bid          : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<GetCurrentDepthEvent>(v2);
    }

    public fun fetch_positions(arg0: &0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::arbitrager::Bot, arg1: vector<u64>, arg2: u64) {
        let v0 = 0x56ca2bf100fcb7f2a3df017059b9a8b666f117854ef69755c17f2829bdb08d48::arbitrager::positions(arg0);
        let v1 = if (0x1::vector::length<u64>(&arg1) == 0) {
            0
        } else {
            assert!(0x1::vector::length<u64>(&arg1) == 1, 13906834590955208703);
            let v2 = *0x1::vector::borrow<u64>(&arg1, 0);
            assert!(0x2::vec_map::length<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0) > v2, 13906834599545143295);
            v2 + 1
        };
        let v3 = 0x1::vector::empty<PositionEvent>();
        let v4 = v1;
        while (v4 < 0x2::vec_map::length<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0) && v4 < v1 + arg2) {
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, v4);
            let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v6);
            let v9 = PositionEvent{
                position_id : *v5,
                pool_id     : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v6),
                tick_lower  : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v7),
                tick_upper  : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v8),
                liquidity   : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v6),
            };
            0x1::vector::push_back<PositionEvent>(&mut v3, v9);
            v4 = v4 + 1;
        };
        let v10 = FetchPositionsEvent{positions: v3};
        0x2::event::emit<FetchPositionsEvent>(v10);
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

