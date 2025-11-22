module 0x6bda5f3c8c7f7b30664c8bff70872adcb0b2d6efb6e9d53aab78a7ee774dd3b4::cte {
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

    fun csr<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : CSR {
        let v0 = isp(arg4);
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

    fun opt<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u8) : u64 {
        assert!(arg6 < 100, 13906835218020892680);
        assert!(arg6 > 0, 13906835222315991050);
        assert!(arg4 > 0, 13906835226610565124);
        assert!(arg4 <= arg5, 13906835230905663494);
        let (v0, v1, v2) = scs<T0, T1>(arg0, arg5, arg1, arg2);
        let v3 = v0;
        if (v0 < arg4) {
            return 0
        };
        if (!v2) {
            if (pok(v1, arg3, arg1)) {
                return v0
            };
        };
        let v4 = 0;
        while (v4 < arg7) {
            let v5 = (((v3 as u128) * ((100 - arg6) as u128) / 100) as u64);
            if (v5 < arg4) {
                return 0
            };
            let (v6, v7, v8) = scs<T0, T1>(arg0, v5, arg1, arg2);
            if (!v8) {
                if (pok(v7, arg3, arg1)) {
                    return v6
                };
            };
            v3 = v6;
            v4 = v4 + 1;
        };
        0
    }

    fun pok(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || arg0 >= arg1
    }

    fun scs<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u128) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let v0 = csr<T0, T1>(arg0, arg2, true, arg1, arg3);
        let v1 = v0.ao;
        let v2 = v0.ai + v0.fa;
        if (v1 == 0 || v2 == 0) {
            return (0, 0, true)
        };
        let v3 = if (arg2) {
            (v2 as u128) * 1000000000000 / (v1 as u128) + 1
        } else {
            (v1 as u128) * 1000000000000 / (v2 as u128)
        };
        (v2, v3, v0.ie)
    }

    fun spstrs(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun tt<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg6 && isp(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0)) <= arg5 || isp(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0)) >= arg5;
        if (!v0) {
            return 0
        };
        let v1 = if (arg6) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        };
        if (v1 < arg7) {
            return 0
        };
        let v2 = if (arg8 > v1) {
            v1
        } else {
            arg8
        };
        let v3 = spstrs(arg5);
        let v4 = opt<T0, T1>(arg0, arg6, arg5, v3, arg7, v2, arg9, arg10);
        if (v4 < arg7) {
            return 0
        };
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg0, arg6, true, v4, isp(arg5), arg4);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8);
        let v12 = if (arg6) {
            0x2::balance::value<T1>(&v9)
        } else {
            0x2::balance::value<T0>(&v10)
        };
        let v13 = if (arg6) {
            (((v11 as u128) * 1000000000000 / v3) as u64)
        } else {
            (((v11 as u128) * v3 / 1000000000000) as u64)
        };
        assert!(v12 >= v13, 13906835896625332226);
        let (v14, v15) = if (arg6) {
            (v11, 0)
        } else {
            (0, v11)
        };
        let (v16, v17) = if (arg6) {
            (0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::wd<T0>(arg1, arg2, v11, arg11), 0x2::coin::zero<T1>(arg11))
        } else {
            (0x2::coin::zero<T0>(arg11), 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::wd<T1>(arg1, arg2, v11, arg11))
        };
        let v18 = v17;
        let v19 = v16;
        let (v20, v21) = if (arg6) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v19, v14, arg11)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v18, v15, arg11)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg0, v20, v21, v8);
        0x2::coin::join<T0>(&mut v19, 0x2::coin::from_balance<T0>(v10, arg11));
        0x2::coin::join<T1>(&mut v18, 0x2::coin::from_balance<T1>(v9, arg11));
        0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::dp<T0>(arg1, arg2, v19, arg11);
        0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::dp<T1>(arg1, arg2, v18, arg11);
        v11
    }

    public fun ttb<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x7e5c9a5a5e505816e99df9ab6a076e8a3f23ddf0c3dab7c3666bbdc66a60e2d8::sq::SQR, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: vector<u128>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u64>, arg11: u64, arg12: u64, arg13: u8, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e5c9a5a5e505816e99df9ab6a076e8a3f23ddf0c3dab7c3666bbdc66a60e2d8::sq::csst(arg3, arg5, arg14, arg15, true, true, arg16);
        if (v0 != 0) {
            let v1 = EE{
                e : v0,
                l : 378,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg6)) {
            tt<T0, T1>(arg0, arg1, arg2, arg4, arg5, *0x1::vector::borrow<u128>(&arg6, v2), true, arg8, *0x1::vector::borrow<u64>(&arg7, v2), arg12, arg13, arg16);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&arg9)) {
            tt<T0, T1>(arg0, arg1, arg2, arg4, arg5, *0x1::vector::borrow<u128>(&arg9, v2), false, arg11, *0x1::vector::borrow<u64>(&arg10, v2), arg12, arg13, arg16);
            v2 = v2 + 1;
        };
    }

    fun usr(arg0: &mut SR, arg1: u64, arg2: u64, arg3: u64) {
        arg0.ai = arg0.ai + arg1;
        arg0.ao = arg0.ao + arg2;
        arg0.fa = arg0.fa + arg3;
    }

    // decompiled from Move bytecode v6
}

