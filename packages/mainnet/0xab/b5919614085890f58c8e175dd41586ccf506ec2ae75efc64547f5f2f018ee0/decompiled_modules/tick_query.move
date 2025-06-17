module 0xabb5919614085890f58c8e175dd41586ccf506ec2ae75efc64547f5f2f018ee0::tick_query {
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
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0));
        let v3 = v2;
        let v4 = false;
        let v5 = 0;
        loop {
            let v6 = v3 > 2147483647;
            let v7 = false;
            if (!v6) {
                let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v3));
                v7 = v8;
                if (v8) {
                    v4 = true;
                };
            };
            let v9 = TickStepDebugLog{
                curr_idx       : v2,
                direction      : 2,
                i              : v5,
                candidate      : v3,
                overflow       : v6,
                is_initialized : v7,
            };
            0x2::event::emit<TickStepDebugLog>(v9);
            if (v4 || v6) {
                break
            };
            v5 = v5 + 1;
            v3 = v2 + v5;
        };
        let v10 = 0x1::vector::empty<u32>();
        0x1::vector::push_back<u32>(&mut v10, v3);
        let v11 = 0;
        let v12 = 1;
        loop {
            if (v11 >= arg1) {
                break
            };
            let v13 = v3 + v1 * v12;
            let v14 = v13 > 2147483647;
            let v15 = false;
            if (!v14) {
                let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v13));
                v15 = v16;
                if (v16) {
                    0x1::vector::push_back<u32>(&mut v10, v13);
                    v11 = v11 + 1;
                };
            };
            let v17 = TickStepDebugLog{
                curr_idx       : v3,
                direction      : 1,
                i              : v12,
                candidate      : v13,
                overflow       : v14,
                is_initialized : v15,
            };
            0x2::event::emit<TickStepDebugLog>(v17);
            if (v14) {
                break
            };
            v12 = v12 + 1;
        };
        let v18 = 0;
        let v19 = 1;
        loop {
            if (v18 >= arg1) {
                break
            };
            if (v3 < v1 * v19) {
                let v20 = TickStepDebugLog{
                    curr_idx       : v3,
                    direction      : 0,
                    i              : v19,
                    candidate      : 0,
                    overflow       : true,
                    is_initialized : false,
                };
                0x2::event::emit<TickStepDebugLog>(v20);
                break
            };
            let v21 = v3 - v1 * v19;
            let v22 = v21 > 2147483647;
            let v23 = false;
            if (!v22) {
                let v24 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v21));
                v23 = v24;
                if (v24) {
                    0x1::vector::push_back<u32>(&mut v10, v21);
                    v18 = v18 + 1;
                };
            };
            let v25 = TickStepDebugLog{
                curr_idx       : v3,
                direction      : 0,
                i              : v19,
                candidate      : v21,
                overflow       : v22,
                is_initialized : v23,
            };
            0x2::event::emit<TickStepDebugLog>(v25);
            if (v22) {
                break
            };
            v19 = v19 + 1;
        };
        let v26 = TickLog{ticks: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::fetch_provided_ticks(v0, v10)};
        0x2::event::emit<TickLog>(v26);
    }

    // decompiled from Move bytecode v6
}

