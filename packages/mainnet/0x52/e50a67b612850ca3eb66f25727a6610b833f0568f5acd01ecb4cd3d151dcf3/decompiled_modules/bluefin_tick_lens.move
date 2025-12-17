module 0x52e50a67b612850ca3eb66f25727a6610b833f0568f5acd01ecb4cd3d151dcf3::bluefin_tick_lens {
    public fun get_all_ticks<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64) : vector<0x52e50a67b612850ca3eb66f25727a6610b833f0568f5acd01ecb4cd3d151dcf3::tick_info::TickInfo> {
        let v0 = 0x1::vector::empty<0x52e50a67b612850ca3eb66f25727a6610b833f0568f5acd01ecb4cd3d151dcf3::tick_info::TickInfo>();
        0x1::vector::append<0x52e50a67b612850ca3eb66f25727a6610b833f0568f5acd01ecb4cd3d151dcf3::tick_info::TickInfo>(&mut v0, get_initialized_ticks<T0, T1>(arg0, arg1, true));
        0x1::vector::append<0x52e50a67b612850ca3eb66f25727a6610b833f0568f5acd01ecb4cd3d151dcf3::tick_info::TickInfo>(&mut v0, get_initialized_ticks<T0, T1>(arg0, arg1, false));
        v0
    }

    public fun get_initialized_ticks<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : vector<0x52e50a67b612850ca3eb66f25727a6610b833f0568f5acd01ecb4cd3d151dcf3::tick_info::TickInfo> {
        let v0 = 0x1::vector::empty<0x52e50a67b612850ca3eb66f25727a6610b833f0568f5acd01ecb4cd3d151dcf3::tick_info::TickInfo>();
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0));
        while (0x1::vector::length<0x52e50a67b612850ca3eb66f25727a6610b833f0568f5acd01ecb4cd3d151dcf3::tick_info::TickInfo>(&v0) < arg1) {
            let (v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_bitmap::next_initialized_tick_within_one_word(v2, v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::tick_spacing(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0)), arg2);
            v1 = v3;
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_tick()) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick())) {
                break
            };
            if (v4) {
                let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0), v3);
                0x1::vector::push_back<0x52e50a67b612850ca3eb66f25727a6610b833f0568f5acd01ecb4cd3d151dcf3::tick_info::TickInfo>(&mut v0, 0x52e50a67b612850ca3eb66f25727a6610b833f0568f5acd01ecb4cd3d151dcf3::tick_info::new(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_gross(v5), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(v5))));
            };
        };
        v0
    }

    // decompiled from Move bytecode v6
}

