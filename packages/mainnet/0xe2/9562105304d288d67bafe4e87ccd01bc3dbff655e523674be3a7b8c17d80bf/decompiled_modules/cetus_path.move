module 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::cetus_path {
    public entry fun run_multi_cycle<T0, T1, T2>(arg0: &0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: 0x2::coin::Coin<T1>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg17);
        assert!(arg14 > 0, 105);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, false, false, arg9, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::max_sqrt_price_limit(), arg16);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let v5 = 0x2::coin::from_balance<T0>(v1, arg17);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, true, true, arg11, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 10000 - 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::push_bps()), arg16);
        let v9 = v8;
        let v10 = v6;
        assert!(0x2::balance::value<T0>(&v10) == 0, 106);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg17);
        assert!(0x2::coin::value<T1>(&v11) > 0, 102);
        let v12 = 0;
        while (v12 < arg14) {
            0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_id_new(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, arg10, arg17)), 0, arg12, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_add_base(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::special_params(arg13), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::tolerance_test_value(), arg16, arg17);
            v12 = v12 + 1;
        };
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v13, 103);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v13, arg17)), 0x2::balance::zero<T1>(), v9);
        let v14 = 0;
        while (v14 < arg14) {
            0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_none_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1) + v14, 0, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_withdraw(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_params(), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_tolerance(), arg16, arg17);
            v14 = v14 + 1;
        };
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        0x2::coin::join<T1>(&mut v11, arg15);
        assert!(0x2::coin::value<T1>(&v11) >= v15, 101);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v15, arg17)), v4);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        if (0x2::coin::value<T1>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, v0);
        } else {
            0x2::coin::destroy_zero<T1>(v11);
        };
    }

    public entry fun run_multi_cycle_restore<T0, T1, T2>(arg0: &0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<T0>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        assert!(arg13 > 0, 105);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, true, true, arg9, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 10000 - 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::push_bps()), arg15);
        let v4 = v3;
        let v5 = v1;
        assert!(0x2::balance::value<T0>(&v5) == 0, 106);
        0x2::balance::destroy_zero<T0>(v5);
        let v6 = 0x2::coin::from_balance<T1>(v2, arg16);
        assert!(0x2::coin::value<T1>(&v6) > 0, 102);
        let v7 = 0;
        while (v7 < arg13) {
            0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_id_new(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg14, arg10, arg16)), 0, arg11, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_add_base(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::special_params(arg12), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::tolerance_test_value(), arg15, arg16);
            v7 = v7 + 1;
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, false, true, 0x2::coin::value<T1>(&v6), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::max_sqrt_price_limit(), arg15);
        let v11 = v10;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v11), arg16)), v11);
        0x2::coin::join<T0>(&mut arg14, 0x2::coin::from_balance<T0>(v8, arg16));
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(0x2::coin::value<T0>(&arg14) >= v12, 107);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg14, v12, arg16)), 0x2::balance::zero<T1>(), v4);
        let v13 = 0;
        while (v13 < arg13) {
            0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_none_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1) + v13, 0, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_withdraw(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_params(), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_tolerance(), arg15, arg16);
            v13 = v13 + 1;
        };
        0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::send_or_destroy<T0>(arg14, v0);
        0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::send_or_destroy<T1>(v6, v0);
    }

    public entry fun run_multi_cycle_restore_reverse<T0, T1, T2>(arg0: &0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<T0>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        assert!(arg13 > 0, 105);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg5, false, true, arg9, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg5), 10000 + 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::push_bps()), arg15);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::balance::value<T0>(&v5) == 0, 106);
        0x2::balance::destroy_zero<T0>(v5);
        let v6 = 0x2::coin::from_balance<T1>(v1, arg16);
        assert!(0x2::coin::value<T1>(&v6) > 0, 102);
        let v7 = 0;
        while (v7 < arg13) {
            0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_id_new(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg14, arg10, arg16)), 0, arg11, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_add_base(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::special_params(arg12), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::tolerance_test_value(), arg15, arg16);
            v7 = v7 + 1;
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg5, true, true, 0x2::coin::value<T1>(&v6), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::min_sqrt_price_limit(), arg15);
        let v11 = v10;
        0x2::balance::destroy_zero<T1>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v11), arg16)), 0x2::balance::zero<T0>(), v11);
        0x2::coin::join<T0>(&mut arg14, 0x2::coin::from_balance<T0>(v9, arg16));
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        assert!(0x2::coin::value<T0>(&arg14) >= v12, 107);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg14, v12, arg16)), v4);
        let v13 = 0;
        while (v13 < arg13) {
            0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_none_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1) + v13, 0, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_withdraw(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_params(), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_tolerance(), arg15, arg16);
            v13 = v13 + 1;
        };
        0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::send_or_destroy<T0>(arg14, v0);
        0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::send_or_destroy<T1>(v6, v0);
    }

    public entry fun run_multi_cycle_reverse<T0, T1, T2>(arg0: &0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: 0x2::coin::Coin<T1>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg17);
        assert!(arg14 > 0, 105);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg5, true, false, arg9, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::min_sqrt_price_limit(), arg16);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v1);
        let v5 = 0x2::coin::from_balance<T0>(v2, arg17);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg5, false, true, arg11, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg5), 10000 + 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::push_bps()), arg16);
        let v9 = v8;
        let v10 = v7;
        assert!(0x2::balance::value<T0>(&v10) == 0, 106);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v6, arg17);
        assert!(0x2::coin::value<T1>(&v11) > 0, 102);
        let v12 = 0;
        while (v12 < arg14) {
            0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_id_new(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, arg10, arg17)), 0, arg12, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_add_base(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::special_params(arg13), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::tolerance_test_value(), arg16, arg17);
            v12 = v12 + 1;
        };
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v13, 103);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v13, arg17)), v9);
        let v14 = 0;
        while (v14 < arg14) {
            0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_none_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1) + v14, 0, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_withdraw(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_params(), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_tolerance(), arg16, arg17);
            v14 = v14 + 1;
        };
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        0x2::coin::join<T1>(&mut v11, arg15);
        assert!(0x2::coin::value<T1>(&v11) >= v15, 101);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v15, arg17)), 0x2::balance::zero<T0>(), v4);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        if (0x2::coin::value<T1>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, v0);
        } else {
            0x2::coin::destroy_zero<T1>(v11);
        };
    }

    public entry fun run_one<T0, T1, T2>(arg0: &0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<T1>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, false, false, arg9, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::max_sqrt_price_limit(), arg15);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let v5 = 0x2::coin::from_balance<T0>(v1, arg16);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, true, true, arg11, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 10000 - 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::push_bps()), arg15);
        let v9 = v8;
        let v10 = v6;
        assert!(0x2::balance::value<T0>(&v10) == 0, 106);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg16);
        assert!(0x2::coin::value<T1>(&v11) > 0, 102);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_id_new(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, arg10, arg16)), 0, arg12, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_add_base(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::special_params(arg13), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::tolerance_test_value(), arg15, arg16);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v12, 103);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v12, arg16)), 0x2::balance::zero<T1>(), v9);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_none_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_withdraw(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_params(), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_tolerance(), arg15, arg16);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        0x2::coin::join<T1>(&mut v11, arg14);
        assert!(0x2::coin::value<T1>(&v11) >= v13, 101);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v13, arg16)), v4);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        if (0x2::coin::value<T1>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, v0);
        } else {
            0x2::coin::destroy_zero<T1>(v11);
        };
    }

    public entry fun run_one_restore<T0, T1, T2>(arg0: &0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: 0x2::coin::Coin<T0>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, true, true, arg9, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 10000 - 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::push_bps()), arg14);
        let v4 = v3;
        let v5 = v1;
        assert!(0x2::balance::value<T0>(&v5) == 0, 106);
        0x2::balance::destroy_zero<T0>(v5);
        let v6 = 0x2::coin::from_balance<T1>(v2, arg15);
        assert!(0x2::coin::value<T1>(&v6) > 0, 102);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_id_new(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg13, arg10, arg15)), 0, arg11, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_add_base(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::special_params(arg12), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::tolerance_test_value(), arg14, arg15);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, false, true, 0x2::coin::value<T1>(&v6), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::max_sqrt_price_limit(), arg14);
        let v10 = v9;
        0x2::balance::destroy_zero<T1>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10), arg15)), v10);
        0x2::coin::join<T0>(&mut arg13, 0x2::coin::from_balance<T0>(v7, arg15));
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(0x2::coin::value<T0>(&arg13) >= v11, 107);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg13, v11, arg15)), 0x2::balance::zero<T1>(), v4);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_none_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_withdraw(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_params(), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_tolerance(), arg14, arg15);
        0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::send_or_destroy<T0>(arg13, v0);
        0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::send_or_destroy<T1>(v6, v0);
    }

    public entry fun run_one_restore_reverse<T0, T1, T2>(arg0: &0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: 0x2::coin::Coin<T0>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg5, false, true, arg9, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg5), 10000 + 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::push_bps()), arg14);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::balance::value<T0>(&v5) == 0, 106);
        0x2::balance::destroy_zero<T0>(v5);
        let v6 = 0x2::coin::from_balance<T1>(v1, arg15);
        assert!(0x2::coin::value<T1>(&v6) > 0, 102);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_id_new(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg13, arg10, arg15)), 0, arg11, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_add_base(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::special_params(arg12), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::tolerance_test_value(), arg14, arg15);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg5, true, true, 0x2::coin::value<T1>(&v6), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::min_sqrt_price_limit(), arg14);
        let v10 = v9;
        0x2::balance::destroy_zero<T1>(v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v10), arg15)), 0x2::balance::zero<T0>(), v10);
        0x2::coin::join<T0>(&mut arg13, 0x2::coin::from_balance<T0>(v8, arg15));
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        assert!(0x2::coin::value<T0>(&arg13) >= v11, 107);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg13, v11, arg15)), v4);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_none_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_withdraw(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_params(), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_tolerance(), arg14, arg15);
        0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::send_or_destroy<T0>(arg13, v0);
        0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::send_or_destroy<T1>(v6, v0);
    }

    public entry fun run_one_reverse<T0, T1, T2>(arg0: &0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<T1>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg5, true, false, arg9, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::min_sqrt_price_limit(), arg15);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v1);
        let v5 = 0x2::coin::from_balance<T0>(v2, arg16);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg5, false, true, arg11, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg5), 10000 + 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::push_bps()), arg15);
        let v9 = v8;
        let v10 = v7;
        assert!(0x2::balance::value<T0>(&v10) == 0, 106);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v6, arg16);
        assert!(0x2::coin::value<T1>(&v11) > 0, 102);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_id_new(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, arg10, arg16)), 0, arg12, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_add_base(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::special_params(arg13), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::tolerance_test_value(), arg15, arg16);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v12, 103);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v12, arg16)), v9);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_none_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::work_factor_max(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::strategy_withdraw(), 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_params(), arg7, arg8, 0xe29562105304d288d67bafe4e87ccd01bc3dbff655e523674be3a7b8c17d80bf::common::settle_tolerance(), arg15, arg16);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        0x2::coin::join<T1>(&mut v11, arg14);
        assert!(0x2::coin::value<T1>(&v11) >= v13, 101);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v13, arg16)), 0x2::balance::zero<T0>(), v4);
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        if (0x2::coin::value<T1>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, v0);
        } else {
            0x2::coin::destroy_zero<T1>(v11);
        };
    }

    // decompiled from Move bytecode v7
}

