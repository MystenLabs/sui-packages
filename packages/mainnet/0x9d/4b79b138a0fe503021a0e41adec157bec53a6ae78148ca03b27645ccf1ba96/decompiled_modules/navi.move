module 0x9d4b79b138a0fe503021a0e41adec157bec53a6ae78148ca03b27645ccf1ba96::navi {
    fun finish<T0>(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg2), 0x2::tx_context::sender(arg2));
        if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun sui_coll_ab<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg9: address, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, arg13, 79226673515401279992447579055, arg2);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, 0x2::sui::SUI>(arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg15);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::balance::value<T0>(&v6);
        if (v8 >= 1000) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, v8, 4295048016, arg2);
            let v12 = v11;
            0x2::balance::destroy_zero<T0>(v9);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::split<T0>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v12)), 0x2::balance::zero<0x2::sui::SUI>(), v12);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v10);
        };
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) >= v13 + arg14, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v7, v13), v3);
        finish<T0>(v7, v6, arg15);
    }

    public fun sui_coll_ba<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg9: address, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg0, arg1, true, false, arg13, 4295048016, arg2);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, 0x2::sui::SUI>(arg2, arg3, arg4, arg5, arg6, v1, arg7, arg8, arg9, arg10, arg11, arg12, arg15);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::balance::value<T0>(&v6);
        if (v8 >= 1000) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg0, arg1, false, true, v8, 79226673515401279992447579055, arg2);
            let v12 = v11;
            0x2::balance::destroy_zero<T0>(v10);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<T0>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v12)), v12);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v9);
        };
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) >= v13 + arg14, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v13), 0x2::balance::zero<T0>(), v3);
        finish<T0>(v7, v6, arg15);
    }

    // decompiled from Move bytecode v7
}

