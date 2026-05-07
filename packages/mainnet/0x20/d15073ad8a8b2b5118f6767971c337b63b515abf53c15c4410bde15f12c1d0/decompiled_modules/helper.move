module 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::helper {
    public entry fun bluefin_auto<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xa536ee4488c7b4ce968d94925928b88df3d3fa0e01a134a285c1e00c830fd985::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: 0x2::coin::Coin<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = calc_debt<T0>(arg1);
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg10, arg4, arg5, false, false, est_borrow_forward(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg5)), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::max_sqrt_price_limit());
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v3);
        let v6 = 0x2::coin::from_balance<T0>(v2, arg11);
        let (v7, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg10, arg4, arg5, true, true, 0x2::coin::value<T0>(&v6), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::mul_bps_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg5), 10000 - 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::push_bps()));
        let v10 = v9;
        let v11 = v7;
        assert!(0x2::balance::value<T0>(&v11) == 0, 503);
        0x2::balance::destroy_zero<T0>(v11);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg11);
        assert!(0x2::coin::value<T1>(&v12) > 0, 501);
        0xa536ee4488c7b4ce968d94925928b88df3d3fa0e01a134a285c1e00c830fd985::bluefin_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_id_new(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, 1, arg11)), 1, v1, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_factor_max(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::strategy_add_base(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::special_params(v1), arg7, arg8, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::tolerance_test_value(), arg10, arg11);
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v10);
        assert!(0x2::coin::value<T0>(&v6) >= v13, 502);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v13, arg11)), 0x2::balance::zero<T1>(), v10);
        0xa536ee4488c7b4ce968d94925928b88df3d3fa0e01a134a285c1e00c830fd985::bluefin_clmm_worker::work_none_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_factor_max(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::strategy_withdraw(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::settle_params(), arg7, arg8, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::settle_tolerance(), arg10, arg11);
        let v14 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v5);
        0x2::coin::join<T1>(&mut v12, arg9);
        assert!(0x2::coin::value<T1>(&v12) >= v14, 502);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v12, v14, arg11)), v5);
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::send_or_destroy<T0>(v6, v0);
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::send_or_destroy<T1>(v12, v0);
    }

    public entry fun bluefin_auto_n<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xa536ee4488c7b4ce968d94925928b88df3d3fa0e01a134a285c1e00c830fd985::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 > 0, 504);
        let v0 = calc_debt<T0>(arg1) / arg9;
        let v1 = est_borrow_forward(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg5)) + arg9;
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::bluefin_path::run_multi_cycle<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, 1, borrow_minus_seed(v1, arg9), v0, v0, arg9, arg10, arg11, arg12);
    }

    public entry fun bluefin_auto_reverse<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xa536ee4488c7b4ce968d94925928b88df3d3fa0e01a134a285c1e00c830fd985::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: 0x2::coin::Coin<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = calc_debt<T0>(arg1);
        let v1 = est_borrow_reverse(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T1, T0>(arg5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg5));
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::bluefin_path::run_one_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, 1, borrow_minus_seed(v1, 1), v0, v0, arg9, arg10, arg11);
    }

    public entry fun bluefin_auto_reverse_n<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0xa536ee4488c7b4ce968d94925928b88df3d3fa0e01a134a285c1e00c830fd985::bluefin_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 > 0, 504);
        let v0 = calc_debt<T0>(arg1) / arg9;
        let v1 = est_borrow_reverse(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T1, T0>(arg5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg5)) + arg9;
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::bluefin_path::run_multi_cycle_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, 1, borrow_minus_seed(v1, arg9), v0, v0, arg9, arg10, arg11, arg12);
    }

    fun borrow_minus_seed(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            1
        }
    }

    fun calc_available_debt<T0>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage) : u64 {
        let v0 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_vault_base_coin_balance<T0>(arg0);
        let v1 = 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_reserve_pool<T0>(arg0);
        assert!(v0 > v1, 500);
        v0 - v1
    }

    fun calc_debt<T0>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage) : u64 {
        calc_available_debt<T0>(arg0) * 9 / 10
    }

    public entry fun cetus_auto<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x96e3e2a52e3b761ada5d302dbfbb06663658174574f42832b301ac25ed7eb5b0::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: 0x2::coin::Coin<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = calc_debt<T0>(arg1);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, false, false, est_borrow_forward(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5)), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::max_sqrt_price_limit(), arg10);
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v3);
        let v6 = 0x2::coin::from_balance<T0>(v2, arg11);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, true, true, 0x2::coin::value<T0>(&v6), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 10000 - 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::push_bps()), arg10);
        let v10 = v9;
        let v11 = v7;
        assert!(0x2::balance::value<T0>(&v11) == 0, 503);
        0x2::balance::destroy_zero<T0>(v11);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg11);
        assert!(0x2::coin::value<T1>(&v12) > 0, 501);
        0x96e3e2a52e3b761ada5d302dbfbb06663658174574f42832b301ac25ed7eb5b0::cetus_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_id_new(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, 1, arg11)), 1, v1, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_factor_max(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::strategy_add_base(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::special_params(v1), arg7, arg8, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::tolerance_test_value(), arg10, arg11);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10);
        assert!(0x2::coin::value<T0>(&v6) >= v13, 502);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v13, arg11)), 0x2::balance::zero<T1>(), v10);
        0x96e3e2a52e3b761ada5d302dbfbb06663658174574f42832b301ac25ed7eb5b0::cetus_clmm_worker::work_none_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_factor_max(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::strategy_withdraw(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::settle_params(), arg7, arg8, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::settle_tolerance(), arg10, arg11);
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        0x2::coin::join<T1>(&mut v12, arg9);
        assert!(0x2::coin::value<T1>(&v12) >= v14, 502);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v12, v14, arg11)), v5);
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::send_or_destroy<T0>(v6, v0);
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::send_or_destroy<T1>(v12, v0);
    }

    public entry fun cetus_auto_n<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x96e3e2a52e3b761ada5d302dbfbb06663658174574f42832b301ac25ed7eb5b0::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 > 0, 504);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = calc_available_debt<T0>(arg1) * 9 / 10 / arg9;
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, false, false, est_borrow_forward(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5)) + arg9, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::max_sqrt_price_limit(), arg11);
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v3);
        let v6 = 0x2::coin::from_balance<T0>(v2, arg12);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, true, true, 0x2::coin::value<T0>(&v6) - arg9, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 10000 - 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::push_bps()), arg11);
        let v10 = v9;
        let v11 = v7;
        assert!(0x2::balance::value<T0>(&v11) == 0, 503);
        0x2::balance::destroy_zero<T0>(v11);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg12);
        assert!(0x2::coin::value<T1>(&v12) > 0, 501);
        let v13 = 0;
        while (v13 < arg9) {
            0x96e3e2a52e3b761ada5d302dbfbb06663658174574f42832b301ac25ed7eb5b0::cetus_clmm_worker::work_only_base_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_id_new(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, 1, arg12)), 1, v1, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_factor_max(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::strategy_add_base(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::special_params(v1), arg7, arg8, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::tolerance_test_value(), arg11, arg12);
            v13 = v13 + 1;
        };
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10);
        assert!(0x2::coin::value<T0>(&v6) >= v14, 502);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v14, arg12)), 0x2::balance::zero<T1>(), v10);
        let v15 = 0;
        while (v15 < arg9) {
            0x96e3e2a52e3b761ada5d302dbfbb06663658174574f42832b301ac25ed7eb5b0::cetus_clmm_worker::work_none_safe<T0, T1, T2>(arg6, arg3, arg1, arg2, arg4, arg5, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1) + v15, 0, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_factor_max(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::strategy_withdraw(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::settle_params(), arg7, arg8, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::settle_tolerance(), arg11, arg12);
            v15 = v15 + 1;
        };
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        0x2::coin::join<T1>(&mut v12, arg10);
        assert!(0x2::coin::value<T1>(&v12) >= v16, 502);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v12, v16, arg12)), v5);
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::send_or_destroy<T0>(v6, v0);
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::send_or_destroy<T1>(v12, v0);
    }

    public entry fun cetus_auto_reverse<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x96e3e2a52e3b761ada5d302dbfbb06663658174574f42832b301ac25ed7eb5b0::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: 0x2::coin::Coin<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = calc_debt<T0>(arg1);
        let v1 = est_borrow_reverse(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T1, T0>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg5));
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::cetus_path::run_one_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, 1, borrow_minus_seed(v1, 1), v0, v0, arg9, arg10, arg11);
    }

    public entry fun cetus_auto_reverse_n<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x96e3e2a52e3b761ada5d302dbfbb06663658174574f42832b301ac25ed7eb5b0::cetus_clmm_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: address, arg7: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg8: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 > 0, 504);
        let v0 = calc_debt<T0>(arg1) / arg9;
        let v1 = est_borrow_reverse(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T1, T0>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg5)) + arg9;
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::cetus_path::run_multi_cycle_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, 1, borrow_minus_seed(v1, arg9), v0, v0, arg9, arg10, arg11, arg12);
    }

    fun est_borrow_forward(arg0: u128, arg1: u128) : u64 {
        let v0 = (0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::push_bps() as u256);
        let v1 = (arg1 as u256) * (10000 - v0);
        let v2 = if (v1 == 0) {
            1
        } else {
            (arg0 as u256) * v0 * 18446744073709551616 / v1
        };
        ((v2 * 3 / 2 + 2) as u64)
    }

    fun est_borrow_reverse(arg0: u128, arg1: u128) : u64 {
        let v0 = (0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::push_bps() as u256);
        let v1 = (arg1 as u256) * (10000 + v0);
        let v2 = if (v1 == 0) {
            1
        } else {
            (arg0 as u256) * v0 * 18446744073709551616 / v1
        };
        ((v2 * 3 / 2 + 2) as u64)
    }

    public entry fun sf_auto<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: address, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: 0x2::coin::Coin<T1>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = calc_debt<T0>(arg1);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg6, false, false, est_borrow_forward(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6)), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::max_sqrt_price_limit(), arg13);
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v3);
        let v6 = 0x2::coin::from_balance<T0>(v2, arg14);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg6, true, true, 0x2::coin::value<T0>(&v6), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), 10000 - 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::push_bps()), arg13);
        let v10 = v9;
        let v11 = v7;
        assert!(0x2::balance::value<T0>(&v11) == 0, 503);
        0x2::balance::destroy_zero<T0>(v11);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg14);
        assert!(0x2::coin::value<T1>(&v12) > 0, 501);
        0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_only_base_safe<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_id_new(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, 1, arg14)), 1, v1, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_factor_max(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::strategy_add_base(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::special_params(v1), arg10, arg11, arg8, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::tolerance_test_value(), arg13, arg14);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10);
        assert!(0x2::coin::value<T0>(&v6) >= v13, 502);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v13, arg14)), 0x2::balance::zero<T1>(), v10);
        0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_none_safe<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_factor_max(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::strategy_withdraw(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::settle_params(), arg10, arg11, arg8, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::settle_tolerance(), arg13, arg14);
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        0x2::coin::join<T1>(&mut v12, arg12);
        assert!(0x2::coin::value<T1>(&v12) >= v14, 502);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v12, v14, arg14)), v5);
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::send_or_destroy<T0>(v6, v0);
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::send_or_destroy<T1>(v12, v0);
    }

    public entry fun sf_auto_n<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: address, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: u64, arg13: 0x2::coin::Coin<T1>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg12 > 0, 504);
        let v0 = calc_debt<T0>(arg1) / arg12;
        let v1 = est_borrow_forward(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6)) + arg12;
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::sf_path::run_multi_cycle<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v1, 1, borrow_minus_seed(v1, arg12), v0, v0, arg12, arg13, arg14, arg15);
    }

    public entry fun sf_auto_restore<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: address, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: 0x2::coin::Coin<T1>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = calc_debt<T0>(arg1);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg6, false, false, est_borrow_forward(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6)), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::max_sqrt_price_limit(), arg13);
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v3);
        let v6 = 0x2::coin::from_balance<T0>(v2, arg14);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg6, true, true, 0x2::coin::value<T0>(&v6), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), 10000 - 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::push_bps()), arg13);
        let v10 = v9;
        let v11 = v7;
        assert!(0x2::balance::value<T0>(&v11) == 0, 503);
        0x2::balance::destroy_zero<T0>(v11);
        let v12 = 0x2::coin::from_balance<T1>(v8, arg14);
        assert!(0x2::coin::value<T1>(&v12) > 0, 501);
        0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_only_base_safe<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_id_new(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::vec1<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, 1, arg14)), 1, v1, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_factor_max(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::strategy_add_base(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::special_params(v1), arg10, arg11, arg8, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::tolerance_test_value(), arg13, arg14);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg6, false, true, 0x2::coin::value<T1>(&v12), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::max_sqrt_price_limit(), arg13);
        let v16 = v15;
        0x2::balance::destroy_zero<T1>(v14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16), arg14)), v16);
        0x2::coin::join<T0>(&mut v6, 0x2::coin::from_balance<T0>(v13, arg14));
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10);
        assert!(0x2::coin::value<T0>(&v6) >= v17, 502);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v17, arg14)), 0x2::balance::zero<T1>(), v10);
        0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_none_safe<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::work_factor_max(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::strategy_withdraw(), 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::settle_params(), arg10, arg11, arg8, 0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::settle_tolerance(), arg13, arg14);
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        0x2::coin::join<T1>(&mut v12, arg12);
        assert!(0x2::coin::value<T1>(&v12) >= v18, 502);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v12, v18, arg14)), v5);
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::send_or_destroy<T0>(v6, v0);
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::common::send_or_destroy<T1>(v12, v0);
    }

    public entry fun sf_auto_reverse<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: address, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: 0x2::coin::Coin<T1>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = calc_debt<T0>(arg1);
        let v1 = est_borrow_reverse(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T1, T0>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg6));
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::sf_path::run_one_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v1, 1, borrow_minus_seed(v1, 1), v0, v0, arg12, arg13, arg14);
    }

    public entry fun sf_auto_reverse_n<T0, T1, T2>(arg0: &0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: address, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: u64, arg13: 0x2::coin::Coin<T1>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg12 > 0, 504);
        let v0 = calc_debt<T0>(arg1) / arg12;
        let v1 = est_borrow_reverse(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T1, T0>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg6)) + arg12;
        0x20d15073ad8a8b2b5118f6767971c337b63b515abf53c15c4410bde15f12c1d0::sf_path::run_multi_cycle_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v1, 1, borrow_minus_seed(v1, arg12), v0, v0, arg12, arg13, arg14, arg15);
    }

    // decompiled from Move bytecode v7
}

