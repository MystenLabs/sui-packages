module 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::sf_path {
    public entry fun run_multi_cycle<T0, T1, T2>(arg0: &0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: address, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: 0x2::coin::Coin<T1>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg20);
        assert!(arg17 > 0, 305);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg6, false, false, arg12, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::max_sqrt_price_limit(), arg19);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let v5 = 0x2::coin::from_balance<T0>(v1, arg20);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg6, true, true, arg14, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), 10000 - 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::push_bps()), arg19);
        let v9 = v8;
        let v10 = v6;
        assert!(0x2::balance::value<T0>(&v10) == 0, 306);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg20);
        assert!(0x2::coin::value<T1>(&v11) > 0, 302);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        let v13 = 0;
        while (v13 < arg17) {
            0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_single_safe<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_id_new(), 0x2::coin::split<T0>(&mut v5, arg13, arg20), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::split_surplus_share<T1>(&mut v11, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::reserve_keep_amount(v12, 0x2::coin::value<T1>(&arg18)), arg17 - v13, arg20), arg15, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_factor_max(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::strategy_add_two_sides(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::optimal_params(true, arg16), arg10, arg11, arg8, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::tolerance_test_value(), arg19, arg20);
            v13 = v13 + 1;
        };
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v14, 303);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v14, arg20)), 0x2::balance::zero<T1>(), v9);
        let v15 = 0;
        while (v15 < arg17) {
            0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_none_safe<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1) + v15, 0, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_factor_max(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::strategy_withdraw(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::settle_params(), arg10, arg11, arg8, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::settle_tolerance(), arg19, arg20);
            v15 = v15 + 1;
        };
        0x2::coin::join<T1>(&mut v11, arg18);
        assert!(0x2::coin::value<T1>(&v11) >= v12, 301);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v12, arg20)), v4);
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

    public entry fun run_multi_cycle_reverse<T0, T1, T2>(arg0: &0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: address, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: 0x2::coin::Coin<T1>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg20);
        assert!(arg17 > 0, 305);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg6, true, false, arg12, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::min_sqrt_price_limit(), arg19);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v1);
        let v5 = 0x2::coin::from_balance<T0>(v2, arg20);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg6, false, true, arg14, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg6), 10000 + 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::push_bps()), arg19);
        let v9 = v8;
        let v10 = v7;
        assert!(0x2::balance::value<T0>(&v10) == 0, 306);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v6, arg20);
        assert!(0x2::coin::value<T1>(&v11) > 0, 302);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        let v13 = 0;
        while (v13 < arg17) {
            0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_single_safe_reverse<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_id_new(), 0x2::coin::split<T0>(&mut v5, arg13, arg20), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::split_surplus_share<T1>(&mut v11, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::reserve_keep_amount(v12, 0x2::coin::value<T1>(&arg18)), arg17 - v13, arg20), arg15, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_factor_max(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::strategy_add_two_sides(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::optimal_params(true, arg16), arg10, arg11, arg8, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::tolerance_test_value(), arg19, arg20);
            v13 = v13 + 1;
        };
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v14, 303);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg6, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v14, arg20)), v9);
        let v15 = 0;
        while (v15 < arg17) {
            0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_none_safe_reverse<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1) + v15, 0, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_factor_max(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::strategy_withdraw(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::settle_params(), arg10, arg11, arg8, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::settle_tolerance(), arg19, arg20);
            v15 = v15 + 1;
        };
        0x2::coin::join<T1>(&mut v11, arg18);
        assert!(0x2::coin::value<T1>(&v11) >= v12, 301);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg6, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v12, arg20)), 0x2::balance::zero<T0>(), v4);
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

    public entry fun run_one<T0, T1, T2>(arg0: &0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: address, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: 0x2::coin::Coin<T1>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg19);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg6, false, false, arg12, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::max_sqrt_price_limit(), arg18);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let v5 = 0x2::coin::from_balance<T0>(v1, arg19);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg6, true, true, arg14, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), 10000 - 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::push_bps()), arg18);
        let v9 = v8;
        let v10 = v6;
        assert!(0x2::balance::value<T0>(&v10) == 0, 306);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v7, arg19);
        assert!(0x2::coin::value<T1>(&v11) > 0, 302);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_single_safe<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_id_new(), 0x2::coin::split<T0>(&mut v5, arg13, arg19), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::split_surplus<T1>(&mut v11, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::reserve_keep_amount(v12, 0x2::coin::value<T1>(&arg17)), arg19), arg15, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_factor_max(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::strategy_add_two_sides(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::optimal_params(true, arg16), arg10, arg11, arg8, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::tolerance_test_value(), arg18, arg19);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v13, 303);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v13, arg19)), 0x2::balance::zero<T1>(), v9);
        0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_none_safe<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_factor_max(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::strategy_withdraw(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::settle_params(), arg10, arg11, arg8, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::settle_tolerance(), arg18, arg19);
        0x2::coin::join<T1>(&mut v11, arg17);
        assert!(0x2::coin::value<T1>(&v11) >= v12, 301);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v12, arg19)), v4);
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

    public entry fun run_one_reverse<T0, T1, T2>(arg0: &0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: address, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: 0x2::coin::Coin<T1>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg19);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg6, true, false, arg12, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::min_sqrt_price_limit(), arg18);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v1);
        let v5 = 0x2::coin::from_balance<T0>(v2, arg19);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg6, false, true, arg14, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg6), 10000 + 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::push_bps()), arg18);
        let v9 = v8;
        let v10 = v7;
        assert!(0x2::balance::value<T0>(&v10) == 0, 306);
        0x2::balance::destroy_zero<T0>(v10);
        let v11 = 0x2::coin::from_balance<T1>(v6, arg19);
        assert!(0x2::coin::value<T1>(&v11) > 0, 302);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_single_safe_reverse<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_id_new(), 0x2::coin::split<T0>(&mut v5, arg13, arg19), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::split_surplus<T1>(&mut v11, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::reserve_keep_amount(v12, 0x2::coin::value<T1>(&arg17)), arg19), arg15, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_factor_max(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::strategy_add_two_sides(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::optimal_params(true, arg16), arg10, arg11, arg8, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::tolerance_test_value(), arg18, arg19);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v9);
        assert!(0x2::coin::value<T0>(&v5) >= v13, 303);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg6, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v13, arg19)), v9);
        0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_none_safe_reverse<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), 0, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::work_factor_max(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::strategy_withdraw(), 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::settle_params(), arg10, arg11, arg8, 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common::settle_tolerance(), arg18, arg19);
        0x2::coin::join<T1>(&mut v11, arg17);
        assert!(0x2::coin::value<T1>(&v11) >= v12, 301);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg6, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v12, arg19)), 0x2::balance::zero<T0>(), v4);
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

