module 0x8d7a2d8fa32f2cf987d828d69fb36f2fb870ab2d1a2becba479e99b749eb442c::m {
    fun isp(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    fun opt<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: u64, arg9: bool) : u64 {
        assert!(arg4 > 0, 13906834668264816644);
        assert!(arg4 <= arg5, 13906834672559915014);
        assert!(arg8 < arg4, 13906834676855013384);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg4;
        let v3 = 0;
        while (v3 < arg6) {
            v3 = v3 + 1;
            if (v2 > arg5) {
                v2 = arg5;
            };
            let (v4, v5, v6) = sms<T0, T1>(arg0, v2, arg1, arg2, arg9);
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
            let (v9, v10, v11) = sms<T0, T1>(arg0, v8, arg1, arg2, arg9);
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

    fun sms<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u128, arg4: bool) : (u64, u128, bool) {
        if (arg1 == 0) {
            return (0, 0, true)
        };
        let v0 = if (arg4) {
            arg3
        } else {
            isp(arg3)
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg4 != arg2, true, v0, arg1);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v1);
        let v3 = arg1 - v2;
        let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1);
        if (v4 == 0 || v3 == 0) {
            return (0, 0, true)
        };
        let v5 = if (arg2) {
            (v3 as u128) * 1000000000000 / (v4 as u128) + 1
        } else {
            (v4 as u128) * 1000000000000 / (v3 as u128)
        };
        (v3, v5, v2 > 0)
    }

    fun spstrs(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun tt<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: u128, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: u64, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = if (arg12) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0)
        } else {
            isp(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0))
        };
        let v1 = arg6 && v0 <= arg5 || v0 >= arg5;
        if (!v1) {
            return (0, 0)
        };
        let v2 = spstrs(arg5);
        let v3 = opt<T0, T1>(arg0, arg6, arg5, v2, arg7, arg8, arg9, arg10, arg11, arg12);
        if (v3 < arg7) {
            return (0, 0)
        };
        let v4 = arg12 != arg6;
        let v5 = if (arg12) {
            arg5
        } else {
            isp(arg5)
        };
        let (v6, v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, v4, true, v3, v5, arg4, arg3, arg13);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        let (v12, v13) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v9);
        let v14 = if (v4) {
            v12
        } else {
            v13
        };
        let v15 = if (v4) {
            0x2::balance::value<T1>(&v10)
        } else {
            0x2::balance::value<T0>(&v11)
        };
        let v16 = if (arg6) {
            (((v14 as u128) * 1000000000000 / v2) as u64)
        } else {
            (((v14 as u128) * v2 / 1000000000000) as u64)
        };
        assert!(v15 >= v16, 13906835505783308290);
        let (v17, v18) = if (v4) {
            (0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T0>(arg1, arg2, v12, arg13), 0x2::coin::zero<T1>(arg13))
        } else {
            (0x2::coin::zero<T0>(arg13), 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::wd<T1>(arg1, arg2, v13, arg13))
        };
        let v19 = v18;
        let v20 = v17;
        let (v21, v22) = if (v4) {
            (0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v20, v12, arg13)))
        } else {
            (0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v19, v13, arg13)), 0x2::balance::zero<T0>())
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v9, v22, v21, arg3, arg13);
        0x2::coin::join<T0>(&mut v20, 0x2::coin::from_balance<T0>(v11, arg13));
        0x2::coin::join<T1>(&mut v19, 0x2::coin::from_balance<T1>(v10, arg13));
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T0>(arg1, arg2, v20, arg13);
        0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::dp<T1>(arg1, arg2, v19, arg13);
        (v14, v15)
    }

    public fun ttb<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0xca032a8e5955ee029d8be796b2963b402baaa9fa62aece62c03e7ca6fba52dd4::bm::CBM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: vector<u128>, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<u128>, arg10: vector<u64>, arg11: vector<u64>, arg12: u64, arg13: u8, arg14: u8, arg15: bool, arg16: &mut 0x2::tx_context::TxContext) {
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
            let v6 = if (v5 > v1) {
                v1
            } else {
                v5
            };
            if (v6 < arg8) {
                break
            };
            let (v7, v8) = tt<T0, T1>(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg5, v4), true, arg8, v6, arg13, arg14, *0x1::vector::borrow<u64>(&arg7, v4), arg15, arg16);
            if (v7 == 0 || v8 == 0) {
                break
            };
            v1 = v1 - v7;
            v3 = v3 + v8;
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < 0x1::vector::length<u128>(&arg9)) {
            let v9 = *0x1::vector::borrow<u64>(&arg10, v4);
            let v10 = if (v9 > v3) {
                v3
            } else {
                v9
            };
            if (v10 < arg12) {
                break
            };
            let (v11, v12) = tt<T0, T1>(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u128>(&arg9, v4), false, arg12, v10, arg13, arg14, *0x1::vector::borrow<u64>(&arg11, v4), arg15, arg16);
            if (v11 == 0 || v12 == 0) {
                break
            };
            v3 = v3 - v11;
            v1 = v1 + v12;
            v4 = v4 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

