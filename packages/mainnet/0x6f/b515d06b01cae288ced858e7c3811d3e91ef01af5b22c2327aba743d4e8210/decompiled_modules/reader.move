module 0x6fb515d06b01cae288ced858e7c3811d3e91ef01af5b22c2327aba743d4e8210::reader {
    struct WindowCursor has drop {
        word: u64,
        remaining: u256,
        loaded: bool,
        start_bit: u8,
        spacing: u32,
        terminal: bool,
    }

    public fun begin_if<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (WindowCursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, bool) {
        if (!arg4) {
            return (empty_cursor(), 0, vector[], vector[], vector[], 0, 0, false, false)
        };
        let v0 = new_cursor(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0), arg1);
        let v1 = &mut v0;
        let (v2, v3, v4, v5, v6, v7, v8, v9) = read_window<T0, T1>(arg0, arg1, v1, arg2, arg3, true, 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>());
        let v10 = v8 && !v9;
        (v0, v2, v3, v4, v5, v6, v7, v8, !v10)
    }

    public fun continue_if<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        if (!arg5 || arg2.terminal) {
            return (0, vector[], vector[], vector[], 0, 0, arg2.terminal)
        };
        let (v0, v1, v2, v3, v4, v5, v6, _) = read_window<T0, T1>(arg0, arg1, arg2, arg3, arg4, false, 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>());
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun current<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (u128, u64, u64) {
        (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0), 1000000)
    }

    fun empty_cursor() : WindowCursor {
        WindowCursor{
            word      : 0,
            remaining : 0,
            loaded    : false,
            start_bit : 0,
            spacing   : 0,
            terminal  : false,
        }
    }

    fun first_curve(arg0: &mut u128, arg1: &mut u128, arg2: bool, arg3: u128, arg4: u128, arg5: bool) : bool {
        if (*arg0 > 0 && arg3 != *arg1) {
            return true
        };
        if (arg2 != arg5) {
            *arg0 = *arg0 - arg4;
        } else {
            *arg0 = *arg0 + arg4;
        };
        *arg1 = arg3;
        false
    }

    fun load_word(arg0: &mut WindowCursor, arg1: u256, arg2: bool) {
        let v0 = if (arg2) {
            let v1 = 1 << arg0.start_bit;
            v1 - 1 | v1
        } else {
            115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ (1 << arg0.start_bit) - 1
        };
        arg0.remaining = arg1 & v0;
        arg0.loaded = true;
    }

    fun new_cursor(arg0: u32, arg1: u32, arg2: bool) : WindowCursor {
        let v0 = ((arg0 ^ 2147483648) as u64);
        let v1 = if (v0 >= 2147483648) {
            2147483648 + (v0 - 2147483648) / (arg1 as u64)
        } else {
            2147483648 - (2147483648 - v0 + (arg1 as u64) - 1) / (arg1 as u64)
        };
        let v2 = if (arg2) {
            v1
        } else {
            v1 + 1
        };
        WindowCursor{
            word      : v2 / 256,
            remaining : 0,
            loaded    : false,
            start_bit : ((v2 % 256) as u8),
            spacing   : arg1,
            terminal  : false,
        }
    }

    fun next_cached(arg0: &mut WindowCursor, arg1: bool) : (u32, bool) {
        let v0 = arg0.remaining != 0;
        let v1 = if (v0) {
            significant_bit(arg0.remaining, arg1)
        } else if (arg1) {
            0
        } else {
            255
        };
        let v2 = arg0.word * 256 + (v1 as u64);
        let v3 = if (v2 >= 2147483648) {
            2147483648 + (v2 - 2147483648) * (arg0.spacing as u64)
        } else {
            2147483648 - (2147483648 - v2) * (arg0.spacing as u64)
        };
        if (v0) {
            arg0.remaining = arg0.remaining ^ 1 << v1;
        };
        if (arg1 && v1 == 0 || !arg1 && v1 == 255) {
            let v4 = if (arg1) {
                arg0.word - 1
            } else {
                arg0.word + 1
            };
            arg0.word = v4;
            let v5 = if (arg1) {
                255
            } else {
                0
            };
            arg0.start_bit = v5;
            arg0.loaded = false;
        };
        ((v3 as u32) ^ 2147483648, v0)
    }

    fun preceding_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg0) ^ 2147483648;
        if (arg1 <= 2147483647 && v0 >= arg1) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v0 - arg1 ^ 2147483648)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1))
        }
    }

    fun read_window<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool, arg6: vector<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, bool) {
        let v0 = !0x1::vector::is_empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&arg6);
        let v1 = if (v0) {
            0
        } else {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0)
        };
        let v2 = v1;
        let v3 = if (arg5) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0)
        } else {
            0
        };
        let v4 = v3;
        let v5 = false;
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        let v7 = if (arg1) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_tick()
        } else {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick()
        };
        let v8 = vector[];
        let v9 = vector[];
        let v10 = vector[];
        let v11 = 0;
        let v12 = 0;
        let v13 = false;
        while (v12 < arg3 && !v13) {
            if (!arg2.loaded) {
                if (v11 == arg4) {
                    break
                };
                let v14 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(v6);
                let v15 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(word_key_bits(arg2.word));
                let v16 = if (0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(v14, v15)) {
                    *0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u256>(v14, v15)
                } else {
                    0
                };
                load_word(arg2, v16, arg1);
                v11 = v11 + 1;
            };
            let (v17, v18) = next_cached(arg2, arg1);
            let v19 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v17);
            let v20 = arg1 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v19, v7) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v19, v7);
            v13 = v20;
            let v21 = if (v20) {
                v7
            } else {
                v19
            };
            let (v22, v23, v24) = if (v18 && !v20) {
                let v25 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v6, v21);
                let v26 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(v25);
                (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v26), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(v25), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v26))
            } else {
                (false, 0, 0)
            };
            if (v18) {
                v12 = v12 + 1;
            };
            let v27 = if (v18 && !v20) {
                v23
            } else {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(v21)
            };
            0x1::vector::push_back<u128>(&mut v8, v27);
            0x1::vector::push_back<u128>(&mut v9, v24);
            0x1::vector::push_back<bool>(&mut v10, v22);
            if (v0) {
                let v28 = v18 || v20;
                v5 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::v3_read_demand_step(0x1::vector::borrow_mut<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut arg6, 0), arg1, v27, v24, v22, false, false, v28);
            } else if (arg5 && (v18 || v20)) {
                let v29 = &mut v2;
                let v30 = &mut v4;
                v5 = first_curve(v29, v30, arg1, v27, v24, v22);
            };
            if (v5) {
                break
            };
        };
        arg2.terminal = v13;
        (v1, v8, v9, v10, v11, v12, v13, v5)
    }

    public fun resume<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64) {
        let (v0, v1, v2, v3) = 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_v3_request(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        if (!v2) {
            return
        };
        let v4 = 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>();
        0x1::vector::push_back<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut v4, v3);
        let (_, v6, v7, v8, v9, v10, v11, _) = read_window<T0, T1>(arg0, arg1, arg2, v0, v1, false, v4);
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_append_v3_run(arg3, arg4, v6, v7, v8, v9, v10, v11, false, true);
    }

    fun significant_bit(arg0: u256, arg1: bool) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg1) {
            if (arg0 >> 128 != 0) {
                arg0 = arg0 >> 128;
                v1 = v0 + 128;
            };
            if (arg0 >> 64 != 0) {
                arg0 = arg0 >> 64;
                v1 = v1 + 64;
            };
            if (arg0 >> 32 != 0) {
                arg0 = arg0 >> 32;
                v1 = v1 + 32;
            };
            if (arg0 >> 16 != 0) {
                arg0 = arg0 >> 16;
                v1 = v1 + 16;
            };
            if (arg0 >> 8 != 0) {
                arg0 = arg0 >> 8;
                v1 = v1 + 8;
            };
            if (arg0 >> 4 != 0) {
                arg0 = arg0 >> 4;
                v1 = v1 + 4;
            };
            if (arg0 >> 2 != 0) {
                arg0 = arg0 >> 2;
                v1 = v1 + 2;
            };
            if (arg0 >> 1 != 0) {
                v1 = v1 + 1;
            };
        } else {
            if (arg0 & 340282366920938463463374607431768211455 == 0) {
                arg0 = arg0 >> 128;
                v1 = v0 + 128;
            };
            if (arg0 & 18446744073709551615 == 0) {
                arg0 = arg0 >> 64;
                v1 = v1 + 64;
            };
            if (arg0 & 4294967295 == 0) {
                arg0 = arg0 >> 32;
                v1 = v1 + 32;
            };
            if (arg0 & 65535 == 0) {
                arg0 = arg0 >> 16;
                v1 = v1 + 16;
            };
            if (arg0 & 255 == 0) {
                arg0 = arg0 >> 8;
                v1 = v1 + 8;
            };
            if (arg0 & 15 == 0) {
                arg0 = arg0 >> 4;
                v1 = v1 + 4;
            };
            if (arg0 & 3 == 0) {
                arg0 = arg0 >> 2;
                v1 = v1 + 2;
            };
            if (arg0 & 1 == 0) {
                v1 = v1 + 1;
            };
        };
        v1
    }

    public fun window_if<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_planned_if<T0, T1>(arg0, arg1, arg2, arg2, arg3)
    }

    public fun window_planned_if<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        if (!arg4) {
            return (0, vector[], vector[], vector[])
        };
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
                        preceding_tick(v15, v2)
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

    fun word_key_bits(arg0: u64) : u32 {
        if (arg0 >= 8388608) {
            ((arg0 - 8388608) as u32)
        } else {
            ((4294967296 - 8388608 - arg0) as u32)
        }
    }

    // decompiled from Move bytecode v7
}

