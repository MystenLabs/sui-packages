module 0x233976fb8804b89fea2c518280d2b79defff8c11478b1430cda8237f481e3d04::tick_query {
    struct TickLog has copy, drop, store {
        ticks: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::TickInfo>,
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
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v7))) {
                0x1::vector::push_back<u32>(&mut v2, v7);
                v4 = v4 + 1;
            };
            v5 = v5 + 1;
            v6 = v6 + 1;
        };
        let v8 = 0;
        let v9 = 1;
        let v10 = 0;
        while (v8 < arg1 && v10 < arg1 * 3) {
            if (v3 < v1 * v9) {
                break
            };
            let v11 = v3 - v1 * v9;
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::is_tick_initialized(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v11))) {
                0x1::vector::push_back<u32>(&mut v2, v11);
                v8 = v8 + 1;
            };
            v9 = v9 + 1;
            v10 = v10 + 1;
        };
        let v12 = TickLog{ticks: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::fetch_provided_ticks(v0, v2)};
        0x2::event::emit<TickLog>(v12);
    }

    // decompiled from Move bytecode v6
}

