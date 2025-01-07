module 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::s1 {
    fun calc_sx<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg0, false, true, get_amount_out_with_fee(arg4, arg1, arg2, arg3));
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::sub(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) as u128)), 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((arg4 as u128)))
    }

    fun calc_sxr<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::I128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg0, true, true, get_amount_out_with_fee(arg4, arg2, arg1, arg3));
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::sub(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) as u128)), 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::from((arg4 as u128)))
    }

    fun get_amount_out_with_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 100);
        assert!(arg1 > 0 && arg2 > 0, 101);
        let v0 = (arg0 as u128) * (10000 - (arg3 as u128));
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 10000 + v0)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun s0p(arg0: &0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg3: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg4: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0x2::sui::SUI, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg5: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        sxp_internal<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14);
    }

    public fun s1p(arg0: &0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>, arg3: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>, arg4: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0x2::sui::SUI, 0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>, arg5: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, 0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        sxp_internal<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14);
    }

    fun sx_internal<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>, arg2: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>, arg3: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0x2::sui::SUI, T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg0, arg1, false, false, arg5, 79226673515401279992447579055, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = 0x2::coin::from_balance<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>(v0, arg6);
        assert!(0x2::coin::value<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>(&v4) == arg5, 15);
        let v5 = 0x1::vector::empty<0x2::coin::Coin<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>>();
        0x1::vector::push_back<0x2::coin::Coin<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>>(&mut v5, v4);
        let (v6, v7) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg2, v5, arg5, arg4, arg6);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(&v3);
        assert!(0x2::coin::value<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>(&v9) == 0, 31);
        assert!(0x2::coin::value<T0>(&v8) > 0, 30);
        assert!(0x2::coin::value<T0>(&v8) > v10, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg0, arg1, 0x2::balance::zero<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v8, v10, arg6)), v3);
        let v11 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v11, v8);
        let (v12, v13) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<0x2::sui::SUI, T0>(arg3, v11, 0x2::coin::value<T0>(&v8), arg4, arg6);
        0x2::coin::destroy_zero<T0>(v12);
        0x2::coin::destroy_zero<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg6));
    }

    fun sxp_internal<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>, arg2: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>, arg3: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0x2::sui::SUI, T0>, arg4: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= arg7, 40);
        assert!(arg9 <= arg10, 40);
        assert!(arg8 > 0, 41);
        assert!(arg11 > 0, 41);
        let (v0, v1, _) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::get_amounts<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg2);
        let v3 = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_admin<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg2) + 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_lp<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg2) + 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_th<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg2);
        let v4 = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::new_f_max(arg6, arg7, 100000000, arg8);
        let v5 = calc_sx<T0>(arg1, v0, v1, v3, arg6);
        if (0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::gt(v5, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::zero())) {
            0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_init(&mut v4, arg6, v5);
            let v6 = 0;
            while (v6 < 10 && !0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_has_converged(&v4)) {
                0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_complete(&mut v4, calc_sx<T0>(arg1, v0, v1, v3, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_prep_u(&mut v4)));
                v6 = v6 + 1;
            };
            let (v7, _) = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_result(&v4);
            sx_internal<T0>(arg0, arg1, arg2, arg3, arg5, v7, arg12);
            return
        };
        let v9 = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::new_f_max(arg9, arg10, 1000000, arg11);
        let v10 = calc_sxr<T0>(arg1, v0, v1, v3, arg9);
        assert!(0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::gt(v10, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::i128::zero()), 25);
        0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_init(&mut v9, arg9, v10);
        let v11 = 0;
        while (v11 < 10 && !0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_has_converged(&v9)) {
            0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_complete(&mut v9, calc_sxr<T0>(arg1, v0, v1, v3, 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_next_step_prep_u(&mut v9)));
            v11 = v11 + 1;
        };
        let (v12, _) = 0x895a25cea1fc62b359d3b2f1db130c2425914cd912d33bd630413fc45efbee02::f_max::f_max_result(&v9);
        sxr_internal<T0>(arg0, arg1, arg2, arg4, arg5, v12, arg12);
    }

    fun sxr_internal<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>, arg2: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>, arg3: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg0, arg1, true, false, arg5, 4295048016, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>(v0);
        let v4 = 0x2::coin::from_balance<T0>(v1, arg6);
        assert!(0x2::coin::value<T0>(&v4) == arg5, 15);
        let v5 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v5, v4);
        let (v6, v7) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg2, v5, arg5, arg4, arg6);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(&v3);
        assert!(0x2::coin::value<T0>(&v9) == 0, 31);
        assert!(0x2::coin::value<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>(&v8) > v10, 20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, T0>(arg0, arg1, 0x2::coin::into_balance<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>(0x2::coin::split<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>(&mut v8, v10, arg6)), 0x2::balance::zero<T0>(), v3);
        let v11 = 0x1::vector::empty<0x2::coin::Coin<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>>();
        0x1::vector::push_back<0x2::coin::Coin<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>>(&mut v11, v8);
        let (v12, v13) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN, 0x2::sui::SUI>(arg3, v11, 0x2::coin::value<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>(&v8), arg4, arg6);
        0x2::coin::destroy_zero<T0>(v9);
        0x2::coin::destroy_zero<0xaf8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN>(v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

