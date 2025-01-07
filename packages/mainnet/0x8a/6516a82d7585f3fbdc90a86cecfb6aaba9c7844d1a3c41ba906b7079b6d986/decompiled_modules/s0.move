module 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::s0 {
    fun calc_sx<T0>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, true, true, get_amount_out_with_fee(arg4, arg1, arg2, arg3));
        0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::sub(0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) as u128)), 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::from((arg4 as u128)))
    }

    fun calc_sxr<T0>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, false, true, get_amount_out_with_fee(arg4, arg2, arg1, arg3));
        0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::sub(0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) as u128)), 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::from((arg4 as u128)))
    }

    fun get_amount_out_with_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 100);
        assert!(arg1 > 0 && arg2 > 0, 101);
        let v0 = (arg0 as u128) * (10000 - (arg3 as u128));
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 10000 + v0)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun s0p(arg0: &0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg3: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0x2::sui::SUI, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        sxp_internal<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
    }

    public fun s1p(arg0: &0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, 0x2::sui::SUI>, arg3: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0x2::sui::SUI, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        sxp_internal<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
    }

    fun sx_internal<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0x2::sui::SUI, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, false, arg4, 4295048016, arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v4) == arg4, 15);
        let v5 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v5, v4);
        let (v6, v7) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<0x2::sui::SUI, T0>(arg2, v5, arg4, arg3, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v9) == 0, 31);
        assert!(0x2::coin::value<T0>(&v8) > 0, 30);
        assert!(0x2::coin::value<T0>(&v8) > v10, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v8, v10, arg5)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        let v11 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v11, v8);
        let (v12, v13) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<0x2::sui::SUI, T0>(arg2, v11, 0x2::coin::value<T0>(&v8), arg3, arg5);
        0x2::coin::destroy_zero<T0>(v12);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg5));
    }

    fun sxp_internal<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0x2::sui::SUI, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= arg5, 40);
        assert!(arg7 <= arg8, 40);
        assert!(arg6 > 0, 41);
        assert!(arg9 > 0, 41);
        let (v0, v1, _) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::get_amounts<0x2::sui::SUI, T0>(arg2);
        let v3 = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_admin<0x2::sui::SUI, T0>(arg2) + 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_lp<0x2::sui::SUI, T0>(arg2) + 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_th<0x2::sui::SUI, T0>(arg2);
        let v4 = 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::new_f_max(arg4, arg5, 1000000000, arg6);
        let v5 = calc_sx<T0>(arg1, v0, v1, v3, arg4);
        if (0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::gt(v5, 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::zero())) {
            0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::f_max_init(&mut v4, arg4, v5);
            let v6 = 0;
            while (v6 < 10 && !0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::f_max_has_converged(&v4)) {
                let v7 = calc_sx<T0>(arg1, v0, v1, v3, 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::f_max_next_step_prep_u(&mut v4));
                0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::f_max_next_step_complete(&mut v4, v7);
                v6 = v6 + 1;
            };
            let (v8, _) = 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::f_max_result(&v4);
            sx_internal<T0>(arg0, arg1, arg2, arg3, v8, arg10);
            return
        };
        let v10 = 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::new_f_max(arg7, arg8, 1000000, arg9);
        let v11 = calc_sxr<T0>(arg1, v0, v1, v3, arg7);
        assert!(0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::gt(v11, 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::i128::zero()), 25);
        0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::f_max_init(&mut v10, arg7, v11);
        let v12 = 0;
        while (v12 < 10 && !0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::f_max_has_converged(&v10)) {
            let v13 = calc_sxr<T0>(arg1, v0, v1, v3, 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::f_max_next_step_prep_u(&mut v10));
            0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::f_max_next_step_complete(&mut v10, v13);
            v12 = v12 + 1;
        };
        let (v14, _) = 0x8a6516a82d7585f3fbdc90a86cecfb6aaba9c7844d1a3c41ba906b7079b6d986::f_max::f_max_result(&v10);
        sxr_internal<T0>(arg0, arg1, arg2, arg3, v14, arg10);
    }

    fun sxr_internal<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0x2::sui::SUI, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, arg4, 79226673515401279992447579055, arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<T0>(v0, arg5);
        assert!(0x2::coin::value<T0>(&v4) == arg4, 15);
        let v5 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v5, v4);
        let (v6, v7) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<0x2::sui::SUI, T0>(arg2, v5, arg4, arg3, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<T0>(&v9) == 0, 31);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v8) > v10, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v10, arg5)), v3);
        0x2::coin::destroy_zero<T0>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

