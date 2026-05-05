module 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::sf_path {
    public entry fun run_multi_cycle<T0, T1, T2>(arg0: &0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: address, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: vector<0x2::coin::Coin<T0>>, arg13: 0x2::coin::Coin<T0>, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg19);
        assert!(arg17 > 0, 305);
        let v1 = 0x1::vector::length<0x2::coin::Coin<T0>>(&arg12);
        assert!(v1 > 0, 303);
        assert!(arg17 <= v1, 304);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg6, true, true, arg14, 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), 10000 + 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::push_bps()), arg18);
        let v5 = v4;
        let v6 = v2;
        assert!(0x2::balance::value<T0>(&v6) == 0, 306);
        0x2::balance::destroy_zero<T0>(v6);
        let v7 = 0x2::coin::from_balance<T1>(v3, arg19);
        assert!(0x2::coin::value<T1>(&v7) > 0, 302);
        let v8 = 0;
        while (v8 < arg17) {
            0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_only_base_safe<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::work_id_new(), 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::vec1<0x2::coin::Coin<T0>>(0x1::vector::remove<0x2::coin::Coin<T0>>(&mut arg12, 0)), arg16, arg15, 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::work_factor_max(), 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::strategy_add_base(), 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::special_params(arg16), arg10, arg11, arg8, 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::tolerance_test_value(), arg18, arg19);
            0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::kill_safe<T0, T1, T2>(v0, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1) + v8, arg10, arg11, arg8, 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::kill_tol_normal(), arg18, arg19);
            v8 = v8 + 1;
        };
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg12)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg12), v0);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg12);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        assert!(0x2::coin::value<T0>(&arg13) >= v9, 301);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg13, v9, arg19)), 0x2::balance::zero<T1>(), v5);
        if (0x2::coin::value<T0>(&arg13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg13, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg13);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, v0);
    }

    public entry fun run_one<T0, T1, T2>(arg0: &0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::auth::OwnerCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x1b089c63a8cfe583ba10a11258d5e83960e76a4c64adb37538cd2ac1546651af::fair_launch::Storage, arg3: &mut 0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::WorkerInfo<T0, T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: address, arg10: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg11: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg12: 0x2::coin::Coin<T0>, arg13: 0x2::coin::Coin<T0>, arg14: u64, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg18);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg6, true, true, arg14, 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::mul_bps_u128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), 10000 + 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::push_bps()), arg17);
        let v4 = v3;
        let v5 = v1;
        assert!(0x2::balance::value<T0>(&v5) == 0, 306);
        0x2::balance::destroy_zero<T0>(v5);
        let v6 = 0x2::coin::from_balance<T1>(v2, arg18);
        assert!(0x2::coin::value<T1>(&v6) > 0, 302);
        0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::work_only_base_safe<T0, T1, T2>(arg9, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::work_id_new(), 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::vec1<0x2::coin::Coin<T0>>(arg12), arg16, arg15, 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::work_factor_max(), 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::strategy_add_base(), 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::special_params(arg16), arg10, arg11, arg8, 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::tolerance_test_value(), arg17, arg18);
        0x71f8de86a9fa5f1e6bdba87dd1982e989f63d8d54e5a3b28601ac8de8b17724d::stable_farming_worker::kill_safe<T0, T1, T2>(v0, arg3, arg1, arg2, arg4, arg5, arg6, arg7, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::get_next_position_id<T0>(arg1), arg10, arg11, arg8, 0x2091e58322c2e236a2200e3bab806be5b1731d3d8912147b52ecd6a34122c425::common::kill_tol_normal(), arg17, arg18);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        assert!(0x2::coin::value<T0>(&arg13) >= v7, 301);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg13, v7, arg18)), 0x2::balance::zero<T1>(), v4);
        if (0x2::coin::value<T0>(&arg13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg13, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg13);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, v0);
    }

    // decompiled from Move bytecode v7
}

