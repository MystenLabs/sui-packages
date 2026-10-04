module 0xca01c4dce59230e17421a48e31f346f88119f6f740eece12a64cc2e5f8f300f2::reader {
    struct WindowCursor has drop {
        tick: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        terminal: bool,
        stalled: bool,
    }

    public fun begin_if<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (WindowCursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        let v0 = if (arg4) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(0)
        };
        let v1 = WindowCursor{
            tick     : v0,
            terminal : false,
            stalled  : false,
        };
        let v2 = &mut v1;
        let (v3, v4, v5, v6, v7, v8, v9) = continue_if<T0, T1, T2>(arg0, arg1, v2, arg2, arg3, arg4);
        (v1, v3, v4, v5, v6, v7, v8, v9)
    }

    public fun continue_if<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
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
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg0);
        let v2 = if (arg1) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_min_tick(v1)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_max_tick(v1)
        };
        let v3 = arg2.tick;
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = 0;
        let v8 = 0;
        let v9 = false;
        loop {
            let v10 = if (v7 < arg4) {
                if (v8 < arg3) {
                    !v9
                } else {
                    false
                }
            } else {
                false
            };
            if (v10) {
                let (v11, v12) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::next_initialized_tick_within_one_word<T0, T1, T2>(arg0, v3, arg1);
                let v13 = arg1 && 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(v11, v2) || 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(v11, v2);
                v9 = v13;
                let v14 = if (v13) {
                    v2
                } else {
                    v11
                };
                let (v15, v16) = if (v12 && !v13) {
                    let v17 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, v14));
                    (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(v17), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::is_neg(v17))
                } else {
                    (0, false)
                };
                v7 = v7 + 1;
                if (v12) {
                    v8 = v8 + 1;
                };
                0x1::vector::push_back<u128>(&mut v4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v14));
                0x1::vector::push_back<u128>(&mut v5, v15);
                0x1::vector::push_back<bool>(&mut v6, v16);
                if (!v13) {
                    let v18 = if (arg1) {
                        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v14, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(v1))
                    } else {
                        v14
                    };
                    if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::eq(v18, v3)) {
                        arg2.stalled = true;
                        break
                    };
                    v3 = v18;
                };
            } else {
                break
            };
        };
        arg2.tick = v3;
        arg2.terminal = v9;
        (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0), v4, v5, v6, v7, v8, v9)
    }

    public fun current<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : (u128, u64, u64) {
        (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0) as u64), 1000000)
    }

    public fun window_if<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u64, arg3: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_planned_if<T0, T1, T2>(arg0, arg1, arg2, arg2, arg3)
    }

    public fun window_planned_if<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        if (!arg4) {
            return (0, vector[], vector[], vector[])
        };
        assert!(arg3 > 0, 1);
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
                        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v13, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(v0))
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

