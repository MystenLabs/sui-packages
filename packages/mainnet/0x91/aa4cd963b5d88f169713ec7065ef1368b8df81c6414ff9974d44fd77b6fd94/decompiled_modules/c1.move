module 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::c1 {
    fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg4) {
        };
        let (v6, v7) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)))
        };
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg9));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v6, v7, v3);
        (arg2, arg3)
    }

    fun c0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, arg5, 79226673515401279992447579055, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<T0>(v0, arg6);
        assert!(0x2::coin::value<T0>(&v4) == arg5, 15);
        let v5 = 0x2::coin::zero<T1>(arg6);
        let (v6, v7) = swap<T1, T0>(arg0, arg2, v5, v4, false, true, arg5, 79226673515401279992447579055, arg4, arg6);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::coin::value<T0>(&v8) == 0, 31);
        assert!(0x2::coin::value<T1>(&v9) > 0, 30);
        let v10 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        let (v11, v12) = swap<T1, 0x2::sui::SUI>(arg0, arg3, v9, v10, true, true, 0x2::coin::value<T1>(&v9), 4295048016, arg4, arg6);
        let v13 = v12;
        let v14 = v11;
        assert!(0x2::coin::value<T1>(&v14) == 0, 31);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > 0, 30);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > v15, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v15, arg6)), v3);
        0x2::coin::destroy_zero<T0>(v8);
        0x2::coin::destroy_zero<T1>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg6));
    }

    public fun c0p<T0, T1>(arg0: &0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= arg7, 40);
        assert!(arg9 <= arg10, 40);
        assert!(arg8 > 0, 41);
        assert!(arg11 > 0, 41);
        let v0 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::new_f_max(arg6, arg7, 1000000000, arg8);
        let v1 = calc_c0<T0, T1>(arg2, arg3, arg4, arg6);
        if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v1, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero())) {
            0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_init(&mut v0, arg6, v1);
            let v2 = 0;
            while (v2 < 10 && !0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_has_converged(&v0)) {
                0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_complete(&mut v0, calc_c0<T0, T1>(arg2, arg3, arg4, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_prep_u(&mut v0)));
                v2 = v2 + 1;
            };
            let (v3, _) = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_result(&v0);
            c0<T0, T1>(arg1, arg2, arg3, arg4, arg5, v3, arg12);
            return
        };
        let v5 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::new_f_max(arg9, arg10, 1000000, arg11);
        let v6 = calc_c0r<T0, T1>(arg2, arg3, arg4, arg9);
        assert!(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v6, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero()), 25);
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_init(&mut v5, arg9, v6);
        let v7 = 0;
        while (v7 < 10 && !0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_has_converged(&v5)) {
            0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_complete(&mut v5, calc_c0r<T0, T1>(arg2, arg3, arg4, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_prep_u(&mut v5)));
            v7 = v7 + 1;
        };
        let (v8, _) = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_result(&v5);
        c0r<T0, T1>(arg1, arg2, arg3, arg4, arg5, v8, arg12);
    }

    public fun c0p_ls<T0, T1>(arg0: &0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 42);
        assert!(arg7 > 0, 42);
        let v0 = vector[1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000];
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = 0;
        let v3 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero();
        let v4 = 0;
        while (v4 < v1) {
            let v5 = arg6 * *0x1::vector::borrow<u64>(&v0, v4);
            let v6 = calc_c0<T0, T1>(arg2, arg3, arg4, v5);
            if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v6, v3)) {
                v2 = v5;
                v3 = v6;
                v4 = v4 + 1;
            } else {
                break
            };
        };
        if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v3, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero())) {
            c0<T0, T1>(arg1, arg2, arg3, arg4, arg5, v2, arg8);
            return
        };
        let v7 = 0;
        let v8 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero();
        let v9 = 0;
        while (v9 < v1) {
            let v10 = arg7 * *0x1::vector::borrow<u64>(&v0, v9);
            let v11 = calc_c0r<T0, T1>(arg2, arg3, arg4, v10);
            if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v11, v8)) {
                v7 = v10;
                v8 = v11;
                v9 = v9 + 1;
            } else {
                break
            };
        };
        assert!(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v8, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero()), 25);
        c0r<T0, T1>(arg1, arg2, arg3, arg4, arg5, v7, arg8);
    }

    fun c0r<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg0, arg3, false, false, arg5, 79226673515401279992447579055, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg6);
        assert!(0x2::coin::value<T1>(&v4) == arg5, 15);
        let v5 = 0x2::coin::zero<T0>(arg6);
        let (v6, v7) = swap<T1, T0>(arg0, arg2, v4, v5, true, true, arg5, 4295048016, arg4, arg6);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::coin::value<T1>(&v9) == 0, 31);
        assert!(0x2::coin::value<T0>(&v8) > 0, 30);
        let v10 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        let (v11, v12) = swap<T0, 0x2::sui::SUI>(arg0, arg1, v8, v10, true, true, 0x2::coin::value<T0>(&v8), 4295048016, arg4, arg6);
        let v13 = v12;
        let v14 = v11;
        assert!(0x2::coin::value<T0>(&v14) == 0, 31);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > 0, 30);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > v15, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg0, arg3, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v15, arg6)), v3);
        0x2::coin::destroy_zero<T0>(v14);
        0x2::coin::destroy_zero<T1>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg6));
    }

    fun calc_c0<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: u64) : 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, false, true, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg2, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::sub(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) as u128)), 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((arg3 as u128)))
    }

    fun calc_c0r<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: u64) : 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, true, true, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, 0x2::sui::SUI>(arg2, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::sub(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) as u128)), 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((arg3 as u128)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

