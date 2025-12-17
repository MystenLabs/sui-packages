module 0xa7a5c57a6d3d8df6a51156f85efa537271f1ef3439bf0795502f00963c3ed04d::bluefin_tick_lens {
    public fun get_all_ticks<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64) : vector<0xa7a5c57a6d3d8df6a51156f85efa537271f1ef3439bf0795502f00963c3ed04d::tick_info::TickInfo> {
        let v0 = 0x1::vector::empty<0xa7a5c57a6d3d8df6a51156f85efa537271f1ef3439bf0795502f00963c3ed04d::tick_info::TickInfo>();
        0x1::vector::append<0xa7a5c57a6d3d8df6a51156f85efa537271f1ef3439bf0795502f00963c3ed04d::tick_info::TickInfo>(&mut v0, get_initialized_ticks<T0, T1>(arg0, arg1, true));
        0x1::vector::append<0xa7a5c57a6d3d8df6a51156f85efa537271f1ef3439bf0795502f00963c3ed04d::tick_info::TickInfo>(&mut v0, get_initialized_ticks<T0, T1>(arg0, arg1, false));
        v0
    }

    public fun get_initialized_ticks<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : vector<0xa7a5c57a6d3d8df6a51156f85efa537271f1ef3439bf0795502f00963c3ed04d::tick_info::TickInfo> {
        let v0 = 0x1::vector::empty<0xa7a5c57a6d3d8df6a51156f85efa537271f1ef3439bf0795502f00963c3ed04d::tick_info::TickInfo>();
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0));
        while (0x1::vector::length<0xa7a5c57a6d3d8df6a51156f85efa537271f1ef3439bf0795502f00963c3ed04d::tick_info::TickInfo>(&v0) < arg1) {
            let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_bitmap::next_initialized_tick_within_one_word(v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::tick_spacing(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0)), arg2);
            if (v3) {
                let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0), v2);
                0x1::vector::push_back<0xa7a5c57a6d3d8df6a51156f85efa537271f1ef3439bf0795502f00963c3ed04d::tick_info::TickInfo>(&mut v0, 0xa7a5c57a6d3d8df6a51156f85efa537271f1ef3439bf0795502f00963c3ed04d::tick_info::new(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_gross(v4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(v4))));
            };
        };
        v0
    }

    // decompiled from Move bytecode v6
}

