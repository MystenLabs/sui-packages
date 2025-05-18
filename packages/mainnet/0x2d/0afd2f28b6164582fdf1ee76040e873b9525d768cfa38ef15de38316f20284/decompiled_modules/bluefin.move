module 0x2d0afd2f28b6164582fdf1ee76040e873b9525d768cfa38ef15de38316f20284::bluefin {
    struct TickInfo has copy, drop, store {
        index: u32,
        liquidity_net: u128,
    }

    public fun get_ticks(arg0: &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>, arg1: vector<u32>) : vector<TickInfo> {
        if (0x1::vector::is_empty<u32>(&arg1)) {
            abort 0
        };
        let v0 = 0x1::vector::empty<TickInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&arg1)) {
            let v2 = *0x1::vector::borrow<u32>(&arg1, v1);
            let v3 = TickInfo{
                index         : v2,
                liquidity_net : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_table(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v2)))),
            };
            0x1::vector::push_back<TickInfo>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

