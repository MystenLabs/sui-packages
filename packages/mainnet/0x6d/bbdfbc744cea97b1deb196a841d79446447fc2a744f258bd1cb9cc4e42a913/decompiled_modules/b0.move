module 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::b0 {
    public fun b0p(arg0: &0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        bxp_internal<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
    }

    public fun b1p(arg0: &0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, 0x2::sui::SUI>, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        bxp_internal<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
    }

    fun bx_internal<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, false, arg4, 4295048016, arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v4) == arg4, 15);
        let v5 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<0x2::sui::SUI, T0>(arg4, v4, 1, arg2, arg5);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<T0>(&v5) > 0, 30);
        assert!(0x2::coin::value<T0>(&v5) > v6, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg5)), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, 0x2::sui::SUI>(0x2::coin::value<T0>(&v5), v5, 1, arg2, arg5), 0x2::tx_context::sender(arg5));
    }

    fun bxp_internal<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= arg5, 40);
        assert!(arg7 <= arg8, 40);
        assert!(arg6 > 0, 41);
        assert!(arg9 > 0, 41);
        let (v0, v1) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::token_reserves<0x2::sui::SUI, T0>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::get_pool<0x2::sui::SUI, T0>(arg2));
        let v2 = 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::new_f_max(arg4, arg5, 1000000000, arg6);
        let v3 = calc_bx<T0>(arg1, v0, v1, arg4);
        if (0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::gt(v3, 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::zero())) {
            0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::f_max_init(&mut v2, arg4, v3);
            let v4 = 0;
            while (v4 < 10 && !0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::f_max_has_converged(&v2)) {
                0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::f_max_next_step_complete(&mut v2, calc_bx<T0>(arg1, v0, v1, 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::f_max_next_step_prep_u(&mut v2)));
                v4 = v4 + 1;
            };
            let (v5, _) = 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::f_max_result(&v2);
            bx_internal<T0>(arg0, arg1, arg2, arg3, v5, arg10);
            return
        };
        let v7 = 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::new_f_max(arg7, arg8, 1000000, arg9);
        let v8 = calc_bxr<T0>(arg1, v0, v1, arg7);
        assert!(0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::gt(v8, 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::zero()), 25);
        0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::f_max_init(&mut v7, arg7, v8);
        let v9 = 0;
        while (v9 < 10 && !0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::f_max_has_converged(&v7)) {
            0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::f_max_next_step_complete(&mut v7, calc_bxr<T0>(arg1, v0, v1, 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::f_max_next_step_prep_u(&mut v7)));
            v9 = v9 + 1;
        };
        let (v10, _) = 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::f_max::f_max_result(&v7);
        bxr_internal<T0>(arg0, arg1, arg2, arg3, v10, arg10);
    }

    fun bxr_internal<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, arg4, 79226673515401279992447579055, arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<T0>(v0, arg5);
        assert!(0x2::coin::value<T0>(&v4) == arg4, 15);
        let v5 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, 0x2::sui::SUI>(arg4, v4, 1, arg2, arg5);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v5) > v6, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v6, arg5)), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, 0x2::tx_context::sender(arg5));
    }

    fun calc_bx<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: u64) : 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, true, true, 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_amount_out(arg3, arg1, arg2));
        0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::sub(0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) as u128)), 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::from((arg3 as u128)))
    }

    fun calc_bxr<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: u64) : 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, false, true, 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::get_amount_out(arg3, arg2, arg1));
        0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::sub(0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) as u128)), 0x6dbbdfbc744cea97b1deb196a841d79446447fc2a744f258bd1cb9cc4e42a913::i128::from((arg3 as u128)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

