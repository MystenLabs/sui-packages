module 0x36fe3948c6aabb068b186512674fea0846affaccd36f6d1ca266229e9a2a7859::h176d3 {
    struct Hfad6a has copy, drop {
        h51522: u64,
        hff85d: u64,
        hbc4dd: u64,
    }

    struct He77bc has copy, drop {
        h51522: u64,
        hff85d: u64,
        hbc4dd: u64,
        hfa5da: u128,
        h27d0a: bool,
    }

    fun h22c05(arg0: &mut Hfad6a, arg1: u64, arg2: u64, arg3: u64) {
        arg0.h51522 = arg0.h51522 + arg1;
        arg0.hff85d = arg0.hff85d + arg2;
        arg0.hbc4dd = arg0.hbc4dd + arg3;
    }

    fun h26956(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun h477a2<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: bool) : He77bc {
        let v0 = if (arg5) {
            arg4
        } else {
            h26956(arg4)
        };
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0);
        let v2 = v1;
        let v3 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_index_current<T0, T1>(arg0);
        let v4 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::liquidity<T0, T1>(arg0);
        let v5 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v6 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(arg0);
        if (arg1) {
            assert!(v0 < v1 && v0 > 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price(), 0);
        } else {
            assert!(v0 > v1 && v0 < 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price(), 0);
        };
        let v7 = Hfad6a{
            h51522 : 0,
            hff85d : 0,
            hbc4dd : 0,
        };
        let v8 = He77bc{
            h51522 : 0,
            hff85d : 0,
            hbc4dd : 0,
            hfa5da : v1,
            h27d0a : false,
        };
        while (arg3 > 0 && v2 != v0) {
            let (v9, v10) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(v5, v3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_spacing<T0, T1>(arg0), arg1);
            let v11 = if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lt(v9, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick())) {
                0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick()
            } else if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gt(v9, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick())) {
                0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick()
            } else {
                v9
            };
            let v12 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_sqrt_price_at_tick(v11);
            let v13 = if (arg1) {
                0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::max(v0, v12)
            } else {
                0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::min(v0, v12)
            };
            let (v14, v15, v16, v17) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_math::compute_swap_step(v2, v13, v4, arg3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_fee_rate<T0, T1>(arg0), arg2);
            if (v15 != 0 || v17 != 0) {
                if (arg2) {
                    let v18 = arg3 - v15;
                    arg3 = v18 - v17;
                } else {
                    arg3 = arg3 - v16;
                };
                let v19 = &mut v7;
                h22c05(v19, v15, v16, v17);
            };
            if (v14 == v12) {
                if (v10) {
                    let v20 = if (arg1) {
                        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::neg(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(v6, v11))
                    } else {
                        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(v6, v11)
                    };
                    v4 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::liquidity_math::add_delta(v4, v20);
                };
                let v21 = if (arg1) {
                    0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::sub(v11, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(1))
                } else {
                    v11
                };
                v3 = v21;
                v2 = v12;
            } else if (v14 != v1) {
                v2 = v14;
                v3 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_tick_at_sqrt_price(v14);
            } else {
                v8.h27d0a = true;
                break
            };
            if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lte(v3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick()) || 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gte(v3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick())) {
                v8.h27d0a = true;
                break
            };
        };
        v8.h51522 = v7.h51522;
        v8.hff85d = v7.hff85d;
        v8.hbc4dd = v7.hbc4dd;
        v8.hfa5da = v2;
        v8
    }

    public fun h6fcb0<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &mut 0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::H8e2ee, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: vector<u64>, arg7: vector<u128>, arg8: vector<u64>, arg9: vector<u128>, arg10: u64, arg11: u64, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg5);
        let v1 = if (arg12) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        };
        let v2 = if (arg12) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        };
        let v3 = if (v1 > arg11) {
            v1 - arg11
        } else {
            0
        };
        let v4 = v3;
        let v5 = if (v2 > arg10) {
            v2 - arg10
        } else {
            0
        };
        let v6 = v5;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&arg6)) {
            let v8 = *0x1::vector::borrow<u64>(&arg6, v7);
            let v9 = v8;
            if (v8 > v4) {
                v9 = v4;
            };
            if (v9 == 0) {
                break
            };
            let (v10, v11) = h9daaa<T0, T1>(v0, arg1, arg2, arg3, arg4, v9, *0x1::vector::borrow<u128>(&arg7, v7), true, arg12, arg13);
            if (v10 == 0 || v11 == 0) {
                break
            };
            v4 = v4 - v10;
            v6 = v6 + v11;
            v7 = v7 + 1;
        };
        v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&arg8)) {
            let v12 = *0x1::vector::borrow<u64>(&arg8, v7);
            let v13 = v12;
            if (v12 > v6) {
                v13 = v6;
            };
            if (v13 == 0) {
                break
            };
            let (v14, v15) = h9daaa<T0, T1>(v0, arg1, arg2, arg3, arg4, v13, *0x1::vector::borrow<u128>(&arg9, v7), false, arg12, arg13);
            if (v14 == 0 || v15 == 0) {
                break
            };
            v6 = v6 - v14;
            v4 = v4 + v15;
            v7 = v7 + 1;
        };
    }

    fun h9daaa<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: &mut 0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::H8e2ee, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg5 == 0) {
            return (0, 0)
        };
        let v0 = if (arg8) {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0)
        } else {
            h26956(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0))
        };
        let v1 = arg7 && v0 < arg6 || v0 > arg6;
        if (!v1) {
            return (0, 0)
        };
        let v2 = arg8 != arg7;
        let v3 = h477a2<T0, T1>(arg0, v2, true, arg5, arg6, arg8);
        let v4 = (v3.h51522 as u128) + (v3.hbc4dd as u128);
        let v5 = v3.hff85d;
        if (v5 == 0 || v4 == 0) {
            return (0, 0)
        };
        let v6 = hb5d74(arg6);
        let v7 = if (arg7) {
            ((v4 * 1000000000000 / v6) as u64)
        } else {
            ((v4 * v6 / 1000000000000) as u64)
        };
        if (v5 < v7) {
            return (0, 0)
        };
        let v8 = if (arg8) {
            arg6
        } else {
            h26956(arg6)
        };
        let (v9, v10, v11) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, v2, true, arg5, v8, arg3, arg4, arg9);
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let (v15, v16) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v12);
        let v17 = if (v2) {
            v15
        } else {
            v16
        };
        let v18 = if (v2) {
            0x2::balance::value<T1>(&v13)
        } else {
            0x2::balance::value<T0>(&v14)
        };
        let v19 = if (arg7) {
            (((v17 as u128) * 1000000000000 / v6) as u64)
        } else {
            (((v17 as u128) * v6 / 1000000000000) as u64)
        };
        assert!(v18 >= v19, 13906835527258144770);
        let (v20, v21) = if (v2) {
            (0, v17)
        } else {
            (v17, 0)
        };
        let (v22, v23) = if (v2) {
            (0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::h1313c<T0>(arg1, arg2, v21, arg9), 0x2::coin::zero<T1>(arg9))
        } else {
            (0x2::coin::zero<T0>(arg9), 0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::h1313c<T1>(arg1, arg2, v20, arg9))
        };
        let v24 = v23;
        let v25 = v22;
        let (v26, v27) = if (v2) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v25, v21, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v24, v20, arg9)))
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v12, v26, v27, arg3, arg9);
        0x2::coin::join<T0>(&mut v25, 0x2::coin::from_balance<T0>(v14, arg9));
        0x2::coin::join<T1>(&mut v24, 0x2::coin::from_balance<T1>(v13, arg9));
        0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::h3ab73<T0>(arg1, arg2, v25, arg9);
        0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::h3ab73<T1>(arg1, arg2, v24, arg9);
        (v17, v18)
    }

    fun hb5d74(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    // decompiled from Move bytecode v6
}

