module 0x2f8126bdb09a7a050c395167ce08e9f834149b3449400a4e9ef1b38097f4143b::reader {
    struct WindowCursor has drop {
        tick: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32,
        terminal: bool,
        stalled: bool,
    }

    public fun begin_if<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (WindowCursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        let v0 = if (arg4) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_index_current<T0, T1>(arg0)
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(0)
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

    public fun continue_if<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
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
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg0);
        let v2 = if (arg1) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_tick()
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_tick()
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
                let (v11, v12) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_bitmap::next_initialized_tick_within_one_word(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_tick_bitmap<T0, T1>(arg0), v3, v1, arg1);
                let v13 = arg1 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::lte(v11, v2) || 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::gte(v11, v2);
                v9 = v13;
                let v14 = if (v13) {
                    v2
                } else {
                    v11
                };
                let (v15, v16) = if (v12 && !v13) {
                    let v17 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick::get_liquidity_net(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::borrow_ticks<T0, T1>(arg0), v14);
                    (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::abs_u128(v17), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i128::is_neg(v17))
                } else {
                    (0, false)
                };
                v7 = v7 + 1;
                if (v12) {
                    v8 = v8 + 1;
                };
                0x1::vector::push_back<u128>(&mut v4, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v14));
                0x1::vector::push_back<u128>(&mut v5, v15);
                0x1::vector::push_back<bool>(&mut v6, v16);
                if (!v13) {
                    let v18 = if (arg1) {
                        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v14, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(v1))
                    } else {
                        v14
                    };
                    if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::eq(v18, v3)) {
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
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), v4, v5, v6, v7, v8, v9)
    }

    public fun current<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : (u128, u64, u64) {
        (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0), 1000000)
    }

    public fun window_if<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_planned_if<T0, T1>(arg0, arg1, arg2, arg2, arg3)
    }

    public fun window_planned_if<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        if (!arg4) {
            return (0, vector[], vector[], vector[])
        };
        assert!(arg3 > 0, 1);
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
                        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(v13, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(v0))
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

    // decompiled from Move bytecode v7
}

