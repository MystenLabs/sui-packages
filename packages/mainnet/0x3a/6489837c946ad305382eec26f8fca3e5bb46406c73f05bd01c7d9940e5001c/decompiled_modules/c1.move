module 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::c1 {
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

    fun c1(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x2::sui::SUI>(arg0, arg1, false, false, arg5, 79226673515401279992447579055, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN>(v0, arg6);
        assert!(0x2::coin::value<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN>(&v4) == arg5, 15);
        let v5 = 0x2::coin::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg6);
        let (v6, v7) = swap<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg0, arg2, v4, v5, true, true, arg5, 4295048016, arg4, arg6);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::coin::value<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN>(&v9) == 0, 31);
        assert!(0x2::coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v8) > 0, 30);
        let v10 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        let (v11, v12) = swap<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(arg0, arg3, v8, v10, true, true, 0x2::coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v8), 4295048016, arg4, arg6);
        let v13 = v12;
        let v14 = v11;
        assert!(0x2::coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v14) == 0, 31);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > 0, 30);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > v15, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v15, arg6)), v3);
        0x2::coin::destroy_zero<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN>(v9);
        0x2::coin::destroy_zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg6));
    }

    public fun c1p(arg0: &0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= arg7, 40);
        assert!(arg9 <= arg10, 40);
        assert!(arg8 > 0, 41);
        assert!(arg11 > 0, 41);
        let v0 = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::new_f_max(arg6, arg7, 1000000000, arg8);
        let v1 = calc_c1(arg2, arg3, arg4, arg6);
        if (0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::gt(v1, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::zero())) {
            0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_init(&mut v0, arg6, v1);
            let v2 = 0;
            while (v2 < 10 && !0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_has_converged(&v0)) {
                let v3 = calc_c1(arg2, arg3, arg4, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_prep_u(&mut v0));
                0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_complete(&mut v0, v3);
                v2 = v2 + 1;
            };
            let (v4, _) = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_result(&v0);
            c1(arg1, arg2, arg3, arg4, arg5, v4, arg13);
            return
        };
        let v6 = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::new_f_max(arg9, arg10, 1000000000, arg11);
        let v7 = calc_c1r(arg2, arg3, arg4, arg9);
        assert!(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::gt(v7, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::zero()), 25);
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_init(&mut v6, arg9, v7);
        let v8 = 0;
        while (v8 < 10 && !0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_has_converged(&v6)) {
            let v9 = calc_c1r(arg2, arg3, arg4, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_prep_u(&mut v6));
            0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_complete(&mut v6, v9);
            v8 = v8 + 1;
        };
        let (v10, _) = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_result(&v6);
        c1r(arg1, arg2, arg3, arg4, arg5, v10, arg13);
    }

    fun c1r(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(arg0, arg3, false, false, arg5, 79226673515401279992447579055, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v0, arg6);
        assert!(0x2::coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v4) == arg5, 15);
        let v5 = 0x2::coin::zero<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN>(arg6);
        let (v6, v7) = swap<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg0, arg2, v5, v4, false, true, arg5, 79226673515401279992447579055, arg4, arg6);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v8) == 0, 31);
        assert!(0x2::coin::value<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN>(&v9) > 0, 30);
        let v10 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        let (v11, v12) = swap<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x2::sui::SUI>(arg0, arg1, v9, v10, true, true, 0x2::coin::value<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN>(&v9), 4295048016, arg4, arg6);
        let v13 = v12;
        let v14 = v11;
        assert!(0x2::coin::value<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN>(&v14) == 0, 31);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > 0, 30);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > v15, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(arg0, arg3, 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v15, arg6)), v3);
        0x2::coin::destroy_zero<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN>(v14);
        0x2::coin::destroy_zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg6));
    }

    fun c2(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x2::sui::SUI>(arg0, arg1, false, false, arg5, 79226673515401279992447579055, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP>(v0, arg6);
        assert!(0x2::coin::value<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP>(&v4) == arg5, 15);
        let v5 = 0x2::coin::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg6);
        let (v6, v7) = swap<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg0, arg2, v4, v5, true, true, arg5, 4295048016, arg4, arg6);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::coin::value<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP>(&v9) == 0, 31);
        assert!(0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v8) > 0, 30);
        let v10 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        let (v11, v12) = swap<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg0, arg3, v8, v10, true, true, 0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v8), 4295048016, arg4, arg6);
        let v13 = v12;
        let v14 = v11;
        assert!(0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v14) == 0, 31);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > 0, 30);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > v15, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v15, arg6)), v3);
        0x2::coin::destroy_zero<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP>(v9);
        0x2::coin::destroy_zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg6));
    }

    public fun c2p(arg0: &0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= arg7, 40);
        assert!(arg9 <= arg10, 40);
        assert!(arg8 > 0, 41);
        assert!(arg11 > 0, 41);
        let v0 = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::new_f_max(arg6, arg7, 1000000000, arg8);
        let v1 = calc_c2(arg2, arg3, arg4, arg6);
        if (0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::gt(v1, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::zero())) {
            0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_init(&mut v0, arg6, v1);
            let v2 = 0;
            while (v2 < 10 && !0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_has_converged(&v0)) {
                let v3 = calc_c2(arg2, arg3, arg4, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_prep_u(&mut v0));
                0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_complete(&mut v0, v3);
                v2 = v2 + 1;
            };
            let (v4, _) = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_result(&v0);
            c2(arg1, arg2, arg3, arg4, arg5, v4, arg13);
            return
        };
        let v6 = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::new_f_max(arg9, arg10, 1000000, arg11);
        let v7 = calc_c2r(arg2, arg3, arg4, arg9);
        assert!(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::gt(v7, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::zero()), 25);
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_init(&mut v6, arg9, v7);
        let v8 = 0;
        while (v8 < 10 && !0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_has_converged(&v6)) {
            let v9 = calc_c2r(arg2, arg3, arg4, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_prep_u(&mut v6));
            0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_complete(&mut v6, v9);
            v8 = v8 + 1;
        };
        let (v10, _) = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_result(&v6);
        c2r(arg1, arg2, arg3, arg4, arg5, v10, arg13);
    }

    fun c2r(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg0, arg3, false, false, arg5, 79226673515401279992447579055, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v0, arg6);
        assert!(0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v4) == arg5, 15);
        let v5 = 0x2::coin::zero<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP>(arg6);
        let (v6, v7) = swap<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg0, arg2, v5, v4, false, true, arg5, 79226673515401279992447579055, arg4, arg6);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v8) == 0, 31);
        assert!(0x2::coin::value<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP>(&v9) > 0, 30);
        let v10 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        let (v11, v12) = swap<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x2::sui::SUI>(arg0, arg1, v9, v10, true, true, 0x2::coin::value<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP>(&v9), 4295048016, arg4, arg6);
        let v13 = v12;
        let v14 = v11;
        assert!(0x2::coin::value<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP>(&v14) == 0, 31);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > 0, 30);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > v15, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg0, arg3, 0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v15, arg6)), v3);
        0x2::coin::destroy_zero<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP>(v14);
        0x2::coin::destroy_zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg6));
    }

    fun c3(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg0, arg1, false, false, arg5, 79226673515401279992447579055, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v0, arg6);
        assert!(0x2::coin::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v4) == arg5, 15);
        let v5 = 0x2::coin::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg6);
        let (v6, v7) = swap<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg0, arg2, v4, v5, true, true, arg5, 4295048016, arg4, arg6);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::coin::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v9) == 0, 31);
        assert!(0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v8) > 0, 30);
        let v10 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        let (v11, v12) = swap<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg0, arg3, v8, v10, true, true, 0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v8), 4295048016, arg4, arg6);
        let v13 = v12;
        let v14 = v11;
        assert!(0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v14) == 0, 31);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > 0, 30);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > v15, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v15, arg6)), v3);
        0x2::coin::destroy_zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v9);
        0x2::coin::destroy_zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg6));
    }

    public fun c3p(arg0: &0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= arg7, 40);
        assert!(arg9 <= arg10, 40);
        assert!(arg8 > 0, 41);
        assert!(arg11 > 0, 41);
        let v0 = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::new_f_max(arg6, arg7, 1000000000, arg8);
        let v1 = calc_c3(arg2, arg3, arg4, arg6);
        if (0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::gt(v1, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::zero())) {
            0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_init(&mut v0, arg6, v1);
            let v2 = 0;
            while (v2 < 10 && !0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_has_converged(&v0)) {
                let v3 = calc_c3(arg2, arg3, arg4, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_prep_u(&mut v0));
                0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_complete(&mut v0, v3);
                v2 = v2 + 1;
            };
            let (v4, _) = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_result(&v0);
            c3(arg1, arg2, arg3, arg4, arg5, v4, arg13);
            return
        };
        let v6 = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::new_f_max(arg9, arg10, 1000000, arg11);
        let v7 = calc_c3r(arg2, arg3, arg4, arg9);
        assert!(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::gt(v7, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::zero()), 25);
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_init(&mut v6, arg9, v7);
        let v8 = 0;
        while (v8 < 10 && !0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_has_converged(&v6)) {
            let v9 = calc_c3r(arg2, arg3, arg4, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_prep_u(&mut v6));
            0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_complete(&mut v6, v9);
            v8 = v8 + 1;
        };
        let (v10, _) = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_result(&v6);
        c3r(arg1, arg2, arg3, arg4, arg5, v10, arg13);
    }

    fun c3r(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg0, arg3, false, false, arg5, 79226673515401279992447579055, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v0, arg6);
        assert!(0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v4) == arg5, 15);
        let v5 = 0x2::coin::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg6);
        let (v6, v7) = swap<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg0, arg2, v5, v4, false, true, arg5, 79226673515401279992447579055, arg4, arg6);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v8) == 0, 31);
        assert!(0x2::coin::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v9) > 0, 30);
        let v10 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        let (v11, v12) = swap<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg0, arg1, v9, v10, true, true, 0x2::coin::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v9), 4295048016, arg4, arg6);
        let v13 = v12;
        let v14 = v11;
        assert!(0x2::coin::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v14) == 0, 31);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > 0, 30);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(&v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v13) > v15, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg0, arg3, 0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v15, arg6)), v3);
        0x2::coin::destroy_zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v14);
        0x2::coin::destroy_zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg6));
    }

    fun calc_c1(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x2::sui::SUI>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg3: u64) : 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg1, true, true, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(arg2, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x2::sui::SUI>(arg0, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::sub(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) as u128)), 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((arg3 as u128)))
    }

    fun calc_c1r(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x2::sui::SUI>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg3: u64) : 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg1, false, true, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x1d58e26e85fbf9ee8596872686da75544342487f95b1773be3c9a49ab1061b19::suia_token::SUIA_TOKEN, 0x2::sui::SUI>(arg0, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(arg2, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::sub(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) as u128)), 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((arg3 as u128)))
    }

    fun calc_c2(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x2::sui::SUI>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg3: u64) : 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg1, true, true, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg2, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x2::sui::SUI>(arg0, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::sub(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) as u128)), 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((arg3 as u128)))
    }

    fun calc_c2r(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x2::sui::SUI>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg3: u64) : 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg1, false, true, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xe4239cd951f6c53d9c41e25270d80d31f925ad1655e5ba5b543843d4a66975ee::SUIP::SUIP, 0x2::sui::SUI>(arg0, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg2, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::sub(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) as u128)), 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((arg3 as u128)))
    }

    fun calc_c3(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg3: u64) : 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg1, true, true, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg2, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg0, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::sub(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) as u128)), 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((arg3 as u128)))
    }

    fun calc_c3r(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg3: u64) : 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg1, false, true, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg0, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg2, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1));
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::sub(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) as u128)), 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((arg3 as u128)))
    }

    fun get_amount_out_with_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 100);
        assert!(arg1 > 0 && arg2 > 0, 101);
        let v0 = (arg0 as u128) * (10000 - (arg3 as u128));
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 10000 + v0)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

