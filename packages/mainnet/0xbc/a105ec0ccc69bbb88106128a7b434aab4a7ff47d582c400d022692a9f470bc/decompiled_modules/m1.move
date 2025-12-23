module 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::m1 {
    fun m1<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, T0>(arg1, true, false, arg5, 4295048017, arg4, arg0, arg6);
        let v3 = v2;
        let (v4, v5) = sbm_b_a<T1, T0>(arg0, arg2, v1, arg4, arg6);
        let (v6, v7) = sbm_a_b<T1, 0x2::sui::SUI>(arg0, arg3, v5, arg4, arg6);
        let v8 = v7;
        let (v9, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v8) > v9, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, T0>(arg1, v3, 0x2::balance::split<0x2::sui::SUI>(&mut v8, v9), 0x2::balance::zero<T0>(), arg0, arg6);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        tb<T0>(v4, arg6);
        tb<T1>(v6, arg6);
        tb<0x2::sui::SUI>(v8, arg6);
    }

    fun calc_m1<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, 0x2::sui::SUI>, arg3: u64) : 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::I128 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T1, T0>(arg1, false, true, 79226673515401279992447579054, arg3);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T1, 0x2::sui::SUI>(arg2, true, true, 4295048017, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0));
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, T0>(arg0, true, true, 4295048017, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1));
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::sub(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v2) as u128)), 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((arg3 as u128)))
    }

    fun calc_m1r<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, 0x2::sui::SUI>, arg3: u64) : 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::I128 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T1, T0>(arg1, true, true, 4295048017, arg3);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, T0>(arg0, false, true, 79226673515401279992447579054, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0));
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T1, 0x2::sui::SUI>(arg2, false, true, 79226673515401279992447579054, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1));
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::sub(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v2) as u128)), 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((arg3 as u128)))
    }

    public fun m1p<T0, T1>(arg0: &0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        m1p_w_s<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 1000000, arg8, arg9, arg10, 1000000000, arg11, arg12);
    }

    public fun m1p_ls<T0, T1>(arg0: &0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 42);
        assert!(arg7 > 0, 42);
        let v0 = vector[1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000];
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = 0;
        let v3 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero();
        let v4 = 0;
        while (v4 < v1) {
            let v5 = arg6 * *0x1::vector::borrow<u64>(&v0, v4);
            let v6 = calc_m1<T0, T1>(arg2, arg3, arg4, v5);
            if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v6, v3)) {
                v2 = v5;
                v3 = v6;
                v4 = v4 + 1;
            } else {
                break
            };
        };
        if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v3, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero())) {
            m1<T0, T1>(arg1, arg2, arg3, arg4, arg5, v2, arg8);
            return
        };
        let v7 = 0;
        let v8 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero();
        let v9 = 0;
        while (v9 < v1) {
            let v10 = arg7 * *0x1::vector::borrow<u64>(&v0, v9);
            let v11 = calc_m1r<T0, T1>(arg2, arg3, arg4, v10);
            if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v11, v8)) {
                v7 = v10;
                v8 = v11;
                v9 = v9 + 1;
            } else {
                break
            };
        };
        assert!(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v8, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero()), 25);
        m1r<T0, T1>(arg1, arg2, arg3, arg4, arg5, v7, arg8);
    }

    public fun m1p_w_s<T0, T1>(arg0: &0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= arg7, 40);
        assert!(arg10 <= arg11, 40);
        assert!(arg9 > 0, 41);
        assert!(arg13 > 0, 41);
        let v0 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::new_f_max(arg6, arg7, arg8, arg9);
        let v1 = calc_m1<T0, T1>(arg2, arg3, arg4, arg6);
        if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v1, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero())) {
            0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_init(&mut v0, arg6, v1);
            let v2 = 0;
            while (v2 < 10 && !0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_has_converged(&v0)) {
                0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_complete(&mut v0, calc_m1<T0, T1>(arg2, arg3, arg4, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_prep_u(&mut v0)));
                v2 = v2 + 1;
            };
            let (v3, _) = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_result(&v0);
            m1<T0, T1>(arg1, arg2, arg3, arg4, arg5, v3, arg14);
            return
        };
        let v5 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::new_f_max(arg10, arg11, arg12, arg13);
        let v6 = calc_m1r<T0, T1>(arg2, arg3, arg4, arg10);
        assert!(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v6, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero()), 25);
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_init(&mut v5, arg10, v6);
        let v7 = 0;
        while (v7 < 10 && !0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_has_converged(&v5)) {
            0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_complete(&mut v5, calc_m1r<T0, T1>(arg2, arg3, arg4, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_prep_u(&mut v5)));
            v7 = v7 + 1;
        };
        let (v8, _) = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_result(&v5);
        m1r<T0, T1>(arg1, arg2, arg3, arg4, arg5, v8, arg14);
    }

    fun m1r<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, 0x2::sui::SUI>(arg3, false, false, arg5, 79226673515401279992447579055, arg4, arg0, arg6);
        let v3 = v2;
        let (v4, v5) = sbm_a_b<T1, T0>(arg0, arg2, v0, arg4, arg6);
        let (v6, v7) = sbm_b_a<0x2::sui::SUI, T0>(arg0, arg1, v5, arg4, arg6);
        let v8 = v7;
        let (_, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v8) > v10, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, 0x2::sui::SUI>(arg3, v3, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v8, v10), arg0, arg6);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        tb<T0>(v6, arg6);
        tb<T1>(v4, arg6);
        tb<0x2::sui::SUI>(v8, arg6);
    }

    fun sbm_a_b<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            return (arg2, 0x2::balance::zero<T1>())
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048016, arg3, arg0, arg4);
        let v3 = v2;
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<T0>(&arg2) >= v4, 30);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::split<T0>(&mut arg2, v4), 0x2::balance::zero<T1>(), arg0, arg4);
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

