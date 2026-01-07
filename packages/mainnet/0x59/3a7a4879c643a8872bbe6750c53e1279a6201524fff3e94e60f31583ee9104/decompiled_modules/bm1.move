module 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::bm1 {
    fun bm1<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T0>(arg4, arg0, arg1, false, true, arg5, 79226673515401279992447579054);
        let v3 = v2;
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v3);
        let (v5, v6) = sbm_a_b_bao<0x2::sui::SUI, T0>(arg2, arg3, v0, v4, arg4, arg6);
        let v7 = v6;
        assert!(0x2::balance::value<T0>(&v7) >= v4, 20);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<T0>(&mut v7, v4), v3);
        0x2::balance::destroy_zero<T0>(v1);
        tb<T0>(v7, arg6);
        tb<0x2::sui::SUI>(v5, arg6);
    }

    public fun bm1p<T0>(arg0: &0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::admin::AdminCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        bm1p_w_s<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 1000000000, arg8, arg9);
    }

    public fun bm1p_ls<T0>(arg0: &0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::admin::AdminCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 42);
        let v0 = vector[1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000];
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = 0;
        let v3 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero();
        let v4 = 0;
        while (v4 < v1) {
            let v5 = arg6 * *0x1::vector::borrow<u64>(&v0, v4);
            let v6 = calc_bm1<T0>(arg2, arg4, v5);
            if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v6, v3)) {
                v2 = v5;
                v3 = v6;
                v4 = v4 + 1;
            } else {
                break
            };
        };
        if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v3, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero())) {
            bm1<T0>(arg1, arg2, arg3, arg4, arg5, v2, arg7);
            return
        };
        let v7 = 0;
        let v8 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero();
        let v9 = 0;
        while (v9 < v1) {
            let v10 = arg6 * *0x1::vector::borrow<u64>(&v0, v9);
            let v11 = calc_bm1r<T0>(arg2, arg4, v10);
            if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v11, v8)) {
                v7 = v10;
                v8 = v11;
                v9 = v9 + 1;
            } else {
                break
            };
        };
        assert!(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v8, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero()), 25);
        bm1r<T0>(arg1, arg2, arg3, arg4, arg5, v7, arg7);
    }

    public fun bm1p_w_s<T0>(arg0: &0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::admin::AdminCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= arg7, 40);
        assert!(arg9 > 0, 41);
        let v0 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::new_f_max(arg6, arg7, arg8, arg9);
        let v1 = calc_bm1<T0>(arg2, arg4, arg6);
        if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v1, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero())) {
            0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_init(&mut v0, arg6, v1);
            let v2 = 0;
            while (v2 < 10 && !0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_has_converged(&v0)) {
                0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_complete(&mut v0, calc_bm1<T0>(arg2, arg4, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_prep_u(&mut v0)));
                v2 = v2 + 1;
            };
            let (v3, _) = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_result(&v0);
            bm1<T0>(arg1, arg2, arg3, arg4, arg5, v3, arg10);
            return
        };
        let v5 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::new_f_max(arg6, arg7, arg8, arg9);
        let v6 = calc_bm1r<T0>(arg2, arg4, arg6);
        assert!(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v6, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero()), 25);
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_init(&mut v5, arg6, v6);
        let v7 = 0;
        while (v7 < 10 && !0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_has_converged(&v5)) {
            0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_complete(&mut v5, calc_bm1r<T0>(arg2, arg4, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_prep_u(&mut v5)));
            v7 = v7 + 1;
        };
        let (v8, _) = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_result(&v5);
        bm1r<T0>(arg1, arg2, arg3, arg4, arg5, v8, arg10);
    }

    fun bm1r<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T0>(arg4, arg0, arg1, true, false, arg5, 4295048017);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::balance::value<T0>(&v4) == arg5, 15);
        let (v5, v6) = sbm_b_a<0x2::sui::SUI, T0>(arg2, arg3, v4, arg4, arg6);
        let v7 = v6;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > 0, 50);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > v8, 20);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v8), 0x2::balance::zero<T0>(), v3);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        tb<T0>(v5, arg6);
        tb<0x2::sui::SUI>(v7, arg6);
    }

    fun calc_bm1<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg2: u64) : 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::I128 {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, T0>(arg0, false, true, arg2, 79226673515401279992447579054);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, T0>(arg1, true, true, 4295048017, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0));
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::sub(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1) as u128)), 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((arg2 as u128)))
    }

    fun calc_bm1r<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg2: u64) : 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::I128 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, T0>(arg1, false, true, 79226673515401279992447579054, arg2);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<0x2::sui::SUI, T0>(arg0, true, true, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0), 4295048017);
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::sub(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v1) as u128)), 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((arg2 as u128)))
    }

    fun sbm_a_b_bao<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg2) == 0 || arg3 == 0) {
            return (arg2, 0x2::balance::zero<T1>())
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, false, arg3, 4295048016, arg4, arg0, arg5);
        let v3 = v2;
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<T0>(&arg2) >= v4, 32);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::split<T0>(&mut arg2, v4), 0x2::balance::zero<T1>(), arg0, arg5);
        0x2::balance::destroy_zero<T0>(v0);
        (arg2, v1)
    }

    fun sbm_b_a<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T1>(&arg2) == 0) {
            return (arg2, 0x2::balance::zero<T0>())
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&arg2), 79226673515401279992447579055, arg3, arg0, arg4);
        let v3 = v2;
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<T1>(&arg2) >= v5, 31);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v5), arg0, arg4);
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

