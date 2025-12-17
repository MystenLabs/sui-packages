module 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::c2 {
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

    fun c2<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, arg4, 4295048016, arg3);
        let v3 = v2;
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        let (v5, v6) = swap<T0, 0x2::sui::SUI>(arg0, arg2, 0x2::balance::zero<T0>(), v1, false, false, v4, 79226673515401279992447579055, arg3);
        let v7 = v5;
        assert!(0x2::balance::value<T0>(&v7) >= v4, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, v4), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0x2::balance::destroy_zero<T0>(v0);
        tb<T0>(v7, arg5);
        tb<0x2::sui::SUI>(v6, arg5);
    }

    public fun c2p<T0>(arg0: &0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        c2p_w_s<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 1000000000, arg7, arg8);
    }

    public fun c2p_w_s<T0>(arg0: &0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= arg6, 40);
        assert!(arg8 > 0, 41);
        let v0 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::new_f_max(arg5, arg6, arg7, arg8);
        let v1 = calc_c2<T0>(arg2, arg3, arg5);
        if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(v1, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero())) {
            0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_init(&mut v0, arg5, v1);
            let v2 = 0;
            while (v2 < 10 && !0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_has_converged(&v0)) {
                0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_complete(&mut v0, calc_c2<T0>(arg2, arg3, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_prep_u(&mut v0)));
                v2 = v2 + 1;
            };
            let (v3, _) = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_result(&v0);
            c2<T0>(arg1, arg2, arg3, arg4, v3, arg9);
            return
        };
        let v5 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::new_f_max(arg5, arg6, arg7, arg8);
        let v6 = calc_c2r<T0>(arg2, arg3, arg5);
        assert!(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(v6, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero()), 25);
        0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_init(&mut v5, arg5, v6);
        let v7 = 0;
        while (v7 < 10 && !0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_has_converged(&v5)) {
            0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_complete(&mut v5, calc_c2r<T0>(arg2, arg3, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_prep_u(&mut v5)));
            v7 = v7 + 1;
        };
        let (v8, _) = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_result(&v5);
        c2r<T0>(arg1, arg2, arg3, arg4, v8, arg9);
    }

    fun c2r<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, arg4, 79226673515401279992447579055, arg3);
        let v3 = v2;
        let v4 = v0;
        assert!(0x2::balance::value<T0>(&v4) == arg4, 15);
        let (v5, v6) = swap<T0, 0x2::sui::SUI>(arg0, arg2, v4, 0x2::balance::zero<0x2::sui::SUI>(), true, true, 0x2::balance::value<T0>(&v4), 4295048016, arg3);
        let v7 = v6;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > 0, 50);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > v8, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v7, v8), v3);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        tb<T0>(v5, arg5);
        tb<0x2::sui::SUI>(v7, arg5);
    }

    fun calc_c2<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64) : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, true, true, arg2);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg1, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1) as u128)), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((arg2 as u128)))
    }

    fun calc_c2r<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64) : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg1, true, true, arg2);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1) as u128)), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((arg2 as u128)))
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

