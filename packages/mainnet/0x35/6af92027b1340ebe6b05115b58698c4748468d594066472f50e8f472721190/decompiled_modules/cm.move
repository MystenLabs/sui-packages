module 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::cm {
    fun calc_cm0<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64) : 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, true, true, arg2);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, 0x2::sui::SUI>(arg1, false, true, 79226673515401279992447579054, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::sub(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1) as u128)), 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((arg2 as u128)))
    }

    fun calc_cm0r<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64) : 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, false, false, arg2);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, 0x2::sui::SUI>(arg1, true, true, 4295048017, arg2);
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::sub(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1) as u128)), 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0) as u128)))
    }

    fun cm0<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, arg5, 79226673515401279992447579055, arg4);
        let v3 = v2;
        let v4 = v0;
        assert!(0x2::balance::value<T0>(&v4) == arg5, 15);
        let (v5, v6) = sbm_a_b<T0, 0x2::sui::SUI>(arg2, arg3, v4, arg4, arg6);
        let v7 = v6;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > 0, 50);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > v8, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v7, v8), v3);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        tb<T0>(v5, arg6);
        tb<0x2::sui::SUI>(v7, arg6);
    }

    public fun cm0p<T0>(arg0: &0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= arg7, 40);
        assert!(arg8 > 0, 41);
        let v0 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::new_f_max(arg6, arg7, 1000000000, arg8);
        let v1 = calc_cm0<T0>(arg2, arg4, arg6);
        if (0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v1, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero())) {
            0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_init(&mut v0, arg6, v1);
            let v2 = 0;
            while (v2 < 10 && !0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_has_converged(&v0)) {
                0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_complete(&mut v0, calc_cm0<T0>(arg2, arg4, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_prep_u(&mut v0)));
                v2 = v2 + 1;
            };
            let (v3, _) = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_result(&v0);
            cm0<T0>(arg1, arg2, arg3, arg4, arg5, v3, arg9);
            return
        };
        let v5 = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::new_f_max(arg6, arg7, 1000000000, arg8);
        let v6 = calc_cm0r<T0>(arg2, arg4, arg6);
        assert!(0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::gt(v6, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::i128::zero()), 25);
        0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_init(&mut v5, arg6, v6);
        let v7 = 0;
        while (v7 < 10 && !0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_has_converged(&v5)) {
            0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_complete(&mut v5, calc_cm0r<T0>(arg2, arg4, 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_next_step_prep_u(&mut v5)));
            v7 = v7 + 1;
        };
        let (v8, _) = 0x48af3fa32897e1215518a1135f429f385b8293f1d942aa02685b3fec20a3ca6::f_max::f_max_result(&v5);
        cm0r<T0>(arg1, arg2, arg3, arg4, arg5, v8, arg9);
    }

    fun cm0r<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, arg5, 79226673515401279992447579055, arg4);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        let (v5, v6) = sbm_b_a_bao<T0, 0x2::sui::SUI>(arg2, arg3, v1, v4, arg4, arg6);
        let v7 = v6;
        assert!(0x2::balance::value<T0>(&v7) >= v4, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, v4), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0x2::balance::destroy_zero<T0>(v0);
        tb<T0>(v7, arg6);
        tb<0x2::sui::SUI>(v5, arg6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
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

    fun sbm_b_a_bao<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T1>(&arg2) == 0 || arg3 == 0) {
            return (arg2, 0x2::balance::zero<T0>())
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, false, arg3, 79226673515401279992447579055, arg4, arg0, arg5);
        let v3 = v2;
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<T1>(&arg2) >= v5, 33);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v5), arg0, arg5);
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

