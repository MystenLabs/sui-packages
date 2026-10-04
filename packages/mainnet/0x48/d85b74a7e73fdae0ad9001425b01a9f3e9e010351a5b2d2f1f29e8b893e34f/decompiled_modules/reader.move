module 0x48d85b74a7e73fdae0ad9001425b01a9f3e9e010351a5b2d2f1f29e8b893e34f::reader {
    struct WindowCursor has drop {
        tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        terminal: bool,
        stalled: bool,
    }

    public fun begin_if<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (WindowCursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        let v0 = if (arg4) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0)
        };
        let v1 = WindowCursor{
            tick     : v0,
            terminal : false,
            stalled  : false,
        };
        let v2 = &mut v1;
        let (v3, v4, v5, v6, v7, v8, v9) = continue_if<T0, T1>(arg0, arg1, v2, arg2, arg3, arg4);
        (v1, v3, v4, v5, v6, v7, v8, v9)
    }

    public fun continue_if<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        let v0 = if (!arg5) {
            true
        } else if (arg2.terminal) {
            true
        } else {
            arg2.stalled
        };
        if (v0) {
            return (0, vector[], vector[], vector[], 0, 0, arg2.terminal)
        };
        assert!(arg4 > 0, 1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(v1);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0);
        let v4 = if (arg1) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_tick()
        } else {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick()
        };
        let v5 = arg2.tick;
        let v6 = vector[];
        let v7 = vector[];
        let v8 = vector[];
        let v9 = 0;
        let v10 = 0;
        let v11 = false;
        loop {
            let v12 = if (v9 < arg4) {
                if (v10 < arg3) {
                    !v11
                } else {
                    false
                }
            } else {
                false
            };
            if (v12) {
                let (v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_bitmap::next_initialized_tick_within_one_word(v2, v5, v3, arg1);
                let v15 = arg1 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v13, v4) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v13, v4);
                v11 = v15;
                let v16 = if (v15) {
                    v4
                } else {
                    v13
                };
                let (v17, v18, v19) = if (v14 && !v15) {
                    let v20 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v1, v16);
                    let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(v20);
                    (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v21), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v21), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(v20))
                } else {
                    (0, false, 0)
                };
                v9 = v9 + 1;
                if (v14) {
                    v10 = v10 + 1;
                };
                let v22 = if (v14 && !v15) {
                    v19
                } else {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(v16)
                };
                0x1::vector::push_back<u128>(&mut v6, v22);
                0x1::vector::push_back<u128>(&mut v7, v17);
                0x1::vector::push_back<bool>(&mut v8, v18);
                if (!v15) {
                    let v23 = if (arg1) {
                        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v16, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v3))
                    } else {
                        v16
                    };
                    if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v23, v5)) {
                        arg2.stalled = true;
                        break
                    };
                    v5 = v23;
                };
            } else {
                break
            };
        };
        arg2.tick = v5;
        arg2.terminal = v11;
        (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0), v6, v7, v8, v9, v10, v11)
    }

    public fun current<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (u128, u64, u64) {
        (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0), 1000000)
    }

    public fun window_if<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_planned_if<T0, T1>(arg0, arg1, arg2, arg2, arg3)
    }

    public fun window_planned_if<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        if (!arg4) {
            return (0, vector[], vector[], vector[])
        };
        assert!(arg3 > 0, 1);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(v0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0);
        let v3 = if (arg1) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_tick()
        } else {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick()
        };
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        let v5 = vector[];
        let v6 = vector[];
        let v7 = vector[];
        let v8 = 0;
        let v9 = 0;
        let v10 = false;
        loop {
            let v11 = if (v8 < arg3) {
                if (v9 < arg2) {
                    !v10
                } else {
                    false
                }
            } else {
                false
            };
            if (v11) {
                let (v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_bitmap::next_initialized_tick_within_one_word(v1, v4, v2, arg1);
                let v14 = arg1 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v12, v3) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v12, v3);
                v10 = v14;
                let v15 = if (v14) {
                    v3
                } else {
                    v12
                };
                let (v16, v17, v18) = if (v13 && !v14) {
                    let v19 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v0, v15);
                    let v20 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(v19);
                    (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v20), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v20), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(v19))
                } else {
                    (0, false, 0)
                };
                let v21 = v8 + 1;
                v8 = v21;
                if (v13) {
                    v9 = v9 + 1;
                };
                let v22 = if (v13) {
                    true
                } else if (v14) {
                    true
                } else {
                    v21 == arg3
                };
                if (v22) {
                    let v23 = if (v13 && !v14) {
                        v18
                    } else {
                        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(v15)
                    };
                    0x1::vector::push_back<u128>(&mut v5, v23);
                    0x1::vector::push_back<u128>(&mut v6, v16);
                    0x1::vector::push_back<bool>(&mut v7, v17);
                };
                if (!v14) {
                    let v24 = if (arg1) {
                        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v15, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v2))
                    } else {
                        v15
                    };
                    v4 = v24;
                };
            } else {
                break
            };
        };
        (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0), v5, v6, v7)
    }

    // decompiled from Move bytecode v7
}

