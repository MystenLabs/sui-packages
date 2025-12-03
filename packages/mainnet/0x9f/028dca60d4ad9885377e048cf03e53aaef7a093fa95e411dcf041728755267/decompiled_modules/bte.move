module 0x9f028dca60d4ad9885377e048cf03e53aaef7a093fa95e411dcf041728755267::bte {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    fun opt<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64) : u64 {
        assert!(arg4 > 0, 13906834599545339908);
        assert!(arg4 <= arg5, 13906834603840438278);
        assert!(arg8 < arg4, 13906834608135536648);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, v5, v6) = sbs<T0, T1>(arg0, v2, arg1, arg2);
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
            v2 = v2 * 2;
        };
        if (v0 == 0) {
            return v0
        };
        v3 = 0;
        while (v3 < arg7) {
            v3 = v3 + 1;
            if (v2 - v1 <= arg8) {
                break
            };
            let v7 = (v1 + v2) / 2;
            let (v8, v9, v10) = sbs<T0, T1>(arg0, v7, arg1, arg2);
            if (pok(v9, arg3, arg1) && !v10) {
                v0 = v8;
                v1 = v7;
                continue
            };
            v2 = v7;
        };
        v0
    }

    fun pok(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || arg0 >= arg1
    }

    fun sbs<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u128) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, !arg2, true, arg1, arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v0) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0);
        if (v2 == 0 || v1 == 0) {
            return (0, 0, true)
        };
        let v3 = if (arg2) {
            (v1 as u128) * 1000000000000 / (v2 as u128) + 1
        } else {
            (v2 as u128) * 1000000000000 / (v1 as u128)
        };
        (v1, v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0))
    }

    fun spstrs(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun tt<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = arg6 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0) <= arg5 || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0) >= arg5;
        if (!v0) {
            return (0, 0)
        };
        let v1 = spstrs(arg5);
        let v2 = opt<T0, T1>(arg0, arg6, arg5, v1, arg7, arg8, arg9, arg10, arg11);
        if (v2 < arg7) {
            return (0, 0)
        };
        let v3 = !arg6;
        let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg3, arg0, v3, true, v2, arg5);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v7);
        let v11 = if (v3) {
            0x2::balance::value<T1>(&v8)
        } else {
            0x2::balance::value<T0>(&v9)
        };
        let v12 = if (arg6) {
            (((v10 as u128) * 1000000000000 / v1) as u64)
        } else {
            (((v10 as u128) * v1 / 1000000000000) as u64)
        };
        assert!(v11 >= v12, 13906835295329910786);
        let (v13, v14) = if (v3) {
            (v10, 0)
        } else {
            (0, v10)
        };
        let (v15, v16) = if (v3) {
            (0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::wd<T0>(arg1, arg2, v13, arg12), 0x2::coin::zero<T1>(arg12))
        } else {
            (0x2::coin::zero<T0>(arg12), 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::wd<T1>(arg1, arg2, v14, arg12))
        };
        let v17 = v16;
        let v18 = v15;
        let (v19, v20) = if (v3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v18, v13, arg12)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v17, v14, arg12)))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg3, arg0, v19, v20, v7);
        0x2::coin::join<T0>(&mut v18, 0x2::coin::from_balance<T0>(v9, arg12));
        0x2::coin::join<T1>(&mut v17, 0x2::coin::from_balance<T1>(v8, arg12));
        0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::dp<T0>(arg1, arg2, v18, arg12);
        0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::dp<T1>(arg1, arg2, v17, arg12);
        (v10, v11)
    }

    public fun ttb<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x7e5c9a5a5e505816e99df9ab6a076e8a3f23ddf0c3dab7c3666bbdc66a60e2d8::sq::SQR, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: vector<u128>, arg11: vector<u64>, arg12: vector<u64>, arg13: u64, arg14: u8, arg15: u8, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e5c9a5a5e505816e99df9ab6a076e8a3f23ddf0c3dab7c3666bbdc66a60e2d8::sq::csst(arg3, arg5, arg16, arg17, true, true, arg18);
        if (v0 != 0) {
            let v1 = EE{
                e : v0,
                l : 341,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u128>(&arg6)) {
            let v5 = *0x1::vector::borrow<u64>(&arg7, v4);
            let v6 = if (v5 > v2) {
                v2
            } else {
                v5
            };
            if (v6 < arg9) {
                break
            };
            let (v7, v8) = tt<T0, T1>(arg0, arg1, arg2, arg4, arg5, *0x1::vector::borrow<u128>(&arg6, v4), true, arg9, v6, arg14, arg15, *0x1::vector::borrow<u64>(&arg8, v4), arg18);
            if (v7 == 0 || v8 == 0) {
                break
            };
            v2 = v2 - v7;
            v3 = v3 + v8;
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < 0x1::vector::length<u128>(&arg10)) {
            let v9 = *0x1::vector::borrow<u64>(&arg11, v4);
            let v10 = if (v9 > v3) {
                v3
            } else {
                v9
            };
            if (v10 < arg13) {
                break
            };
            let (v11, v12) = tt<T0, T1>(arg0, arg1, arg2, arg4, arg5, *0x1::vector::borrow<u128>(&arg10, v4), false, arg13, v10, arg14, arg15, *0x1::vector::borrow<u64>(&arg12, v4), arg18);
            if (v11 == 0 || v12 == 0) {
                break
            };
            v3 = v3 - v11;
            v2 = v2 + v12;
            v4 = v4 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

