module 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::bluefin_path {
    public entry fun run_multi_cycle<T0, T1, T2>(arg0: &0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: 0x2::coin::Coin<T1>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg17);
        assert!(arg14 > 0, 205);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg4, arg5, false, false, arg9, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::max_sqrt_price_limit());
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let v5 = 0x2::coin::from_balance<T0>(v1, arg17);
        let (v6, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg16, arg4, arg5, true, true, arg11, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::mul_bps_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg5), 10000 - 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::push_bps()));
        let v9 = v8;
        let v10 = v6;
        assert!(0x2::balance::value<T0>(&v10) == 0, 206);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg17);
        assert!(0x2::coin::value<T1>(&v11) > 0, 202);
        let v12 = 0;
        while (v12 < arg14) {
            0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_id_new(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, arg10, arg17)), 0, arg12, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_factor_max(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::strategy_add_base(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::special_params(arg13), arg7, arg8, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::tolerance_test_value(), arg16, arg17);
            v12 = v12 + 1;
        };
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v13, 203);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v13, arg17)), 0x2::balance::zero<T1>(), v9);
        let v14 = 0;
        while (v14 < arg14) {
            0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::work_none_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1) + v14, 0, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_factor_max(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::strategy_withdraw(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::settle_params(), arg7, arg8, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::settle_tolerance(), arg16, arg17);
            v14 = v14 + 1;
        };
        let v15 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4);
        0x2::coin::join<T1>(&mut v11, arg15);
        assert!(0x2::coin::value<T1>(&v11) >= v15, 201);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v15, arg17)), v4);
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

    public entry fun run_multi_cycle_reverse<T0, T1, T2>(arg0: &0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: 0x2::coin::Coin<T1>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg17);
        assert!(arg14 > 0, 205);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg16, arg4, arg5, true, false, arg9, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::min_sqrt_price_limit());
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v1);
        let v5 = 0x2::coin::from_balance<T0>(v2, arg17);
        let (v6, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg16, arg4, arg5, false, true, arg11, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::mul_bps_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg5), 10000 + 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::push_bps()));
        let v9 = v8;
        let v10 = v7;
        assert!(0x2::balance::value<T0>(&v10) == 0, 206);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v6, arg17);
        assert!(0x2::coin::value<T1>(&v11) > 0, 202);
        let v12 = 0;
        while (v12 < arg14) {
            0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::work_only_base_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_id_new(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, arg10, arg17)), 0, arg12, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_factor_max(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::strategy_add_base(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::special_params(arg13), arg7, arg8, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::tolerance_test_value(), arg16, arg17);
            v12 = v12 + 1;
        };
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v13, 203);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v13, arg17)), v9);
        let v14 = 0;
        while (v14 < arg14) {
            0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::work_none_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1) + v14, 0, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_factor_max(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::strategy_withdraw(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::settle_params(), arg7, arg8, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::settle_tolerance(), arg16, arg17);
            v14 = v14 + 1;
        };
        let v15 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v4);
        0x2::coin::join<T1>(&mut v11, arg15);
        assert!(0x2::coin::value<T1>(&v11) >= v15, 201);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v15, arg17)), 0x2::balance::zero<T0>(), v4);
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

    public entry fun run_one<T0, T1, T2>(arg0: &0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<T1>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg4, arg5, false, false, arg9, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::max_sqrt_price_limit());
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let v5 = 0x2::coin::from_balance<T0>(v1, arg16);
        let (v6, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg4, arg5, true, true, arg11, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::mul_bps_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg5), 10000 - 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::push_bps()));
        let v9 = v8;
        let v10 = v6;
        assert!(0x2::balance::value<T0>(&v10) == 0, 206);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg16);
        assert!(0x2::coin::value<T1>(&v11) > 0, 202);
        0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_id_new(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, arg10, arg16)), 0, arg12, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_factor_max(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::strategy_add_base(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::special_params(arg13), arg7, arg8, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::tolerance_test_value(), arg15, arg16);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v12, 203);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v12, arg16)), 0x2::balance::zero<T1>(), v9);
        0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::work_none_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_factor_max(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::strategy_withdraw(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::settle_params(), arg7, arg8, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::settle_tolerance(), arg15, arg16);
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4);
        0x2::coin::join<T1>(&mut v11, arg14);
        assert!(0x2::coin::value<T1>(&v11) >= v13, 201);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v13, arg16)), v4);
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

    public entry fun run_one_reverse<T0, T1, T2>(arg0: &0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<T1>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg15, arg4, arg5, true, false, arg9, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::min_sqrt_price_limit());
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v1);
        let v5 = 0x2::coin::from_balance<T0>(v2, arg16);
        let (v6, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg15, arg4, arg5, false, true, arg11, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::mul_bps_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg5), 10000 + 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::push_bps()));
        let v9 = v8;
        let v10 = v7;
        assert!(0x2::balance::value<T0>(&v10) == 0, 206);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v6, arg16);
        assert!(0x2::coin::value<T1>(&v11) > 0, 202);
        0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::work_only_base_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_id_new(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, arg10, arg16)), 0, arg12, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_factor_max(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::strategy_add_base(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::special_params(arg13), arg7, arg8, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::tolerance_test_value(), arg15, arg16);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v12, 203);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v12, arg16)), v9);
        0xcf9fd9331aaaf2e788a1678e59e1221f3791c30cf3cbb65358af50df11a5c8d0::bluefin_clmm_worker::work_none_safe_reverse<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::work_factor_max(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::strategy_withdraw(), 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::settle_params(), arg7, arg8, 0xfe53558dfe4f0a1e4fd66f4d96d724a7e7683552b27016464fc101ea1f03af63::common::settle_tolerance(), arg15, arg16);
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v4);
        0x2::coin::join<T1>(&mut v11, arg14);
        assert!(0x2::coin::value<T1>(&v11) >= v13, 201);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v13, arg16)), 0x2::balance::zero<T0>(), v4);
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

