module 0xa45aaf1bfb5f7212de5a1d4076cc1830b6a6ad9ec8a956f76e85e781d4bd07ab::m {
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

    fun csr<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: bool) : CSR {
        let v0 = if (arg5) {
            arg4
        } else {
            isp(arg4)
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0);
        let v3 = SR{
            ai : 0,
            ao : 0,
            fa : 0,
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::first_score_for_swap(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v5 = CSR{
            ai  : 0,
            ao  : 0,
            fa  : 0,
            asp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
            ie  : false,
        };
        while (arg3 > 0 && v1 != v0) {
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v4)) {
                v5.ie = true;
                break
            };
            let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::borrow_tick_for_swap(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0), 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v4), arg1);
            v4 = v7;
            let v8 = if (arg1) {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::max(v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::sqrt_price(v6))
            } else {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::min(v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::sqrt_price(v6))
            };
            let (v9, v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(v1, v8, v2, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0), arg1, arg2);
            if (v9 != 0 || v12 != 0) {
                if (arg2) {
                    let v13 = arg3 - v9;
                    arg3 = v13 - v12;
                } else {
                    arg3 = arg3 - v10;
                };
                let v14 = &mut v3;
                usr(v14, v9, v10, v12);
            };
            if (v11 == v8) {
                v1 = v8;
                let v15 = if (arg1) {
                    0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::neg(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v6))
                } else {
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v6)
                };
                if (!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v15)) {
                    v2 = v2 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v15);
                    continue
                };
                v2 = v2 - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v15);
                continue
            };
            v1 = v11;
        };
        v5.ai = v3.ai;
        v5.ao = v3.ao;
        v5.fa = v3.fa;
        v5.asp = v1;
        v5
    }

    fun isp(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun opt<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64, arg9: bool) : u64 {
        assert!(arg4 > 0, 13906835273855401991);
        assert!(arg4 <= arg5, 13906835278150500361);
        assert!(arg8 < arg4, 13906835282445598731);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, v5, v6) = scs<T0, T1>(arg0, v2, arg1, arg2, arg9);
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
            let (v9, v10, v11) = scs<T0, T1>(arg0, v8, arg1, arg2, arg9);
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

    fun scs<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u128, arg4: bool) : (u64, u128, bool) {
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

    fun stt<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg5 == 0) {
            return (0, 0)
        };
        let v0 = if (arg8) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0)
        } else {
            isp(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0))
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
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg0, v2, true, arg5, v8, arg4);
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12);
        let v16 = if (v2) {
            0x2::balance::value<T1>(&v13)
        } else {
            0x2::balance::value<T0>(&v14)
        };
        let v17 = if (arg7) {
            (((v15 as u128) * 1000000000000 / v6) as u64)
        } else {
            (((v15 as u128) * v6 / 1000000000000) as u64)
        };
        assert!(v16 >= v17, 13906837163640881157);
        let (v18, v19) = if (v2) {
            (v15, 0)
        } else {
            (0, v15)
        };
        let (v20, v21) = if (v2) {
            (0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T0>(arg1, arg2, v15, arg9), 0x2::coin::zero<T1>(arg9))
        } else {
            (0x2::coin::zero<T0>(arg9), 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T1>(arg1, arg2, v15, arg9))
        };
        let v22 = v21;
        let v23 = v20;
        let (v24, v25) = if (v2) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v23, v18, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v22, v19, arg9)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg0, v24, v25, v12);
        0x2::coin::join<T0>(&mut v23, 0x2::coin::from_balance<T0>(v14, arg9));
        0x2::coin::join<T1>(&mut v22, 0x2::coin::from_balance<T1>(v13, arg9));
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T0>(arg1, arg2, v23, arg9);
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T1>(arg1, arg2, v22, arg9);
        (v15, v16)
    }

    public fun sttb<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: vector<u64>, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u128>, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg9) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        };
        let v1 = v0;
        let v2 = if (arg9) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        };
        let v3 = v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg5)) {
            let v5 = *0x1::vector::borrow<u64>(&arg5, v4);
            let v6 = v5;
            if (v5 > v1) {
                v6 = v1;
            };
            if (v6 == 0) {
                break
            };
            let (v7, v8) = stt<T0, T1>(arg0, arg1, arg2, arg3, arg4, v6, *0x1::vector::borrow<u128>(&arg6, v4), true, arg9, arg10);
            if (v7 == 0 || v8 == 0) {
                break
            };
            v1 = v1 - v7;
            v3 = v3 + v8;
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg7)) {
            let v9 = *0x1::vector::borrow<u64>(&arg7, v4);
            let v10 = v9;
            if (v9 > v3) {
                v10 = v3;
            };
            if (v10 == 0) {
                break
            };
            let (v11, v12) = stt<T0, T1>(arg0, arg1, arg2, arg3, arg4, v10, *0x1::vector::borrow<u128>(&arg8, v4), false, arg9, arg10);
            if (v11 == 0 || v12 == 0) {
                break
            };
            v3 = v3 - v11;
            v1 = v1 + v12;
            v4 = v4 + 1;
        };
    }

    fun tt<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = if (arg12) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0)
        } else {
            isp(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0))
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
                l : 408,
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
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg0, v5, true, v3, v6, arg4);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10);
        let v14 = if (v5) {
            0x2::balance::value<T1>(&v11)
        } else {
            0x2::balance::value<T0>(&v12)
        };
        let v15 = if (arg6) {
            (((v13 as u128) * 1000000000000 / v2) as u64)
        } else {
            (((v13 as u128) * v2 / 1000000000000) as u64)
        };
        assert!(v14 >= v15, 13906836077014155269);
        let (v16, v17) = if (v5) {
            (v13, 0)
        } else {
            (0, v13)
        };
        let (v18, v19) = if (v5) {
            (0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T0>(arg1, arg2, v13, arg13), 0x2::coin::zero<T1>(arg13))
        } else {
            (0x2::coin::zero<T0>(arg13), 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T1>(arg1, arg2, v13, arg13))
        };
        let v20 = v19;
        let v21 = v18;
        let (v22, v23) = if (v5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v21, v16, arg13)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v20, v17, arg13)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg0, v22, v23, v10);
        0x2::coin::join<T0>(&mut v21, 0x2::coin::from_balance<T0>(v12, arg13));
        0x2::coin::join<T1>(&mut v20, 0x2::coin::from_balance<T1>(v11, arg13));
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T0>(arg1, arg2, v21, arg13);
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T1>(arg1, arg2, v20, arg13);
        (v13, v14)
    }

    public fun ttb<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: vector<u128>, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u8, arg14: u8, arg15: bool, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg15) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        };
        let v1 = v0;
        let v2 = if (arg15) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        };
        let v3 = v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u128>(&arg5)) {
            let v5 = *0x1::vector::borrow<u64>(&arg6, v4);
            if (v5 > v1) {
                let v6 = EE{
                    e : 114,
                    l : 530,
                };
                0x2::event::emit<EE>(v6);
            };
            let v7 = if (v5 > v1) {
                v1
            } else {
                v5
            };
            if (v7 < arg8) {
                let v8 = EE{
                    e : 115,
                    l : 533,
                };
                0x2::event::emit<EE>(v8);
                break
            };
            let (v9, v10) = tt<T0, T1>(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg5, v4), true, arg8, v7, arg13, arg14, *0x1::vector::borrow<u64>(&arg7, v4), arg15, arg16);
            if (v9 == 0 || v10 == 0) {
                break
            };
            v1 = v1 - v9;
            v3 = v3 + v10;
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < 0x1::vector::length<u128>(&arg9)) {
            let v11 = *0x1::vector::borrow<u64>(&arg10, v4);
            if (v11 > v3) {
                let v12 = EE{
                    e : 114,
                    l : 569,
                };
                0x2::event::emit<EE>(v12);
            };
            let v13 = if (v11 > v3) {
                v3
            } else {
                v11
            };
            if (v13 < arg12) {
                let v14 = EE{
                    e : 115,
                    l : 572,
                };
                0x2::event::emit<EE>(v14);
                break
            };
            let (v15, v16) = tt<T0, T1>(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg9, v4), false, arg12, v13, arg13, arg14, *0x1::vector::borrow<u64>(&arg11, v4), arg15, arg16);
            if (v15 == 0 || v16 == 0) {
                break
            };
            v3 = v3 - v15;
            v1 = v1 + v16;
            v4 = v4 + 1;
        };
    }

    fun usr(arg0: &mut SR, arg1: u64, arg2: u64, arg3: u64) {
        arg0.ai = arg0.ai + arg1;
        arg0.ao = arg0.ao + arg2;
        arg0.fa = arg0.fa + arg3;
    }

    // decompiled from Move bytecode v6
}

