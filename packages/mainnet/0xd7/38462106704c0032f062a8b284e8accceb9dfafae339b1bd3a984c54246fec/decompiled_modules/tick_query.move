module 0xd738462106704c0032f062a8b284e8accceb9dfafae339b1bd3a984c54246fec::tick_query {
    struct TickLog has copy, drop, store {
        ticks: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>,
    }

    struct SimpleTickInfo has copy, drop, store {
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
    }

    struct CetusTickLog has copy, drop, store {
        ticks: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>,
    }

    struct TickQueryLightResult has copy, drop, store {
        ticks: vector<SimpleTickInfo>,
        ticks_requested: vector<u32>,
        pool_info: SimplePoolInfoLog,
    }

    struct TickQueryLightResultEvent has copy, drop, store {
        ticks: vector<SimpleTickInfo>,
        ticks_requested: vector<u32>,
        pool_info: SimplePoolInfoLog,
    }

    struct SimplePoolInfoLog has copy, drop, store {
        liquidity: u128,
        sqrt_price: u128,
        current_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sequence_number: u128,
        tick_spacing: u32,
        fee_rate: u64,
        coin_a_value: u64,
        coin_b_value: u64,
    }

    struct FetchTicksDebugLog has copy, drop, store {
        ticks_requested: vector<u32>,
    }

    struct TickIndicesLog has copy, drop, store {
        indices: vector<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>,
    }

    struct TickQueryResult has copy, drop, store {
        ticks: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>,
        ticks_requested: vector<u32>,
        pool_info: SimplePoolInfoLog,
    }

    fun collect_in_word(arg0: &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u32, arg3: &mut vector<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>, arg4: &mut u32) {
        if (!0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, arg1)) {
            return
        };
        let v0 = 0;
        while (v0 < 255) {
            if (*0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, arg1) & 1 << v0 != 0) {
                0x1::vector::push_back<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(arg3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(256)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((v0 as u32))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg2)));
                *arg4 = *arg4 + 1;
            };
            v0 = v0 + 1;
        };
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
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::coin_reserves<T0, T1>(arg0);
        let v2 = SimplePoolInfoLog{
            liquidity       : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0),
            sqrt_price      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0),
            current_tick    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0),
            sequence_number : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::sequence_number<T0, T1>(arg0),
            tick_spacing    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0),
            fee_rate        : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0),
            coin_a_value    : v0,
            coin_b_value    : v1,
        };
        0x2::event::emit<SimplePoolInfoLog>(v2);
    }

    public entry fun fetch_cetus_ticks<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) : vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2)
    }

    public entry fun fetch_cetus_ticks_events<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) {
        let v0 = CetusTickLog{ticks: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<CetusTickLog>(v0);
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
        while ((v1 < arg3 || v2 < arg3) && arg2 <= 4 * (arg3 - 1) * arg2) {
            if (v1 < arg3) {
                let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg2));
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(arg0, v3)) {
                    0x1::vector::push_back<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v0, v3);
                    v1 = v1 + 1;
                };
            };
            if (v2 < arg3) {
                let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg2));
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(arg0, v4)) {
                    0x1::vector::push_back<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v0, v4);
                    v2 = v2 + 1;
                };
            };
            arg2 = arg2 + arg2;
        };
        v0
    }

    public fun get_bluefin_ticks_light<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32) : TickQueryLightResult {
        let v0 = 350;
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v1)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(256));
        let v3 = 0x1::vector::empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>();
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0));
        let v5 = 0;
        let v6 = &mut v3;
        let v7 = &mut v5;
        collect_in_word(v4, v2, v1, v6, v7);
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        let v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        while (v5 < 2 * arg1 + 1 && (v8 < v0 || v9 < v0)) {
            if (v8 < v0 && 0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(v4, v10)) {
                let v12 = &mut v3;
                let v13 = &mut v5;
                collect_in_word(v4, v10, v1, v12, v13);
            };
            if (v8 < v0) {
                v8 = v8 + 1;
                v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v10, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            };
            if (v9 < v0 && 0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(v4, v11)) {
                let v14 = &mut v3;
                let v15 = &mut v5;
                collect_in_word(v4, v11, v1, v14, v15);
            };
            if (v9 < v0) {
                v9 = v9 + 1;
                v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v11, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            };
        };
        let v16 = convert_i32_vector_to_u32(v3);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::fetch_provided_ticks<T0, T1>(arg0, v16);
        let v18 = 0x1::vector::empty<SimpleTickInfo>();
        let v19 = 0;
        while (v19 < 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>(&v17)) {
            0x1::vector::borrow<u32>(&v16, v19);
            let v20 = SimpleTickInfo{
                index         : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&v16, v19)),
                liquidity_net : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>(&v17, v19)),
            };
            0x1::vector::push_back<SimpleTickInfo>(&mut v18, v20);
            v19 = v19 + 1;
        };
        let (v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::coin_reserves<T0, T1>(arg0);
        let v23 = SimplePoolInfoLog{
            liquidity       : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0),
            sqrt_price      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0),
            current_tick    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0),
            sequence_number : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::sequence_number<T0, T1>(arg0),
            tick_spacing    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0),
            fee_rate        : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0),
            coin_a_value    : v21,
            coin_b_value    : v22,
        };
        TickQueryLightResult{
            ticks           : v18,
            ticks_requested : v16,
            pool_info       : v23,
        }
    }

    public fun get_bluefin_ticks_light_by_event<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32) {
        let v0 = 350;
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v1)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(256));
        let v3 = 0x1::vector::empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>();
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0));
        let v5 = 0;
        let v6 = &mut v3;
        let v7 = &mut v5;
        collect_in_word(v4, v2, v1, v6, v7);
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        let v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        while (v5 < 2 * arg1 + 1 && (v8 < v0 || v9 < v0)) {
            if (v8 < v0 && 0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(v4, v10)) {
                let v12 = &mut v3;
                let v13 = &mut v5;
                collect_in_word(v4, v10, v1, v12, v13);
            };
            if (v8 < v0) {
                v8 = v8 + 1;
                v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v10, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            };
            if (v9 < v0 && 0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(v4, v11)) {
                let v14 = &mut v3;
                let v15 = &mut v5;
                collect_in_word(v4, v11, v1, v14, v15);
            };
            if (v9 < v0) {
                v9 = v9 + 1;
                v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v11, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            };
        };
        let v16 = convert_i32_vector_to_u32(v3);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::fetch_provided_ticks<T0, T1>(arg0, v16);
        let v18 = 0x1::vector::empty<SimpleTickInfo>();
        let v19 = 0;
        while (v19 < 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>(&v17)) {
            let v20 = SimpleTickInfo{
                index         : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(*0x1::vector::borrow<u32>(&v16, v19)),
                liquidity_net : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>(&v17, v19)),
            };
            0x1::vector::push_back<SimpleTickInfo>(&mut v18, v20);
            v19 = v19 + 1;
        };
        let (v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::coin_reserves<T0, T1>(arg0);
        let v23 = SimplePoolInfoLog{
            liquidity       : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0),
            sqrt_price      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0),
            current_tick    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0),
            sequence_number : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::sequence_number<T0, T1>(arg0),
            tick_spacing    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0),
            fee_rate        : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0),
            coin_a_value    : v21,
            coin_b_value    : v22,
        };
        let v24 = TickQueryLightResultEvent{
            ticks           : v18,
            ticks_requested : v16,
            pool_info       : v23,
        };
        0x2::event::emit<TickQueryLightResultEvent>(v24);
    }

    public fun get_cetus_ticks_light<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) : TickQueryLightResult {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x1::vector::empty<SimpleTickInfo>();
        let v2 = 0x1::vector::empty<u32>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v0)) {
            let v4 = 0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v0, v3);
            let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(v4);
            let v6 = SimpleTickInfo{
                index         : v5,
                liquidity_net : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v4),
            };
            0x1::vector::push_back<SimpleTickInfo>(&mut v1, v6);
            0x1::vector::push_back<u32>(&mut v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v5));
            v3 = v3 + 1;
        };
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg0);
        let v9 = SimplePoolInfoLog{
            liquidity       : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0),
            sqrt_price      : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
            current_tick    : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0),
            sequence_number : 0,
            tick_spacing    : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg0),
            fee_rate        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0),
            coin_a_value    : 0x2::balance::value<T0>(v7),
            coin_b_value    : 0x2::balance::value<T1>(v8),
        };
        TickQueryLightResult{
            ticks           : v1,
            ticks_requested : v2,
            pool_info       : v9,
        }
    }

    public fun get_cetus_ticks_light_events<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: vector<u32>, arg2: u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fetch_ticks<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x1::vector::empty<SimpleTickInfo>();
        let v2 = 0x1::vector::empty<u32>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v0)) {
            let v4 = 0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::Tick>(&v0, v3);
            let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::index(v4);
            let v6 = SimpleTickInfo{
                index         : v5,
                liquidity_net : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v4),
            };
            0x1::vector::push_back<SimpleTickInfo>(&mut v1, v6);
            0x1::vector::push_back<u32>(&mut v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v5));
            v3 = v3 + 1;
        };
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg0);
        let v9 = SimplePoolInfoLog{
            liquidity       : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0),
            sqrt_price      : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
            current_tick    : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0),
            sequence_number : 0,
            tick_spacing    : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg0),
            fee_rate        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0),
            coin_a_value    : 0x2::balance::value<T0>(v7),
            coin_b_value    : 0x2::balance::value<T1>(v8),
        };
        let v10 = TickQueryLightResultEvent{
            ticks           : v1,
            ticks_requested : v2,
            pool_info       : v9,
        };
        0x2::event::emit<TickQueryLightResultEvent>(v10);
    }

    public entry fun get_ticks_around<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32) {
        assert!(arg1 > 0, 1);
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
        let (v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::coin_reserves<T0, T1>(arg0);
        let v6 = SimplePoolInfoLog{
            liquidity       : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0),
            sqrt_price      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0),
            current_tick    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0),
            sequence_number : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::sequence_number<T0, T1>(arg0),
            tick_spacing    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0),
            fee_rate        : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0),
            coin_a_value    : v4,
            coin_b_value    : v5,
        };
        TickQueryResult{
            ticks           : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::fetch_provided_ticks<T0, T1>(arg0, v3),
            ticks_requested : v3,
            pool_info       : v6,
        }
    }

    public entry fun get_ticks_around_marker<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32, arg2: u32) {
        assert!(arg2 > 0, 1);
        let v0 = convert_i32_vector_to_u32(gather_initialized_ticks(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0), arg2));
        let v1 = FetchTicksDebugLog{ticks_requested: v0};
        0x2::event::emit<FetchTicksDebugLog>(v1);
        let v2 = TickLog{ticks: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::fetch_provided_ticks<T0, T1>(arg0, v0)};
        0x2::event::emit<TickLog>(v2);
        emit_simple_pool_info<T0, T1>(arg0);
    }

    public fun get_ticks_by_bitmap<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32) : TickQueryResult {
        let v0 = 350;
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v1)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(256));
        let v3 = 0x1::vector::empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>();
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0));
        let v5 = 0;
        let v6 = &mut v3;
        let v7 = &mut v5;
        collect_in_word(v4, v2, v1, v6, v7);
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        let v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        while (v5 < 2 * arg1 + 1 && (v8 < v0 || v9 < v0)) {
            if (v8 < v0 && 0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(v4, v10)) {
                let v12 = &mut v3;
                let v13 = &mut v5;
                collect_in_word(v4, v10, v1, v12, v13);
            };
            if (v8 < v0) {
                v8 = v8 + 1;
                v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v10, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            };
            if (v9 < v0 && 0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(v4, v11)) {
                let v14 = &mut v3;
                let v15 = &mut v5;
                collect_in_word(v4, v11, v1, v14, v15);
            };
            if (v9 < v0) {
                v9 = v9 + 1;
                v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v11, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            };
        };
        let v16 = convert_i32_vector_to_u32(v3);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::fetch_provided_ticks<T0, T1>(arg0, v16);
        let (v18, v19) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::coin_reserves<T0, T1>(arg0);
        let v20 = SimplePoolInfoLog{
            liquidity       : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0),
            sqrt_price      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0),
            current_tick    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0),
            sequence_number : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::sequence_number<T0, T1>(arg0),
            tick_spacing    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0),
            fee_rate        : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0),
            coin_a_value    : v18,
            coin_b_value    : v19,
        };
        let v21 = TickLog{ticks: v17};
        0x2::event::emit<TickLog>(v21);
        TickQueryResult{
            ticks           : v17,
            ticks_requested : v16,
            pool_info       : v20,
        }
    }

    public entry fun get_ticks_by_bitmap_event<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32) {
        let v0 = 350;
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v1)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(256));
        let v3 = 0x1::vector::empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>();
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0));
        let v5 = 0;
        let v6 = &mut v3;
        let v7 = &mut v5;
        collect_in_word(v4, v2, v1, v6, v7);
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        let v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        while (v5 < 2 * arg1 + 1 && (v8 < v0 || v9 < v0)) {
            if (v8 < v0 && 0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(v4, v10)) {
                let v12 = &mut v3;
                let v13 = &mut v5;
                collect_in_word(v4, v10, v1, v12, v13);
            };
            if (v8 < v0) {
                v8 = v8 + 1;
                v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v10, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            };
            if (v9 < v0 && 0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(v4, v11)) {
                let v14 = &mut v3;
                let v15 = &mut v5;
                collect_in_word(v4, v11, v1, v14, v15);
            };
            if (v9 < v0) {
                v9 = v9 + 1;
                v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v11, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            };
        };
        let v16 = TickIndicesLog{indices: v3};
        0x2::event::emit<TickIndicesLog>(v16);
        let v17 = TickLog{ticks: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::fetch_provided_ticks<T0, T1>(arg0, convert_i32_vector_to_u32(v3))};
        0x2::event::emit<TickLog>(v17);
    }

    public entry fun test_bluefin_quote<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::SwapResult {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, true, true, 100000000, 0)
    }

    // decompiled from Move bytecode v6
}

