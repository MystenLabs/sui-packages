module 0xc7fffeca37de8a462bf051cb4431c6707a1f82269163c95be9c0934960da7e59::tick_query {
    struct TickLog has copy, drop, store {
        ticks: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>,
    }

    struct TickStepDebugLog has copy, drop, store {
        curr_idx: u32,
        direction: u8,
        i: u32,
        candidate: u32,
        overflow: bool,
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
            let v8 = v7 > 2147483647;
            let v9 = false;
            if (!v8) {
                let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v7));
                v9 = v10;
                if (v10) {
                    0x1::vector::push_back<u32>(&mut v2, v7);
                    v4 = v4 + 1;
                };
            };
            let v11 = TickStepDebugLog{
                curr_idx       : v3,
                direction      : 1,
                i              : v5,
                candidate      : v7,
                overflow       : v8,
                is_initialized : v9,
            };
            0x2::event::emit<TickStepDebugLog>(v11);
            if (v8) {
                break
            };
            v5 = v5 + 1;
            v6 = v6 + 1;
        };
        let v12 = 0;
        let v13 = 1;
        let v14 = 0;
        while (v12 < arg1 && v14 < arg1 * 3) {
            if (v3 < v1 * v13) {
                let v15 = TickStepDebugLog{
                    curr_idx       : v3,
                    direction      : 0,
                    i              : v13,
                    candidate      : 0,
                    overflow       : true,
                    is_initialized : false,
                };
                0x2::event::emit<TickStepDebugLog>(v15);
                break
            };
            let v16 = v3 - v1 * v13;
            let v17 = v16 > 2147483647;
            let v18 = false;
            if (!v17) {
                let v19 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v16));
                v18 = v19;
                if (v19) {
                    0x1::vector::push_back<u32>(&mut v2, v16);
                    v12 = v12 + 1;
                };
            };
            let v20 = TickStepDebugLog{
                curr_idx       : v3,
                direction      : 0,
                i              : v13,
                candidate      : v16,
                overflow       : v17,
                is_initialized : v18,
            };
            0x2::event::emit<TickStepDebugLog>(v20);
            if (v17) {
                break
            };
            v13 = v13 + 1;
            v14 = v14 + 1;
        };
        let v21 = TickLog{ticks: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::fetch_provided_ticks(v0, v2)};
        0x2::event::emit<TickLog>(v21);
    }

    // decompiled from Move bytecode v6
}

