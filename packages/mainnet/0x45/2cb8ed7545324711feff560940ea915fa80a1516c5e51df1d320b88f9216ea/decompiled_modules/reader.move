module 0x452cb8ed7545324711feff560940ea915fa80a1516c5e51df1d320b88f9216ea::reader {
    struct WindowCursor has drop {
        tick: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        terminal: bool,
        stalled: bool,
    }

    public fun begin_if<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (WindowCursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        let v0 = if (arg5) {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_index_current<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T1>(arg0, arg1))
        } else {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(0)
        };
        let v1 = WindowCursor{
            tick     : v0,
            terminal : false,
            stalled  : false,
        };
        let v2 = &mut v1;
        let (v3, v4, v5, v6, v7, v8, v9) = continue_if<T0, T1>(arg0, arg1, arg2, v2, arg3, arg4, arg5);
        (v1, v3, v4, v5, v6, v7, v8, v9)
    }

    public fun continue_if<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: bool, arg3: &mut WindowCursor, arg4: u64, arg5: u64, arg6: bool) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        let v0 = if (!arg6) {
            true
        } else if (arg3.terminal) {
            true
        } else {
            arg3.stalled
        };
        if (v0) {
            return (0, vector[], vector[], vector[], 0, 0, arg3.terminal)
        };
        assert!(arg5 > 0, 1);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T1>(arg0, arg1);
        let v2 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_spacing<T0, T1>(v1);
        let v3 = if (arg2) {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick()
        } else {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick()
        };
        let v4 = arg3.tick;
        let v5 = vector[];
        let v6 = vector[];
        let v7 = vector[];
        let v8 = 0;
        let v9 = 0;
        let v10 = false;
        loop {
            let v11 = if (v8 < arg5) {
                if (v9 < arg4) {
                    !v10
                } else {
                    false
                }
            } else {
                false
            };
            if (v11) {
                let (v12, v13) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_tick_bitmap<T0, T1>(v1), v4, v2, arg2);
                let v14 = arg2 && 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lte(v12, v3) || 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gte(v12, v3);
                v10 = v14;
                let v15 = if (v14) {
                    v3
                } else {
                    v12
                };
                let (v16, v17) = if (v13 && !v14) {
                    let v18 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(v1), v15);
                    (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::abs_u128(v18), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::is_neg(v18))
                } else {
                    (0, false)
                };
                v8 = v8 + 1;
                if (v13) {
                    v9 = v9 + 1;
                };
                0x1::vector::push_back<u128>(&mut v5, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_sqrt_price_at_tick(v15));
                0x1::vector::push_back<u128>(&mut v6, v16);
                0x1::vector::push_back<bool>(&mut v7, v17);
                if (!v14) {
                    let v19 = if (arg2) {
                        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::sub(v15, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(v2))
                    } else {
                        v15
                    };
                    if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::eq(v19, v4)) {
                        arg3.stalled = true;
                        break
                    };
                    v4 = v19;
                };
            } else {
                break
            };
        };
        arg3.tick = v4;
        arg3.terminal = v10;
        (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::liquidity<T0, T1>(v1), v5, v6, v7, v8, v9, v10)
    }

    public fun current<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64) : (u128, u64, u64) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T1>(arg0, arg1);
        (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(v0), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_fee_rate<T0, T1>(v0), 1000000)
    }

    public fun window_if<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: bool, arg3: u64, arg4: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_planned_if<T0, T1>(arg0, arg1, arg2, arg3, arg3, arg4)
    }

    public fun window_planned_if<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        if (!arg5) {
            return (0, vector[], vector[], vector[])
        };
        assert!(arg4 > 0, 1);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T1>(arg0, arg1);
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_spacing<T0, T1>(v0);
        let v2 = if (arg2) {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick()
        } else {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick()
        };
        let v3 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_index_current<T0, T1>(v0);
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
                let (v11, v12) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_tick_bitmap<T0, T1>(v0), v3, v1, arg2);
                let v13 = arg2 && 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lte(v11, v2) || 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gte(v11, v2);
                v9 = v13;
                let v14 = if (v13) {
                    v2
                } else {
                    v11
                };
                let (v15, v16) = if (v12 && !v13) {
                    let v17 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(v0), v14);
                    (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::abs_u128(v17), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::is_neg(v17))
                } else {
                    (0, false)
                };
                let v18 = v7 + 1;
                v7 = v18;
                if (v12) {
                    v8 = v8 + 1;
                };
                let v19 = if (v12) {
                    true
                } else if (v13) {
                    true
                } else {
                    v18 == arg4
                };
                if (v19) {
                    0x1::vector::push_back<u128>(&mut v4, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_sqrt_price_at_tick(v14));
                    0x1::vector::push_back<u128>(&mut v5, v15);
                    0x1::vector::push_back<bool>(&mut v6, v16);
                };
                if (!v13) {
                    let v20 = if (arg2) {
                        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::sub(v14, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(v1))
                    } else {
                        v14
                    };
                    v3 = v20;
                };
            } else {
                break
            };
        };
        (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::liquidity<T0, T1>(v0), v4, v5, v6)
    }

    // decompiled from Move bytecode v7
}

