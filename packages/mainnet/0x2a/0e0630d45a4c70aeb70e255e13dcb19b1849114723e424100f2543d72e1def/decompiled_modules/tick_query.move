module 0x2a0e0630d45a4c70aeb70e255e13dcb19b1849114723e424100f2543d72e1def::tick_query {
    struct TickLog has copy, drop, store {
        ticks: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>,
    }

    struct SimplePoolInfoLog has copy, drop, store {
        liquidity: u128,
        sqrt_price: u128,
        current_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sequence_number: u128,
    }

    struct FetchTicksDebugLog has copy, drop, store {
        ticks_requested: vector<u32>,
    }

    struct TickQueryResult has copy, drop, store {
        ticks: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>,
        ticks_requested: vector<u32>,
        pool_info: SimplePoolInfoLog,
    }

    fun convert_i32_vector_to_u32(arg0: vector<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>) : vector<u32> {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&arg0)) {
            0x1::vector::push_back<u32>(&mut v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(*0x1::vector::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun emit_simple_pool_info<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        let v0 = SimplePoolInfoLog{
            liquidity       : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0),
            sqrt_price      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0),
            current_tick    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0),
            sequence_number : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::sequence_number<T0, T1>(arg0),
        };
        0x2::event::emit<SimplePoolInfoLog>(v0);
    }

    fun find_nearest_initialized_tick_down(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        let v0 = arg1;
        loop {
            v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(arg0, v0)) {
                break
            };
        };
        v0
    }

    fun gather_initialized_ticks(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickManager, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u32, arg3: u32) : vector<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32> {
        let v0 = 0x1::vector::empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>();
        0x1::vector::push_back<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v0, arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 20 * arg3 * arg2;
        let v4 = 0;
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg2);
        while (v1 < arg3 && v4 < v3) {
            let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, v5);
            arg1 = v6;
            v4 = v4 + arg2;
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(arg0, v6)) {
                0x1::vector::push_back<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v0, v6);
                v1 = v1 + 1;
            };
        };
        let v7 = 0;
        while (v2 < arg3 && v7 < v3) {
            let v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg1, v5);
            arg1 = v8;
            v7 = v7 + arg2;
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(arg0, v8)) {
                0x1::vector::push_back<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v0, v8);
                v2 = v2 + 1;
            };
        };
        v0
    }

    public entry fun get_ticks_around<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        let v2 = v1;
        if (!0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v0, v1)) {
            v2 = find_nearest_initialized_tick_down(v0, v1);
        };
        let v3 = convert_i32_vector_to_u32(gather_initialized_ticks(v0, v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0), arg1));
        let v4 = FetchTicksDebugLog{ticks_requested: v3};
        0x2::event::emit<FetchTicksDebugLog>(v4);
        let v5 = TickLog{ticks: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::fetch_provided_ticks<T0, T1>(arg0, v3)};
        0x2::event::emit<TickLog>(v5);
        emit_simple_pool_info<T0, T1>(arg0);
    }

    public fun get_ticks_around2<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32) : TickQueryResult {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        let v2 = v1;
        if (!0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v0, v1)) {
            v2 = find_nearest_initialized_tick_down(v0, v1);
        };
        let v3 = convert_i32_vector_to_u32(gather_initialized_ticks(v0, v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0), arg1));
        let v4 = SimplePoolInfoLog{
            liquidity       : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0),
            sqrt_price      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0),
            current_tick    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0),
            sequence_number : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::sequence_number<T0, T1>(arg0),
        };
        TickQueryResult{
            ticks           : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::fetch_provided_ticks<T0, T1>(arg0, v3),
            ticks_requested : v3,
            pool_info       : v4,
        }
    }

    // decompiled from Move bytecode v6
}

