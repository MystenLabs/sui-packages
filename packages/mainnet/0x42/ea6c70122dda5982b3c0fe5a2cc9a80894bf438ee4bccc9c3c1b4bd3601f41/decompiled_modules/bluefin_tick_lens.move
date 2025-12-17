module 0x42ea6c70122dda5982b3c0fe5a2cc9a80894bf438ee4bccc9c3c1b4bd3601f41::bluefin_tick_lens {
    struct TickInfo has copy, drop, store {
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_gross: u128,
        liquidity_net: u128,
    }

    public fun get_all_ticks<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : vector<TickInfo> {
        let v0 = 0x1::vector::empty<TickInfo>();
        0x1::vector::append<TickInfo>(&mut v0, get_initialized_ticks<T0, T1>(arg0, arg1, arg2, true));
        0x1::vector::append<TickInfo>(&mut v0, get_initialized_ticks<T0, T1>(arg0, arg1, arg2, false));
        v0
    }

    public fun get_initialized_ticks<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) : vector<TickInfo> {
        let v0 = 0x1::vector::empty<TickInfo>();
        let v1 = 0;
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0));
        while (0x1::vector::length<TickInfo>(&v0) < arg1 && v1 < arg2) {
            v1 = v1 + 1;
            let (v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_bitmap::next_initialized_tick_within_one_word(v3, v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::tick_spacing(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0)), arg3);
            v2 = v4;
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::i32H::lt(v4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_tick()) || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::i32H::gt(v4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick())) {
                break
            };
            if (v5) {
                let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0), v4);
                let v7 = TickInfo{
                    index           : v4,
                    liquidity_gross : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_gross(v6),
                    liquidity_net   : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(v6)),
                };
                0x1::vector::push_back<TickInfo>(&mut v0, v7);
            };
        };
        v0
    }

    // decompiled from Move bytecode v6
}

