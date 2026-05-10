module 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::bluefin2_path {
    public entry fun run_leveraged_reverse<T0, T1, T2>(arg0: &0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: address, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<T0>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1);
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg15, arg4, arg5, false, true, arg9, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::max_sqrt_price_limit());
        let v5 = v4;
        let v6 = v3;
        assert!(0x2::balance::value<T0>(&v6) == 0, 804);
        0x2::balance::destroy_zero<T0>(v6);
        let v7 = 0x2::coin::from_balance<T1>(v2, arg16);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg14, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v5), arg16)), v5);
        0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::work_safe_reverse<T0, T1, T2>(arg8, arg3, arg1, arg2, arg4, arg5, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_id_new(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg14, arg10, arg16)), arg10, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg11, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_factor_max(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_two_sides(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::two_sides_params(true, arg12), arg6, arg7, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::tolerance_test_value(), arg15, arg16);
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg15, arg4, arg5, true, true, 0x2::coin::value<T1>(&v7), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::min_sqrt_price_limit());
        let v11 = v10;
        0x2::balance::destroy_zero<T1>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v7, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v11), arg16)), 0x2::balance::zero<T0>(), v11);
        0x2::coin::join<T0>(&mut arg14, 0x2::coin::from_balance<T0>(v9, arg16));
        let (_, v13) = 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::position_info_reverse<T0, T1, T2>(arg3, arg1, arg5, v1);
        0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::work_none_safe_reverse<T0, T1, T2>(arg8, arg3, arg1, arg2, arg4, arg5, v1, v13, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_factor_max(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_withdraw(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::settle_params(), arg6, arg7, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::settle_tolerance(), arg15, arg16);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T0>(arg14, v0);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T1>(v7, v0);
    }

    public entry fun run_restore_reverse<T0, T1, T2>(arg0: &0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: address, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: 0x2::coin::Coin<T0>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun run_restore_reverse_v2<T0, T1, T2>(arg0: &0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: address, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<T0>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1);
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg15, arg4, arg5, false, true, arg9, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::max_sqrt_price_limit());
        let v5 = v4;
        let v6 = v3;
        assert!(0x2::balance::value<T0>(&v6) == 0, 804);
        0x2::balance::destroy_zero<T0>(v6);
        let v7 = 0x2::coin::from_balance<T1>(v2, arg16);
        assert!(0x2::coin::value<T1>(&v7) > 0, 801);
        0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::work_only_base_safe_reverse<T0, T1, T2>(arg8, arg3, arg1, arg2, arg4, arg5, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_id_new(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg14, arg11, arg16)), arg11, arg12, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_factor_max(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_add_base(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::special_params(arg13), arg6, arg7, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::tolerance_test_value(), arg15, arg16);
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg15, arg4, arg5, true, true, 0x2::coin::value<T1>(&v7), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::min_sqrt_price_limit());
        let v11 = v10;
        0x2::balance::destroy_zero<T1>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v7, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v11), arg16)), 0x2::balance::zero<T0>(), v11);
        0x2::coin::join<T0>(&mut arg14, 0x2::coin::from_balance<T0>(v9, arg16));
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v5);
        assert!(0x2::coin::value<T0>(&arg14) >= v12, 805);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg14, v12, arg16)), v5);
        let (_, v14) = 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::position_info_reverse<T0, T1, T2>(arg3, arg1, arg5, v1);
        0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::work_none_safe_reverse<T0, T1, T2>(arg8, arg3, arg1, arg2, arg4, arg5, v1, v14, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_factor_max(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_withdraw(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::settle_params(), arg6, arg7, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::settle_tolerance(), arg15, arg16);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T0>(arg14, v0);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T1>(v7, v0);
    }

    public entry fun run_restore_reverse_v3<T0, T1, T2>(arg0: &0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: address, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: 0x2::coin::Coin<T0>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        let v1 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1);
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg14, arg4, arg5, false, true, arg9, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::max_sqrt_price_limit());
        let v5 = v4;
        let v6 = v3;
        assert!(0x2::balance::value<T0>(&v6) == 0, 804);
        0x2::balance::destroy_zero<T0>(v6);
        let v7 = 0x2::coin::from_balance<T1>(v2, arg15);
        assert!(0x2::coin::value<T1>(&v7) > 0, 801);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg13, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v5), arg15)), v5);
        0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::work_only_base_safe_reverse<T0, T1, T2>(arg8, arg3, arg1, arg2, arg4, arg5, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_id_new(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg13, arg10, arg15)), arg10, arg11, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_factor_max(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_add_base(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::special_params(arg12), arg6, arg7, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::tolerance_test_value(), arg14, arg15);
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg14, arg4, arg5, true, true, 0x2::coin::value<T1>(&v7), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::min_sqrt_price_limit());
        let v11 = v10;
        0x2::balance::destroy_zero<T1>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v7, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v11), arg15)), 0x2::balance::zero<T0>(), v11);
        0x2::coin::join<T0>(&mut arg13, 0x2::coin::from_balance<T0>(v9, arg15));
        let (_, v13) = 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::position_info_reverse<T0, T1, T2>(arg3, arg1, arg5, v1);
        0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::work_none_safe_reverse<T0, T1, T2>(arg8, arg3, arg1, arg2, arg4, arg5, v1, v13, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_factor_max(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_withdraw(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::settle_params(), arg6, arg7, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::settle_tolerance(), arg14, arg15);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T0>(arg13, v0);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T1>(v7, v0);
    }

    public entry fun run_simple_leveraged<T0, T1, T2>(arg0: &0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: address, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: 0x2::coin::Coin<T0>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1);
        let v1 = if (arg12 == 0) {
            0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_add_base()
        } else {
            0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_two_sides()
        };
        let v2 = if (arg12 == 0) {
            0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::special_params(arg11)
        } else {
            0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::two_sides_params(arg12 > 0, arg11)
        };
        0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::work_safe_reverse<T0, T1, T2>(arg8, arg3, arg1, arg2, arg4, arg5, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_id_new(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg13, arg9, arg15)), arg9, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0, arg10, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_factor_max(), v1, v2, arg6, arg7, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::tolerance_test_value(), arg14, arg15);
        let (_, v4) = 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::position_info_reverse<T0, T1, T2>(arg3, arg1, arg5, v0);
        0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::work_none_safe_reverse<T0, T1, T2>(arg8, arg3, arg1, arg2, arg4, arg5, v0, v4, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_factor_max(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_withdraw(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::settle_params(), arg6, arg7, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::settle_tolerance(), arg14, arg15);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T0>(arg13, 0x2::tx_context::sender(arg15));
    }

    public entry fun run_simple_reverse<T0, T1, T2>(arg0: &0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: address, arg9: u64, arg10: u64, arg11: u64, arg12: 0x2::coin::Coin<T0>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1);
        0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::work_only_base_safe_reverse<T0, T1, T2>(arg8, arg3, arg1, arg2, arg4, arg5, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_id_new(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg12, arg9, arg14)), arg9, arg10, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_factor_max(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_add_base(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::special_params(arg11), arg6, arg7, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::tolerance_test_value(), arg13, arg14);
        let (_, v2) = 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::position_info_reverse<T0, T1, T2>(arg3, arg1, arg5, v0);
        0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::work_none_safe_reverse<T0, T1, T2>(arg8, arg3, arg1, arg2, arg4, arg5, v0, v2, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_factor_max(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_withdraw(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::settle_params(), arg6, arg7, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::settle_tolerance(), arg13, arg14);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T0>(arg12, 0x2::tx_context::sender(arg14));
    }

    public entry fun test_flash<T0, T1>(arg0: &0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::auth::OwnerCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3) {
            0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::min_sqrt_price_limit()
        } else {
            0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::max_sqrt_price_limit()
        };
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg1, arg2, arg3, true, arg4, v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x2::tx_context::sender(arg6);
        if (arg3) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
            0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T0>(0x2::coin::from_balance<T0>(v6, arg6), v7);
            0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T1>(0x2::coin::from_balance<T1>(v5, arg6), v7);
        } else {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4)), v4);
            0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T0>(0x2::coin::from_balance<T0>(v6, arg6), v7);
            0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T1>(0x2::coin::from_balance<T1>(v5, arg6), v7);
        };
    }

    public entry fun test_flash_ext<T0, T1, T2>(arg0: &0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: address, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<T0>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1);
        let v0 = 0x2::tx_context::sender(arg16);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg15, arg4, arg5, false, true, arg9, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::max_sqrt_price_limit());
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::balance::value<T0>(&v5) == 0, 804);
        0x2::balance::destroy_zero<T0>(v5);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg14, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v4), arg16)), v4);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T0>(arg14, v0);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T1>(0x2::coin::from_balance<T1>(v1, arg16), v0);
    }

    public entry fun test_flash_full<T0, T1, T2>(arg0: &0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun test_flash_plus_worker<T0, T1, T2>(arg0: &0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: address, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<T0>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg15, arg4, arg5, false, true, arg9, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::max_sqrt_price_limit());
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::balance::value<T0>(&v5) == 0, 804);
        0x2::balance::destroy_zero<T0>(v5);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg14, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v4), arg16)), v4);
        0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::work_only_base_safe_reverse<T0, T1, T2>(arg8, arg3, arg1, arg2, arg4, arg5, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_id_new(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg14, arg11, arg16)), arg11, 0, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::work_factor_max(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::strategy_add_base(), 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::special_params(arg13), arg6, arg7, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::tolerance_test_value(), arg15, arg16);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T0>(arg14, v0);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T1>(0x2::coin::from_balance<T1>(v1, arg16), v0);
    }

    public entry fun test_push_only<T0, T1, T2>(arg0: &0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xad21f582315ff7c040c96f8f9466aa2f6098294b2cb9698f79ea16d52a2ffb32::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: address, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: 0x2::coin::Coin<T0>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg16);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg15, arg4, arg5, false, true, arg9, 0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::max_sqrt_price_limit());
        let v4 = v3;
        let v5 = v2;
        assert!(0x2::balance::value<T0>(&v5) == 0, 804);
        0x2::balance::destroy_zero<T0>(v5);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg4, arg5, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg14, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v4), arg16)), v4);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T0>(arg14, v0);
        0x6442770d7d5d13e5e2671a9ac71ae0451c376cfddc3d2d3611dafba6ff32b39d::common::send_or_destroy<T1>(0x2::coin::from_balance<T1>(v1, arg16), v0);
    }

    // decompiled from Move bytecode v7
}

