module 0xdbc8a494d6737a10760d81e9fa724e85bd81a42fdeed2a18028d5c2f2784edbd::cetus_fetcher {
    struct TicksFetchedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        current_tick_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        current_sqrt_price: u128,
        left_ticks_count: u64,
        left_ticks_vector: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>,
        right_ticks_count: u64,
        right_ticks_vector: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>,
        total_fetched: u64,
    }

    public fun fetch_left_ticks<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick> {
        if (arg1 == 0) {
            return 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>()
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::first_score_for_swap(v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), true);
        let v2 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>();
        let v3 = 0;
        while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v1) && v3 < arg1) {
            let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::borrow_tick_for_swap(v0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1), true);
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&mut v2, *v4);
            v3 = v3 + 1;
            v1 = v5;
        };
        v2
    }

    public fun fetch_right_ticks<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick> {
        if (arg1 == 0) {
            return 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>()
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::first_score_for_swap(v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), false);
        let v2 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>();
        let v3 = 0;
        while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_some(&v1) && v3 < arg1) {
            let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::borrow_tick_for_swap(v0, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1), false);
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&mut v2, *v4);
            v3 = v3 + 1;
            v1 = v5;
        };
        v2
    }

    public fun fetch_ticks_around_current<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>, vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>) {
        (fetch_left_ticks<T0, T1>(arg0, arg1), fetch_right_ticks<T0, T1>(arg0, arg2))
    }

    public entry fun fetch_ticks_entry<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let (_, _) = fetch_ticks_with_event<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun fetch_ticks_sorted<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick> {
        let (v0, v1) = fetch_ticks_around_current<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>();
        let v5 = 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v3);
        while (v5 > 0) {
            let v6 = v5 - 1;
            v5 = v6;
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&mut v4, *0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v3, v6));
        };
        v5 = 0;
        while (v5 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v2)) {
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&mut v4, *0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v2, v5));
            v5 = v5 + 1;
        };
        v4
    }

    public entry fun fetch_ticks_symmetric_entry<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        let (_, _) = fetch_ticks_with_event<T0, T1>(arg0, arg1, arg1, arg2);
    }

    public fun fetch_ticks_with_event<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>, vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>) {
        let (v0, v1) = fetch_ticks_around_current<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v3);
        let v5 = 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v2);
        let v6 = TicksFetchedEvent{
            pool_id            : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            current_tick_index : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0),
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
            left_ticks_count   : v4,
            left_ticks_vector  : v3,
            right_ticks_count  : v5,
            right_ticks_vector : v2,
            total_fetched      : v4 + v5,
        };
        0x2::event::emit<TicksFetchedEvent>(v6);
        (v3, v2)
    }

    public fun get_current_tick_index<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0)
    }

    public fun get_tick_index(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(arg0)
    }

    public fun get_tick_liquidity_gross(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_gross(arg0)
    }

    public fun get_tick_liquidity_net(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(arg0)
    }

    public fun get_tick_sqrt_price(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::sqrt_price(arg0)
    }

    // decompiled from Move bytecode v6
}

