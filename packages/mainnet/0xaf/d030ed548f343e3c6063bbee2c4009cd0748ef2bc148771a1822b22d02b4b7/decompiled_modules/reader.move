module 0xafd030ed548f343e3c6063bbee2c4009cd0748ef2bc148771a1822b22d02b4b7::reader {
    struct WindowCursor has drop {
        word: u64,
        remaining: u256,
        loaded: bool,
        start_bit: u8,
        spacing: u32,
        terminal: bool,
    }

    public fun begin_if<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (WindowCursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, bool) {
        if (!arg4) {
            return (empty_cursor(), 0, vector[], vector[], vector[], 0, 0, false, false)
        };
        let v0 = new_cursor(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg0)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0), arg1);
        let v1 = &mut v0;
        let (v2, v3, v4, v5, v6, v7, v8, v9) = read_window<T0, T1>(arg0, arg1, v1, arg2, arg3, true, 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>());
        let v10 = v8 && !v9;
        (v0, v2, v3, v4, v5, v6, v7, v8, !v10)
    }

    public fun continue_if<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        if (!arg5 || arg2.terminal) {
            return (0, vector[], vector[], vector[], 0, 0, arg2.terminal)
        };
        let (v0, v1, v2, v3, v4, v5, v6, _) = read_window<T0, T1>(arg0, arg1, arg2, arg3, arg4, false, 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>());
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun current<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : (u128, u64, u64) {
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0), 1000000)
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

    fun preceding_tick(arg0: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg1: u32) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(arg0) ^ 2147483648;
        if (arg1 <= 2147483647 && v0 >= arg1) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(v0 - arg1 ^ 2147483648)
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(arg1))
        }
    }

    fun read_window<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool, arg6: vector<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, bool) {
        let v0 = !0x1::vector::is_empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&arg6);
        let v1 = if (v0) {
            0
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0)
        };
        let v2 = v1;
        let v3 = if (arg5) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0)
        } else {
            0
        };
        let v4 = v3;
        let v5 = false;
        let v6 = if (arg1) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_tick()
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_tick()
        };
        let v7 = vector[];
        let v8 = vector[];
        let v9 = vector[];
        let v10 = 0;
        let v11 = 0;
        let v12 = false;
        while (v11 < arg3 && !v12) {
            if (!arg2.loaded) {
                if (v10 == arg4) {
                    break
                };
                let v13 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_tick_bitmap<T0, T1>(arg0);
                let v14 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(word_key_bits(arg2.word));
                let v15 = if (0x2::table::contains<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>(v13, v14)) {
                    *0x2::table::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, u256>(v13, v14)
                } else {
                    0
                };
                load_word(arg2, v15, arg1);
                v10 = v10 + 1;
            };
            let (v16, v17) = next_cached(arg2, arg1);
            let v18 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(v16);
            let v19 = arg1 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v18, v6) || 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gte(v18, v6);
            v12 = v19;
            let v20 = if (v19) {
                v6
            } else {
                v18
            };
            let (v21, v22) = if (v17 && !v19) {
                let v23 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0), v20);
                (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::is_neg(v23), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::abs_u128(v23))
            } else {
                (false, 0)
            };
            if (v17) {
                v11 = v11 + 1;
            };
            let v24 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v20);
            0x1::vector::push_back<u128>(&mut v7, v24);
            0x1::vector::push_back<u128>(&mut v8, v22);
            0x1::vector::push_back<bool>(&mut v9, v21);
            if (v0) {
                let v25 = v17 || v19;
                v5 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::v3_read_demand_step(0x1::vector::borrow_mut<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut arg6, 0), arg1, v24, v22, v21, true, false, v25);
            } else if (arg5 && (v17 || v19)) {
                let v26 = &mut v2;
                let v27 = &mut v4;
                v5 = first_curve(v26, v27, arg1, v24, v22, v21);
            };
            if (v5) {
                break
            };
        };
        arg2.terminal = v12;
        (v1, v7, v8, v9, v10, v11, v12, v5)
    }

    public fun resume<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64) {
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

    public fun window_if<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_planned_if<T0, T1>(arg0, arg1, arg2, arg2, arg3)
    }

    public fun window_planned_if<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        if (!arg4) {
            return (0, vector[], vector[], vector[])
        };
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0);
        let v1 = if (arg1) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_tick()
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_tick()
        };
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg0);
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0;
        let v7 = 0;
        let v8 = false;
        loop {
            let v9 = if (v6 < arg3) {
                if (v7 < arg2) {
                    !v8
                } else {
                    false
                }
            } else {
                false
            };
            if (v9) {
                let (v10, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_bitmap::next_initialized_tick_within_one_word(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_tick_bitmap<T0, T1>(arg0), v2, v0, arg1);
                let v12 = arg1 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v10, v1) || 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gte(v10, v1);
                v8 = v12;
                let v13 = if (v12) {
                    v1
                } else {
                    v10
                };
                let (v14, v15) = if (v11 && !v12) {
                    let v16 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0), v13);
                    (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::abs_u128(v16), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::is_neg(v16))
                } else {
                    (0, false)
                };
                v6 = v6 + 1;
                if (v11) {
                    v7 = v7 + 1;
                };
                0x1::vector::push_back<u128>(&mut v3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v13));
                0x1::vector::push_back<u128>(&mut v4, v14);
                0x1::vector::push_back<bool>(&mut v5, v15);
                if (!v12) {
                    let v17 = if (arg1) {
                        preceding_tick(v13, v0)
                    } else {
                        v13
                    };
                    v2 = v17;
                };
            } else {
                break
            };
        };
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), v3, v4, v5)
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

