module 0x5f0169c8b5e528f32edaf9c11e038ee337a780130273966e55c0a279e4184cbe::bluefin {
    struct TickInfo has copy, drop, store {
        index: u32,
        liquidity_net: u128,
    }

    public fun get_ticks<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: vector<u32>) : vector<TickInfo> {
        if (0x1::vector::is_empty<u32>(&arg1)) {
            abort 0
        };
        let v0 = 0x1::vector::empty<TickInfo>();
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&arg1)) {
            let v3 = *0x1::vector::borrow<u32>(&arg1, v2);
            let v4 = TickInfo{
                index         : v3,
                liquidity_net : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v3)))),
            };
            0x1::vector::push_back<TickInfo>(&mut v0, v4);
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

