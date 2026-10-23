module 0xc09938f3e62fad50953c7f18c2bb0d21aa57e245f439ce75ea2d076f9a96a42a::reader {
    struct WindowCursor has drop {
        tick: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        terminal: bool,
    }

    public fun begin_if<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (WindowCursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, bool) {
        if (!arg4) {
            let v0 = WindowCursor{
                tick     : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(0),
                terminal : false,
            };
            return (v0, 0, vector[], vector[], vector[], 0, 0, false, false)
        };
        let v1 = WindowCursor{
            tick     : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0),
            terminal : false,
        };
        let v2 = &mut v1;
        let (v3, v4, v5, v6, v7, v8, v9, v10) = read_window<T0, T1, T2>(arg0, arg1, v2, arg2, arg3, true, 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>());
        let v11 = v9 && !v10;
        (v1, v3, v4, v5, v6, v7, v8, v9, !v11)
    }

    public fun continue_if<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        if (!arg5 || arg2.terminal) {
            return (0, vector[], vector[], vector[], 0, 0, arg2.terminal)
        };
        let (v0, v1, v2, v3, v4, v5, v6, _) = read_window<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, false, 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>());
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun current<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : (u128, u64, u64) {
        (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0) as u64), 1000000)
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

    fun preceding_tick(arg0: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg1: u32) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32 {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(arg0) ^ 2147483648;
        if (arg1 <= 2147483647 && v0 >= arg1) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(v0 - arg1 ^ 2147483648)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(arg1))
        }
    }

    fun read_window<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool, arg6: vector<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, bool) {
        let v0 = !0x1::vector::is_empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&arg6);
        let v1 = if (v0) {
            0
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0)
        };
        let v2 = v1;
        let v3 = if (arg5) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0)
        } else {
            0
        };
        let v4 = v3;
        let v5 = false;
        let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg0);
        let v7 = if (arg1) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_min_tick(v6)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_max_tick(v6)
        };
        let v8 = arg2.tick;
        let v9 = vector[];
        let v10 = vector[];
        let v11 = vector[];
        let v12 = 0;
        let v13 = 0;
        let v14 = false;
        loop {
            let v15 = if (v12 < arg4) {
                if (v13 < arg3) {
                    !v14
                } else {
                    false
                }
            } else {
                false
            };
            if (v15) {
                let (v16, v17) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::next_initialized_tick_within_one_word<T0, T1, T2>(arg0, v8, arg1);
                let v18 = arg1 && 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(v16, v7) || 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(v16, v7);
                v14 = v18;
                let v19 = if (v18) {
                    v7
                } else {
                    v16
                };
                let (v20, v21) = if (v17 && !v18) {
                    let v22 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, v19));
                    (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(v22), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::is_neg(v22))
                } else {
                    (0, false)
                };
                v12 = v12 + 1;
                if (v17) {
                    v13 = v13 + 1;
                };
                let v23 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v19);
                0x1::vector::push_back<u128>(&mut v9, v23);
                0x1::vector::push_back<u128>(&mut v10, v20);
                0x1::vector::push_back<bool>(&mut v11, v21);
                if (v0) {
                    let v24 = v17 || v18;
                    v5 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::v3_read_demand_step(0x1::vector::borrow_mut<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut arg6, 0), arg1, v23, v20, v21, false, true, v24);
                } else if (arg5 && (v17 || v18)) {
                    let v25 = &mut v2;
                    let v26 = &mut v4;
                    v5 = first_curve(v25, v26, arg1, v23, v20, v21);
                };
                if (!v18) {
                    let v27 = if (arg1) {
                        preceding_tick(v19, v6)
                    } else {
                        v19
                    };
                    v8 = v27;
                };
                if (v5) {
                    break
                };
            } else {
                break
            };
        };
        arg2.tick = v8;
        arg2.terminal = v14;
        (v1, v9, v10, v11, v12, v13, v14, v5)
    }

    public fun resume<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: &mut WindowCursor, arg3: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64) {
        let (v0, v1, v2, v3) = 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_v3_request(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        if (!v2) {
            return
        };
        let v4 = 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>();
        0x1::vector::push_back<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut v4, v3);
        let (_, v6, v7, v8, v9, v10, v11, _) = read_window<T0, T1, T2>(arg0, arg1, arg2, v0, v1, false, v4);
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_append_v3_run(arg3, arg4, v6, v7, v8, v9, v10, v11, false, true);
    }

    public fun window_if<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u64, arg3: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_planned_if<T0, T1, T2>(arg0, arg1, arg2, arg2, arg3)
    }

    public fun window_planned_if<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        if (!arg4) {
            return (0, vector[], vector[], vector[])
        };
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg0);
        let v1 = if (arg1) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_min_tick(v0)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_max_tick(v0)
        };
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0);
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
                let (v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::next_initialized_tick_within_one_word<T0, T1, T2>(arg0, v2, arg1);
                let v12 = arg1 && 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(v10, v1) || 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(v10, v1);
                v8 = v12;
                let v13 = if (v12) {
                    v1
                } else {
                    v10
                };
                let (v14, v15) = if (v11 && !v12) {
                    let v16 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, v13));
                    (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(v16), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::is_neg(v16))
                } else {
                    (0, false)
                };
                let v17 = v6 + 1;
                v6 = v17;
                if (v11) {
                    v7 = v7 + 1;
                };
                let v18 = if (v11) {
                    true
                } else if (v12) {
                    true
                } else {
                    v17 == arg3
                };
                if (v18) {
                    0x1::vector::push_back<u128>(&mut v3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v13));
                    0x1::vector::push_back<u128>(&mut v4, v14);
                    0x1::vector::push_back<bool>(&mut v5, v15);
                };
                if (!v12) {
                    let v19 = if (arg1) {
                        preceding_tick(v13, v0)
                    } else {
                        v13
                    };
                    v2 = v19;
                };
            } else {
                break
            };
        };
        (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0), v3, v4, v5)
    }

    // decompiled from Move bytecode v7
}

