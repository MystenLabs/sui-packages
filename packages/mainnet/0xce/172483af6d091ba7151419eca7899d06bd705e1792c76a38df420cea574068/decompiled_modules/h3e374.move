module 0xce172483af6d091ba7151419eca7899d06bd705e1792c76a38df420cea574068::h3e374 {
    struct Hb0f61 has copy, drop {
        h4eafb: u64,
        hb8120: u64,
        hb3b4b: u64,
    }

    struct H75189 has copy, drop {
        h4eafb: u64,
        hb8120: u64,
        hb3b4b: u64,
        h6e11c: u128,
        h22cf0: bool,
    }

    fun h60d57(arg0: &mut Hb0f61, arg1: u64, arg2: u64, arg3: u64) {
        arg0.h4eafb = arg0.h4eafb + arg1;
        arg0.hb8120 = arg0.hb8120 + arg2;
        arg0.hb3b4b = arg0.hb3b4b + arg3;
    }

    fun hbfa6e<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: bool) : H75189 {
        let v0 = if (arg5) {
            arg4
        } else {
            he3d95(arg4)
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0);
        let v3 = Hb0f61{
            h4eafb : 0,
            hb8120 : 0,
            hb3b4b : 0,
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::first_score_for_swap(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v5 = H75189{
            h4eafb : 0,
            hb8120 : 0,
            hb3b4b : 0,
            h6e11c : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
            h22cf0 : false,
        };
        while (arg3 > 0 && v1 != v0) {
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v4)) {
                v5.h22cf0 = true;
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
                h60d57(v14, v9, v10, v12);
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
        v5.h4eafb = v3.h4eafb;
        v5.hb8120 = v3.hb8120;
        v5.hb3b4b = v3.hb3b4b;
        v5.h6e11c = v1;
        v5
    }

    fun hc715c(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun he3d95(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun he732a<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::H8e2ee, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg5 == 0) {
            return (0, 0)
        };
        let v0 = if (arg8) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0)
        } else {
            he3d95(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0))
        };
        let v1 = arg7 && v0 <= arg6 || v0 >= arg6;
        if (!v1) {
            return (0, 0)
        };
        let v2 = arg8 != arg7;
        let v3 = hbfa6e<T0, T1>(arg0, v2, true, arg5, arg6, arg8);
        let v4 = (v3.h4eafb as u128) + (v3.hb3b4b as u128);
        let v5 = v3.hb8120;
        if (v5 == 0 || v4 == 0) {
            return (0, 0)
        };
        let v6 = hc715c(arg6);
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
            he3d95(arg6)
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
        assert!(v16 >= v17, 13906835333984616450);
        let (v18, v19) = if (v2) {
            (v15, 0)
        } else {
            (0, v15)
        };
        let (v20, v21) = if (v2) {
            (0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::h1313c<T0>(arg1, arg2, v15, arg9), 0x2::coin::zero<T1>(arg9))
        } else {
            (0x2::coin::zero<T0>(arg9), 0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::h1313c<T1>(arg1, arg2, v15, arg9))
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
        0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::h3ab73<T0>(arg1, arg2, v23, arg9);
        0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::h3ab73<T1>(arg1, arg2, v22, arg9);
        (v15, v16)
    }

    public fun hfb38e<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xc971a569f8ebe9c3a5a683bb0b20750f5052239a8d74d59a0f594b599fa95618::h637f4::H8e2ee, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: vector<u64>, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u128>, arg9: u64, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg11) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        };
        let v1 = if (arg11) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2)
        };
        let v2 = if (v0 > arg10) {
            v0 - arg10
        } else {
            0
        };
        let v3 = v2;
        let v4 = if (v1 > arg9) {
            v1 - arg9
        } else {
            0
        };
        let v5 = v4;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&arg5)) {
            let v7 = *0x1::vector::borrow<u64>(&arg5, v6);
            let v8 = v7;
            if (v7 > v3) {
                v8 = v3;
            };
            if (v8 == 0) {
                break
            };
            let (v9, v10) = he732a<T0, T1>(arg0, arg1, arg2, arg3, arg4, v8, *0x1::vector::borrow<u128>(&arg6, v6), true, arg11, arg12);
            if (v9 == 0 || v10 == 0) {
                break
            };
            v3 = v3 - v9;
            v5 = v5 + v10;
            v6 = v6 + 1;
        };
        v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&arg7)) {
            let v11 = *0x1::vector::borrow<u64>(&arg7, v6);
            let v12 = v11;
            if (v11 > v5) {
                v12 = v5;
            };
            if (v12 == 0) {
                break
            };
            let (v13, v14) = he732a<T0, T1>(arg0, arg1, arg2, arg3, arg4, v12, *0x1::vector::borrow<u128>(&arg8, v6), false, arg11, arg12);
            if (v13 == 0 || v14 == 0) {
                break
            };
            v5 = v5 - v13;
            v3 = v3 + v14;
            v6 = v6 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

