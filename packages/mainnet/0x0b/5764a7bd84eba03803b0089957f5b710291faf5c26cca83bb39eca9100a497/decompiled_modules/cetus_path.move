module 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::cetus_path {
    public entry fun run_multi_cycle<T0, T1, T2>(arg0: &0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: vector<0x2::coin::Coin<T0>>, arg10: 0x2::coin::Coin<T0>, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        assert!(arg14 > 0, 105);
        let v1 = 0x1::vector::length<0x2::coin::Coin<T0>>(&arg9);
        assert!(v1 > 0, 103);
        assert!(arg14 <= v1, 104);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, true, true, arg11, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 10000 + 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::push_bps()), arg15);
        let v5 = v4;
        let v6 = v2;
        assert!(0x2::balance::value<T0>(&v6) == 0, 106);
        0x2::balance::destroy_zero<T0>(v6);
        let v7 = 0x2::coin::from_balance<T1>(v3, arg16);
        assert!(0x2::coin::value<T1>(&v7) > 0, 102);
        let v8 = 0;
        while (v8 < arg14) {
            0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::work_id_new(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::vec1<0x2::coin::Coin<T0>>(0x1::vector::remove<0x2::coin::Coin<T0>>(&mut arg9, 0)), arg13, arg12, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::work_factor_max(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::strategy_add_base(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::special_params(arg13), arg7, arg8, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::tolerance_test_value(), arg15, arg16);
            0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::kill_safe<T0, T1, T2>(v0, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1) + v8, arg7, arg8, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::kill_tol_normal(), arg15, arg16);
            v8 = v8 + 1;
        };
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg9)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg9), v0);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg9);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        assert!(0x2::coin::value<T0>(&arg10) >= v9, 101);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg10, v9, arg16)), 0x2::balance::zero<T1>(), v5);
        if (0x2::coin::value<T0>(&arg10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg10, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg10);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, v0);
    }

    public entry fun run_one<T0, T1, T2>(arg0: &0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T0>, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, true, true, arg11, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 10000 + 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::push_bps()), arg14);
        let v4 = v3;
        let v5 = v1;
        assert!(0x2::balance::value<T0>(&v5) == 0, 106);
        0x2::balance::destroy_zero<T0>(v5);
        let v6 = 0x2::coin::from_balance<T1>(v2, arg15);
        assert!(0x2::coin::value<T1>(&v6) > 0, 102);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::work_id_new(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::vec1<0x2::coin::Coin<T0>>(arg9), arg13, arg12, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::work_factor_max(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::strategy_add_base(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::special_params(arg13), arg7, arg8, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::tolerance_test_value(), arg14, arg15);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::kill_safe<T0, T1, T2>(v0, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), arg7, arg8, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::kill_tol_normal(), arg14, arg15);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(0x2::coin::value<T0>(&arg10) >= v7, 101);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg10, v7, arg15)), 0x2::balance::zero<T1>(), v4);
        if (0x2::coin::value<T0>(&arg10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg10, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg10);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, v0);
    }

    public entry fun run_one_flash_no_kill<T0, T1, T2>(arg0: &0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u8, arg15: vector<u8>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg17);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, false, false, arg9, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::max_sqrt_price_limit(), arg16);
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::balance::value<T1>(&v5) == 0, 106);
        0x2::balance::destroy_zero<T1>(v5);
        let v6 = 0x2::coin::from_balance<T0>(v1, arg17);
        assert!(0x2::coin::value<T0>(&v6) >= arg10, 107);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, true, true, arg11, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 10000 + 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::push_bps()), arg16);
        let v10 = v9;
        let v11 = v7;
        assert!(0x2::balance::value<T0>(&v11) == 0, 106);
        0x2::balance::destroy_zero<T0>(v11);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg17);
        assert!(0x2::coin::value<T1>(&v12) > 0, 102);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::work_id_new(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, arg10, arg17)), arg10, arg12, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::work_factor_max(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::strategy_add_base(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::special_params(arg13), arg7, arg8, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::tolerance_test_value(), arg16, arg17);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10);
        assert!(0x2::coin::value<T0>(&v6) >= v13, 108);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v13, arg17)), 0x2::balance::zero<T1>(), v10);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_none_safe<T0, T1, T2>(v0, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::work_factor_max(), arg14, arg15, arg7, arg8, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::settle_tol_normal(), arg16, arg17);
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(0x2::coin::value<T1>(&v12) >= v14, 109);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v12, v14, arg17)), v4);
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        if (0x2::coin::value<T1>(&v12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, v0);
        } else {
            0x2::coin::destroy_zero<T1>(v12);
        };
    }

    public entry fun run_one_flash_no_kill_reverse<T0, T1, T2>(arg0: &0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u8, arg15: vector<u8>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg17);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg5, true, false, arg9, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::min_sqrt_price_limit(), arg16);
        let v4 = v3;
        let v5 = v1;
        assert!(0x2::balance::value<T1>(&v5) == 0, 106);
        0x2::balance::destroy_zero<T1>(v5);
        let v6 = 0x2::coin::from_balance<T0>(v2, arg17);
        assert!(0x2::coin::value<T0>(&v6) >= arg10, 107);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg5, false, true, arg11, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg5), 10000 + 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::push_bps()), arg16);
        let v10 = v9;
        let v11 = v8;
        assert!(0x2::balance::value<T0>(&v11) == 0, 106);
        0x2::balance::destroy_zero<T0>(v11);
        let v12 = 0x2::coin::from_balance<T1>(v7, arg17);
        assert!(0x2::coin::value<T1>(&v12) > 0, 102);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_only_base_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::work_id_new(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, arg10, arg17)), arg10, arg12, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::work_factor_max(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::strategy_add_base(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::special_params(arg13), arg7, arg8, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::tolerance_test_value(), arg16, arg17);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v10);
        assert!(0x2::coin::value<T0>(&v6) >= v13, 108);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v13, arg17)), v10);
        0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::work_none_safe_reverse<T0, T1, T2>(v0, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::work_factor_max(), arg14, arg15, arg7, arg8, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::settle_tol_normal(), arg16, arg17);
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        assert!(0x2::coin::value<T1>(&v12) >= v14, 109);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v12, v14, arg17)), 0x2::balance::zero<T0>(), v4);
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        if (0x2::coin::value<T1>(&v12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, v0);
        } else {
            0x2::coin::destroy_zero<T1>(v12);
        };
    }

    public entry fun run_one_flash_no_kill_reverse_withdraw<T0, T1, T2>(arg0: &0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        run_one_flash_no_kill_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::strategy_withdraw_minimize(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::withdraw_params(0), arg14, arg15);
    }

    public entry fun run_one_flash_no_kill_withdraw<T0, T1, T2>(arg0: &0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        run_one_flash_no_kill<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::strategy_withdraw_minimize(), 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common::withdraw_params(0), arg14, arg15);
    }

    // decompiled from Move bytecode v7
}

