module 0xb8d46270c768c2c219cc179ebf850906d56af0bb428bb727a7150c0e82ee1edf::tick_query {
    struct TickLog has copy, drop, store {
        ticks: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>,
    }

    struct TickDebugLog has copy, drop, store {
        tick: u32,
        direction: u8,
        is_initialized: bool,
    }

    public entry fun get_ticks_around<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0);
        let v2 = 0x1::vector::empty<u32>();
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0));
        0x1::vector::push_back<u32>(&mut v2, v3);
        let v4 = 0;
        let v5 = 1;
        let v6 = 0;
        while (v4 < arg1 && v6 < arg1 * 3) {
            let v7 = v3 + v1 * v5;
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v7));
            let v9 = TickDebugLog{
                tick           : v7,
                direction      : 1,
                is_initialized : v8,
            };
            0x2::event::emit<TickDebugLog>(v9);
            if (v8) {
                0x1::vector::push_back<u32>(&mut v2, v7);
                v4 = v4 + 1;
            };
            v5 = v5 + 1;
            v6 = v6 + 1;
        };
        let v10 = 0;
        let v11 = 1;
        let v12 = 0;
        while (v10 < arg1 && v12 < arg1 * 3) {
            if (v3 < v1 * v11) {
                break
            };
            let v13 = v3 - v1 * v11;
            let v14 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v13));
            let v15 = TickDebugLog{
                tick           : v13,
                direction      : 0,
                is_initialized : v14,
            };
            0x2::event::emit<TickDebugLog>(v15);
            if (v14) {
                0x1::vector::push_back<u32>(&mut v2, v13);
                v10 = v10 + 1;
            };
            v11 = v11 + 1;
            v12 = v12 + 1;
        };
        let v16 = TickLog{ticks: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::fetch_provided_ticks(v0, v2)};
        0x2::event::emit<TickLog>(v16);
    }

    // decompiled from Move bytecode v6
}

