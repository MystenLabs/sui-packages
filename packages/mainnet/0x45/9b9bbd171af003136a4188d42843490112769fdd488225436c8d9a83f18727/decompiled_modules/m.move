module 0x459b9bbd171af003136a4188d42843490112769fdd488225436c8d9a83f18727::m {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    fun isp(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun opt<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64, arg9: bool) : u64 {
        assert!(arg4 > 0, 13906834745574424583);
        assert!(arg4 <= arg5, 13906834749869522953);
        assert!(arg8 < arg4, 13906834754164621323);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, v5, v6) = sbs<T0, T1>(arg0, v2, arg1, arg2, arg9);
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
            let (v9, v10, v11) = sbs<T0, T1>(arg0, v8, arg1, arg2, arg9);
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

    fun sbs<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u128, arg4: bool) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let v0 = arg4 != arg2;
        let v1 = if (arg4) {
            arg3
        } else {
            isp(arg3)
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        if (v0 && v2 <= v1) {
            return (0, 0, true)
        };
        if (!v0 && v2 >= v1) {
            return (0, 0, true)
        };
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, v0, true, arg1, v1);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v3);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v3) - v4;
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v3);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v3) || v4 > 0;
        if (v6 == 0 || v5 == 0) {
            return (0, 0, true)
        };
        let v8 = if (arg2) {
            (v5 as u128) * 1000000000000 / (v6 as u128) + 1
        } else {
            (v6 as u128) * 1000000000000 / (v5 as u128)
        };
        (v5, v8, v7)
    }

    fun spstrs(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun stt<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg5 == 0) {
            return (0, 0)
        };
        let v0 = if (arg8) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0)
        } else {
            isp(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0))
        };
        let v1 = arg7 && v0 < arg6 || v0 > arg6;
        if (!v1) {
            return (0, 0)
        };
        let v2 = arg8 != arg7;
        let v3 = if (arg8) {
            arg6
        } else {
            isp(arg6)
        };
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, v2, true, arg5, v3);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v4) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v4);
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v4);
        if (v6 == 0 || v5 == 0) {
            return (0, 0)
        };
        let v7 = spstrs(arg6);
        let v8 = if (arg7) {
            (((v5 as u128) * 1000000000000 / v7) as u64)
        } else {
            (((v5 as u128) * v7 / 1000000000000) as u64)
        };
        if (v6 < v8) {
            return (0, 0)
        };
        let (v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg3, arg0, v2, true, arg5, v3);
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let v15 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v12);
        let v16 = if (v2) {
            0x2::balance::value<T1>(&v13)
        } else {
            0x2::balance::value<T0>(&v14)
        };
        let v17 = if (arg7) {
            (((v15 as u128) * 1000000000000 / v7) as u64)
        } else {
            (((v15 as u128) * v7 / 1000000000000) as u64)
        };
        assert!(v16 >= v17, 13906836631064936453);
        let (v18, v19) = if (v2) {
            (v15, 0)
        } else {
            (0, v15)
        };
        let (v20, v21) = if (v2) {
            (0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T0>(arg1, arg2, v18, arg9), 0x2::coin::zero<T1>(arg9))
        } else {
            (0x2::coin::zero<T0>(arg9), 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T1>(arg1, arg2, v19, arg9))
        };
        let v22 = v21;
        let v23 = v20;
        let (v24, v25) = if (v2) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v23, v18, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v22, v19, arg9)))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg3, arg0, v24, v25, v12);
        0x2::coin::join<T0>(&mut v23, 0x2::coin::from_balance<T0>(v14, arg9));
        0x2::coin::join<T1>(&mut v22, 0x2::coin::from_balance<T1>(v13, arg9));
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T0>(arg1, arg2, v23, arg9);
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T1>(arg1, arg2, v22, arg9);
        (v15, v16)
    }

    public fun sttb<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: vector<u64>, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u128>, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
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

    fun tt<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = if (arg12) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0)
        } else {
            isp(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0))
        };
        let v1 = arg6 && v0 < arg5 || v0 > arg5;
        if (!v1) {
            return (0, 0)
        };
        let v2 = spstrs(arg5);
        let v3 = opt<T0, T1>(arg0, arg6, arg5, v2, arg7, arg8, arg9, arg10, arg11, arg12);
        if (v3 < arg7) {
            let v4 = EE{
                e : 116,
                l : 279,
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
        let (v7, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg3, arg0, v5, true, v3, v6);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v10);
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
        assert!(v14 >= v15, 13906835574502981637);
        let (v16, v17) = if (v5) {
            (v13, 0)
        } else {
            (0, v13)
        };
        let (v18, v19) = if (v5) {
            (0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T0>(arg1, arg2, v16, arg13), 0x2::coin::zero<T1>(arg13))
        } else {
            (0x2::coin::zero<T0>(arg13), 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T1>(arg1, arg2, v17, arg13))
        };
        let v20 = v19;
        let v21 = v18;
        let (v22, v23) = if (v5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v21, v16, arg13)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v20, v17, arg13)))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg3, arg0, v22, v23, v10);
        0x2::coin::join<T0>(&mut v21, 0x2::coin::from_balance<T0>(v12, arg13));
        0x2::coin::join<T1>(&mut v20, 0x2::coin::from_balance<T1>(v11, arg13));
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T0>(arg1, arg2, v21, arg13);
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T1>(arg1, arg2, v20, arg13);
        (v13, v14)
    }

    public fun ttb<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: vector<u128>, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u8, arg14: u8, arg15: bool, arg16: &mut 0x2::tx_context::TxContext) {
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
                    l : 397,
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
                    l : 400,
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
                    l : 436,
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
                    l : 439,
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

    // decompiled from Move bytecode v6
}

