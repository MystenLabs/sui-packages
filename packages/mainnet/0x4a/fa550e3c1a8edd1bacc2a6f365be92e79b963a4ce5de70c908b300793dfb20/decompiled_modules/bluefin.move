module 0x4afa550e3c1a8edd1bacc2a6f365be92e79b963a4ce5de70c908b300793dfb20::bluefin {
    struct BluefinPoolStatus has drop {
        index: u32,
        sqrt_price: u128,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct BluefinTick has drop {
        index: u32,
        liquidity_gross: u128,
        liquidity_net: u128,
    }

    public entry fun fetch_center<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: vector<u32>) : (vector<BluefinTick>, BluefinPoolStatus) {
        let v0 = 0x1::vector::empty<BluefinTick>();
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&arg1)) {
            let v3 = *0x1::vector::borrow<u32>(&arg1, v2);
            let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v3);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v1, v4)) {
                let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v1, v4);
                let v6 = BluefinTick{
                    index           : v3,
                    liquidity_gross : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_gross(v5),
                    liquidity_net   : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::as_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(v5)),
                };
                0x1::vector::push_back<BluefinTick>(&mut v0, v6);
            };
            v2 = v2 + 1;
        };
        let (v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::coin_reserves<T0, T1>(arg0);
        let v9 = BluefinPoolStatus{
            index      : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0)),
            sqrt_price : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0),
            liquidity  : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0),
            amount_a   : v7,
            amount_b   : v8,
        };
        (v0, v9)
    }

    // decompiled from Move bytecode v6
}

