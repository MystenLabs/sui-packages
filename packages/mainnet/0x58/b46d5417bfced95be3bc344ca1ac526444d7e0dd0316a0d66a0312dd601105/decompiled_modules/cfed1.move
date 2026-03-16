module 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::cfed1 {
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

    fun calc_cfef1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, 0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock) : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, false, true, arg3);
        let (_, v2, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T1, 0x2::sui::SUI>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0), false, arg4);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, false, true, v2);
        0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4) as u128)), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((arg3 as u128)))
    }

    fun calc_cfef1r<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, 0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock) : 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, true, true, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        let (v2, _, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T1, 0x2::sui::SUI>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1), false, arg4);
        0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::sub(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((v2 as u128)), 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::from((arg3 as u128)))
    }

    fun cfef1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg4: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, arg6, 79226673515401279992447579055, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<T0>(v0, arg7);
        assert!(0x2::coin::value<T0>(&v4) == arg6, 15);
        let v5 = 0x2::coin::zero<T1>(arg7);
        let (v6, v7) = swap<T1, T0>(arg0, arg2, v5, v4, false, true, arg6, 79226673515401279992447579055, arg5, arg7);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::coin::value<T0>(&v8) == 0, 31);
        assert!(0x2::coin::value<T1>(&v9) > 0, 30);
        let (v10, v11) = ferra_swap<T1, 0x2::sui::SUI>(arg3, arg4, 0x2::coin::into_balance<T1>(v9), 0x2::balance::zero<0x2::sui::SUI>(), true, 1, arg5, arg7);
        let v12 = v11;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v12) > 0, 30);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v12) > v13, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v12, v13), v3);
        0x2::coin::destroy_zero<T0>(v8);
        tb<T1>(v10, arg7);
        tb<0x2::sui::SUI>(v12, arg7);
    }

    public fun cfef1p<T0, T1>(arg0: &0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg5: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        cfef1p_w_s<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 1000000000, arg9, arg10, arg11, 1000000, arg12, arg13);
    }

    public fun cfef1p_ls<T0, T1>(arg0: &0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg5: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 42);
        assert!(arg8 > 0, 42);
        let v0 = vector[1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000];
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = 0;
        let v3 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero();
        let v4 = 0;
        while (v4 < v1) {
            let v5 = arg7 * *0x1::vector::borrow<u64>(&v0, v4);
            let v6 = calc_cfef1<T0, T1>(arg2, arg3, arg5, v5, arg6);
            if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(v6, v3)) {
                v2 = v5;
                v3 = v6;
                v4 = v4 + 1;
            } else {
                break
            };
        };
        if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(v3, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero())) {
            cfef1<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, v2, arg9);
            return
        };
        let v7 = 0;
        let v8 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero();
        let v9 = 0;
        while (v9 < v1) {
            let v10 = arg8 * *0x1::vector::borrow<u64>(&v0, v9);
            let v11 = calc_cfef1r<T0, T1>(arg2, arg3, arg5, v10, arg6);
            if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(v11, v8)) {
                v7 = v10;
                v8 = v11;
                v9 = v9 + 1;
            } else {
                break
            };
        };
        assert!(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(v8, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero()), 25);
        cfef1r<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, v7, arg9);
    }

    public fun cfef1p_w_s<T0, T1>(arg0: &0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg5: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 <= arg8, 40);
        assert!(arg11 <= arg12, 40);
        assert!(arg10 > 0, 41);
        assert!(arg14 > 0, 41);
        let v0 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::new_f_max(arg7, arg8, arg9, arg10);
        let v1 = calc_cfef1<T0, T1>(arg2, arg3, arg5, arg7, arg6);
        if (0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(v1, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero())) {
            0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_init(&mut v0, arg7, v1);
            let v2 = 0;
            while (v2 < 10 && !0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_has_converged(&v0)) {
                0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_complete(&mut v0, calc_cfef1<T0, T1>(arg2, arg3, arg5, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_prep_u(&mut v0), arg6));
                v2 = v2 + 1;
            };
            let (v3, _) = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_result(&v0);
            cfef1<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, v3, arg15);
            return
        };
        let v5 = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::new_f_max(arg11, arg12, arg13, arg14);
        let v6 = calc_cfef1r<T0, T1>(arg2, arg3, arg5, arg11, arg6);
        assert!(0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::gt(v6, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::i128::zero()), 25);
        0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_init(&mut v5, arg11, v6);
        let v7 = 0;
        while (v7 < 10 && !0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_has_converged(&v5)) {
            0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_complete(&mut v5, calc_cfef1r<T0, T1>(arg2, arg3, arg5, 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_next_step_prep_u(&mut v5), arg6));
            v7 = v7 + 1;
        };
        let (v8, _) = 0xfa2b769879418c0f006b7d7a3745a3585e7ec8a86171ae6971bdd5b7e776cafe::f_max::f_max_result(&v5);
        cfef1r<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, v8, arg15);
    }

    fun cfef1r<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg4: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg2, true, true, arg6, 4295048016, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let v4 = 0x2::coin::from_balance<T0>(v1, arg7);
        let v5 = 0x2::coin::zero<0x2::sui::SUI>(arg7);
        let (v6, v7) = swap<T0, 0x2::sui::SUI>(arg0, arg1, v4, v5, true, true, 0x2::coin::value<T0>(&v4), 4295048016, arg5, arg7);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v3);
        let (_, v10, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_in<T1, 0x2::sui::SUI>(arg4, v8, false, arg5);
        let v12 = 0x2::coin::into_balance<0x2::sui::SUI>(v7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v12) >= v10, 21);
        let (v13, v14) = ferra_swap<T1, 0x2::sui::SUI>(arg3, arg4, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v12, v10), false, v8, arg5, arg7);
        let v15 = v13;
        assert!(0x2::balance::value<T1>(&v15) > v8, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg2, 0x2::balance::split<T1>(&mut v15, v8), 0x2::balance::zero<T0>(), v3);
        0x2::coin::destroy_zero<T0>(v6);
        0x2::balance::join<0x2::sui::SUI>(&mut v12, v14);
        tb<T1>(v15, arg7);
        tb<0x2::sui::SUI>(v12, arg7);
    }

    fun ferra_swap<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (arg4 && 0x2::balance::value<T0>(&arg2) == 0 || !arg4 && 0x2::balance::value<T1>(&arg3) == 0) {
            return (arg2, arg3)
        };
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, arg4, arg5, 0x2::coin::from_balance<T0>(arg2, arg7), 0x2::coin::from_balance<T1>(arg3, arg7), arg6, arg7);
        (0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(v1))
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

