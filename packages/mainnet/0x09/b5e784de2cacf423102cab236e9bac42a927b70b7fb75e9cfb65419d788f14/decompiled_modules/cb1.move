module 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::cb1 {
    fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (arg6 == 0) {
            return (arg2, arg3)
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg4) {
        };
        let (v6, v7) = if (arg4) {
            (0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)))
        };
        0x2::balance::join<T0>(&mut arg2, v5);
        0x2::balance::join<T1>(&mut arg3, v4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v6, v7, v3);
        (arg2, arg3)
    }

    fun cb1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, false, true, arg6, 79226673515401279992447579055, arg5);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v3);
        let (v5, v6) = sbb_b_a_bao<T0, T1>(arg3, arg4, v0, v4, arg5);
        let v7 = v6;
        let v8 = v5;
        assert!(0x2::balance::value<T0>(&v7) >= v4, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v7, v4), v3);
        let (v9, v10) = swap<T1, 0x2::sui::SUI>(arg0, arg2, v8, 0x2::balance::zero<0x2::sui::SUI>(), true, true, 0x2::balance::value<T1>(&v8), 4295048016, arg5);
        0x2::balance::destroy_zero<T0>(v1);
        tb<T0>(v7, arg7);
        tb<T1>(v9, arg7);
        tb<0x2::sui::SUI>(v10, arg7);
    }

    fun calc_cb1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u64) : 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg0, false, true, arg2);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0), 79226673515401279992447579054);
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::sub(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v1) as u128)), 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((arg2 as u128)))
    }

    fun calc_cb1r<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u64) : 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::I128 {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, true, true, arg2, 4295048017);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg0, true, true, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0));
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::sub(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1) as u128)), 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((arg2 as u128)))
    }

    public fun cb1p<T0, T1>(arg0: &0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= arg8, 40);
        assert!(arg9 > 0, 41);
        let v0 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::new_f_max(arg7, arg8, 1000000000, arg9);
        let v1 = calc_cb1<T0, T1>(arg2, arg5, arg7);
        if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v1, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero())) {
            0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_init(&mut v0, arg7, v1);
            let v2 = 0;
            while (v2 < 10 && !0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_has_converged(&v0)) {
                0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_complete(&mut v0, calc_cb1<T0, T1>(arg2, arg5, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_prep_u(&mut v0)));
                v2 = v2 + 1;
            };
            let (v3, _) = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_result(&v0);
            cb1<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, v3, arg10);
            return
        };
        let v5 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::new_f_max(arg7, arg8, 1000000000, arg9);
        let v6 = calc_cb1r<T0, T1>(arg2, arg5, arg7);
        assert!(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v6, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero()), 25);
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_init(&mut v5, arg7, v6);
        let v7 = 0;
        while (v7 < 10 && !0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_has_converged(&v5)) {
            0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_complete(&mut v5, calc_cb1r<T0, T1>(arg2, arg5, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_prep_u(&mut v5)));
            v7 = v7 + 1;
        };
        let (v8, _) = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_result(&v5);
        cb1r<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, v8, arg10);
    }

    fun cb1r<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, true, false, arg6, 4295048016, arg5);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::balance::value<T0>(&v4) == arg6, 15);
        let (v5, v6) = sbb_a_b<T0, T1>(arg3, arg4, v4, arg5);
        let v7 = v6;
        assert!(0x2::balance::value<T1>(&v7) > 0, 50);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v3);
        assert!(0x2::balance::value<T1>(&v7) > v8, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::balance::split<T1>(&mut v7, v8), 0x2::balance::zero<T0>(), v3);
        let (v9, v10) = swap<T1, 0x2::sui::SUI>(arg0, arg2, v7, 0x2::balance::zero<0x2::sui::SUI>(), true, true, 0x2::balance::value<T1>(&v7), 4295048016, arg5);
        0x2::balance::destroy_zero<T1>(v0);
        tb<T0>(v5, arg7);
        tb<T1>(v9, arg7);
        tb<0x2::sui::SUI>(v10, arg7);
    }

    fun sbb_a_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            return (arg2, 0x2::balance::zero<T1>())
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048017);
        let v3 = v2;
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(0x2::balance::value<T0>(&arg2) >= v4, 30);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, v4), 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(v0);
        (arg2, v1)
    }

    fun sbb_b_a_bao<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T1>(&arg2) == 0 || arg3 == 0) {
            return (arg2, 0x2::balance::zero<T0>())
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg1, false, false, arg3, 79226673515401279992447579054);
        let v3 = v2;
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(0x2::balance::value<T1>(&arg2) >= v4, 33);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v4), v3);
        0x2::balance::destroy_zero<T1>(v1);
        (arg2, v0)
    }

    fun tb<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

