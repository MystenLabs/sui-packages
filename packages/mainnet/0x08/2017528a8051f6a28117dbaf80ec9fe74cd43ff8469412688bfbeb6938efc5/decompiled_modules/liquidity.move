module 0x82017528a8051f6a28117dbaf80ec9fe74cd43ff8469412688bfbeb6938efc5::liquidity {
    struct Tick has copy, drop {
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct TickEventSingle has copy, drop {
        data: vector<Tick>,
    }

    struct TickEvent has copy, drop {
        data: vector<vector<Tick>>,
    }

    public fun emit_single_ticks(arg0: vector<Tick>) {
        let v0 = TickEventSingle{data: arg0};
        0x2::event::emit<TickEventSingle>(v0);
    }

    public fun emit_ticks(arg0: vector<vector<Tick>>) {
        let v0 = TickEvent{data: arg0};
        0x2::event::emit<TickEvent>(v0);
    }

    public fun get_entry_ticks(arg0: &vector<Tick>, arg1: u64) : &Tick {
        0x1::vector::borrow<Tick>(arg0, arg1)
    }

    public fun get_liquidity_directed_steps<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : vector<Tick> {
        let v0 = 0x1::vector::empty<Tick>();
        let v1 = false;
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        while (!v1 && arg2 > 0) {
            let (v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_bitmap::next_initialized_tick_within_one_word(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0)), v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::tick_spacing(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0)), arg1);
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick())) {
                v1 = true;
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick())) {
                v1 = true;
            };
            if (v4) {
                let v5 = Tick{
                    liquidity_net : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0), v3)),
                    index         : v3,
                };
                0x1::vector::push_back<Tick>(&mut v0, v5);
            };
            let v6 = if (arg1) {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))
            } else {
                v3
            };
            v2 = v6;
            arg2 = arg2 - 1;
        };
        v0
    }

    public fun get_liquidity_steps<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64) : vector<Tick> {
        let v0 = get_liquidity_directed_steps<T0, T1>(arg0, true, arg1);
        0x1::vector::reverse<Tick>(&mut v0);
        0x1::vector::append<Tick>(&mut v0, get_liquidity_directed_steps<T0, T1>(arg0, false, arg1));
        v0
    }

    public fun get_liquidity_steps_8<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T6, T7>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T8, T9>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T10, T11>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T12, T13>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T14, T15>, arg8: u64) : vector<vector<Tick>> {
        let v0 = 0x1::vector::empty<vector<Tick>>();
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity_steps<T0, T1>(arg0, arg8));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity_steps<T2, T3>(arg1, arg8));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity_steps<T4, T5>(arg2, arg8));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity_steps<T6, T7>(arg3, arg8));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity_steps<T8, T9>(arg4, arg8));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity_steps<T10, T11>(arg5, arg8));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity_steps<T12, T13>(arg6, arg8));
        0x1::vector::push_back<vector<Tick>>(&mut v0, get_liquidity_steps<T14, T15>(arg7, arg8));
        v0
    }

    public fun get_tick_index(arg0: &Tick) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.index
    }

    public fun get_tick_liquidity_net(arg0: &Tick) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128 {
        arg0.liquidity_net
    }

    // decompiled from Move bytecode v6
}

