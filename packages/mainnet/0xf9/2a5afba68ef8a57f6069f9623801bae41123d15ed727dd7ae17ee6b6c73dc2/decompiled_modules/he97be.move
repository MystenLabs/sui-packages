module 0xf92a5afba68ef8a57f6069f9623801bae41123d15ed727dd7ae17ee6b6c73dc2::he97be {
    fun h71fd6(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        ((340282366920938463463374607431768211456 / (arg0 as u256)) as u128)
    }

    public fun hc99cd<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: vector<u64>, arg6: vector<u128>, arg7: vector<u64>, arg8: vector<u128>, arg9: u64, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
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
            let (v9, v10) = he8f4b<T0, T1>(arg0, arg1, arg2, arg3, arg4, v8, *0x1::vector::borrow<u128>(&arg6, v6), true, arg11, arg12);
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
            let (v13, v14) = he8f4b<T0, T1>(arg0, arg1, arg2, arg3, arg4, v12, *0x1::vector::borrow<u128>(&arg8, v6), false, arg11, arg12);
            if (v13 == 0 || v14 == 0) {
                break
            };
            v5 = v5 - v13;
            v3 = v3 + v14;
            v6 = v6 + 1;
        };
    }

    fun hce35f(arg0: u128) : u128 {
        (((arg0 as u256) * (arg0 as u256) * (1000000000000 as u256) / 340282366920938463463374607431768211456) as u128)
    }

    fun he8f4b<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg5 == 0) {
            return (0, 0)
        };
        let v0 = if (arg8) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0)
        } else {
            h71fd6(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0))
        };
        let v1 = arg7 && v0 < arg6 || v0 > arg6;
        if (!v1) {
            return (0, 0)
        };
        let v2 = arg8 != arg7;
        let v3 = if (arg8) {
            arg6
        } else {
            h71fd6(arg6)
        };
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, v2, true, arg5, v3);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v4) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v4);
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v4);
        if (v6 == 0 || v5 == 0) {
            return (0, 0)
        };
        let v7 = hce35f(arg6);
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
        assert!(v16 >= v17, 13906834732689195010);
        let (v18, v19) = if (v2) {
            (v15, 0)
        } else {
            (0, v15)
        };
        let (v20, v21) = if (v2) {
            (0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T0>(arg1, arg2, v18, arg9), 0x2::coin::zero<T1>(arg9))
        } else {
            (0x2::coin::zero<T0>(arg9), 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T1>(arg1, arg2, v19, arg9))
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
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T0>(arg1, arg2, v23, arg9);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T1>(arg1, arg2, v22, arg9);
        (v15, v16)
    }

    // decompiled from Move bytecode v6
}

