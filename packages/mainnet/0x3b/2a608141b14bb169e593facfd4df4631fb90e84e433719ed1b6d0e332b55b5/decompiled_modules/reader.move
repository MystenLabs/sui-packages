module 0x3b2a608141b14bb169e593facfd4df4631fb90e84e433719ed1b6d0e332b55b5::reader {
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
        pool: 0x2::object::ID,
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

    public fun assert_binding<T0, T1>(arg0: &Cursor, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool) {
        assert!(arg0.pool == 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg1) && arg0.down == arg2, 10);
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
            pool      : 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg0),
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

    public fun begin_if<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (Cursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, u128) {
        let v0 = begin<T0, T1>(arg0, arg1);
        let (v1, v2, v3, v4, v5, v6, v7) = if (arg4) {
            let v8 = &mut v0;
            let (v9, v10, v11, v12, v13, v14, v15, v16) = read<T0, T1>(arg0, v8, arg2, arg3);
            let _ = v13;
            (v9, v10, v11, v12, v14, v15, v16)
        } else {
            let _ = 0;
            (vector[], vector[], vector[], 0, 0, v0.frontier, false)
        };
        (v0, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::liquidity<T0, T1>(arg0), v1, v2, v3, v4, v5, v7, v6)
    }

    public fun continue_if<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: bool, arg2: &mut Cursor, arg3: u64, arg4: u64, arg5: bool) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool, u128) {
        assert!(arg1 == arg2.down, 9);
        let (v0, v1, v2, v3, v4, v5, v6) = if (arg5) {
            let (v7, v8, v9, v10, v11, v12, v13, v14) = read<T0, T1>(arg0, arg2, arg3, arg4);
            let _ = v11;
            (v7, v8, v9, v10, v12, v13, v14)
        } else {
            let _ = 0;
            (vector[], vector[], vector[], 0, 0, arg2.frontier, arg2.terminal)
        };
        (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::liquidity<T0, T1>(arg0), v0, v1, v2, v3, v4, v6, v5)
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
        assert!(0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg0) == arg1.pool && 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg0) == arg1.spacing, 3);
        assert!(arg2 <= 512 && arg3 <= 512, 4);
        let v0 = vector[];
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0;
        let v4 = 0;
        while (!arg1.terminal && 0x1::vector::length<u128>(&v0) < arg2) {
            if (!arg1.loaded) {
                if (v3 >= arg3) {
                    break
                };
                let v5 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::borrow_tick_bitmap<T0, T1>(arg0);
                let v6 = key(arg1.word, 8388608);
                let v7 = v4 + 1;
                v4 = v7;
                let v8 = if (0x2::table::contains<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32, u256>(v5, v6)) {
                    v4 = v7 + 1;
                    *0x2::table::borrow<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32, u256>(v5, v6)
                } else {
                    0
                };
                arg1.remaining = v8;
                v3 = v3 + 1;
                arg1.loaded = true;
                let v9 = if (arg1.down) {
                    if (arg1.start_bit == 255) {
                        115792089237316195423570985008687907853269984665640564039457584007913129639935
                    } else {
                        (1 << arg1.start_bit + 1) - 1
                    }
                } else {
                    115792089237316195423570985008687907853269984665640564039457584007913129639935 ^ (1 << arg1.start_bit) - 1
                };
                arg1.remaining = arg1.remaining & v9;
            };
            if (arg1.remaining == 0) {
                let v10 = if (arg1.down) {
                    0
                } else {
                    255
                };
                let v11 = tick_coord(arg1.word, v10, arg1.spacing);
                arg1.frontier = price(v11);
                if (arg1.down && v11 <= 2147483648 - 443636 || !arg1.down && v11 >= 2147483648 + 443636) {
                    arg1.terminal = true;
                    break
                };
                let v12 = if (arg1.down) {
                    arg1.word - 1
                } else {
                    arg1.word + 1
                };
                arg1.word = v12;
                let v13 = if (arg1.down) {
                    255
                } else {
                    0
                };
                arg1.start_bit = v13;
                arg1.loaded = false;
                continue
            };
            let v14 = if (arg1.down) {
                0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::bit_math::most_significant_bit(arg1.remaining)
            } else {
                0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::bit_math::least_significant_bit(arg1.remaining)
            };
            let v15 = tick_coord(arg1.word, v14, arg1.spacing);
            if (v15 < 2147483648 - 443636 || v15 > 2147483648 + 443636) {
                arg1.frontier = price(v15);
                arg1.terminal = true;
                break
            };
            let v16 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick::get_liquidity_net(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::borrow_ticks<T0, T1>(arg0), key(v15, 2147483648));
            v4 = v4 + 1;
            let v17 = price(v15);
            0x1::vector::push_back<u128>(&mut v0, v17);
            0x1::vector::push_back<u128>(&mut v1, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i128::abs_u128(v16));
            0x1::vector::push_back<bool>(&mut v2, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i128::is_neg(v16));
            arg1.remaining = arg1.remaining ^ 1 << v14;
            arg1.frontier = v17;
        };
        let v18 = 0x1::vector::length<u128>(&v0);
        arg1.words = arg1.words + v3;
        arg1.getters = arg1.getters + v4;
        arg1.ticks = arg1.ticks + v18;
        (v0, v1, v2, v3, v4, v18, arg1.frontier, arg1.terminal)
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

