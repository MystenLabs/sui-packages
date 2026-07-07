module 0xb0cc021d0367988250377b24a48efc832757cb199745262ec3c397466b102969::h176d3 {
    struct H72e5a has copy, drop {
        h25729: bool,
        h1c4b7: u64,
        hffc0b: u64,
        hdd2e2: u64,
    }

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
        let v7 = arg1 && v0 < v1 && v0 > 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price() || v0 > v1 && v0 < 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price();
        if (!v7) {
            return He77bc{
                h51522 : 0,
                hff85d : 0,
                hbc4dd : 0,
                hfa5da : v1,
                h27d0a : false,
            }
        };
        let v8 = Hfad6a{
            h51522 : 0,
            hff85d : 0,
            hbc4dd : 0,
        };
        let v9 = He77bc{
            h51522 : 0,
            hff85d : 0,
            hbc4dd : 0,
            hfa5da : v1,
            h27d0a : false,
        };
        while (arg3 > 0 && v2 != v0) {
            let (v10, v11) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(v5, v3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_spacing<T0, T1>(arg0), arg1);
            let v12 = if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lt(v10, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick())) {
                0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick()
            } else if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gt(v10, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick())) {
                0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick()
            } else {
                v10
            };
            let v13 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_sqrt_price_at_tick(v12);
            let v14 = if (arg1) {
                0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::max(v0, v13)
            } else {
                0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u128::min(v0, v13)
            };
            let (v15, v16, v17, v18) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_math::compute_swap_step(v2, v14, v4, arg3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_fee_rate<T0, T1>(arg0), arg2);
            if (v16 != 0 || v18 != 0) {
                if (arg2) {
                    let v19 = arg3 - v16;
                    arg3 = v19 - v18;
                } else {
                    arg3 = arg3 - v17;
                };
                let v20 = &mut v8;
                h22c05(v20, v16, v17, v18);
            };
            if (v15 == v13) {
                if (v11) {
                    let v21 = if (arg1) {
                        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::neg(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(v6, v12))
                    } else {
                        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(v6, v12)
                    };
                    v4 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::liquidity_math::add_delta(v4, v21);
                };
                let v22 = if (arg1) {
                    0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::sub(v12, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(1))
                } else {
                    v12
                };
                v3 = v22;
                v2 = v13;
            } else if (v15 != v1) {
                v2 = v15;
                v3 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_tick_at_sqrt_price(v15);
            } else {
                v9.h27d0a = true;
                break
            };
            if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lte(v3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick()) || 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gte(v3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick())) {
                v9.h27d0a = true;
                break
            };
        };
        v9.h51522 = v8.h51522;
        v9.hff85d = v8.hff85d;
        v9.hbc4dd = v8.hbc4dd;
        v9.hfa5da = v2;
        v9
    }

    public fun h6fcb0<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: vector<u64>, arg7: vector<u128>, arg8: vector<u64>, arg9: vector<u128>, arg10: u64, arg11: u64, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) {
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
                let v10 = H72e5a{
                    h25729 : true,
                    h1c4b7 : v7,
                    hffc0b : v8,
                    hdd2e2 : v4,
                };
                0x2::event::emit<H72e5a>(v10);
            };
            if (v9 == 0) {
                break
            };
            let (v11, v12) = h9daaa<T0, T1>(v0, arg1, arg2, arg3, arg4, v9, *0x1::vector::borrow<u128>(&arg7, v7), true, arg12, arg13);
            if (v11 == 0 || v12 == 0) {
                break
            };
            v4 = v4 - v11;
            v6 = v6 + v12;
            v7 = v7 + 1;
        };
        v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&arg8)) {
            let v13 = *0x1::vector::borrow<u64>(&arg8, v7);
            let v14 = v13;
            if (v13 > v6) {
                v14 = v6;
                let v15 = H72e5a{
                    h25729 : false,
                    h1c4b7 : v7,
                    hffc0b : v13,
                    hdd2e2 : v6,
                };
                0x2::event::emit<H72e5a>(v15);
            };
            if (v14 == 0) {
                break
            };
            let (v16, v17) = h9daaa<T0, T1>(v0, arg1, arg2, arg3, arg4, v14, *0x1::vector::borrow<u128>(&arg9, v7), false, arg12, arg13);
            if (v16 == 0 || v17 == 0) {
                break
            };
            v6 = v6 - v16;
            v4 = v4 + v17;
            v7 = v7 + 1;
        };
    }

    fun h9daaa<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
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
        if (v6 == 0) {
            return (0, 0)
        };
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
        assert!(v18 >= v19, 13906835613157490690);
        let (v20, v21) = if (v2) {
            (0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T0>(arg1, arg2, v17, arg9)))
        } else {
            (0x2::coin::into_balance<T1>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T1>(arg1, arg2, v17, arg9)), 0x2::balance::zero<T0>())
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v12, v21, v20, arg3, arg9);
        if (0x2::balance::value<T0>(&v14) > 0) {
            0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v14, arg9), arg9);
        } else {
            0x2::balance::destroy_zero<T0>(v14);
        };
        if (0x2::balance::value<T1>(&v13) > 0) {
            0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v13, arg9), arg9);
        } else {
            0x2::balance::destroy_zero<T1>(v13);
        };
        (v17, v18)
    }

    fun hb5d74(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    // decompiled from Move bytecode v6
}

