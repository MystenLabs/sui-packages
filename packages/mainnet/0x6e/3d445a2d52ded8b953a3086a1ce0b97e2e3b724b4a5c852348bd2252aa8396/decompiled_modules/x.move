module 0x6e3d445a2d52ded8b953a3086a1ce0b97e2e3b724b4a5c852348bd2252aa8396::x {
    public fun AAA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg14, 4295048017, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T3, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T3>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048017, arg13);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v11), 4295048017, arg13);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        if (0x2::coin::value<T3>(&v7) == 0) {
            0x2::coin::destroy_zero<T3>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T2>(&v15) < v16) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 14876365023445144158, 9223395354232225791);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AA_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, false, arg13, 4295048017, arg12);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v1, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048017, arg12);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3)), 0x2::balance::zero<T2>(), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223388757162459135);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AAa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg14, 79226673515401279992447579054, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048017, arg13);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T3>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v11), 4295048017, arg13);
        let v15 = v13;
        0x2::balance::destroy_zero<T1>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T3>(arg0, arg2, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T3>(&v15) < v16) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 14876365023445144158, 9223395014929809407);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AC_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg13, arg1, arg3, true, false, arg14, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::coin::value<T0>(&v6), 4295048017, arg13);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg3, 0x2::balance::split<T1>(&mut v11, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3)), 0x2::balance::zero<T2>(), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223390062832517119);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun A__<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0x2::clock::Clock, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg12 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg3)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg8, arg9, arg10, arg3, arg4, arg5, arg6, arg11, arg13);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg12, 4295048017, arg11);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg2, arg3, arg4, 0x2::coin::from_balance<T1>(v1, arg13), arg5, arg6, arg11, arg13);
        let v6 = v5;
        let v7 = v4;
        if (0x2::coin::value<T1>(&v7) == 0) {
            0x2::coin::destroy_zero<T1>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg13));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14876365023445144158, 9223386948981227519);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AaA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg14, 4295048017, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T3, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T3>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048017, arg13);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054, arg13);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        if (0x2::coin::value<T3>(&v7) == 0) {
            0x2::coin::destroy_zero<T3>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T2>(&v15) < v16) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 14876365023445144158, 9223394675627393023);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Aa_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, false, arg13, 79226673515401279992447579054, arg12);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v0, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048017, arg12);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v3)), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223388439334879231);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Aaa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg14, 79226673515401279992447579054, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048017, arg13);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579054, arg13);
        let v15 = v12;
        0x2::balance::destroy_zero<T1>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T1>(arg0, arg2, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T3>(&v15) < v16) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 14876365023445144158, 9223394336324976639);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Ac_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg13, arg1, arg3, false, false, arg14, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::coin::value<T0>(&v6), 4295048017, arg13);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3)), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223389736415002623);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CA_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, true, false, arg14, 4295048017, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg1, arg2, true, true, 0x2::coin::value<T0>(&v6), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, 0x2::balance::split<T1>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3)), 0x2::balance::zero<T2>(), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223391368502575103);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CC_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg12, arg0, arg2, true, false, arg13, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v1, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v11, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3)), 0x2::balance::zero<T2>(), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223392639812894719);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun C__<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0x2::clock::Clock, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg12 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg3)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg8, arg9, arg10, arg3, arg4, arg5, arg6, arg11, arg13);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg11, arg0, arg1, true, false, arg12, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg2, arg3, arg4, 0x2::coin::from_balance<T1>(v1, arg13), arg5, arg6, arg11, arg13);
        let v6 = v5;
        let v7 = v4;
        if (0x2::coin::value<T1>(&v7) == 0) {
            0x2::coin::destroy_zero<T1>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v6), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg13));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14876365023445144158, 9223387490147106815);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Ca_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, arg14, 79226673515401279992447579054, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg1, arg2, true, true, 0x2::coin::value<T0>(&v6), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v3)), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223391042085060607);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Cc_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg12, arg0, arg2, false, false, arg13, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v0, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3)), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223392321985314815);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aAA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg14, 4295048017, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T3, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T3>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054, arg13);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v11), 4295048017, arg13);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg2, v11, 0x2::balance::zero<T2>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        if (0x2::coin::value<T3>(&v7) == 0) {
            0x2::coin::destroy_zero<T3>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T2>(&v15) < v16) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 14876365023445144158, 9223393997022560255);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aA_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, true, false, arg13, 4295048017, arg12);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v1, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054, arg12);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::split<T0>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v3)), 0x2::balance::zero<T2>(), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223388121507299327);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aAa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg14, 79226673515401279992447579054, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054, arg13);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T3>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v11), 4295048017, arg13);
        let v15 = v13;
        0x2::balance::destroy_zero<T0>(v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T3>(arg0, arg2, v11, 0x2::balance::zero<T3>(), v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T3>(&v15) < v16) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 14876365023445144158, 9223393657720143871);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aC_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg13, arg1, arg3, true, false, arg14, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054, arg13);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg1, arg3, 0x2::balance::split<T0>(&mut v11, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T2>(&v3)), 0x2::balance::zero<T2>(), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223389409997488127);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun a__<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0x2::clock::Clock, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg12 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg3)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg8, arg9, arg10, arg3, arg4, arg5, arg6, arg11, arg13);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, false, arg12, 79226673515401279992447579054, arg11);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg2, arg3, arg4, 0x2::coin::from_balance<T0>(v0, arg13), arg5, arg6, arg11, arg13);
        let v6 = v5;
        let v7 = v4;
        if (0x2::coin::value<T0>(&v7) == 0) {
            0x2::coin::destroy_zero<T0>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut v6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg13));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14876365023445144158, 9223386678398287871);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aaA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg14, 4295048017, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T3, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T3>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054, arg13);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054, arg13);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        if (0x2::coin::value<T3>(&v7) == 0) {
            0x2::coin::destroy_zero<T3>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T2>(&v15) < v16) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::split<T2>(&mut v15, v16), 0x2::balance::zero<T3>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 14876365023445144158, 9223393318417727487);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aa_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, false, false, arg13, 79226673515401279992447579054, arg12);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v0, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054, arg12);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v3)), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223387803679719423);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aaa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg14, 79226673515401279992447579054, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054, arg13);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T0>(arg0, arg2, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579054, arg13);
        let v15 = v12;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T0>(arg0, arg2, 0x2::balance::zero<T3>(), v11, v14);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v3);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T3>(&v15) < v16) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut v15, v16), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 14876365023445144158, 9223392979115311103);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ac_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg13, arg1, arg3, false, false, arg14, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054, arg13);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg1, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T0>(&v3)), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223389083579973631);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun b<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg13), arg13);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223372517891112959);
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v8 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v8, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v8, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v9 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v9, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v9, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v10, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v10, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v11, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v11, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v12, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v12, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v13, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v13, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v14, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v14, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v15, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v15, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v16, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v16, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v17, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v17, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v18, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v18, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v19, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v19, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v20, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v20, arg13);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg13);
        let (v21, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg13);
        let v23 = v21;
        if (arg12 < v21) {
            v23 = arg12;
        };
        v23
    }

    public fun c<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg14), arg14);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223373467078885375);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v9 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v9, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v9, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v10, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v10, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v11, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v11, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v12, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v12, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v13, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v13, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v14, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v14, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v15, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v15, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v16, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v16, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v17, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v17, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v18, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v18, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v19, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v19, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v20, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v20, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v8 = arg12;
            } else {
                v8 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v21, arg2, v8, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v21, arg14);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg14);
        let (v22, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg14);
        let v24 = v22;
        if (arg13 < v22) {
            v24 = arg13;
        };
        v24
    }

    public fun cA_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg3, true, false, arg14, 4295048017, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg1, arg2, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg3, 0x2::balance::split<T0>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v3)), 0x2::balance::zero<T2>(), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223390715667546111);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cC_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg12, arg0, arg2, true, false, arg13, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v1, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::split<T0>(&mut v11, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T2>(&v3)), 0x2::balance::zero<T2>(), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223392004157734911);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun c__<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0x2::clock::Clock, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg12 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg3)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg8, arg9, arg10, arg3, arg4, arg5, arg6, arg11, arg13);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg11, arg0, arg1, false, false, arg12, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg2, arg3, arg4, 0x2::coin::from_balance<T0>(v0, arg13), arg5, arg6, arg11, arg13);
        let v6 = v5;
        let v7 = v4;
        if (0x2::coin::value<T0>(&v7) == 0) {
            0x2::coin::destroy_zero<T0>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut v6), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg13));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 14876365023445144158, 9223387219564167167);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ca_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg3, false, false, arg14, 79226673515401279992447579054, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg1, arg2, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v3)), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223390389250031615);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cc_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg12, arg0, arg2, false, false, arg13, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v0, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T0>(&v3)), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 14876365023445144158, 9223391686330155007);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun d<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg15), arg15);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223374446331428863);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v9 == 1) {
                v8 = arg12;
            } else if (v9 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v11 == 1) {
                v8 = arg12;
            } else if (v11 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v12, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v12, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v13 == 1) {
                v8 = arg12;
            } else if (v13 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v14, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v14, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v15 == 1) {
                v8 = arg12;
            } else if (v15 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v16, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v16, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v17 == 1) {
                v8 = arg12;
            } else if (v17 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v18, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v18, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v19 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v19 == 1) {
                v8 = arg12;
            } else if (v19 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v20, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v20, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v21 == 1) {
                v8 = arg12;
            } else if (v21 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v22, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v22, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v23 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v23 == 1) {
                v8 = arg12;
            } else if (v23 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v24, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v24, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v25 == 1) {
                v8 = arg12;
            } else if (v25 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v26, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v26, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v27 == 1) {
                v8 = arg12;
            } else if (v27 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v28, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v28, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v29 == 1) {
                v8 = arg12;
            } else if (v29 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v30 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v30, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v30, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v31 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v31 == 1) {
                v8 = arg12;
            } else if (v31 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v32, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v32, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v33 == 1) {
                v8 = arg12;
            } else if (v33 == 2) {
                v8 = arg13;
            } else {
                v8 = arg11;
            };
            let v34 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v34, arg2, v8, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v34, arg15);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg15);
        let (v35, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg15);
        let v37 = v35;
        if (arg14 < v35) {
            v37 = arg14;
        };
        v37
    }

    public fun e<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg16), arg16);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223375455648743423);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v9 == 1) {
                v8 = arg12;
            } else if (v9 == 2) {
                v8 = arg13;
            } else if (v9 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v11 == 1) {
                v8 = arg12;
            } else if (v11 == 2) {
                v8 = arg13;
            } else if (v11 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v12, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v12, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v13 == 1) {
                v8 = arg12;
            } else if (v13 == 2) {
                v8 = arg13;
            } else if (v13 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v14, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v14, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v15 == 1) {
                v8 = arg12;
            } else if (v15 == 2) {
                v8 = arg13;
            } else if (v15 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v16, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v16, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v17 == 1) {
                v8 = arg12;
            } else if (v17 == 2) {
                v8 = arg13;
            } else if (v17 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v18, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v18, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v19 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v19 == 1) {
                v8 = arg12;
            } else if (v19 == 2) {
                v8 = arg13;
            } else if (v19 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v20, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v20, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v21 == 1) {
                v8 = arg12;
            } else if (v21 == 2) {
                v8 = arg13;
            } else if (v21 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v22, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v22, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v23 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v23 == 1) {
                v8 = arg12;
            } else if (v23 == 2) {
                v8 = arg13;
            } else if (v23 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v24, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v24, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v25 == 1) {
                v8 = arg12;
            } else if (v25 == 2) {
                v8 = arg13;
            } else if (v25 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v26, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v26, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v27 == 1) {
                v8 = arg12;
            } else if (v27 == 2) {
                v8 = arg13;
            } else if (v27 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v28, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v28, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v29 == 1) {
                v8 = arg12;
            } else if (v29 == 2) {
                v8 = arg13;
            } else if (v29 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v30 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v30, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v30, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v31 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v31 == 1) {
                v8 = arg12;
            } else if (v31 == 2) {
                v8 = arg13;
            } else if (v31 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v32, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v32, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v33 == 1) {
                v8 = arg12;
            } else if (v33 == 2) {
                v8 = arg13;
            } else if (v33 == 3) {
                v8 = arg14;
            } else {
                v8 = arg11;
            };
            let v34 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v34, arg2, v8, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v34, arg16);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg16);
        let (v35, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg16);
        let v37 = v35;
        if (arg15 < v35) {
            v37 = arg15;
        };
        v37
    }

    public fun f<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg17), arg17);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223376495030829055);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v9 == 1) {
                v8 = arg12;
            } else if (v9 == 2) {
                v8 = arg13;
            } else if (v9 == 3) {
                v8 = arg14;
            } else if (v9 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v11 == 1) {
                v8 = arg12;
            } else if (v11 == 2) {
                v8 = arg13;
            } else if (v11 == 3) {
                v8 = arg14;
            } else if (v11 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v12, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v12, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v13 == 1) {
                v8 = arg12;
            } else if (v13 == 2) {
                v8 = arg13;
            } else if (v13 == 3) {
                v8 = arg14;
            } else if (v13 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v14, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v14, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v15 == 1) {
                v8 = arg12;
            } else if (v15 == 2) {
                v8 = arg13;
            } else if (v15 == 3) {
                v8 = arg14;
            } else if (v15 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v16, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v16, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v17 == 1) {
                v8 = arg12;
            } else if (v17 == 2) {
                v8 = arg13;
            } else if (v17 == 3) {
                v8 = arg14;
            } else if (v17 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v18, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v18, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v19 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v19 == 1) {
                v8 = arg12;
            } else if (v19 == 2) {
                v8 = arg13;
            } else if (v19 == 3) {
                v8 = arg14;
            } else if (v19 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v20, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v20, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v21 == 1) {
                v8 = arg12;
            } else if (v21 == 2) {
                v8 = arg13;
            } else if (v21 == 3) {
                v8 = arg14;
            } else if (v21 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v22, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v22, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v23 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v23 == 1) {
                v8 = arg12;
            } else if (v23 == 2) {
                v8 = arg13;
            } else if (v23 == 3) {
                v8 = arg14;
            } else if (v23 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v24, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v24, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v25 == 1) {
                v8 = arg12;
            } else if (v25 == 2) {
                v8 = arg13;
            } else if (v25 == 3) {
                v8 = arg14;
            } else if (v25 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v26, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v26, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v27 == 1) {
                v8 = arg12;
            } else if (v27 == 2) {
                v8 = arg13;
            } else if (v27 == 3) {
                v8 = arg14;
            } else if (v27 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v28, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v28, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v29 == 1) {
                v8 = arg12;
            } else if (v29 == 2) {
                v8 = arg13;
            } else if (v29 == 3) {
                v8 = arg14;
            } else if (v29 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v30 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v30, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v30, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v31 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v31 == 1) {
                v8 = arg12;
            } else if (v31 == 2) {
                v8 = arg13;
            } else if (v31 == 3) {
                v8 = arg14;
            } else if (v31 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v32, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v32, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v33 == 1) {
                v8 = arg12;
            } else if (v33 == 2) {
                v8 = arg13;
            } else if (v33 == 3) {
                v8 = arg14;
            } else if (v33 == 4) {
                v8 = arg15;
            } else {
                v8 = arg11;
            };
            let v34 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v34, arg2, v8, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v34, arg17);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg17);
        let (v35, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg17);
        let v37 = v35;
        if (arg16 < v35) {
            v37 = arg16;
        };
        v37
    }

    public fun g<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg18), arg18);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223377564477685759);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v9 == 1) {
                v8 = arg12;
            } else if (v9 == 2) {
                v8 = arg13;
            } else if (v9 == 3) {
                v8 = arg14;
            } else if (v9 == 4) {
                v8 = arg15;
            } else if (v9 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v11 == 1) {
                v8 = arg12;
            } else if (v11 == 2) {
                v8 = arg13;
            } else if (v11 == 3) {
                v8 = arg14;
            } else if (v11 == 4) {
                v8 = arg15;
            } else if (v11 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v12, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v12, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v13 == 1) {
                v8 = arg12;
            } else if (v13 == 2) {
                v8 = arg13;
            } else if (v13 == 3) {
                v8 = arg14;
            } else if (v13 == 4) {
                v8 = arg15;
            } else if (v13 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v14, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v14, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v15 == 1) {
                v8 = arg12;
            } else if (v15 == 2) {
                v8 = arg13;
            } else if (v15 == 3) {
                v8 = arg14;
            } else if (v15 == 4) {
                v8 = arg15;
            } else if (v15 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v16, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v16, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v17 == 1) {
                v8 = arg12;
            } else if (v17 == 2) {
                v8 = arg13;
            } else if (v17 == 3) {
                v8 = arg14;
            } else if (v17 == 4) {
                v8 = arg15;
            } else if (v17 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v18, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v18, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v19 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v19 == 1) {
                v8 = arg12;
            } else if (v19 == 2) {
                v8 = arg13;
            } else if (v19 == 3) {
                v8 = arg14;
            } else if (v19 == 4) {
                v8 = arg15;
            } else if (v19 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v20, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v20, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v21 == 1) {
                v8 = arg12;
            } else if (v21 == 2) {
                v8 = arg13;
            } else if (v21 == 3) {
                v8 = arg14;
            } else if (v21 == 4) {
                v8 = arg15;
            } else if (v21 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v22, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v22, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v23 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v23 == 1) {
                v8 = arg12;
            } else if (v23 == 2) {
                v8 = arg13;
            } else if (v23 == 3) {
                v8 = arg14;
            } else if (v23 == 4) {
                v8 = arg15;
            } else if (v23 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v24, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v24, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v25 == 1) {
                v8 = arg12;
            } else if (v25 == 2) {
                v8 = arg13;
            } else if (v25 == 3) {
                v8 = arg14;
            } else if (v25 == 4) {
                v8 = arg15;
            } else if (v25 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v26, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v26, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v27 == 1) {
                v8 = arg12;
            } else if (v27 == 2) {
                v8 = arg13;
            } else if (v27 == 3) {
                v8 = arg14;
            } else if (v27 == 4) {
                v8 = arg15;
            } else if (v27 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v28, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v28, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v29 == 1) {
                v8 = arg12;
            } else if (v29 == 2) {
                v8 = arg13;
            } else if (v29 == 3) {
                v8 = arg14;
            } else if (v29 == 4) {
                v8 = arg15;
            } else if (v29 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v30 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v30, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v30, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v31 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v31 == 1) {
                v8 = arg12;
            } else if (v31 == 2) {
                v8 = arg13;
            } else if (v31 == 3) {
                v8 = arg14;
            } else if (v31 == 4) {
                v8 = arg15;
            } else if (v31 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v32, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v32, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v33 == 1) {
                v8 = arg12;
            } else if (v33 == 2) {
                v8 = arg13;
            } else if (v33 == 3) {
                v8 = arg14;
            } else if (v33 == 4) {
                v8 = arg15;
            } else if (v33 == 5) {
                v8 = arg16;
            } else {
                v8 = arg11;
            };
            let v34 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v34, arg2, v8, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v34, arg18);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg18);
        let (v35, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg18);
        let v37 = v35;
        if (arg17 < v35) {
            v37 = arg17;
        };
        v37
    }

    public fun h<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg19), arg19);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg20));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223378663989313535);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v9 == 1) {
                v8 = arg12;
            } else if (v9 == 2) {
                v8 = arg13;
            } else if (v9 == 3) {
                v8 = arg14;
            } else if (v9 == 4) {
                v8 = arg15;
            } else if (v9 == 5) {
                v8 = arg16;
            } else if (v9 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v11 == 1) {
                v8 = arg12;
            } else if (v11 == 2) {
                v8 = arg13;
            } else if (v11 == 3) {
                v8 = arg14;
            } else if (v11 == 4) {
                v8 = arg15;
            } else if (v11 == 5) {
                v8 = arg16;
            } else if (v11 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v12, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v12, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v13 == 1) {
                v8 = arg12;
            } else if (v13 == 2) {
                v8 = arg13;
            } else if (v13 == 3) {
                v8 = arg14;
            } else if (v13 == 4) {
                v8 = arg15;
            } else if (v13 == 5) {
                v8 = arg16;
            } else if (v13 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v14, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v14, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v15 == 1) {
                v8 = arg12;
            } else if (v15 == 2) {
                v8 = arg13;
            } else if (v15 == 3) {
                v8 = arg14;
            } else if (v15 == 4) {
                v8 = arg15;
            } else if (v15 == 5) {
                v8 = arg16;
            } else if (v15 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v16, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v16, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v17 == 1) {
                v8 = arg12;
            } else if (v17 == 2) {
                v8 = arg13;
            } else if (v17 == 3) {
                v8 = arg14;
            } else if (v17 == 4) {
                v8 = arg15;
            } else if (v17 == 5) {
                v8 = arg16;
            } else if (v17 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v18, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v18, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v19 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v19 == 1) {
                v8 = arg12;
            } else if (v19 == 2) {
                v8 = arg13;
            } else if (v19 == 3) {
                v8 = arg14;
            } else if (v19 == 4) {
                v8 = arg15;
            } else if (v19 == 5) {
                v8 = arg16;
            } else if (v19 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v20, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v20, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v21 == 1) {
                v8 = arg12;
            } else if (v21 == 2) {
                v8 = arg13;
            } else if (v21 == 3) {
                v8 = arg14;
            } else if (v21 == 4) {
                v8 = arg15;
            } else if (v21 == 5) {
                v8 = arg16;
            } else if (v21 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v22, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v22, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v23 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v23 == 1) {
                v8 = arg12;
            } else if (v23 == 2) {
                v8 = arg13;
            } else if (v23 == 3) {
                v8 = arg14;
            } else if (v23 == 4) {
                v8 = arg15;
            } else if (v23 == 5) {
                v8 = arg16;
            } else if (v23 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v24, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v24, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v25 == 1) {
                v8 = arg12;
            } else if (v25 == 2) {
                v8 = arg13;
            } else if (v25 == 3) {
                v8 = arg14;
            } else if (v25 == 4) {
                v8 = arg15;
            } else if (v25 == 5) {
                v8 = arg16;
            } else if (v25 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v26, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v26, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v27 == 1) {
                v8 = arg12;
            } else if (v27 == 2) {
                v8 = arg13;
            } else if (v27 == 3) {
                v8 = arg14;
            } else if (v27 == 4) {
                v8 = arg15;
            } else if (v27 == 5) {
                v8 = arg16;
            } else if (v27 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v28, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v28, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v29 == 1) {
                v8 = arg12;
            } else if (v29 == 2) {
                v8 = arg13;
            } else if (v29 == 3) {
                v8 = arg14;
            } else if (v29 == 4) {
                v8 = arg15;
            } else if (v29 == 5) {
                v8 = arg16;
            } else if (v29 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v30 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v30, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v30, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v31 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v31 == 1) {
                v8 = arg12;
            } else if (v31 == 2) {
                v8 = arg13;
            } else if (v31 == 3) {
                v8 = arg14;
            } else if (v31 == 4) {
                v8 = arg15;
            } else if (v31 == 5) {
                v8 = arg16;
            } else if (v31 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v32, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v32, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v33 == 1) {
                v8 = arg12;
            } else if (v33 == 2) {
                v8 = arg13;
            } else if (v33 == 3) {
                v8 = arg14;
            } else if (v33 == 4) {
                v8 = arg15;
            } else if (v33 == 5) {
                v8 = arg16;
            } else if (v33 == 6) {
                v8 = arg17;
            } else {
                v8 = arg11;
            };
            let v34 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v34, arg2, v8, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v34, arg19);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg19);
        let (v35, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg19);
        let v37 = v35;
        if (arg18 < v35) {
            v37 = arg18;
        };
        v37
    }

    public fun i<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg20), arg20);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg21));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223379793565712383);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v9 == 1) {
                v8 = arg12;
            } else if (v9 == 2) {
                v8 = arg13;
            } else if (v9 == 3) {
                v8 = arg14;
            } else if (v9 == 4) {
                v8 = arg15;
            } else if (v9 == 5) {
                v8 = arg16;
            } else if (v9 == 6) {
                v8 = arg17;
            } else if (v9 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v11 == 1) {
                v8 = arg12;
            } else if (v11 == 2) {
                v8 = arg13;
            } else if (v11 == 3) {
                v8 = arg14;
            } else if (v11 == 4) {
                v8 = arg15;
            } else if (v11 == 5) {
                v8 = arg16;
            } else if (v11 == 6) {
                v8 = arg17;
            } else if (v11 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v12, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v12, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v13 == 1) {
                v8 = arg12;
            } else if (v13 == 2) {
                v8 = arg13;
            } else if (v13 == 3) {
                v8 = arg14;
            } else if (v13 == 4) {
                v8 = arg15;
            } else if (v13 == 5) {
                v8 = arg16;
            } else if (v13 == 6) {
                v8 = arg17;
            } else if (v13 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v14, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v14, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v15 == 1) {
                v8 = arg12;
            } else if (v15 == 2) {
                v8 = arg13;
            } else if (v15 == 3) {
                v8 = arg14;
            } else if (v15 == 4) {
                v8 = arg15;
            } else if (v15 == 5) {
                v8 = arg16;
            } else if (v15 == 6) {
                v8 = arg17;
            } else if (v15 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v16, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v16, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v17 == 1) {
                v8 = arg12;
            } else if (v17 == 2) {
                v8 = arg13;
            } else if (v17 == 3) {
                v8 = arg14;
            } else if (v17 == 4) {
                v8 = arg15;
            } else if (v17 == 5) {
                v8 = arg16;
            } else if (v17 == 6) {
                v8 = arg17;
            } else if (v17 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v18, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v18, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v19 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v19 == 1) {
                v8 = arg12;
            } else if (v19 == 2) {
                v8 = arg13;
            } else if (v19 == 3) {
                v8 = arg14;
            } else if (v19 == 4) {
                v8 = arg15;
            } else if (v19 == 5) {
                v8 = arg16;
            } else if (v19 == 6) {
                v8 = arg17;
            } else if (v19 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v20, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v20, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v21 == 1) {
                v8 = arg12;
            } else if (v21 == 2) {
                v8 = arg13;
            } else if (v21 == 3) {
                v8 = arg14;
            } else if (v21 == 4) {
                v8 = arg15;
            } else if (v21 == 5) {
                v8 = arg16;
            } else if (v21 == 6) {
                v8 = arg17;
            } else if (v21 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v22, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v22, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v23 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v23 == 1) {
                v8 = arg12;
            } else if (v23 == 2) {
                v8 = arg13;
            } else if (v23 == 3) {
                v8 = arg14;
            } else if (v23 == 4) {
                v8 = arg15;
            } else if (v23 == 5) {
                v8 = arg16;
            } else if (v23 == 6) {
                v8 = arg17;
            } else if (v23 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v24, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v24, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v25 == 1) {
                v8 = arg12;
            } else if (v25 == 2) {
                v8 = arg13;
            } else if (v25 == 3) {
                v8 = arg14;
            } else if (v25 == 4) {
                v8 = arg15;
            } else if (v25 == 5) {
                v8 = arg16;
            } else if (v25 == 6) {
                v8 = arg17;
            } else if (v25 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v26, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v26, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v27 == 1) {
                v8 = arg12;
            } else if (v27 == 2) {
                v8 = arg13;
            } else if (v27 == 3) {
                v8 = arg14;
            } else if (v27 == 4) {
                v8 = arg15;
            } else if (v27 == 5) {
                v8 = arg16;
            } else if (v27 == 6) {
                v8 = arg17;
            } else if (v27 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v28, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v28, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v29 == 1) {
                v8 = arg12;
            } else if (v29 == 2) {
                v8 = arg13;
            } else if (v29 == 3) {
                v8 = arg14;
            } else if (v29 == 4) {
                v8 = arg15;
            } else if (v29 == 5) {
                v8 = arg16;
            } else if (v29 == 6) {
                v8 = arg17;
            } else if (v29 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v30 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v30, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v30, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v31 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v31 == 1) {
                v8 = arg12;
            } else if (v31 == 2) {
                v8 = arg13;
            } else if (v31 == 3) {
                v8 = arg14;
            } else if (v31 == 4) {
                v8 = arg15;
            } else if (v31 == 5) {
                v8 = arg16;
            } else if (v31 == 6) {
                v8 = arg17;
            } else if (v31 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v32, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v32, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v33 == 1) {
                v8 = arg12;
            } else if (v33 == 2) {
                v8 = arg13;
            } else if (v33 == 3) {
                v8 = arg14;
            } else if (v33 == 4) {
                v8 = arg15;
            } else if (v33 == 5) {
                v8 = arg16;
            } else if (v33 == 6) {
                v8 = arg17;
            } else if (v33 == 7) {
                v8 = arg18;
            } else {
                v8 = arg11;
            };
            let v34 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v34, arg2, v8, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v34, arg20);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg20);
        let (v35, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg20);
        let v37 = v35;
        if (arg19 < v35) {
            v37 = arg19;
        };
        v37
    }

    public fun j<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg21), arg21);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg22));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223380953206882303);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v9 == 1) {
                v8 = arg12;
            } else if (v9 == 2) {
                v8 = arg13;
            } else if (v9 == 3) {
                v8 = arg14;
            } else if (v9 == 4) {
                v8 = arg15;
            } else if (v9 == 5) {
                v8 = arg16;
            } else if (v9 == 6) {
                v8 = arg17;
            } else if (v9 == 7) {
                v8 = arg18;
            } else if (v9 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v11 == 1) {
                v8 = arg12;
            } else if (v11 == 2) {
                v8 = arg13;
            } else if (v11 == 3) {
                v8 = arg14;
            } else if (v11 == 4) {
                v8 = arg15;
            } else if (v11 == 5) {
                v8 = arg16;
            } else if (v11 == 6) {
                v8 = arg17;
            } else if (v11 == 7) {
                v8 = arg18;
            } else if (v11 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v12, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v12, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v13 == 1) {
                v8 = arg12;
            } else if (v13 == 2) {
                v8 = arg13;
            } else if (v13 == 3) {
                v8 = arg14;
            } else if (v13 == 4) {
                v8 = arg15;
            } else if (v13 == 5) {
                v8 = arg16;
            } else if (v13 == 6) {
                v8 = arg17;
            } else if (v13 == 7) {
                v8 = arg18;
            } else if (v13 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v14, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v14, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v15 == 1) {
                v8 = arg12;
            } else if (v15 == 2) {
                v8 = arg13;
            } else if (v15 == 3) {
                v8 = arg14;
            } else if (v15 == 4) {
                v8 = arg15;
            } else if (v15 == 5) {
                v8 = arg16;
            } else if (v15 == 6) {
                v8 = arg17;
            } else if (v15 == 7) {
                v8 = arg18;
            } else if (v15 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v16, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v16, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v17 == 1) {
                v8 = arg12;
            } else if (v17 == 2) {
                v8 = arg13;
            } else if (v17 == 3) {
                v8 = arg14;
            } else if (v17 == 4) {
                v8 = arg15;
            } else if (v17 == 5) {
                v8 = arg16;
            } else if (v17 == 6) {
                v8 = arg17;
            } else if (v17 == 7) {
                v8 = arg18;
            } else if (v17 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v18, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v18, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v19 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v19 == 1) {
                v8 = arg12;
            } else if (v19 == 2) {
                v8 = arg13;
            } else if (v19 == 3) {
                v8 = arg14;
            } else if (v19 == 4) {
                v8 = arg15;
            } else if (v19 == 5) {
                v8 = arg16;
            } else if (v19 == 6) {
                v8 = arg17;
            } else if (v19 == 7) {
                v8 = arg18;
            } else if (v19 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v20, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v20, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v21 == 1) {
                v8 = arg12;
            } else if (v21 == 2) {
                v8 = arg13;
            } else if (v21 == 3) {
                v8 = arg14;
            } else if (v21 == 4) {
                v8 = arg15;
            } else if (v21 == 5) {
                v8 = arg16;
            } else if (v21 == 6) {
                v8 = arg17;
            } else if (v21 == 7) {
                v8 = arg18;
            } else if (v21 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v22, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v22, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v23 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v23 == 1) {
                v8 = arg12;
            } else if (v23 == 2) {
                v8 = arg13;
            } else if (v23 == 3) {
                v8 = arg14;
            } else if (v23 == 4) {
                v8 = arg15;
            } else if (v23 == 5) {
                v8 = arg16;
            } else if (v23 == 6) {
                v8 = arg17;
            } else if (v23 == 7) {
                v8 = arg18;
            } else if (v23 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v24, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v24, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v25 == 1) {
                v8 = arg12;
            } else if (v25 == 2) {
                v8 = arg13;
            } else if (v25 == 3) {
                v8 = arg14;
            } else if (v25 == 4) {
                v8 = arg15;
            } else if (v25 == 5) {
                v8 = arg16;
            } else if (v25 == 6) {
                v8 = arg17;
            } else if (v25 == 7) {
                v8 = arg18;
            } else if (v25 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v26, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v26, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v27 == 1) {
                v8 = arg12;
            } else if (v27 == 2) {
                v8 = arg13;
            } else if (v27 == 3) {
                v8 = arg14;
            } else if (v27 == 4) {
                v8 = arg15;
            } else if (v27 == 5) {
                v8 = arg16;
            } else if (v27 == 6) {
                v8 = arg17;
            } else if (v27 == 7) {
                v8 = arg18;
            } else if (v27 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v28, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v28, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v29 == 1) {
                v8 = arg12;
            } else if (v29 == 2) {
                v8 = arg13;
            } else if (v29 == 3) {
                v8 = arg14;
            } else if (v29 == 4) {
                v8 = arg15;
            } else if (v29 == 5) {
                v8 = arg16;
            } else if (v29 == 6) {
                v8 = arg17;
            } else if (v29 == 7) {
                v8 = arg18;
            } else if (v29 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v30 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v30, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v30, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v31 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v31 == 1) {
                v8 = arg12;
            } else if (v31 == 2) {
                v8 = arg13;
            } else if (v31 == 3) {
                v8 = arg14;
            } else if (v31 == 4) {
                v8 = arg15;
            } else if (v31 == 5) {
                v8 = arg16;
            } else if (v31 == 6) {
                v8 = arg17;
            } else if (v31 == 7) {
                v8 = arg18;
            } else if (v31 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v32, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v32, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v33 == 1) {
                v8 = arg12;
            } else if (v33 == 2) {
                v8 = arg13;
            } else if (v33 == 3) {
                v8 = arg14;
            } else if (v33 == 4) {
                v8 = arg15;
            } else if (v33 == 5) {
                v8 = arg16;
            } else if (v33 == 6) {
                v8 = arg17;
            } else if (v33 == 7) {
                v8 = arg18;
            } else if (v33 == 8) {
                v8 = arg19;
            } else {
                v8 = arg11;
            };
            let v34 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v34, arg2, v8, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v34, arg21);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg21);
        let (v35, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg21);
        let v37 = v35;
        if (arg20 < v35) {
            v37 = arg20;
        };
        v37
    }

    public fun k<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg22), arg22);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg23));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223382142912823295);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v9 == 1) {
                v8 = arg12;
            } else if (v9 == 2) {
                v8 = arg13;
            } else if (v9 == 3) {
                v8 = arg14;
            } else if (v9 == 4) {
                v8 = arg15;
            } else if (v9 == 5) {
                v8 = arg16;
            } else if (v9 == 6) {
                v8 = arg17;
            } else if (v9 == 7) {
                v8 = arg18;
            } else if (v9 == 8) {
                v8 = arg19;
            } else if (v9 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v11 == 1) {
                v8 = arg12;
            } else if (v11 == 2) {
                v8 = arg13;
            } else if (v11 == 3) {
                v8 = arg14;
            } else if (v11 == 4) {
                v8 = arg15;
            } else if (v11 == 5) {
                v8 = arg16;
            } else if (v11 == 6) {
                v8 = arg17;
            } else if (v11 == 7) {
                v8 = arg18;
            } else if (v11 == 8) {
                v8 = arg19;
            } else if (v11 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v12, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v12, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v13 == 1) {
                v8 = arg12;
            } else if (v13 == 2) {
                v8 = arg13;
            } else if (v13 == 3) {
                v8 = arg14;
            } else if (v13 == 4) {
                v8 = arg15;
            } else if (v13 == 5) {
                v8 = arg16;
            } else if (v13 == 6) {
                v8 = arg17;
            } else if (v13 == 7) {
                v8 = arg18;
            } else if (v13 == 8) {
                v8 = arg19;
            } else if (v13 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v14, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v14, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v15 == 1) {
                v8 = arg12;
            } else if (v15 == 2) {
                v8 = arg13;
            } else if (v15 == 3) {
                v8 = arg14;
            } else if (v15 == 4) {
                v8 = arg15;
            } else if (v15 == 5) {
                v8 = arg16;
            } else if (v15 == 6) {
                v8 = arg17;
            } else if (v15 == 7) {
                v8 = arg18;
            } else if (v15 == 8) {
                v8 = arg19;
            } else if (v15 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v16, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v16, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v17 == 1) {
                v8 = arg12;
            } else if (v17 == 2) {
                v8 = arg13;
            } else if (v17 == 3) {
                v8 = arg14;
            } else if (v17 == 4) {
                v8 = arg15;
            } else if (v17 == 5) {
                v8 = arg16;
            } else if (v17 == 6) {
                v8 = arg17;
            } else if (v17 == 7) {
                v8 = arg18;
            } else if (v17 == 8) {
                v8 = arg19;
            } else if (v17 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v18, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v18, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v19 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v19 == 1) {
                v8 = arg12;
            } else if (v19 == 2) {
                v8 = arg13;
            } else if (v19 == 3) {
                v8 = arg14;
            } else if (v19 == 4) {
                v8 = arg15;
            } else if (v19 == 5) {
                v8 = arg16;
            } else if (v19 == 6) {
                v8 = arg17;
            } else if (v19 == 7) {
                v8 = arg18;
            } else if (v19 == 8) {
                v8 = arg19;
            } else if (v19 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v20, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v20, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v21 == 1) {
                v8 = arg12;
            } else if (v21 == 2) {
                v8 = arg13;
            } else if (v21 == 3) {
                v8 = arg14;
            } else if (v21 == 4) {
                v8 = arg15;
            } else if (v21 == 5) {
                v8 = arg16;
            } else if (v21 == 6) {
                v8 = arg17;
            } else if (v21 == 7) {
                v8 = arg18;
            } else if (v21 == 8) {
                v8 = arg19;
            } else if (v21 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v22, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v22, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v23 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v23 == 1) {
                v8 = arg12;
            } else if (v23 == 2) {
                v8 = arg13;
            } else if (v23 == 3) {
                v8 = arg14;
            } else if (v23 == 4) {
                v8 = arg15;
            } else if (v23 == 5) {
                v8 = arg16;
            } else if (v23 == 6) {
                v8 = arg17;
            } else if (v23 == 7) {
                v8 = arg18;
            } else if (v23 == 8) {
                v8 = arg19;
            } else if (v23 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v24, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v24, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v25 == 1) {
                v8 = arg12;
            } else if (v25 == 2) {
                v8 = arg13;
            } else if (v25 == 3) {
                v8 = arg14;
            } else if (v25 == 4) {
                v8 = arg15;
            } else if (v25 == 5) {
                v8 = arg16;
            } else if (v25 == 6) {
                v8 = arg17;
            } else if (v25 == 7) {
                v8 = arg18;
            } else if (v25 == 8) {
                v8 = arg19;
            } else if (v25 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v26, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v26, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v27 == 1) {
                v8 = arg12;
            } else if (v27 == 2) {
                v8 = arg13;
            } else if (v27 == 3) {
                v8 = arg14;
            } else if (v27 == 4) {
                v8 = arg15;
            } else if (v27 == 5) {
                v8 = arg16;
            } else if (v27 == 6) {
                v8 = arg17;
            } else if (v27 == 7) {
                v8 = arg18;
            } else if (v27 == 8) {
                v8 = arg19;
            } else if (v27 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v28, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v28, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v29 == 1) {
                v8 = arg12;
            } else if (v29 == 2) {
                v8 = arg13;
            } else if (v29 == 3) {
                v8 = arg14;
            } else if (v29 == 4) {
                v8 = arg15;
            } else if (v29 == 5) {
                v8 = arg16;
            } else if (v29 == 6) {
                v8 = arg17;
            } else if (v29 == 7) {
                v8 = arg18;
            } else if (v29 == 8) {
                v8 = arg19;
            } else if (v29 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v30 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v30, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v30, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v31 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v31 == 1) {
                v8 = arg12;
            } else if (v31 == 2) {
                v8 = arg13;
            } else if (v31 == 3) {
                v8 = arg14;
            } else if (v31 == 4) {
                v8 = arg15;
            } else if (v31 == 5) {
                v8 = arg16;
            } else if (v31 == 6) {
                v8 = arg17;
            } else if (v31 == 7) {
                v8 = arg18;
            } else if (v31 == 8) {
                v8 = arg19;
            } else if (v31 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v32, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v32, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v33 == 1) {
                v8 = arg12;
            } else if (v33 == 2) {
                v8 = arg13;
            } else if (v33 == 3) {
                v8 = arg14;
            } else if (v33 == 4) {
                v8 = arg15;
            } else if (v33 == 5) {
                v8 = arg16;
            } else if (v33 == 6) {
                v8 = arg17;
            } else if (v33 == 7) {
                v8 = arg18;
            } else if (v33 == 8) {
                v8 = arg19;
            } else if (v33 == 9) {
                v8 = arg20;
            } else {
                v8 = arg11;
            };
            let v34 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v34, arg2, v8, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v34, arg22);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg22);
        let (v35, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg22);
        let v37 = v35;
        if (arg21 < v35) {
            v37 = arg21;
        };
        v37
    }

    public fun l<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: u64, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg23), arg23);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg24));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223383362683535359);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v9 == 1) {
                v8 = arg12;
            } else if (v9 == 2) {
                v8 = arg13;
            } else if (v9 == 3) {
                v8 = arg14;
            } else if (v9 == 4) {
                v8 = arg15;
            } else if (v9 == 5) {
                v8 = arg16;
            } else if (v9 == 6) {
                v8 = arg17;
            } else if (v9 == 7) {
                v8 = arg18;
            } else if (v9 == 8) {
                v8 = arg19;
            } else if (v9 == 9) {
                v8 = arg20;
            } else if (v9 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v11 == 1) {
                v8 = arg12;
            } else if (v11 == 2) {
                v8 = arg13;
            } else if (v11 == 3) {
                v8 = arg14;
            } else if (v11 == 4) {
                v8 = arg15;
            } else if (v11 == 5) {
                v8 = arg16;
            } else if (v11 == 6) {
                v8 = arg17;
            } else if (v11 == 7) {
                v8 = arg18;
            } else if (v11 == 8) {
                v8 = arg19;
            } else if (v11 == 9) {
                v8 = arg20;
            } else if (v11 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v12, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v12, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v13 == 1) {
                v8 = arg12;
            } else if (v13 == 2) {
                v8 = arg13;
            } else if (v13 == 3) {
                v8 = arg14;
            } else if (v13 == 4) {
                v8 = arg15;
            } else if (v13 == 5) {
                v8 = arg16;
            } else if (v13 == 6) {
                v8 = arg17;
            } else if (v13 == 7) {
                v8 = arg18;
            } else if (v13 == 8) {
                v8 = arg19;
            } else if (v13 == 9) {
                v8 = arg20;
            } else if (v13 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v14, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v14, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v15 == 1) {
                v8 = arg12;
            } else if (v15 == 2) {
                v8 = arg13;
            } else if (v15 == 3) {
                v8 = arg14;
            } else if (v15 == 4) {
                v8 = arg15;
            } else if (v15 == 5) {
                v8 = arg16;
            } else if (v15 == 6) {
                v8 = arg17;
            } else if (v15 == 7) {
                v8 = arg18;
            } else if (v15 == 8) {
                v8 = arg19;
            } else if (v15 == 9) {
                v8 = arg20;
            } else if (v15 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v16, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v16, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v17 == 1) {
                v8 = arg12;
            } else if (v17 == 2) {
                v8 = arg13;
            } else if (v17 == 3) {
                v8 = arg14;
            } else if (v17 == 4) {
                v8 = arg15;
            } else if (v17 == 5) {
                v8 = arg16;
            } else if (v17 == 6) {
                v8 = arg17;
            } else if (v17 == 7) {
                v8 = arg18;
            } else if (v17 == 8) {
                v8 = arg19;
            } else if (v17 == 9) {
                v8 = arg20;
            } else if (v17 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v18, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v18, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v19 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v19 == 1) {
                v8 = arg12;
            } else if (v19 == 2) {
                v8 = arg13;
            } else if (v19 == 3) {
                v8 = arg14;
            } else if (v19 == 4) {
                v8 = arg15;
            } else if (v19 == 5) {
                v8 = arg16;
            } else if (v19 == 6) {
                v8 = arg17;
            } else if (v19 == 7) {
                v8 = arg18;
            } else if (v19 == 8) {
                v8 = arg19;
            } else if (v19 == 9) {
                v8 = arg20;
            } else if (v19 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v20, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v20, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v21 == 1) {
                v8 = arg12;
            } else if (v21 == 2) {
                v8 = arg13;
            } else if (v21 == 3) {
                v8 = arg14;
            } else if (v21 == 4) {
                v8 = arg15;
            } else if (v21 == 5) {
                v8 = arg16;
            } else if (v21 == 6) {
                v8 = arg17;
            } else if (v21 == 7) {
                v8 = arg18;
            } else if (v21 == 8) {
                v8 = arg19;
            } else if (v21 == 9) {
                v8 = arg20;
            } else if (v21 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v22, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v22, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v23 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v23 == 1) {
                v8 = arg12;
            } else if (v23 == 2) {
                v8 = arg13;
            } else if (v23 == 3) {
                v8 = arg14;
            } else if (v23 == 4) {
                v8 = arg15;
            } else if (v23 == 5) {
                v8 = arg16;
            } else if (v23 == 6) {
                v8 = arg17;
            } else if (v23 == 7) {
                v8 = arg18;
            } else if (v23 == 8) {
                v8 = arg19;
            } else if (v23 == 9) {
                v8 = arg20;
            } else if (v23 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v24, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v24, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v25 == 1) {
                v8 = arg12;
            } else if (v25 == 2) {
                v8 = arg13;
            } else if (v25 == 3) {
                v8 = arg14;
            } else if (v25 == 4) {
                v8 = arg15;
            } else if (v25 == 5) {
                v8 = arg16;
            } else if (v25 == 6) {
                v8 = arg17;
            } else if (v25 == 7) {
                v8 = arg18;
            } else if (v25 == 8) {
                v8 = arg19;
            } else if (v25 == 9) {
                v8 = arg20;
            } else if (v25 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v26, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v26, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v27 == 1) {
                v8 = arg12;
            } else if (v27 == 2) {
                v8 = arg13;
            } else if (v27 == 3) {
                v8 = arg14;
            } else if (v27 == 4) {
                v8 = arg15;
            } else if (v27 == 5) {
                v8 = arg16;
            } else if (v27 == 6) {
                v8 = arg17;
            } else if (v27 == 7) {
                v8 = arg18;
            } else if (v27 == 8) {
                v8 = arg19;
            } else if (v27 == 9) {
                v8 = arg20;
            } else if (v27 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v28, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v28, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v29 == 1) {
                v8 = arg12;
            } else if (v29 == 2) {
                v8 = arg13;
            } else if (v29 == 3) {
                v8 = arg14;
            } else if (v29 == 4) {
                v8 = arg15;
            } else if (v29 == 5) {
                v8 = arg16;
            } else if (v29 == 6) {
                v8 = arg17;
            } else if (v29 == 7) {
                v8 = arg18;
            } else if (v29 == 8) {
                v8 = arg19;
            } else if (v29 == 9) {
                v8 = arg20;
            } else if (v29 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v30 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v30, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v30, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v31 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v31 == 1) {
                v8 = arg12;
            } else if (v31 == 2) {
                v8 = arg13;
            } else if (v31 == 3) {
                v8 = arg14;
            } else if (v31 == 4) {
                v8 = arg15;
            } else if (v31 == 5) {
                v8 = arg16;
            } else if (v31 == 6) {
                v8 = arg17;
            } else if (v31 == 7) {
                v8 = arg18;
            } else if (v31 == 8) {
                v8 = arg19;
            } else if (v31 == 9) {
                v8 = arg20;
            } else if (v31 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v32, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v32, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v33 == 1) {
                v8 = arg12;
            } else if (v33 == 2) {
                v8 = arg13;
            } else if (v33 == 3) {
                v8 = arg14;
            } else if (v33 == 4) {
                v8 = arg15;
            } else if (v33 == 5) {
                v8 = arg16;
            } else if (v33 == 6) {
                v8 = arg17;
            } else if (v33 == 7) {
                v8 = arg18;
            } else if (v33 == 8) {
                v8 = arg19;
            } else if (v33 == 9) {
                v8 = arg20;
            } else if (v33 == 10) {
                v8 = arg21;
            } else {
                v8 = arg11;
            };
            let v34 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v34, arg2, v8, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v34, arg23);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg23);
        let (v35, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg23);
        let v37 = v35;
        if (arg22 < v35) {
            v37 = arg22;
        };
        v37
    }

    public fun m<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: u64, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg24), arg24);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg25));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223384612519018495);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v9 == 1) {
                v8 = arg12;
            } else if (v9 == 2) {
                v8 = arg13;
            } else if (v9 == 3) {
                v8 = arg14;
            } else if (v9 == 4) {
                v8 = arg15;
            } else if (v9 == 5) {
                v8 = arg16;
            } else if (v9 == 6) {
                v8 = arg17;
            } else if (v9 == 7) {
                v8 = arg18;
            } else if (v9 == 8) {
                v8 = arg19;
            } else if (v9 == 9) {
                v8 = arg20;
            } else if (v9 == 10) {
                v8 = arg21;
            } else if (v9 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v11 == 1) {
                v8 = arg12;
            } else if (v11 == 2) {
                v8 = arg13;
            } else if (v11 == 3) {
                v8 = arg14;
            } else if (v11 == 4) {
                v8 = arg15;
            } else if (v11 == 5) {
                v8 = arg16;
            } else if (v11 == 6) {
                v8 = arg17;
            } else if (v11 == 7) {
                v8 = arg18;
            } else if (v11 == 8) {
                v8 = arg19;
            } else if (v11 == 9) {
                v8 = arg20;
            } else if (v11 == 10) {
                v8 = arg21;
            } else if (v11 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v12, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v12, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v13 == 1) {
                v8 = arg12;
            } else if (v13 == 2) {
                v8 = arg13;
            } else if (v13 == 3) {
                v8 = arg14;
            } else if (v13 == 4) {
                v8 = arg15;
            } else if (v13 == 5) {
                v8 = arg16;
            } else if (v13 == 6) {
                v8 = arg17;
            } else if (v13 == 7) {
                v8 = arg18;
            } else if (v13 == 8) {
                v8 = arg19;
            } else if (v13 == 9) {
                v8 = arg20;
            } else if (v13 == 10) {
                v8 = arg21;
            } else if (v13 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v14, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v14, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v15 == 1) {
                v8 = arg12;
            } else if (v15 == 2) {
                v8 = arg13;
            } else if (v15 == 3) {
                v8 = arg14;
            } else if (v15 == 4) {
                v8 = arg15;
            } else if (v15 == 5) {
                v8 = arg16;
            } else if (v15 == 6) {
                v8 = arg17;
            } else if (v15 == 7) {
                v8 = arg18;
            } else if (v15 == 8) {
                v8 = arg19;
            } else if (v15 == 9) {
                v8 = arg20;
            } else if (v15 == 10) {
                v8 = arg21;
            } else if (v15 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v16, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v16, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v17 == 1) {
                v8 = arg12;
            } else if (v17 == 2) {
                v8 = arg13;
            } else if (v17 == 3) {
                v8 = arg14;
            } else if (v17 == 4) {
                v8 = arg15;
            } else if (v17 == 5) {
                v8 = arg16;
            } else if (v17 == 6) {
                v8 = arg17;
            } else if (v17 == 7) {
                v8 = arg18;
            } else if (v17 == 8) {
                v8 = arg19;
            } else if (v17 == 9) {
                v8 = arg20;
            } else if (v17 == 10) {
                v8 = arg21;
            } else if (v17 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v18, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v18, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v19 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v19 == 1) {
                v8 = arg12;
            } else if (v19 == 2) {
                v8 = arg13;
            } else if (v19 == 3) {
                v8 = arg14;
            } else if (v19 == 4) {
                v8 = arg15;
            } else if (v19 == 5) {
                v8 = arg16;
            } else if (v19 == 6) {
                v8 = arg17;
            } else if (v19 == 7) {
                v8 = arg18;
            } else if (v19 == 8) {
                v8 = arg19;
            } else if (v19 == 9) {
                v8 = arg20;
            } else if (v19 == 10) {
                v8 = arg21;
            } else if (v19 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v20, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v20, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v21 == 1) {
                v8 = arg12;
            } else if (v21 == 2) {
                v8 = arg13;
            } else if (v21 == 3) {
                v8 = arg14;
            } else if (v21 == 4) {
                v8 = arg15;
            } else if (v21 == 5) {
                v8 = arg16;
            } else if (v21 == 6) {
                v8 = arg17;
            } else if (v21 == 7) {
                v8 = arg18;
            } else if (v21 == 8) {
                v8 = arg19;
            } else if (v21 == 9) {
                v8 = arg20;
            } else if (v21 == 10) {
                v8 = arg21;
            } else if (v21 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v22, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v22, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v23 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v23 == 1) {
                v8 = arg12;
            } else if (v23 == 2) {
                v8 = arg13;
            } else if (v23 == 3) {
                v8 = arg14;
            } else if (v23 == 4) {
                v8 = arg15;
            } else if (v23 == 5) {
                v8 = arg16;
            } else if (v23 == 6) {
                v8 = arg17;
            } else if (v23 == 7) {
                v8 = arg18;
            } else if (v23 == 8) {
                v8 = arg19;
            } else if (v23 == 9) {
                v8 = arg20;
            } else if (v23 == 10) {
                v8 = arg21;
            } else if (v23 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v24, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v24, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v25 == 1) {
                v8 = arg12;
            } else if (v25 == 2) {
                v8 = arg13;
            } else if (v25 == 3) {
                v8 = arg14;
            } else if (v25 == 4) {
                v8 = arg15;
            } else if (v25 == 5) {
                v8 = arg16;
            } else if (v25 == 6) {
                v8 = arg17;
            } else if (v25 == 7) {
                v8 = arg18;
            } else if (v25 == 8) {
                v8 = arg19;
            } else if (v25 == 9) {
                v8 = arg20;
            } else if (v25 == 10) {
                v8 = arg21;
            } else if (v25 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v26, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v26, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v27 == 1) {
                v8 = arg12;
            } else if (v27 == 2) {
                v8 = arg13;
            } else if (v27 == 3) {
                v8 = arg14;
            } else if (v27 == 4) {
                v8 = arg15;
            } else if (v27 == 5) {
                v8 = arg16;
            } else if (v27 == 6) {
                v8 = arg17;
            } else if (v27 == 7) {
                v8 = arg18;
            } else if (v27 == 8) {
                v8 = arg19;
            } else if (v27 == 9) {
                v8 = arg20;
            } else if (v27 == 10) {
                v8 = arg21;
            } else if (v27 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v28, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v28, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v29 == 1) {
                v8 = arg12;
            } else if (v29 == 2) {
                v8 = arg13;
            } else if (v29 == 3) {
                v8 = arg14;
            } else if (v29 == 4) {
                v8 = arg15;
            } else if (v29 == 5) {
                v8 = arg16;
            } else if (v29 == 6) {
                v8 = arg17;
            } else if (v29 == 7) {
                v8 = arg18;
            } else if (v29 == 8) {
                v8 = arg19;
            } else if (v29 == 9) {
                v8 = arg20;
            } else if (v29 == 10) {
                v8 = arg21;
            } else if (v29 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v30 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v30, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v30, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v31 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v31 == 1) {
                v8 = arg12;
            } else if (v31 == 2) {
                v8 = arg13;
            } else if (v31 == 3) {
                v8 = arg14;
            } else if (v31 == 4) {
                v8 = arg15;
            } else if (v31 == 5) {
                v8 = arg16;
            } else if (v31 == 6) {
                v8 = arg17;
            } else if (v31 == 7) {
                v8 = arg18;
            } else if (v31 == 8) {
                v8 = arg19;
            } else if (v31 == 9) {
                v8 = arg20;
            } else if (v31 == 10) {
                v8 = arg21;
            } else if (v31 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v32, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v32, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v33 == 1) {
                v8 = arg12;
            } else if (v33 == 2) {
                v8 = arg13;
            } else if (v33 == 3) {
                v8 = arg14;
            } else if (v33 == 4) {
                v8 = arg15;
            } else if (v33 == 5) {
                v8 = arg16;
            } else if (v33 == 6) {
                v8 = arg17;
            } else if (v33 == 7) {
                v8 = arg18;
            } else if (v33 == 8) {
                v8 = arg19;
            } else if (v33 == 9) {
                v8 = arg20;
            } else if (v33 == 10) {
                v8 = arg21;
            } else if (v33 == 11) {
                v8 = arg22;
            } else {
                v8 = arg11;
            };
            let v34 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v34, arg2, v8, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v34, arg24);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg24);
        let (v35, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg24);
        let v37 = v35;
        if (arg23 < v35) {
            v37 = arg23;
        };
        v37
    }

    public fun n<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: u64, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : u64 {
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v0 = 0;
            let v1 = 169;
            while (v0 < 0x1::vector::length<u8>(&arg3)) {
                let v2 = 0x1::vector::borrow_mut<u8>(&mut arg3, v0);
                *v2 = *v2 ^ v1;
                let v3 = (v1 as u16) + (*v2 as u16) & 255;
                v1 = (v3 as u8);
                v0 = v0 + 1;
            };
            let v4 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg25), arg25);
            let v6 = v5;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v5, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v6);
        };
        let v7 = 0x2::address::to_u256(0x2::tx_context::sender(arg26));
        assert!(((v7 & 18446744073709551615) as u64) ^ ((v7 >> 192) as u64) == 14876365023445144158, 9223385892419272703);
        let v8;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v9 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v9 == 1) {
                v8 = arg12;
            } else if (v9 == 2) {
                v8 = arg13;
            } else if (v9 == 3) {
                v8 = arg14;
            } else if (v9 == 4) {
                v8 = arg15;
            } else if (v9 == 5) {
                v8 = arg16;
            } else if (v9 == 6) {
                v8 = arg17;
            } else if (v9 == 7) {
                v8 = arg18;
            } else if (v9 == 8) {
                v8 = arg19;
            } else if (v9 == 9) {
                v8 = arg20;
            } else if (v9 == 10) {
                v8 = arg21;
            } else if (v9 == 11) {
                v8 = arg22;
            } else if (v9 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v11 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v11 == 1) {
                v8 = arg12;
            } else if (v11 == 2) {
                v8 = arg13;
            } else if (v11 == 3) {
                v8 = arg14;
            } else if (v11 == 4) {
                v8 = arg15;
            } else if (v11 == 5) {
                v8 = arg16;
            } else if (v11 == 6) {
                v8 = arg17;
            } else if (v11 == 7) {
                v8 = arg18;
            } else if (v11 == 8) {
                v8 = arg19;
            } else if (v11 == 9) {
                v8 = arg20;
            } else if (v11 == 10) {
                v8 = arg21;
            } else if (v11 == 11) {
                v8 = arg22;
            } else if (v11 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v12, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v12, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v13 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v13 == 1) {
                v8 = arg12;
            } else if (v13 == 2) {
                v8 = arg13;
            } else if (v13 == 3) {
                v8 = arg14;
            } else if (v13 == 4) {
                v8 = arg15;
            } else if (v13 == 5) {
                v8 = arg16;
            } else if (v13 == 6) {
                v8 = arg17;
            } else if (v13 == 7) {
                v8 = arg18;
            } else if (v13 == 8) {
                v8 = arg19;
            } else if (v13 == 9) {
                v8 = arg20;
            } else if (v13 == 10) {
                v8 = arg21;
            } else if (v13 == 11) {
                v8 = arg22;
            } else if (v13 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v14, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v14, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v15 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v15 == 1) {
                v8 = arg12;
            } else if (v15 == 2) {
                v8 = arg13;
            } else if (v15 == 3) {
                v8 = arg14;
            } else if (v15 == 4) {
                v8 = arg15;
            } else if (v15 == 5) {
                v8 = arg16;
            } else if (v15 == 6) {
                v8 = arg17;
            } else if (v15 == 7) {
                v8 = arg18;
            } else if (v15 == 8) {
                v8 = arg19;
            } else if (v15 == 9) {
                v8 = arg20;
            } else if (v15 == 10) {
                v8 = arg21;
            } else if (v15 == 11) {
                v8 = arg22;
            } else if (v15 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v16, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v16, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v17 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v17 == 1) {
                v8 = arg12;
            } else if (v17 == 2) {
                v8 = arg13;
            } else if (v17 == 3) {
                v8 = arg14;
            } else if (v17 == 4) {
                v8 = arg15;
            } else if (v17 == 5) {
                v8 = arg16;
            } else if (v17 == 6) {
                v8 = arg17;
            } else if (v17 == 7) {
                v8 = arg18;
            } else if (v17 == 8) {
                v8 = arg19;
            } else if (v17 == 9) {
                v8 = arg20;
            } else if (v17 == 10) {
                v8 = arg21;
            } else if (v17 == 11) {
                v8 = arg22;
            } else if (v17 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v18, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v18, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v19 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v19 == 1) {
                v8 = arg12;
            } else if (v19 == 2) {
                v8 = arg13;
            } else if (v19 == 3) {
                v8 = arg14;
            } else if (v19 == 4) {
                v8 = arg15;
            } else if (v19 == 5) {
                v8 = arg16;
            } else if (v19 == 6) {
                v8 = arg17;
            } else if (v19 == 7) {
                v8 = arg18;
            } else if (v19 == 8) {
                v8 = arg19;
            } else if (v19 == 9) {
                v8 = arg20;
            } else if (v19 == 10) {
                v8 = arg21;
            } else if (v19 == 11) {
                v8 = arg22;
            } else if (v19 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v20, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v20, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v21 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v21 == 1) {
                v8 = arg12;
            } else if (v21 == 2) {
                v8 = arg13;
            } else if (v21 == 3) {
                v8 = arg14;
            } else if (v21 == 4) {
                v8 = arg15;
            } else if (v21 == 5) {
                v8 = arg16;
            } else if (v21 == 6) {
                v8 = arg17;
            } else if (v21 == 7) {
                v8 = arg18;
            } else if (v21 == 8) {
                v8 = arg19;
            } else if (v21 == 9) {
                v8 = arg20;
            } else if (v21 == 10) {
                v8 = arg21;
            } else if (v21 == 11) {
                v8 = arg22;
            } else if (v21 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v22, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v22, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v23 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v23 == 1) {
                v8 = arg12;
            } else if (v23 == 2) {
                v8 = arg13;
            } else if (v23 == 3) {
                v8 = arg14;
            } else if (v23 == 4) {
                v8 = arg15;
            } else if (v23 == 5) {
                v8 = arg16;
            } else if (v23 == 6) {
                v8 = arg17;
            } else if (v23 == 7) {
                v8 = arg18;
            } else if (v23 == 8) {
                v8 = arg19;
            } else if (v23 == 9) {
                v8 = arg20;
            } else if (v23 == 10) {
                v8 = arg21;
            } else if (v23 == 11) {
                v8 = arg22;
            } else if (v23 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v24 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v24, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v24, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v25 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v25 == 1) {
                v8 = arg12;
            } else if (v25 == 2) {
                v8 = arg13;
            } else if (v25 == 3) {
                v8 = arg14;
            } else if (v25 == 4) {
                v8 = arg15;
            } else if (v25 == 5) {
                v8 = arg16;
            } else if (v25 == 6) {
                v8 = arg17;
            } else if (v25 == 7) {
                v8 = arg18;
            } else if (v25 == 8) {
                v8 = arg19;
            } else if (v25 == 9) {
                v8 = arg20;
            } else if (v25 == 10) {
                v8 = arg21;
            } else if (v25 == 11) {
                v8 = arg22;
            } else if (v25 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v26 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v26, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v26, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v27 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v27 == 1) {
                v8 = arg12;
            } else if (v27 == 2) {
                v8 = arg13;
            } else if (v27 == 3) {
                v8 = arg14;
            } else if (v27 == 4) {
                v8 = arg15;
            } else if (v27 == 5) {
                v8 = arg16;
            } else if (v27 == 6) {
                v8 = arg17;
            } else if (v27 == 7) {
                v8 = arg18;
            } else if (v27 == 8) {
                v8 = arg19;
            } else if (v27 == 9) {
                v8 = arg20;
            } else if (v27 == 10) {
                v8 = arg21;
            } else if (v27 == 11) {
                v8 = arg22;
            } else if (v27 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v28 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v28, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v28, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v29 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v29 == 1) {
                v8 = arg12;
            } else if (v29 == 2) {
                v8 = arg13;
            } else if (v29 == 3) {
                v8 = arg14;
            } else if (v29 == 4) {
                v8 = arg15;
            } else if (v29 == 5) {
                v8 = arg16;
            } else if (v29 == 6) {
                v8 = arg17;
            } else if (v29 == 7) {
                v8 = arg18;
            } else if (v29 == 8) {
                v8 = arg19;
            } else if (v29 == 9) {
                v8 = arg20;
            } else if (v29 == 10) {
                v8 = arg21;
            } else if (v29 == 11) {
                v8 = arg22;
            } else if (v29 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v30 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v30, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v30, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v31 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v31 == 1) {
                v8 = arg12;
            } else if (v31 == 2) {
                v8 = arg13;
            } else if (v31 == 3) {
                v8 = arg14;
            } else if (v31 == 4) {
                v8 = arg15;
            } else if (v31 == 5) {
                v8 = arg16;
            } else if (v31 == 6) {
                v8 = arg17;
            } else if (v31 == 7) {
                v8 = arg18;
            } else if (v31 == 8) {
                v8 = arg19;
            } else if (v31 == 9) {
                v8 = arg20;
            } else if (v31 == 10) {
                v8 = arg21;
            } else if (v31 == 11) {
                v8 = arg22;
            } else if (v31 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v32 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v32, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v32, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v33 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v33 == 1) {
                v8 = arg12;
            } else if (v33 == 2) {
                v8 = arg13;
            } else if (v33 == 3) {
                v8 = arg14;
            } else if (v33 == 4) {
                v8 = arg15;
            } else if (v33 == 5) {
                v8 = arg16;
            } else if (v33 == 6) {
                v8 = arg17;
            } else if (v33 == 7) {
                v8 = arg18;
            } else if (v33 == 8) {
                v8 = arg19;
            } else if (v33 == 9) {
                v8 = arg20;
            } else if (v33 == 10) {
                v8 = arg21;
            } else if (v33 == 11) {
                v8 = arg22;
            } else if (v33 == 12) {
                v8 = arg23;
            } else {
                v8 = arg11;
            };
            let v34 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v34, arg2, v8, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v34, arg25);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg25);
        let (v35, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg25);
        let v37 = v35;
        if (arg24 < v35) {
            v37 = arg24;
        };
        v37
    }

    // decompiled from Move bytecode v7
}

