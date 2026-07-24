module 0x7a57e040296effdedcdc3557e30a8d1f0f3ad51de57bf468b081e9cf9556841b::shot {
    public entry fun shot<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = if (arg7 < v1) {
            arg7
        } else {
            v1
        };
        let (v3, v4, v5, v6) = pick<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, v2);
        assert!(v6 >= arg8, 1);
        if (v3) {
            let (v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg6, v5, arg9)), 0x2::balance::zero<T1>(), true, true, v5, 0, 4295048017);
            0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v7, arg9));
            let v9 = 0x2::coin::from_balance<T1>(v8, arg9);
            let v10 = if (v4) {
                let (v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg0, arg1, arg3, 0x2::coin::into_balance<T1>(v9), 0x2::balance::zero<T2>(), true, true, 0x2::coin::value<T1>(&v9), 0, 4295048017);
                sweep<T1>(0x2::coin::from_balance<T1>(v11, arg9), v0);
                0x2::coin::from_balance<T2>(v12, arg9)
            } else {
                let (v13, v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg4, v9, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9), 0, arg0, arg9);
                sweep<T1>(v13, v0);
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v15);
                v14
            };
            let (v16, v17, v18) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T2>(arg5, v10, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9), 0, arg0, arg9);
            0x2::coin::join<T0>(&mut arg6, v16);
            sweep<T2>(v17, v0);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v18);
        } else {
            let (v19, v20, v21) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T2>(arg5, 0x2::coin::split<T0>(&mut arg6, v5, arg9), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9), 0, arg0, arg9);
            let v22 = v20;
            0x2::coin::join<T0>(&mut arg6, v19);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v21);
            let v23 = if (v4) {
                let (v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg0, arg1, arg3, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(v22), false, true, 0x2::coin::value<T2>(&v22), 0, 79226673515401279992447579054);
                sweep<T2>(0x2::coin::from_balance<T2>(v25, arg9), v0);
                0x2::coin::from_balance<T1>(v24, arg9)
            } else {
                let (v26, v27, v28) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg4, v22, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9), 0, arg0, arg9);
                sweep<T2>(v27, v0);
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v28);
                v26
            };
            let (v29, v30) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v23), false, true, 0x2::coin::value<T1>(&v23), 0, 79226673515401279992447579054);
            0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v29, arg9));
            sweep<T1>(0x2::coin::from_balance<T1>(v30, arg9), v0);
        };
        assert!(0x2::coin::value<T0>(&arg6) >= v1 + arg8, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, v0);
    }

    fun pick<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg5: u64) : (bool, bool, u64, u64) {
        let v0 = true;
        let v1 = true;
        let v2 = 0;
        let v3 = 0;
        let v4 = vector[8, 6, 4, 2, 1];
        let v5 = 0;
        while (v5 < 5) {
            let v6 = arg5 / 8 * *0x1::vector::borrow<u64>(&v4, v5);
            if (v6 > 0) {
                let v7 = 0;
                while (v7 < 4) {
                    let v8 = v7 % 2 == 0;
                    let v9 = v7 < 2;
                    let v10 = preview<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v8, v9, v6);
                    if (v10 > v6 && v10 - v6 > v3) {
                        v3 = v10 - v6;
                        v2 = v6;
                        v0 = v8;
                        v1 = v9;
                    };
                    v7 = v7 + 1;
                };
            };
            v5 = v5 + 1;
        };
        (v0, v1, v2, v3)
    }

    fun preview<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg5: bool, arg6: bool, arg7: u64) : u64 {
        if (arg5) {
            let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, true, true, arg7, 4295048017);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v1)) {
                return 0
            };
            let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v1);
            if (v2 == 0) {
                return 0
            };
            let v3 = preview_mid<T1, T2>(arg0, arg2, arg3, arg6, true, v2);
            if (v3 == 0) {
                return 0
            };
            let (v4, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T2>(arg4, 0, v3, arg0);
            v4
        } else {
            let (_, v8, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T2>(arg4, arg7, 0, arg0);
            if (v8 == 0) {
                return 0
            };
            let v10 = preview_mid<T1, T2>(arg0, arg2, arg3, arg6, false, v8);
            if (v10 == 0) {
                return 0
            };
            let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, false, true, v10, 79226673515401279992447579054);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v11)) {
                return 0
            };
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v11)
        }
    }

    fun preview_mid<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: bool, arg4: bool, arg5: u64) : u64 {
        if (arg3) {
            let v1 = if (arg4) {
                4295048017
            } else {
                79226673515401279992447579054
            };
            let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, arg4, true, arg5, v1);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v2)) {
                return 0
            };
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v2)
        } else if (arg4) {
            let (_, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg2, arg5, 0, arg0);
            v4
        } else {
            let (v6, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg2, 0, arg5, arg0);
            v6
        }
    }

    public fun probe<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg5: u64) : (bool, bool, u64, u64) {
        pick<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun sweep<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

