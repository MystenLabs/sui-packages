module 0xac3e19c4afbb0722f285729e29b74d8d449404a96a58e68ed1b375eaa5f12d6e::reader {
    struct AccessSample has copy, drop {
        price: u128,
        liquidity: u128,
        tick_bits: u32,
        spacing: u32,
        fee: u64,
        reserve_x: u64,
        reserve_y: u64,
        word_bits: u32,
        exists: bool,
        word: u256,
        next_tick: u32,
        initialized: bool,
        net_abs: u128,
        net_negative: bool,
        next_price: u128,
    }

    struct Cursor has drop, store {
        down: bool,
        spacing: u32,
        word: u64,
        remaining: u256,
        loaded: bool,
        start_bit: u8,
        frontier: u128,
        terminal: bool,
        words: u64,
        getters: u64,
        ticks: u64,
    }

    struct WindowSample has copy, drop {
        prices: vector<u128>,
        nets: vector<u128>,
        negative: vector<bool>,
        words: u64,
        getters: u64,
        effective: u64,
        frontier: u128,
        terminal: bool,
        total_words: u64,
        total_getters: u64,
        total_ticks: u64,
    }

    public fun assert_gate(arg0: bool, arg1: bool) {
        assert!(arg0 == arg1, 11);
    }

    public fun begin<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: bool) : Cursor {
        let v0 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg0);
        let v1 = coordinate(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::as_u32(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_index_current<T0, T1>(arg0)));
        let v2 = if (v1 >= 2147483648) {
            2147483648 + (v1 - 2147483648) / (v0 as u64)
        } else {
            2147483648 - (2147483648 - v1 + (v0 as u64) - 1) / (v0 as u64)
        };
        let v3 = if (arg1) {
            v2
        } else {
            v2 + 1
        };
        Cursor{
            down      : arg1,
            spacing   : v0,
            word      : v3 / 256,
            remaining : 0,
            loaded    : false,
            start_bit : ((v3 % 256) as u8),
            frontier  : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg0),
            terminal  : false,
            words     : 0,
            getters   : 0,
            ticks     : 0,
        }
    }

    public fun begin_if<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (Cursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, u128, bool) {
        if (!arg4) {
            let v0 = Cursor{
                down      : arg1,
                spacing   : 0,
                word      : 0,
                remaining : 0,
                loaded    : false,
                start_bit : 0,
                frontier  : 0,
                terminal  : false,
                words     : 0,
                getters   : 0,
                ticks     : 0,
            };
            return (v0, 0, vector[], vector[], vector[], 0, 0, false, 0, false)
        };
        let v1 = begin<T0, T1>(arg0, arg1);
        let v2 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::liquidity<T0, T1>(arg0);
        let v3 = &mut v1;
        let (v4, v5, v6, v7, _, v9, v10, v11, v12) = read_window<T0, T1>(arg0, v3, arg2, arg3, true, v2, 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>());
        let v13 = v11 && !v12;
        (v1, v2, v4, v5, v6, v7, v9, v11, v10, !v13)
    }

    public fun begin_window_if<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (Cursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, u128) {
        if (!arg4) {
            let v0 = Cursor{
                down      : arg1,
                spacing   : 0,
                word      : 0,
                remaining : 0,
                loaded    : false,
                start_bit : 0,
                frontier  : 0,
                terminal  : false,
                words     : 0,
                getters   : 0,
                ticks     : 0,
            };
            return (v0, 0, vector[], vector[], vector[], 0, 0, false, 0)
        };
        let v1 = begin<T0, T1>(arg0, arg1);
        let v2 = &mut v1;
        let (v3, v4, v5, v6, _, v8, v9, v10) = read<T0, T1>(arg0, v2, arg2, arg3);
        (v1, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::liquidity<T0, T1>(arg0), v3, v4, v5, v6, v8, v10, v9)
    }

    public fun continue_if<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: bool, arg2: &mut Cursor, arg3: u64, arg4: u64, arg5: bool) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, u128) {
        if (!arg5) {
            return (0, vector[], vector[], vector[], 0, 0, arg2.terminal, arg2.frontier)
        };
        let (v0, v1, v2, v3, _, v5, v6, v7) = read<T0, T1>(arg0, arg2, arg3, arg4);
        (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::liquidity<T0, T1>(arg0), v0, v1, v2, v3, v5, v7, v6)
    }

    fun coordinate(arg0: u32) : u64 {
        if (arg0 < 2147483648) {
            (arg0 as u64) + 2147483648
        } else {
            (arg0 as u64) - 2147483648
        }
    }

    public fun current<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>) : (u128, u64, u64) {
        (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg0), 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::swap_fee_rate<T0, T1>(arg0), 1000000)
    }

    fun demand_frontier(arg0: &mut 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand, arg1: bool, arg2: u128, arg3: bool) : bool {
        if (arg3) {
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::v3_read_demand_step(arg0, arg1, arg2, 0, false, false, false, true)
        } else {
            let v1 = *arg0;
            0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::v3_read_demand_step(&mut v1, arg1, arg2, 0, false, false, false, false)
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

    fun key(arg0: u64, arg1: u64) : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32 {
        if (arg0 >= arg1) {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::from(((arg0 - arg1) as u32))
        } else {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::neg_from(((arg1 - arg0) as u32))
        }
    }

    public fun limits(arg0: &Cursor) : (u128, bool, u64, u64, u64) {
        (arg0.frontier, arg0.terminal, arg0.words, arg0.getters, arg0.ticks)
    }

    fun price(arg0: u64) : u128 {
        if (arg0 <= 2147483648 - 443636) {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::min_sqrt_price()
        } else if (arg0 >= 2147483648 + 443636) {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::max_sqrt_price()
        } else {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::get_sqrt_price_at_tick(key(arg0, 2147483648))
        }
    }

    public fun probe<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: u32, arg3: bool) {
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::assert_supported_version(arg1);
        let v0 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v1 = signed(arg2);
        let v2 = 0x2::table::contains<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32, u256>(v0, v1);
        let v3 = if (v2) {
            *0x2::table::borrow<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32, u256>(v0, v1)
        } else {
            0
        };
        let (v4, v5) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_bitmap::next_initialized_tick_within_one_word(v0, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_index_current<T0, T1>(arg0), 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg0), arg3);
        let (v6, v7) = if (v5) {
            let v8 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick::get_liquidity_net(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::borrow_ticks<T0, T1>(arg0), v4);
            (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i128::abs_u128(v8), 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i128::is_neg(v8))
        } else {
            (0, false)
        };
        let (v9, v10) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::get_reserves<T0, T1>(arg0);
        let v11 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::as_u32(v4);
        let v12 = if (v11 >= 2147483648 && 4294967295 - v11 + 1 > 443636) {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::min_sqrt_price()
        } else if (v11 < 2147483648 && v11 > 443636) {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::max_sqrt_price()
        } else {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::get_sqrt_price_at_tick(v4)
        };
        let v13 = AccessSample{
            price        : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg0),
            liquidity    : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::liquidity<T0, T1>(arg0),
            tick_bits    : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::as_u32(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_index_current<T0, T1>(arg0)),
            spacing      : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg0),
            fee          : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::swap_fee_rate<T0, T1>(arg0),
            reserve_x    : v9,
            reserve_y    : v10,
            word_bits    : arg2,
            exists       : v2,
            word         : v3,
            next_tick    : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::as_u32(v4),
            initialized  : v5,
            net_abs      : v6,
            net_negative : v7,
            next_price   : v12,
        };
        0x2::event::emit<AccessSample>(v13);
    }

    public fun read<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &mut Cursor, arg2: u64, arg3: u64) : (vector<u128>, vector<u128>, vector<bool>, u64, u64, u64, u128, bool) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, _) = read_window<T0, T1>(arg0, arg1, arg2, arg3, false, 0, 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>());
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    fun read_window<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &mut Cursor, arg2: u64, arg3: u64, arg4: bool, arg5: u128, arg6: vector<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>) : (vector<u128>, vector<u128>, vector<bool>, u64, u64, u64, u128, bool, bool) {
        let v0 = !0x1::vector::is_empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&arg6);
        let v1 = arg1.frontier;
        let v2 = false;
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0;
        let v7 = 0;
        while (!arg1.terminal && 0x1::vector::length<u128>(&v3) < arg2) {
            if (!arg1.loaded) {
                if (v6 >= arg3) {
                    break
                };
                let v8 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::borrow_tick_bitmap<T0, T1>(arg0);
                let v9 = key(arg1.word, 8388608);
                let v10 = v7 + 1;
                v7 = v10;
                let v11 = if (0x2::table::contains<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32, u256>(v8, v9)) {
                    v7 = v10 + 1;
                    *0x2::table::borrow<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32, u256>(v8, v9)
                } else {
                    0
                };
                arg1.remaining = v11;
                v6 = v6 + 1;
                arg1.loaded = true;
                let v12 = if (arg1.down) {
                    if (arg1.start_bit == 255) {
                        115792089237316195423570985008687907853269984665640564039457584007913129639935
                    } else {
                        (1 << arg1.start_bit + 1) - 1
                    }
                } else {
                    115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ (1 << arg1.start_bit) - 1
                };
                arg1.remaining = arg1.remaining & v12;
            };
            if (arg1.remaining == 0) {
                let v13 = if (arg1.down) {
                    0
                } else {
                    255
                };
                let v14 = tick_coord(arg1.word, v13, arg1.spacing);
                arg1.frontier = price(v14);
                let v15 = arg1.down && v14 <= 2147483648 - 443636 || !arg1.down && v14 >= 2147483648 + 443636;
                arg1.terminal = v15;
                if (!arg1.terminal) {
                    let v16 = if (arg1.down) {
                        arg1.word - 1
                    } else {
                        arg1.word + 1
                    };
                    arg1.word = v16;
                    let v17 = if (arg1.down) {
                        255
                    } else {
                        0
                    };
                    arg1.start_bit = v17;
                    arg1.loaded = false;
                };
                if (v0) {
                    let v18 = 0x1::vector::borrow_mut<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut arg6, 0);
                    v2 = demand_frontier(v18, arg1.down, arg1.frontier, arg1.terminal);
                } else if (arg4 && arg1.terminal) {
                    let v19 = &mut arg5;
                    let v20 = &mut v1;
                    v2 = first_curve(v19, v20, arg1.down, arg1.frontier, 0, false);
                };
                if (arg1.terminal || v2) {
                    break
                } else {
                    continue
                };
            };
            let v21 = if (arg1.down) {
                0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::bit_math::most_significant_bit(arg1.remaining)
            } else {
                0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::bit_math::least_significant_bit(arg1.remaining)
            };
            let v22 = tick_coord(arg1.word, v21, arg1.spacing);
            if (v22 < 2147483648 - 443636 || v22 > 2147483648 + 443636) {
                arg1.frontier = price(v22);
                arg1.terminal = true;
                if (v0) {
                    v2 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::v3_read_demand_step(0x1::vector::borrow_mut<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut arg6, 0), arg1.down, arg1.frontier, 0, false, false, false, true);
                    break
                };
                if (arg4) {
                    let v23 = &mut arg5;
                    let v24 = &mut v1;
                    v2 = first_curve(v23, v24, arg1.down, arg1.frontier, 0, false);
                    break
                } else {
                    break
                };
            };
            let v25 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick::get_liquidity_net(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::borrow_ticks<T0, T1>(arg0), key(v22, 2147483648));
            v7 = v7 + 1;
            let v26 = price(v22);
            let v27 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i128::abs_u128(v25);
            let v28 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i128::is_neg(v25);
            0x1::vector::push_back<u128>(&mut v3, v26);
            0x1::vector::push_back<u128>(&mut v4, v27);
            0x1::vector::push_back<bool>(&mut v5, v28);
            arg1.remaining = arg1.remaining ^ 1 << v21;
            arg1.frontier = v26;
            if (v0) {
                v2 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::v3_read_demand_step(0x1::vector::borrow_mut<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut arg6, 0), arg1.down, v26, v27, v28, false, false, true);
            } else if (arg4) {
                let v29 = &mut arg5;
                let v30 = &mut v1;
                v2 = first_curve(v29, v30, arg1.down, v26, v27, v28);
            };
            if (v2) {
                break
            };
        };
        let v31 = 0x1::vector::length<u128>(&v3);
        arg1.words = arg1.words + v6;
        arg1.getters = arg1.getters + v7;
        arg1.ticks = arg1.ticks + v31;
        (v3, v4, v5, v6, v7, v31, arg1.frontier, arg1.terminal, v2)
    }

    public fun resume<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: bool, arg2: &mut Cursor, arg3: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64) {
        let (v0, v1, v2, v3) = 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_v3_request(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        if (!v2) {
            return
        };
        let v4 = 0x1::vector::empty<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>();
        0x1::vector::push_back<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand>(&mut v4, v3);
        let (v5, v6, v7, v8, _, v10, v11, v12, _) = read_window<T0, T1>(arg0, arg2, v0, v1, false, 0, v4);
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_append_v3_frontier_run(arg3, arg4, v5, v6, v7, v8, v10, v12, v11, true);
    }

    public fun sample<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &mut Cursor, arg2: u64, arg3: u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = read<T0, T1>(arg0, arg1, arg2, arg3);
        let v8 = WindowSample{
            prices        : v0,
            nets          : v1,
            negative      : v2,
            words         : v3,
            getters       : v4,
            effective     : v5,
            frontier      : v6,
            terminal      : v7,
            total_words   : arg1.words,
            total_getters : arg1.getters,
            total_ticks   : arg1.ticks,
        };
        0x2::event::emit<WindowSample>(v8);
    }

    public fun sample_budget<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &mut Cursor, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x1::u64::min(arg2, arg4 - 0x1::u64::min(arg1.ticks, arg4));
        let v1 = 0x1::u64::min(arg3, arg5 - 0x1::u64::min(arg1.words, arg5));
        sample<T0, T1>(arg0, arg1, v0, v1);
    }

    public fun signed(arg0: u32) : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32 {
        if (arg0 < 2147483648) {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::from(arg0)
        } else {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::neg_from(4294967295 - arg0 + 1)
        }
    }

    fun tick_coord(arg0: u64, arg1: u8, arg2: u32) : u64 {
        let v0 = arg0 * 256 + (arg1 as u64);
        if (v0 >= 2147483648) {
            2147483648 + (v0 - 2147483648) * (arg2 as u64)
        } else {
            2147483648 - (2147483648 - v0) * (arg2 as u64)
        }
    }

    // decompiled from Move bytecode v7
}

