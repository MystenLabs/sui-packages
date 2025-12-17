module 0x30ecd56002e40d0c740544f4ae8a63c87500088243ef78cda5fdc683ba2ed21::bluefin {
    struct TickData has copy, drop, store {
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_gross: u128,
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
        initialized: bool,
        sqrt_price: u128,
    }

    struct TicksFetchedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        fee_rate: u64,
        coin_a: u64,
        coin_b: u64,
        liquidity: u128,
        current_tick_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        current_sqrt_price: u128,
        left_ticks_count: u64,
        left_ticks_vector: vector<TickData>,
        right_ticks_count: u64,
        right_ticks_vector: vector<TickData>,
        total_fetched: u64,
    }

    public fun fetch_left_ticks<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64) : vector<TickData> {
        if (arg1 == 0) {
            return 0x1::vector::empty<TickData>()
        };
        scan_ticks<T0, T1>(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), arg1, true)
    }

    public fun fetch_right_ticks<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64) : vector<TickData> {
        if (arg1 == 0) {
            return 0x1::vector::empty<TickData>()
        };
        scan_ticks<T0, T1>(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), arg1, false)
    }

    public fun fetch_ticks_around_current<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (vector<TickData>, vector<TickData>) {
        let v0 = fetch_left_ticks<T0, T1>(arg0, arg1);
        (v0, fetch_right_ticks<T0, T1>(arg0, arg2))
    }

    public entry fun fetch_ticks_entry<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: u64) {
        let (_, _) = fetch_ticks_with_event<T0, T1>(arg0, arg1, arg2);
    }

    public fun fetch_ticks_with_event<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (vector<TickData>, vector<TickData>) {
        let (v0, v1) = fetch_ticks_around_current<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::length<TickData>(&v3);
        let v5 = 0x1::vector::length<TickData>(&v2);
        let (v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::coin_reserves<T0, T1>(arg0);
        let v8 = TicksFetchedEvent{
            pool_id            : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0),
            fee_rate           : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0),
            coin_a             : v6,
            coin_b             : v7,
            liquidity          : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0),
            current_tick_index : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0),
            current_sqrt_price : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0),
            left_ticks_count   : v4,
            left_ticks_vector  : v3,
            right_ticks_count  : v5,
            right_ticks_vector : v2,
            total_fetched      : v4 + v5,
        };
        0x2::event::emit<TicksFetchedEvent>(v8);
        (v3, v2)
    }

    fun scan_ticks<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u64, arg3: bool) : vector<TickData> {
        let v0 = 0x1::vector::empty<TickData>();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(v3);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0);
        while (v1 < arg2 && v2 < 100) {
            v2 = v2 + 1;
            let (v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_bitmap::next_initialized_tick_within_one_word(v4, arg1, v5, arg3);
            if (v7) {
                let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v3, v6);
                let v9 = TickData{
                    index           : v6,
                    liquidity_gross : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_gross(v8),
                    liquidity_net   : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(v8),
                    initialized     : true,
                    sqrt_price      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(v8),
                };
                0x1::vector::push_back<TickData>(&mut v0, v9);
                v1 = v1 + 1;
            };
            if (arg3) {
                if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v6, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(443636))) {
                    break
                };
                if (v7) {
                    arg1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v6, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v5));
                    continue
                };
                arg1 = v6;
                continue
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v6, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(443636))) {
                break
            };
            if (v7) {
                arg1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v6, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v5));
                continue
            };
            arg1 = v6;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

