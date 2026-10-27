module 0x5ccbf73256ca7ee7e13a2ef68209b6a3717a5505ccb489642921ad99490a05c0::traversal {
    public(friend) fun guarded<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : bool {
        0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0) == @0xa8479545ff8a71659a7a3b5a2149cab68c5468a67aab8b18f62e4b42623e341e
    }

    public(friend) fun limit<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool) : u128 {
        if (!guarded<T0, T1>(arg0)) {
            return if (arg1) {
                4295048017
            } else {
                79226673515401279992447579054
            }
        };
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0) != 1 || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::reward_infos_length<T0, T1>(arg0) > 3) {
            return 0
        };
        let v1 = price_limit(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), arg1);
        if (v1 == 0) {
            return 0
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        let v3 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v2)) {
            524288 - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(v2)
        } else {
            524288 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v2)
        };
        let (v4, v5) = if (arg1) {
            (v3 - 82, v3)
        } else {
            (v3 + 1, v3 + 82)
        };
        if (!sparse(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0)), v4, v5)) {
            return 0
        };
        v1
    }

    fun mask(arg0: u8, arg1: u8) : u256 {
        115792089237316195423570985008687907853269984665640564039457584007913129639935 << arg0 & 115792089237316195423570985008687907853269984665640564039457584007913129639935 >> 255 - arg1
    }

    fun price_limit(arg0: u128, arg1: bool) : u128 {
        let v0 = if (arg1) {
            0x1::u128::max(arg0 - arg0 / 250, 4295048017)
        } else {
            0x1::u128::min(arg0 + arg0 / 250, 79226673515401279992447579054)
        };
        if (arg1 && v0 >= arg0 || !arg1 && v0 <= arg0) {
            0
        } else {
            v0
        }
    }

    fun sparse(arg0: &0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>, arg1: u32, arg2: u32) : bool {
        let v0 = arg1 / 256;
        let v1 = arg2 / 256;
        let v2 = 0;
        while (v0 <= v1) {
            let v3 = if (v0 < 524288 / 256) {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(524288 / 256 - v0)
            } else {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v0 - 524288 / 256)
            };
            let v4 = if (0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, v3)) {
                *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(arg0, v3)
            } else {
                0
            };
            let v5 = if (v0 == arg1 / 256) {
                ((arg1 % 256) as u8)
            } else {
                0
            };
            let v6 = if (v0 == v1) {
                ((arg2 % 256) as u8)
            } else {
                255
            };
            let v7 = v4 & mask(v5, v6);
            while (v7 != 0) {
                let v8 = v2 + 1;
                v2 = v8;
                if (v8 > 6) {
                    return false
                };
                let v9 = v7 - 1;
                v7 = v7 & v9;
            };
            v0 = v0 + 1;
        };
        true
    }

    // decompiled from Move bytecode v7
}

