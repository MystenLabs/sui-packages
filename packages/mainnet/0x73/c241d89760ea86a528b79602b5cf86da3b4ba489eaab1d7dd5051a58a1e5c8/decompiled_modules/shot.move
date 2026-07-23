module 0x73c241d89760ea86a528b79602b5cf86da3b4ba489eaab1d7dd5051a58a1e5c8::shot {
    public entry fun shot<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::coin::value<T0>(&arg5);
        let v2 = if (arg6 < v1) {
            arg6
        } else {
            v1
        };
        let (v3, v4, v5) = pick<T0, T1, T2>(arg0, arg2, arg3, arg4, v2);
        assert!(v5 >= arg7, 1);
        if (v3) {
            let (v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, v4, arg8)), 0x2::balance::zero<T1>(), true, true, v4, 0, 4295048017);
            0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v6, arg8));
            let (v8, v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg3, 0x2::coin::from_balance<T1>(v7, arg8), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg0, arg8);
            let (v11, v12, v13) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T2>(arg4, v9, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg0, arg8);
            0x2::coin::join<T0>(&mut arg5, v11);
            sweep<T1>(v8, v0);
            sweep<T2>(v12, v0);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v10);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v13);
        } else {
            let (v14, v15, v16) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T2>(arg4, 0x2::coin::split<T0>(&mut arg5, v4, arg8), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg0, arg8);
            0x2::coin::join<T0>(&mut arg5, v14);
            let (v17, v18, v19) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg3, v15, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg0, arg8);
            let v20 = v17;
            let (v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v20), false, true, 0x2::coin::value<T1>(&v20), 0, 79226673515401279992447579054);
            0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v21, arg8));
            sweep<T1>(0x2::coin::from_balance<T1>(v22, arg8), v0);
            sweep<T2>(v18, v0);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v16);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v19);
        };
        assert!(0x2::coin::value<T0>(&arg5) >= v1 + arg7, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, v0);
    }

    fun pick<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg4: u64) : (bool, u64, u64) {
        let v0 = true;
        let v1 = 0;
        let v2 = 0;
        let v3 = vector[8, 6, 4, 2, 1];
        let v4 = 0;
        while (v4 < 5) {
            let v5 = arg4 / 8 * *0x1::vector::borrow<u64>(&v3, v4);
            if (v5 > 0) {
                let v6 = preview_sell<T0, T1, T2>(arg0, arg1, arg2, arg3, v5);
                if (v6 > v5 && v6 - v5 > v2) {
                    v2 = v6 - v5;
                    v1 = v5;
                    v0 = true;
                };
                let v7 = preview_buy<T0, T1, T2>(arg0, arg1, arg2, arg3, v5);
                if (v7 > v5 && v7 - v5 > v2) {
                    v2 = v7 - v5;
                    v1 = v5;
                    v0 = false;
                };
            };
            v4 = v4 + 1;
        };
        (v0, v1, v2)
    }

    fun preview_buy<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg4: u64) : u64 {
        let (_, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T2>(arg3, arg4, 0, arg0);
        if (v1 == 0) {
            return 0
        };
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T1, T2>(arg2, 0, v1, arg0);
        if (v3 == 0) {
            return 0
        };
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, false, true, v3, 79226673515401279992447579054);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v6)) {
            return 0
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v6)
    }

    fun preview_sell<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg4: u64) : u64 {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, true, true, arg4, 4295048017);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0)) {
            return 0
        };
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0);
        if (v1 == 0) {
            return 0
        };
        let (_, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T1, T2>(arg2, v1, 0, arg0);
        if (v3 == 0) {
            return 0
        };
        let (v5, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T2>(arg3, 0, v3, arg0);
        v5
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

