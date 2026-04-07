module 0xc1fb29bdfb72fffd3b3bf8aa69b2e8c9387783e499de37964f10242262f53b1::m {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    struct SR has copy, drop {
        ai: u64,
        ao: u64,
        fa: u64,
    }

    struct CSR has copy, drop {
        ai: u64,
        ao: u64,
        fa: u64,
        asp: u128,
        ie: bool,
    }

    fun csr<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: bool) : CSR {
        let v0 = if (arg5) {
            arg4
        } else {
            isp(arg4)
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
        let v7 = SR{
            ai : 0,
            ao : 0,
            fa : 0,
        };
        let v8 = CSR{
            ai  : 0,
            ao  : 0,
            fa  : 0,
            asp : v1,
            ie  : false,
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
                usr(v19, v15, v16, v17);
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
                v8.ie = true;
                break
            };
            if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lte(v3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick()) || 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gte(v3, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick())) {
                v8.ie = true;
                break
            };
        };
        v8.ai = v7.ai;
        v8.ao = v7.ao;
        v8.fa = v7.fa;
        v8.asp = v2;
        v8
    }

    fun isp(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun opt<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64, arg9: bool) : u64 {
        assert!(arg4 > 0, 13906835458538995719);
        assert!(arg4 <= arg5, 13906835462834094089);
        assert!(arg8 < arg4, 13906835467129192459);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, v5, v6) = sfs<T0, T1>(arg0, v2, arg1, arg2, arg9);
            if (v6) {
                break
            };
            if (!pok(v5, arg3, arg1)) {
                break
            };
            v0 = v4;
            if (v2 == arg5) {
                return v4
            };
            v1 = v2;
            let v7 = if (v2 > arg5 / 2) {
                arg5
            } else {
                v2 * 2
            };
            v2 = v7;
        };
        if (v0 == 0) {
            return v0
        };
        if (v2 > arg5) {
            v2 = arg5;
        };
        v3 = 0;
        while (v3 < arg7) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg8) {
                break
            };
            let v8 = (v1 + v2) / 2;
            let (v9, v10, v11) = sfs<T0, T1>(arg0, v8, arg1, arg2, arg9);
            if (pok(v10, arg3, arg1) && !v11) {
                v0 = v9;
                v1 = v8;
                continue
            };
            v2 = v8;
        };
        v0
    }

    fun pok(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || arg0 >= arg1
    }

    fun sfs<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u128, arg4: bool) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let v0 = csr<T0, T1>(arg0, arg4 != arg2, true, arg1, arg3, arg4);
        let v1 = v0.ie || v0.ai + v0.fa < arg1;
        let v2 = v0.ao;
        let v3 = v0.ai + v0.fa;
        if (v2 == 0 || v3 == 0) {
            return (0, 0, true)
        };
        let v4 = if (arg2) {
            (v3 as u128) * 1000000000000 / (v2 as u128) + 1
        } else {
            (v2 as u128) * 1000000000000 / (v3 as u128)
        };
        (v3, v4, v1)
    }

    fun spstrs(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun stt<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg5 == 0) {
            return (0, 0)
        };
        let v0 = if (arg8) {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0)
        } else {
            isp(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0))
        };
        let v1 = arg7 && v0 <= arg6 || v0 >= arg6;
        if (!v1) {
            return (0, 0)
        };
        let v2 = arg8 != arg7;
        let v3 = csr<T0, T1>(arg0, v2, true, arg5, arg6, arg8);
        let v4 = (v3.ai as u128) + (v3.fa as u128);
        let v5 = v3.ao;
        if (v5 == 0 || v4 == 0) {
            return (0, 0)
        };
        let v6 = spstrs(arg6);
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
            isp(arg6)
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
        assert!(v18 >= v19, 13906837322554671109);
        let (v20, v21) = if (v2) {
            (0, v17)
        } else {
            (v17, 0)
        };
        let (v22, v23) = if (v2) {
            (0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T0>(arg1, arg2, v21, arg9), 0x2::coin::zero<T1>(arg9))
        } else {
            (0x2::coin::zero<T0>(arg9), 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T1>(arg1, arg2, v20, arg9))
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
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T0>(arg1, arg2, v25, arg9);
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T1>(arg1, arg2, v24, arg9);
        (v17, v18)
    }

    public fun sttb<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: vector<u64>, arg7: vector<u128>, arg8: vector<u64>, arg9: vector<u128>, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg5);
        let v1 = if (arg10) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        };
        let v2 = v1;
        let v3 = if (arg10) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        };
        let v4 = v3;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg6)) {
            let v6 = *0x1::vector::borrow<u64>(&arg6, v5);
            let v7 = v6;
            if (v6 > v2) {
                v7 = v2;
            };
            if (v7 == 0) {
                break
            };
            let (v8, v9) = stt<T0, T1>(v0, arg1, arg2, arg3, arg4, v7, *0x1::vector::borrow<u128>(&arg7, v5), true, arg10, arg11);
            if (v8 == 0 || v9 == 0) {
                break
            };
            v2 = v2 - v8;
            v4 = v4 + v9;
            v5 = v5 + 1;
        };
        v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg8)) {
            let v10 = *0x1::vector::borrow<u64>(&arg8, v5);
            let v11 = v10;
            if (v10 > v4) {
                v11 = v4;
            };
            if (v11 == 0) {
                break
            };
            let (v12, v13) = stt<T0, T1>(v0, arg1, arg2, arg3, arg4, v11, *0x1::vector::borrow<u128>(&arg9, v5), false, arg10, arg11);
            if (v12 == 0 || v13 == 0) {
                break
            };
            v4 = v4 - v12;
            v2 = v2 + v13;
            v5 = v5 + 1;
        };
    }

    fun tt<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = if (arg12) {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0)
        } else {
            isp(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0))
        };
        let v1 = arg6 && v0 <= arg5 || v0 >= arg5;
        if (!v1) {
            return (0, 0)
        };
        let v2 = spstrs(arg5);
        let v3 = opt<T0, T1>(arg0, arg6, arg5, v2, arg7, arg8, arg9, arg10, arg11, arg12);
        if (v3 < arg7) {
            let v4 = EE{
                e : 116,
                l : 451,
            };
            0x2::event::emit<EE>(v4);
            return (0, 0)
        };
        let v5 = arg12 != arg6;
        let v6 = if (arg12) {
            arg5
        } else {
            isp(arg5)
        };
        let (v7, v8, v9) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg0, v5, true, v3, v6, arg3, arg4, arg13);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        let (v13, v14) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v10);
        let v15 = if (v5) {
            v13
        } else {
            v14
        };
        let v16 = if (v5) {
            0x2::balance::value<T1>(&v11)
        } else {
            0x2::balance::value<T0>(&v12)
        };
        let v17 = if (arg6) {
            (((v15 as u128) * 1000000000000 / v2) as u64)
        } else {
            (((v15 as u128) * v2 / 1000000000000) as u64)
        };
        assert!(v16 >= v17, 13906836253107814405);
        let (v18, v19) = if (v5) {
            (v15, 0)
        } else {
            (0, v15)
        };
        let (v20, v21) = if (v5) {
            (0x2::coin::zero<T1>(arg13), 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T0>(arg1, arg2, v18, arg13))
        } else {
            (0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T1>(arg1, arg2, v19, arg13), 0x2::coin::zero<T0>(arg13))
        };
        let v22 = v20;
        let v23 = v21;
        let (v24, v25) = if (v5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v23, v18, arg13)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v22, v19, arg13)))
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg0, v10, v24, v25, arg3, arg13);
        0x2::coin::join<T0>(&mut v23, 0x2::coin::from_balance<T0>(v12, arg13));
        0x2::coin::join<T1>(&mut v22, 0x2::coin::from_balance<T1>(v11, arg13));
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T0>(arg1, arg2, v23, arg13);
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T1>(arg1, arg2, v22, arg13);
        (v15, v16)
    }

    public fun ttb<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: vector<u128>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u8, arg15: u8, arg16: bool, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg5);
        let v1 = if (arg16) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        };
        let v2 = v1;
        let v3 = if (arg16) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        };
        let v4 = v3;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u128>(&arg6)) {
            let v6 = *0x1::vector::borrow<u64>(&arg7, v5);
            if (v6 > v2) {
                let v7 = EE{
                    e : 114,
                    l : 566,
                };
                0x2::event::emit<EE>(v7);
            };
            let v8 = if (v6 > v2) {
                v2
            } else {
                v6
            };
            if (v8 < arg9) {
                let v9 = EE{
                    e : 115,
                    l : 569,
                };
                0x2::event::emit<EE>(v9);
                break
            };
            let (v10, v11) = tt<T0, T1>(v0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg6, v5), true, arg9, v8, arg14, arg15, *0x1::vector::borrow<u64>(&arg8, v5), arg16, arg17);
            if (v10 == 0 || v11 == 0) {
                break
            };
            v2 = v2 - v10;
            v4 = v4 + v11;
            v5 = v5 + 1;
        };
        v5 = 0;
        while (v5 < 0x1::vector::length<u128>(&arg10)) {
            let v12 = *0x1::vector::borrow<u64>(&arg11, v5);
            if (v12 > v4) {
                let v13 = EE{
                    e : 114,
                    l : 605,
                };
                0x2::event::emit<EE>(v13);
            };
            let v14 = if (v12 > v4) {
                v4
            } else {
                v12
            };
            if (v14 < arg13) {
                let v15 = EE{
                    e : 115,
                    l : 608,
                };
                0x2::event::emit<EE>(v15);
                break
            };
            let (v16, v17) = tt<T0, T1>(v0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg10, v5), false, arg13, v14, arg14, arg15, *0x1::vector::borrow<u64>(&arg12, v5), arg16, arg17);
            if (v16 == 0 || v17 == 0) {
                break
            };
            v4 = v4 - v16;
            v2 = v2 + v17;
            v5 = v5 + 1;
        };
    }

    fun usr(arg0: &mut SR, arg1: u64, arg2: u64, arg3: u64) {
        arg0.ai = arg0.ai + arg1;
        arg0.ao = arg0.ao + arg2;
        arg0.fa = arg0.fa + arg3;
    }

    // decompiled from Move bytecode v6
}

