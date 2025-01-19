module 0xf49fe66ec8357eb3b81652dfc8eedae6c2ad7a843c825b36c788f07135bf87b::x {
    public fun A<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0x2::clock::Clock, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg12 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg3)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg8, arg9, arg10, arg3, arg4, arg5, arg6, arg11, arg13);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, false, arg12, 79226673515401279992447579055, arg11);
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
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg13)), v3);
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg13));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223386669808353279);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AAA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg14, 4295048016, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T3, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T3>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048016, arg13);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v11), 4295048016, arg13);
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
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 64 & 18446744073709551615) as u64) ^ ((v17 >> 128 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 9459194608057385379, 9223394783001575423);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AA_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, false, arg13, 4295048016, arg12);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v1, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048016, arg12);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223388185931808767);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AAa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg14, 79226673515401279992447579055, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048016, arg13);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T3>(arg0, arg2, true, true, 0x2::balance::value<T1>(&v11), 4295048016, arg13);
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
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 64 & 18446744073709551615) as u64) ^ ((v17 >> 128 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 9459194608057385379, 9223394443699159039);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AC_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg13, arg1, arg3, true, false, arg14, 4295048016);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::coin::value<T0>(&v6), 4295048016, arg13);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223389491601866751);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AaA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg14, 4295048016, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T3, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T3>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048016, arg13);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579055, arg13);
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
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 64 & 18446744073709551615) as u64) ^ ((v17 >> 128 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 9459194608057385379, 9223394104396742655);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Aa_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, false, arg13, 79226673515401279992447579055, arg12);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v0, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048016, arg12);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223387868104228863);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Aaa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg14, 79226673515401279992447579055, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048016, arg13);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v11), 79226673515401279992447579055, arg13);
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
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 64 & 18446744073709551615) as u64) ^ ((v17 >> 128 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 9459194608057385379, 9223393765094326271);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Ac_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg13, arg1, arg3, false, false, arg14, 79226673515401279992447579055);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::coin::value<T0>(&v6), 4295048016, arg13);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223389165184352255);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun B<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg8: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg11: &0x2::clock::Clock, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg12 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg3)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg8, arg9, arg10, arg3, arg4, arg5, arg6, arg11, arg13);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg12, 4295048016, arg11);
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
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg13)), 0x2::balance::zero<T1>(), v3);
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg13));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223386918916456447);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CA_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, true, false, arg14, 4295048016, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg1, arg2, true, true, 0x2::coin::value<T0>(&v6), 4295048016);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223390797271924735);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CC_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg12, arg0, arg2, true, false, arg13, 4295048016);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v1, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048016);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223392068582244351);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Ca_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, arg14, 79226673515401279992447579055, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg1, arg2, true, true, 0x2::coin::value<T0>(&v6), 4295048016);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223390470854410239);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Cc_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg12, arg0, arg2, false, false, arg13, 79226673515401279992447579055);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v0, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048016);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223391750754664447);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aAA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg14, 4295048016, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T3, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T3>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055, arg13);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v11), 4295048016, arg13);
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
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 64 & 18446744073709551615) as u64) ^ ((v17 >> 128 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 9459194608057385379, 9223393425791909887);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aA_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, true, false, arg13, 4295048016, arg12);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v1, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055, arg12);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223387550276648959);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aAa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg14, 79226673515401279992447579055, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055, arg13);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T3>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v11), 4295048016, arg13);
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
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 64 & 18446744073709551615) as u64) ^ ((v17 >> 128 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 9459194608057385379, 9223393086489493503);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aC_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg13, arg1, arg3, true, false, arg14, 4295048016);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055, arg13);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223388838766837759);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aaA<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, true, false, arg14, 4295048016, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T3, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T3>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055, arg13);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579055, arg13);
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
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 64 & 18446744073709551615) as u64) ^ ((v17 >> 128 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 9459194608057385379, 9223392747187077119);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aa_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, false, false, arg13, 79226673515401279992447579055, arg12);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v0, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055, arg12);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223387232449069055);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aaa<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg0, arg3, false, false, arg14, 79226673515401279992447579055, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T3>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055, arg13);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T0>(arg0, arg2, false, true, 0x2::balance::value<T0>(&v11), 79226673515401279992447579055, arg13);
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
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 64 & 18446744073709551615) as u64) ^ ((v17 >> 128 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 9459194608057385379, 9223392407884660735);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v15, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ac_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg13, arg1, arg3, false, false, arg14, 79226673515401279992447579055);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055, arg13);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223388512349323263);
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223372449171636223);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg13), arg13);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223372526481047551);
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v9 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v9, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v9, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v10, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v10, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v11, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v11, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v12, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v12, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v13, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v13, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v14, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v14, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v15, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v15, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v16, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v16, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v17, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v17, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v18, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v18, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v19, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v19, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v20, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v20, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v21, arg2, arg11, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v21, arg13);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg13);
        let (v22, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg13);
        let v24 = v22;
        if (arg12 < v22) {
            v24 = arg12;
        };
        v24
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223373376884572159);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg14), arg14);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223373475668819967);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v11, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v11, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v12, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v12, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v13, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v13, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v14, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v14, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v15, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v15, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v16, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v16, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v17, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v17, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v18, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v18, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v19, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v19, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v20 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v20, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v20, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v21, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v21, arg14);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v22 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v22, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v22, arg14);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg14);
        let (v23, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg14);
        let v25 = v23;
        if (arg13 < v23) {
            v25 = arg13;
        };
        v25
    }

    public fun cA_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg3, true, false, arg14, 4295048016, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v1, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg1, arg2, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223390144436895743);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cC_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg12, arg0, arg2, true, false, arg13, 4295048016);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v1, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223391432927084543);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ca_<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0x2::clock::Clock, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        if (arg14 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg5)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg10, arg11, arg12, arg5, arg6, arg7, arg8, arg13, arg15);
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg3, false, false, arg14, 79226673515401279992447579055, arg13);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg4, arg5, arg6, 0x2::coin::from_balance<T2>(v0, arg15), arg7, arg8, arg13, arg15);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg13, arg1, arg2, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223389818019381247);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg15), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cc_<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg12, arg0, arg2, false, false, arg13, 79226673515401279992447579055);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v0, arg14), arg6, arg7, arg12, arg14);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg12, arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055);
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
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223391115099504639);
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223374334662279167);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg15), arg15);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223374454921363455);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg12;
            } else if (v10 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg12;
            } else if (v12 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg12;
            } else if (v14 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg12;
            } else if (v16 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg12;
            } else if (v18 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg12;
            } else if (v20 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg12;
            } else if (v22 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg12;
            } else if (v24 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg12;
            } else if (v26 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg12;
            } else if (v28 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v30 == 1) {
                v9 = arg12;
            } else if (v30 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v31 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v31, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v31, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v32 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v32 == 1) {
                v9 = arg12;
            } else if (v32 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v33 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v33, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v33, arg15);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v34 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v34 == 1) {
                v9 = arg12;
            } else if (v34 == 2) {
                v9 = arg13;
            } else {
                v9 = arg11;
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v35, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v35, arg15);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg15);
        let (v36, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg15);
        let v38 = v36;
        if (arg14 < v36) {
            v38 = arg14;
        };
        v38
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223375322504757247);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg16), arg16);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223375464238678015);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg12;
            } else if (v10 == 2) {
                v9 = arg13;
            } else if (v10 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg12;
            } else if (v12 == 2) {
                v9 = arg13;
            } else if (v12 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg12;
            } else if (v14 == 2) {
                v9 = arg13;
            } else if (v14 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg12;
            } else if (v16 == 2) {
                v9 = arg13;
            } else if (v16 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg12;
            } else if (v18 == 2) {
                v9 = arg13;
            } else if (v18 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg12;
            } else if (v20 == 2) {
                v9 = arg13;
            } else if (v20 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg12;
            } else if (v22 == 2) {
                v9 = arg13;
            } else if (v22 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg12;
            } else if (v24 == 2) {
                v9 = arg13;
            } else if (v24 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg12;
            } else if (v26 == 2) {
                v9 = arg13;
            } else if (v26 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg12;
            } else if (v28 == 2) {
                v9 = arg13;
            } else if (v28 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v30 == 1) {
                v9 = arg12;
            } else if (v30 == 2) {
                v9 = arg13;
            } else if (v30 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v31 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v31, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v31, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v32 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v32 == 1) {
                v9 = arg12;
            } else if (v32 == 2) {
                v9 = arg13;
            } else if (v32 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v33 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v33, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v33, arg16);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v34 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v34 == 1) {
                v9 = arg12;
            } else if (v34 == 2) {
                v9 = arg13;
            } else if (v34 == 3) {
                v9 = arg14;
            } else {
                v9 = arg11;
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v35, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v35, arg16);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg16);
        let (v36, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg16);
        let v38 = v36;
        if (arg15 < v36) {
            v38 = arg15;
        };
        v38
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223376340412006399);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg17), arg17);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223376503620763647);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg12;
            } else if (v10 == 2) {
                v9 = arg13;
            } else if (v10 == 3) {
                v9 = arg14;
            } else if (v10 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg12;
            } else if (v12 == 2) {
                v9 = arg13;
            } else if (v12 == 3) {
                v9 = arg14;
            } else if (v12 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg12;
            } else if (v14 == 2) {
                v9 = arg13;
            } else if (v14 == 3) {
                v9 = arg14;
            } else if (v14 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg12;
            } else if (v16 == 2) {
                v9 = arg13;
            } else if (v16 == 3) {
                v9 = arg14;
            } else if (v16 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg12;
            } else if (v18 == 2) {
                v9 = arg13;
            } else if (v18 == 3) {
                v9 = arg14;
            } else if (v18 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg12;
            } else if (v20 == 2) {
                v9 = arg13;
            } else if (v20 == 3) {
                v9 = arg14;
            } else if (v20 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg12;
            } else if (v22 == 2) {
                v9 = arg13;
            } else if (v22 == 3) {
                v9 = arg14;
            } else if (v22 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg12;
            } else if (v24 == 2) {
                v9 = arg13;
            } else if (v24 == 3) {
                v9 = arg14;
            } else if (v24 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg12;
            } else if (v26 == 2) {
                v9 = arg13;
            } else if (v26 == 3) {
                v9 = arg14;
            } else if (v26 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg12;
            } else if (v28 == 2) {
                v9 = arg13;
            } else if (v28 == 3) {
                v9 = arg14;
            } else if (v28 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v30 == 1) {
                v9 = arg12;
            } else if (v30 == 2) {
                v9 = arg13;
            } else if (v30 == 3) {
                v9 = arg14;
            } else if (v30 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v31 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v31, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v31, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v32 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v32 == 1) {
                v9 = arg12;
            } else if (v32 == 2) {
                v9 = arg13;
            } else if (v32 == 3) {
                v9 = arg14;
            } else if (v32 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v33 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v33, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v33, arg17);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v34 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v34 == 1) {
                v9 = arg12;
            } else if (v34 == 2) {
                v9 = arg13;
            } else if (v34 == 3) {
                v9 = arg14;
            } else if (v34 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v35, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v35, arg17);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg17);
        let (v36, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg17);
        let v38 = v36;
        if (arg16 < v36) {
            v38 = arg16;
        };
        v38
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223377388384026623);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg18), arg18);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223377573067620351);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg12;
            } else if (v10 == 2) {
                v9 = arg13;
            } else if (v10 == 3) {
                v9 = arg14;
            } else if (v10 == 4) {
                v9 = arg15;
            } else if (v10 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg12;
            } else if (v12 == 2) {
                v9 = arg13;
            } else if (v12 == 3) {
                v9 = arg14;
            } else if (v12 == 4) {
                v9 = arg15;
            } else if (v12 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg12;
            } else if (v14 == 2) {
                v9 = arg13;
            } else if (v14 == 3) {
                v9 = arg14;
            } else if (v14 == 4) {
                v9 = arg15;
            } else if (v14 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg12;
            } else if (v16 == 2) {
                v9 = arg13;
            } else if (v16 == 3) {
                v9 = arg14;
            } else if (v16 == 4) {
                v9 = arg15;
            } else if (v16 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg12;
            } else if (v18 == 2) {
                v9 = arg13;
            } else if (v18 == 3) {
                v9 = arg14;
            } else if (v18 == 4) {
                v9 = arg15;
            } else if (v18 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg12;
            } else if (v20 == 2) {
                v9 = arg13;
            } else if (v20 == 3) {
                v9 = arg14;
            } else if (v20 == 4) {
                v9 = arg15;
            } else if (v20 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg12;
            } else if (v22 == 2) {
                v9 = arg13;
            } else if (v22 == 3) {
                v9 = arg14;
            } else if (v22 == 4) {
                v9 = arg15;
            } else if (v22 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg12;
            } else if (v24 == 2) {
                v9 = arg13;
            } else if (v24 == 3) {
                v9 = arg14;
            } else if (v24 == 4) {
                v9 = arg15;
            } else if (v24 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg12;
            } else if (v26 == 2) {
                v9 = arg13;
            } else if (v26 == 3) {
                v9 = arg14;
            } else if (v26 == 4) {
                v9 = arg15;
            } else if (v26 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg12;
            } else if (v28 == 2) {
                v9 = arg13;
            } else if (v28 == 3) {
                v9 = arg14;
            } else if (v28 == 4) {
                v9 = arg15;
            } else if (v28 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v30 == 1) {
                v9 = arg12;
            } else if (v30 == 2) {
                v9 = arg13;
            } else if (v30 == 3) {
                v9 = arg14;
            } else if (v30 == 4) {
                v9 = arg15;
            } else if (v30 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v31 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v31, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v31, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v32 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v32 == 1) {
                v9 = arg12;
            } else if (v32 == 2) {
                v9 = arg13;
            } else if (v32 == 3) {
                v9 = arg14;
            } else if (v32 == 4) {
                v9 = arg15;
            } else if (v32 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v33 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v33, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v33, arg18);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v34 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v34 == 1) {
                v9 = arg12;
            } else if (v34 == 2) {
                v9 = arg13;
            } else if (v34 == 3) {
                v9 = arg14;
            } else if (v34 == 4) {
                v9 = arg15;
            } else if (v34 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v35, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v35, arg18);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg18);
        let (v36, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg18);
        let v38 = v36;
        if (arg17 < v36) {
            v38 = arg17;
        };
        v38
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg20));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223378466420817919);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg19), arg19);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg20));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223378672579248127);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg12;
            } else if (v10 == 2) {
                v9 = arg13;
            } else if (v10 == 3) {
                v9 = arg14;
            } else if (v10 == 4) {
                v9 = arg15;
            } else if (v10 == 5) {
                v9 = arg16;
            } else if (v10 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg12;
            } else if (v12 == 2) {
                v9 = arg13;
            } else if (v12 == 3) {
                v9 = arg14;
            } else if (v12 == 4) {
                v9 = arg15;
            } else if (v12 == 5) {
                v9 = arg16;
            } else if (v12 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg12;
            } else if (v14 == 2) {
                v9 = arg13;
            } else if (v14 == 3) {
                v9 = arg14;
            } else if (v14 == 4) {
                v9 = arg15;
            } else if (v14 == 5) {
                v9 = arg16;
            } else if (v14 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg12;
            } else if (v16 == 2) {
                v9 = arg13;
            } else if (v16 == 3) {
                v9 = arg14;
            } else if (v16 == 4) {
                v9 = arg15;
            } else if (v16 == 5) {
                v9 = arg16;
            } else if (v16 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg12;
            } else if (v18 == 2) {
                v9 = arg13;
            } else if (v18 == 3) {
                v9 = arg14;
            } else if (v18 == 4) {
                v9 = arg15;
            } else if (v18 == 5) {
                v9 = arg16;
            } else if (v18 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg12;
            } else if (v20 == 2) {
                v9 = arg13;
            } else if (v20 == 3) {
                v9 = arg14;
            } else if (v20 == 4) {
                v9 = arg15;
            } else if (v20 == 5) {
                v9 = arg16;
            } else if (v20 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg12;
            } else if (v22 == 2) {
                v9 = arg13;
            } else if (v22 == 3) {
                v9 = arg14;
            } else if (v22 == 4) {
                v9 = arg15;
            } else if (v22 == 5) {
                v9 = arg16;
            } else if (v22 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg12;
            } else if (v24 == 2) {
                v9 = arg13;
            } else if (v24 == 3) {
                v9 = arg14;
            } else if (v24 == 4) {
                v9 = arg15;
            } else if (v24 == 5) {
                v9 = arg16;
            } else if (v24 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg12;
            } else if (v26 == 2) {
                v9 = arg13;
            } else if (v26 == 3) {
                v9 = arg14;
            } else if (v26 == 4) {
                v9 = arg15;
            } else if (v26 == 5) {
                v9 = arg16;
            } else if (v26 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg12;
            } else if (v28 == 2) {
                v9 = arg13;
            } else if (v28 == 3) {
                v9 = arg14;
            } else if (v28 == 4) {
                v9 = arg15;
            } else if (v28 == 5) {
                v9 = arg16;
            } else if (v28 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v30 == 1) {
                v9 = arg12;
            } else if (v30 == 2) {
                v9 = arg13;
            } else if (v30 == 3) {
                v9 = arg14;
            } else if (v30 == 4) {
                v9 = arg15;
            } else if (v30 == 5) {
                v9 = arg16;
            } else if (v30 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v31 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v31, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v31, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v32 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v32 == 1) {
                v9 = arg12;
            } else if (v32 == 2) {
                v9 = arg13;
            } else if (v32 == 3) {
                v9 = arg14;
            } else if (v32 == 4) {
                v9 = arg15;
            } else if (v32 == 5) {
                v9 = arg16;
            } else if (v32 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v33 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v33, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v33, arg19);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v34 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v34 == 1) {
                v9 = arg12;
            } else if (v34 == 2) {
                v9 = arg13;
            } else if (v34 == 3) {
                v9 = arg14;
            } else if (v34 == 4) {
                v9 = arg15;
            } else if (v34 == 5) {
                v9 = arg16;
            } else if (v34 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v35, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v35, arg19);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg19);
        let (v36, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg19);
        let v38 = v36;
        if (arg18 < v36) {
            v38 = arg18;
        };
        v38
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg21));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223379574522380287);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg20), arg20);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg21));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223379802155646975);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg12;
            } else if (v10 == 2) {
                v9 = arg13;
            } else if (v10 == 3) {
                v9 = arg14;
            } else if (v10 == 4) {
                v9 = arg15;
            } else if (v10 == 5) {
                v9 = arg16;
            } else if (v10 == 6) {
                v9 = arg17;
            } else if (v10 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg12;
            } else if (v12 == 2) {
                v9 = arg13;
            } else if (v12 == 3) {
                v9 = arg14;
            } else if (v12 == 4) {
                v9 = arg15;
            } else if (v12 == 5) {
                v9 = arg16;
            } else if (v12 == 6) {
                v9 = arg17;
            } else if (v12 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg12;
            } else if (v14 == 2) {
                v9 = arg13;
            } else if (v14 == 3) {
                v9 = arg14;
            } else if (v14 == 4) {
                v9 = arg15;
            } else if (v14 == 5) {
                v9 = arg16;
            } else if (v14 == 6) {
                v9 = arg17;
            } else if (v14 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg12;
            } else if (v16 == 2) {
                v9 = arg13;
            } else if (v16 == 3) {
                v9 = arg14;
            } else if (v16 == 4) {
                v9 = arg15;
            } else if (v16 == 5) {
                v9 = arg16;
            } else if (v16 == 6) {
                v9 = arg17;
            } else if (v16 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg12;
            } else if (v18 == 2) {
                v9 = arg13;
            } else if (v18 == 3) {
                v9 = arg14;
            } else if (v18 == 4) {
                v9 = arg15;
            } else if (v18 == 5) {
                v9 = arg16;
            } else if (v18 == 6) {
                v9 = arg17;
            } else if (v18 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg12;
            } else if (v20 == 2) {
                v9 = arg13;
            } else if (v20 == 3) {
                v9 = arg14;
            } else if (v20 == 4) {
                v9 = arg15;
            } else if (v20 == 5) {
                v9 = arg16;
            } else if (v20 == 6) {
                v9 = arg17;
            } else if (v20 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg12;
            } else if (v22 == 2) {
                v9 = arg13;
            } else if (v22 == 3) {
                v9 = arg14;
            } else if (v22 == 4) {
                v9 = arg15;
            } else if (v22 == 5) {
                v9 = arg16;
            } else if (v22 == 6) {
                v9 = arg17;
            } else if (v22 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg12;
            } else if (v24 == 2) {
                v9 = arg13;
            } else if (v24 == 3) {
                v9 = arg14;
            } else if (v24 == 4) {
                v9 = arg15;
            } else if (v24 == 5) {
                v9 = arg16;
            } else if (v24 == 6) {
                v9 = arg17;
            } else if (v24 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg12;
            } else if (v26 == 2) {
                v9 = arg13;
            } else if (v26 == 3) {
                v9 = arg14;
            } else if (v26 == 4) {
                v9 = arg15;
            } else if (v26 == 5) {
                v9 = arg16;
            } else if (v26 == 6) {
                v9 = arg17;
            } else if (v26 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg12;
            } else if (v28 == 2) {
                v9 = arg13;
            } else if (v28 == 3) {
                v9 = arg14;
            } else if (v28 == 4) {
                v9 = arg15;
            } else if (v28 == 5) {
                v9 = arg16;
            } else if (v28 == 6) {
                v9 = arg17;
            } else if (v28 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v30 == 1) {
                v9 = arg12;
            } else if (v30 == 2) {
                v9 = arg13;
            } else if (v30 == 3) {
                v9 = arg14;
            } else if (v30 == 4) {
                v9 = arg15;
            } else if (v30 == 5) {
                v9 = arg16;
            } else if (v30 == 6) {
                v9 = arg17;
            } else if (v30 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v31 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v31, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v31, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v32 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v32 == 1) {
                v9 = arg12;
            } else if (v32 == 2) {
                v9 = arg13;
            } else if (v32 == 3) {
                v9 = arg14;
            } else if (v32 == 4) {
                v9 = arg15;
            } else if (v32 == 5) {
                v9 = arg16;
            } else if (v32 == 6) {
                v9 = arg17;
            } else if (v32 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v33 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v33, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v33, arg20);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v34 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v34 == 1) {
                v9 = arg12;
            } else if (v34 == 2) {
                v9 = arg13;
            } else if (v34 == 3) {
                v9 = arg14;
            } else if (v34 == 4) {
                v9 = arg15;
            } else if (v34 == 5) {
                v9 = arg16;
            } else if (v34 == 6) {
                v9 = arg17;
            } else if (v34 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v35, arg2, v9, arg10, arg20);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v35, arg20);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg20);
        let (v36, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg20);
        let v38 = v36;
        if (arg19 < v36) {
            v38 = arg19;
        };
        v38
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg22));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223380712688713727);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg21), arg21);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg22));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223380961796816895);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg12;
            } else if (v10 == 2) {
                v9 = arg13;
            } else if (v10 == 3) {
                v9 = arg14;
            } else if (v10 == 4) {
                v9 = arg15;
            } else if (v10 == 5) {
                v9 = arg16;
            } else if (v10 == 6) {
                v9 = arg17;
            } else if (v10 == 7) {
                v9 = arg18;
            } else if (v10 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg12;
            } else if (v12 == 2) {
                v9 = arg13;
            } else if (v12 == 3) {
                v9 = arg14;
            } else if (v12 == 4) {
                v9 = arg15;
            } else if (v12 == 5) {
                v9 = arg16;
            } else if (v12 == 6) {
                v9 = arg17;
            } else if (v12 == 7) {
                v9 = arg18;
            } else if (v12 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg12;
            } else if (v14 == 2) {
                v9 = arg13;
            } else if (v14 == 3) {
                v9 = arg14;
            } else if (v14 == 4) {
                v9 = arg15;
            } else if (v14 == 5) {
                v9 = arg16;
            } else if (v14 == 6) {
                v9 = arg17;
            } else if (v14 == 7) {
                v9 = arg18;
            } else if (v14 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg12;
            } else if (v16 == 2) {
                v9 = arg13;
            } else if (v16 == 3) {
                v9 = arg14;
            } else if (v16 == 4) {
                v9 = arg15;
            } else if (v16 == 5) {
                v9 = arg16;
            } else if (v16 == 6) {
                v9 = arg17;
            } else if (v16 == 7) {
                v9 = arg18;
            } else if (v16 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg12;
            } else if (v18 == 2) {
                v9 = arg13;
            } else if (v18 == 3) {
                v9 = arg14;
            } else if (v18 == 4) {
                v9 = arg15;
            } else if (v18 == 5) {
                v9 = arg16;
            } else if (v18 == 6) {
                v9 = arg17;
            } else if (v18 == 7) {
                v9 = arg18;
            } else if (v18 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg12;
            } else if (v20 == 2) {
                v9 = arg13;
            } else if (v20 == 3) {
                v9 = arg14;
            } else if (v20 == 4) {
                v9 = arg15;
            } else if (v20 == 5) {
                v9 = arg16;
            } else if (v20 == 6) {
                v9 = arg17;
            } else if (v20 == 7) {
                v9 = arg18;
            } else if (v20 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg12;
            } else if (v22 == 2) {
                v9 = arg13;
            } else if (v22 == 3) {
                v9 = arg14;
            } else if (v22 == 4) {
                v9 = arg15;
            } else if (v22 == 5) {
                v9 = arg16;
            } else if (v22 == 6) {
                v9 = arg17;
            } else if (v22 == 7) {
                v9 = arg18;
            } else if (v22 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg12;
            } else if (v24 == 2) {
                v9 = arg13;
            } else if (v24 == 3) {
                v9 = arg14;
            } else if (v24 == 4) {
                v9 = arg15;
            } else if (v24 == 5) {
                v9 = arg16;
            } else if (v24 == 6) {
                v9 = arg17;
            } else if (v24 == 7) {
                v9 = arg18;
            } else if (v24 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg12;
            } else if (v26 == 2) {
                v9 = arg13;
            } else if (v26 == 3) {
                v9 = arg14;
            } else if (v26 == 4) {
                v9 = arg15;
            } else if (v26 == 5) {
                v9 = arg16;
            } else if (v26 == 6) {
                v9 = arg17;
            } else if (v26 == 7) {
                v9 = arg18;
            } else if (v26 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg12;
            } else if (v28 == 2) {
                v9 = arg13;
            } else if (v28 == 3) {
                v9 = arg14;
            } else if (v28 == 4) {
                v9 = arg15;
            } else if (v28 == 5) {
                v9 = arg16;
            } else if (v28 == 6) {
                v9 = arg17;
            } else if (v28 == 7) {
                v9 = arg18;
            } else if (v28 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v30 == 1) {
                v9 = arg12;
            } else if (v30 == 2) {
                v9 = arg13;
            } else if (v30 == 3) {
                v9 = arg14;
            } else if (v30 == 4) {
                v9 = arg15;
            } else if (v30 == 5) {
                v9 = arg16;
            } else if (v30 == 6) {
                v9 = arg17;
            } else if (v30 == 7) {
                v9 = arg18;
            } else if (v30 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v31 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v31, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v31, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v32 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v32 == 1) {
                v9 = arg12;
            } else if (v32 == 2) {
                v9 = arg13;
            } else if (v32 == 3) {
                v9 = arg14;
            } else if (v32 == 4) {
                v9 = arg15;
            } else if (v32 == 5) {
                v9 = arg16;
            } else if (v32 == 6) {
                v9 = arg17;
            } else if (v32 == 7) {
                v9 = arg18;
            } else if (v32 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v33 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v33, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v33, arg21);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v34 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v34 == 1) {
                v9 = arg12;
            } else if (v34 == 2) {
                v9 = arg13;
            } else if (v34 == 3) {
                v9 = arg14;
            } else if (v34 == 4) {
                v9 = arg15;
            } else if (v34 == 5) {
                v9 = arg16;
            } else if (v34 == 6) {
                v9 = arg17;
            } else if (v34 == 7) {
                v9 = arg18;
            } else if (v34 == 8) {
                v9 = arg19;
            } else {
                v9 = arg11;
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v35, arg2, v9, arg10, arg21);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v35, arg21);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg21);
        let (v36, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg21);
        let v38 = v36;
        if (arg20 < v36) {
            v38 = arg20;
        };
        v38
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg23));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223381880919818239);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg22), arg22);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg23));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223382151502757887);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg12;
            } else if (v10 == 2) {
                v9 = arg13;
            } else if (v10 == 3) {
                v9 = arg14;
            } else if (v10 == 4) {
                v9 = arg15;
            } else if (v10 == 5) {
                v9 = arg16;
            } else if (v10 == 6) {
                v9 = arg17;
            } else if (v10 == 7) {
                v9 = arg18;
            } else if (v10 == 8) {
                v9 = arg19;
            } else if (v10 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg12;
            } else if (v12 == 2) {
                v9 = arg13;
            } else if (v12 == 3) {
                v9 = arg14;
            } else if (v12 == 4) {
                v9 = arg15;
            } else if (v12 == 5) {
                v9 = arg16;
            } else if (v12 == 6) {
                v9 = arg17;
            } else if (v12 == 7) {
                v9 = arg18;
            } else if (v12 == 8) {
                v9 = arg19;
            } else if (v12 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg12;
            } else if (v14 == 2) {
                v9 = arg13;
            } else if (v14 == 3) {
                v9 = arg14;
            } else if (v14 == 4) {
                v9 = arg15;
            } else if (v14 == 5) {
                v9 = arg16;
            } else if (v14 == 6) {
                v9 = arg17;
            } else if (v14 == 7) {
                v9 = arg18;
            } else if (v14 == 8) {
                v9 = arg19;
            } else if (v14 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg12;
            } else if (v16 == 2) {
                v9 = arg13;
            } else if (v16 == 3) {
                v9 = arg14;
            } else if (v16 == 4) {
                v9 = arg15;
            } else if (v16 == 5) {
                v9 = arg16;
            } else if (v16 == 6) {
                v9 = arg17;
            } else if (v16 == 7) {
                v9 = arg18;
            } else if (v16 == 8) {
                v9 = arg19;
            } else if (v16 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg12;
            } else if (v18 == 2) {
                v9 = arg13;
            } else if (v18 == 3) {
                v9 = arg14;
            } else if (v18 == 4) {
                v9 = arg15;
            } else if (v18 == 5) {
                v9 = arg16;
            } else if (v18 == 6) {
                v9 = arg17;
            } else if (v18 == 7) {
                v9 = arg18;
            } else if (v18 == 8) {
                v9 = arg19;
            } else if (v18 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg12;
            } else if (v20 == 2) {
                v9 = arg13;
            } else if (v20 == 3) {
                v9 = arg14;
            } else if (v20 == 4) {
                v9 = arg15;
            } else if (v20 == 5) {
                v9 = arg16;
            } else if (v20 == 6) {
                v9 = arg17;
            } else if (v20 == 7) {
                v9 = arg18;
            } else if (v20 == 8) {
                v9 = arg19;
            } else if (v20 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg12;
            } else if (v22 == 2) {
                v9 = arg13;
            } else if (v22 == 3) {
                v9 = arg14;
            } else if (v22 == 4) {
                v9 = arg15;
            } else if (v22 == 5) {
                v9 = arg16;
            } else if (v22 == 6) {
                v9 = arg17;
            } else if (v22 == 7) {
                v9 = arg18;
            } else if (v22 == 8) {
                v9 = arg19;
            } else if (v22 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg12;
            } else if (v24 == 2) {
                v9 = arg13;
            } else if (v24 == 3) {
                v9 = arg14;
            } else if (v24 == 4) {
                v9 = arg15;
            } else if (v24 == 5) {
                v9 = arg16;
            } else if (v24 == 6) {
                v9 = arg17;
            } else if (v24 == 7) {
                v9 = arg18;
            } else if (v24 == 8) {
                v9 = arg19;
            } else if (v24 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg12;
            } else if (v26 == 2) {
                v9 = arg13;
            } else if (v26 == 3) {
                v9 = arg14;
            } else if (v26 == 4) {
                v9 = arg15;
            } else if (v26 == 5) {
                v9 = arg16;
            } else if (v26 == 6) {
                v9 = arg17;
            } else if (v26 == 7) {
                v9 = arg18;
            } else if (v26 == 8) {
                v9 = arg19;
            } else if (v26 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg12;
            } else if (v28 == 2) {
                v9 = arg13;
            } else if (v28 == 3) {
                v9 = arg14;
            } else if (v28 == 4) {
                v9 = arg15;
            } else if (v28 == 5) {
                v9 = arg16;
            } else if (v28 == 6) {
                v9 = arg17;
            } else if (v28 == 7) {
                v9 = arg18;
            } else if (v28 == 8) {
                v9 = arg19;
            } else if (v28 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v30 == 1) {
                v9 = arg12;
            } else if (v30 == 2) {
                v9 = arg13;
            } else if (v30 == 3) {
                v9 = arg14;
            } else if (v30 == 4) {
                v9 = arg15;
            } else if (v30 == 5) {
                v9 = arg16;
            } else if (v30 == 6) {
                v9 = arg17;
            } else if (v30 == 7) {
                v9 = arg18;
            } else if (v30 == 8) {
                v9 = arg19;
            } else if (v30 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v31 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v31, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v31, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v32 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v32 == 1) {
                v9 = arg12;
            } else if (v32 == 2) {
                v9 = arg13;
            } else if (v32 == 3) {
                v9 = arg14;
            } else if (v32 == 4) {
                v9 = arg15;
            } else if (v32 == 5) {
                v9 = arg16;
            } else if (v32 == 6) {
                v9 = arg17;
            } else if (v32 == 7) {
                v9 = arg18;
            } else if (v32 == 8) {
                v9 = arg19;
            } else if (v32 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v33 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v33, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v33, arg22);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v34 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v34 == 1) {
                v9 = arg12;
            } else if (v34 == 2) {
                v9 = arg13;
            } else if (v34 == 3) {
                v9 = arg14;
            } else if (v34 == 4) {
                v9 = arg15;
            } else if (v34 == 5) {
                v9 = arg16;
            } else if (v34 == 6) {
                v9 = arg17;
            } else if (v34 == 7) {
                v9 = arg18;
            } else if (v34 == 8) {
                v9 = arg19;
            } else if (v34 == 9) {
                v9 = arg20;
            } else {
                v9 = arg11;
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v35, arg2, v9, arg10, arg22);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v35, arg22);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg22);
        let (v36, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg22);
        let v38 = v36;
        if (arg21 < v36) {
            v38 = arg21;
        };
        v38
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg24));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223383079215693823);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg23), arg23);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg24));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223383371273469951);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg12;
            } else if (v10 == 2) {
                v9 = arg13;
            } else if (v10 == 3) {
                v9 = arg14;
            } else if (v10 == 4) {
                v9 = arg15;
            } else if (v10 == 5) {
                v9 = arg16;
            } else if (v10 == 6) {
                v9 = arg17;
            } else if (v10 == 7) {
                v9 = arg18;
            } else if (v10 == 8) {
                v9 = arg19;
            } else if (v10 == 9) {
                v9 = arg20;
            } else if (v10 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg12;
            } else if (v12 == 2) {
                v9 = arg13;
            } else if (v12 == 3) {
                v9 = arg14;
            } else if (v12 == 4) {
                v9 = arg15;
            } else if (v12 == 5) {
                v9 = arg16;
            } else if (v12 == 6) {
                v9 = arg17;
            } else if (v12 == 7) {
                v9 = arg18;
            } else if (v12 == 8) {
                v9 = arg19;
            } else if (v12 == 9) {
                v9 = arg20;
            } else if (v12 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg12;
            } else if (v14 == 2) {
                v9 = arg13;
            } else if (v14 == 3) {
                v9 = arg14;
            } else if (v14 == 4) {
                v9 = arg15;
            } else if (v14 == 5) {
                v9 = arg16;
            } else if (v14 == 6) {
                v9 = arg17;
            } else if (v14 == 7) {
                v9 = arg18;
            } else if (v14 == 8) {
                v9 = arg19;
            } else if (v14 == 9) {
                v9 = arg20;
            } else if (v14 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg12;
            } else if (v16 == 2) {
                v9 = arg13;
            } else if (v16 == 3) {
                v9 = arg14;
            } else if (v16 == 4) {
                v9 = arg15;
            } else if (v16 == 5) {
                v9 = arg16;
            } else if (v16 == 6) {
                v9 = arg17;
            } else if (v16 == 7) {
                v9 = arg18;
            } else if (v16 == 8) {
                v9 = arg19;
            } else if (v16 == 9) {
                v9 = arg20;
            } else if (v16 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg12;
            } else if (v18 == 2) {
                v9 = arg13;
            } else if (v18 == 3) {
                v9 = arg14;
            } else if (v18 == 4) {
                v9 = arg15;
            } else if (v18 == 5) {
                v9 = arg16;
            } else if (v18 == 6) {
                v9 = arg17;
            } else if (v18 == 7) {
                v9 = arg18;
            } else if (v18 == 8) {
                v9 = arg19;
            } else if (v18 == 9) {
                v9 = arg20;
            } else if (v18 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg12;
            } else if (v20 == 2) {
                v9 = arg13;
            } else if (v20 == 3) {
                v9 = arg14;
            } else if (v20 == 4) {
                v9 = arg15;
            } else if (v20 == 5) {
                v9 = arg16;
            } else if (v20 == 6) {
                v9 = arg17;
            } else if (v20 == 7) {
                v9 = arg18;
            } else if (v20 == 8) {
                v9 = arg19;
            } else if (v20 == 9) {
                v9 = arg20;
            } else if (v20 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg12;
            } else if (v22 == 2) {
                v9 = arg13;
            } else if (v22 == 3) {
                v9 = arg14;
            } else if (v22 == 4) {
                v9 = arg15;
            } else if (v22 == 5) {
                v9 = arg16;
            } else if (v22 == 6) {
                v9 = arg17;
            } else if (v22 == 7) {
                v9 = arg18;
            } else if (v22 == 8) {
                v9 = arg19;
            } else if (v22 == 9) {
                v9 = arg20;
            } else if (v22 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg12;
            } else if (v24 == 2) {
                v9 = arg13;
            } else if (v24 == 3) {
                v9 = arg14;
            } else if (v24 == 4) {
                v9 = arg15;
            } else if (v24 == 5) {
                v9 = arg16;
            } else if (v24 == 6) {
                v9 = arg17;
            } else if (v24 == 7) {
                v9 = arg18;
            } else if (v24 == 8) {
                v9 = arg19;
            } else if (v24 == 9) {
                v9 = arg20;
            } else if (v24 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg12;
            } else if (v26 == 2) {
                v9 = arg13;
            } else if (v26 == 3) {
                v9 = arg14;
            } else if (v26 == 4) {
                v9 = arg15;
            } else if (v26 == 5) {
                v9 = arg16;
            } else if (v26 == 6) {
                v9 = arg17;
            } else if (v26 == 7) {
                v9 = arg18;
            } else if (v26 == 8) {
                v9 = arg19;
            } else if (v26 == 9) {
                v9 = arg20;
            } else if (v26 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg12;
            } else if (v28 == 2) {
                v9 = arg13;
            } else if (v28 == 3) {
                v9 = arg14;
            } else if (v28 == 4) {
                v9 = arg15;
            } else if (v28 == 5) {
                v9 = arg16;
            } else if (v28 == 6) {
                v9 = arg17;
            } else if (v28 == 7) {
                v9 = arg18;
            } else if (v28 == 8) {
                v9 = arg19;
            } else if (v28 == 9) {
                v9 = arg20;
            } else if (v28 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v30 == 1) {
                v9 = arg12;
            } else if (v30 == 2) {
                v9 = arg13;
            } else if (v30 == 3) {
                v9 = arg14;
            } else if (v30 == 4) {
                v9 = arg15;
            } else if (v30 == 5) {
                v9 = arg16;
            } else if (v30 == 6) {
                v9 = arg17;
            } else if (v30 == 7) {
                v9 = arg18;
            } else if (v30 == 8) {
                v9 = arg19;
            } else if (v30 == 9) {
                v9 = arg20;
            } else if (v30 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v31 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v31, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v31, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v32 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v32 == 1) {
                v9 = arg12;
            } else if (v32 == 2) {
                v9 = arg13;
            } else if (v32 == 3) {
                v9 = arg14;
            } else if (v32 == 4) {
                v9 = arg15;
            } else if (v32 == 5) {
                v9 = arg16;
            } else if (v32 == 6) {
                v9 = arg17;
            } else if (v32 == 7) {
                v9 = arg18;
            } else if (v32 == 8) {
                v9 = arg19;
            } else if (v32 == 9) {
                v9 = arg20;
            } else if (v32 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v33 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v33, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v33, arg23);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v34 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v34 == 1) {
                v9 = arg12;
            } else if (v34 == 2) {
                v9 = arg13;
            } else if (v34 == 3) {
                v9 = arg14;
            } else if (v34 == 4) {
                v9 = arg15;
            } else if (v34 == 5) {
                v9 = arg16;
            } else if (v34 == 6) {
                v9 = arg17;
            } else if (v34 == 7) {
                v9 = arg18;
            } else if (v34 == 8) {
                v9 = arg19;
            } else if (v34 == 9) {
                v9 = arg20;
            } else if (v34 == 10) {
                v9 = arg21;
            } else {
                v9 = arg11;
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v35, arg2, v9, arg10, arg23);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v35, arg23);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg23);
        let (v36, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg23);
        let v38 = v36;
        if (arg22 < v36) {
            v38 = arg22;
        };
        v38
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg25));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223384307576340479);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg24), arg24);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg25));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223384621108953087);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg12;
            } else if (v10 == 2) {
                v9 = arg13;
            } else if (v10 == 3) {
                v9 = arg14;
            } else if (v10 == 4) {
                v9 = arg15;
            } else if (v10 == 5) {
                v9 = arg16;
            } else if (v10 == 6) {
                v9 = arg17;
            } else if (v10 == 7) {
                v9 = arg18;
            } else if (v10 == 8) {
                v9 = arg19;
            } else if (v10 == 9) {
                v9 = arg20;
            } else if (v10 == 10) {
                v9 = arg21;
            } else if (v10 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg12;
            } else if (v12 == 2) {
                v9 = arg13;
            } else if (v12 == 3) {
                v9 = arg14;
            } else if (v12 == 4) {
                v9 = arg15;
            } else if (v12 == 5) {
                v9 = arg16;
            } else if (v12 == 6) {
                v9 = arg17;
            } else if (v12 == 7) {
                v9 = arg18;
            } else if (v12 == 8) {
                v9 = arg19;
            } else if (v12 == 9) {
                v9 = arg20;
            } else if (v12 == 10) {
                v9 = arg21;
            } else if (v12 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg12;
            } else if (v14 == 2) {
                v9 = arg13;
            } else if (v14 == 3) {
                v9 = arg14;
            } else if (v14 == 4) {
                v9 = arg15;
            } else if (v14 == 5) {
                v9 = arg16;
            } else if (v14 == 6) {
                v9 = arg17;
            } else if (v14 == 7) {
                v9 = arg18;
            } else if (v14 == 8) {
                v9 = arg19;
            } else if (v14 == 9) {
                v9 = arg20;
            } else if (v14 == 10) {
                v9 = arg21;
            } else if (v14 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg12;
            } else if (v16 == 2) {
                v9 = arg13;
            } else if (v16 == 3) {
                v9 = arg14;
            } else if (v16 == 4) {
                v9 = arg15;
            } else if (v16 == 5) {
                v9 = arg16;
            } else if (v16 == 6) {
                v9 = arg17;
            } else if (v16 == 7) {
                v9 = arg18;
            } else if (v16 == 8) {
                v9 = arg19;
            } else if (v16 == 9) {
                v9 = arg20;
            } else if (v16 == 10) {
                v9 = arg21;
            } else if (v16 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg12;
            } else if (v18 == 2) {
                v9 = arg13;
            } else if (v18 == 3) {
                v9 = arg14;
            } else if (v18 == 4) {
                v9 = arg15;
            } else if (v18 == 5) {
                v9 = arg16;
            } else if (v18 == 6) {
                v9 = arg17;
            } else if (v18 == 7) {
                v9 = arg18;
            } else if (v18 == 8) {
                v9 = arg19;
            } else if (v18 == 9) {
                v9 = arg20;
            } else if (v18 == 10) {
                v9 = arg21;
            } else if (v18 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg12;
            } else if (v20 == 2) {
                v9 = arg13;
            } else if (v20 == 3) {
                v9 = arg14;
            } else if (v20 == 4) {
                v9 = arg15;
            } else if (v20 == 5) {
                v9 = arg16;
            } else if (v20 == 6) {
                v9 = arg17;
            } else if (v20 == 7) {
                v9 = arg18;
            } else if (v20 == 8) {
                v9 = arg19;
            } else if (v20 == 9) {
                v9 = arg20;
            } else if (v20 == 10) {
                v9 = arg21;
            } else if (v20 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg12;
            } else if (v22 == 2) {
                v9 = arg13;
            } else if (v22 == 3) {
                v9 = arg14;
            } else if (v22 == 4) {
                v9 = arg15;
            } else if (v22 == 5) {
                v9 = arg16;
            } else if (v22 == 6) {
                v9 = arg17;
            } else if (v22 == 7) {
                v9 = arg18;
            } else if (v22 == 8) {
                v9 = arg19;
            } else if (v22 == 9) {
                v9 = arg20;
            } else if (v22 == 10) {
                v9 = arg21;
            } else if (v22 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg12;
            } else if (v24 == 2) {
                v9 = arg13;
            } else if (v24 == 3) {
                v9 = arg14;
            } else if (v24 == 4) {
                v9 = arg15;
            } else if (v24 == 5) {
                v9 = arg16;
            } else if (v24 == 6) {
                v9 = arg17;
            } else if (v24 == 7) {
                v9 = arg18;
            } else if (v24 == 8) {
                v9 = arg19;
            } else if (v24 == 9) {
                v9 = arg20;
            } else if (v24 == 10) {
                v9 = arg21;
            } else if (v24 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg12;
            } else if (v26 == 2) {
                v9 = arg13;
            } else if (v26 == 3) {
                v9 = arg14;
            } else if (v26 == 4) {
                v9 = arg15;
            } else if (v26 == 5) {
                v9 = arg16;
            } else if (v26 == 6) {
                v9 = arg17;
            } else if (v26 == 7) {
                v9 = arg18;
            } else if (v26 == 8) {
                v9 = arg19;
            } else if (v26 == 9) {
                v9 = arg20;
            } else if (v26 == 10) {
                v9 = arg21;
            } else if (v26 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg12;
            } else if (v28 == 2) {
                v9 = arg13;
            } else if (v28 == 3) {
                v9 = arg14;
            } else if (v28 == 4) {
                v9 = arg15;
            } else if (v28 == 5) {
                v9 = arg16;
            } else if (v28 == 6) {
                v9 = arg17;
            } else if (v28 == 7) {
                v9 = arg18;
            } else if (v28 == 8) {
                v9 = arg19;
            } else if (v28 == 9) {
                v9 = arg20;
            } else if (v28 == 10) {
                v9 = arg21;
            } else if (v28 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v30 == 1) {
                v9 = arg12;
            } else if (v30 == 2) {
                v9 = arg13;
            } else if (v30 == 3) {
                v9 = arg14;
            } else if (v30 == 4) {
                v9 = arg15;
            } else if (v30 == 5) {
                v9 = arg16;
            } else if (v30 == 6) {
                v9 = arg17;
            } else if (v30 == 7) {
                v9 = arg18;
            } else if (v30 == 8) {
                v9 = arg19;
            } else if (v30 == 9) {
                v9 = arg20;
            } else if (v30 == 10) {
                v9 = arg21;
            } else if (v30 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v31 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v31, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v31, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v32 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v32 == 1) {
                v9 = arg12;
            } else if (v32 == 2) {
                v9 = arg13;
            } else if (v32 == 3) {
                v9 = arg14;
            } else if (v32 == 4) {
                v9 = arg15;
            } else if (v32 == 5) {
                v9 = arg16;
            } else if (v32 == 6) {
                v9 = arg17;
            } else if (v32 == 7) {
                v9 = arg18;
            } else if (v32 == 8) {
                v9 = arg19;
            } else if (v32 == 9) {
                v9 = arg20;
            } else if (v32 == 10) {
                v9 = arg21;
            } else if (v32 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v33 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v33, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v33, arg24);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v34 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v34 == 1) {
                v9 = arg12;
            } else if (v34 == 2) {
                v9 = arg13;
            } else if (v34 == 3) {
                v9 = arg14;
            } else if (v34 == 4) {
                v9 = arg15;
            } else if (v34 == 5) {
                v9 = arg16;
            } else if (v34 == 6) {
                v9 = arg17;
            } else if (v34 == 7) {
                v9 = arg18;
            } else if (v34 == 8) {
                v9 = arg19;
            } else if (v34 == 9) {
                v9 = arg20;
            } else if (v34 == 10) {
                v9 = arg21;
            } else if (v34 == 11) {
                v9 = arg22;
            } else {
                v9 = arg11;
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v35, arg2, v9, arg10, arg24);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v35, arg24);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg24);
        let (v36, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg24);
        let v38 = v36;
        if (arg23 < v36) {
            v38 = arg23;
        };
        v38
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg26));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223385566001758207);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg25), arg25);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg26));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223385901009207295);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v10 == 1) {
                v9 = arg12;
            } else if (v10 == 2) {
                v9 = arg13;
            } else if (v10 == 3) {
                v9 = arg14;
            } else if (v10 == 4) {
                v9 = arg15;
            } else if (v10 == 5) {
                v9 = arg16;
            } else if (v10 == 6) {
                v9 = arg17;
            } else if (v10 == 7) {
                v9 = arg18;
            } else if (v10 == 8) {
                v9 = arg19;
            } else if (v10 == 9) {
                v9 = arg20;
            } else if (v10 == 10) {
                v9 = arg21;
            } else if (v10 == 11) {
                v9 = arg22;
            } else if (v10 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v12 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v12 == 1) {
                v9 = arg12;
            } else if (v12 == 2) {
                v9 = arg13;
            } else if (v12 == 3) {
                v9 = arg14;
            } else if (v12 == 4) {
                v9 = arg15;
            } else if (v12 == 5) {
                v9 = arg16;
            } else if (v12 == 6) {
                v9 = arg17;
            } else if (v12 == 7) {
                v9 = arg18;
            } else if (v12 == 8) {
                v9 = arg19;
            } else if (v12 == 9) {
                v9 = arg20;
            } else if (v12 == 10) {
                v9 = arg21;
            } else if (v12 == 11) {
                v9 = arg22;
            } else if (v12 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v14 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v14 == 1) {
                v9 = arg12;
            } else if (v14 == 2) {
                v9 = arg13;
            } else if (v14 == 3) {
                v9 = arg14;
            } else if (v14 == 4) {
                v9 = arg15;
            } else if (v14 == 5) {
                v9 = arg16;
            } else if (v14 == 6) {
                v9 = arg17;
            } else if (v14 == 7) {
                v9 = arg18;
            } else if (v14 == 8) {
                v9 = arg19;
            } else if (v14 == 9) {
                v9 = arg20;
            } else if (v14 == 10) {
                v9 = arg21;
            } else if (v14 == 11) {
                v9 = arg22;
            } else if (v14 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v16 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v16 == 1) {
                v9 = arg12;
            } else if (v16 == 2) {
                v9 = arg13;
            } else if (v16 == 3) {
                v9 = arg14;
            } else if (v16 == 4) {
                v9 = arg15;
            } else if (v16 == 5) {
                v9 = arg16;
            } else if (v16 == 6) {
                v9 = arg17;
            } else if (v16 == 7) {
                v9 = arg18;
            } else if (v16 == 8) {
                v9 = arg19;
            } else if (v16 == 9) {
                v9 = arg20;
            } else if (v16 == 10) {
                v9 = arg21;
            } else if (v16 == 11) {
                v9 = arg22;
            } else if (v16 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v18 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v18 == 1) {
                v9 = arg12;
            } else if (v18 == 2) {
                v9 = arg13;
            } else if (v18 == 3) {
                v9 = arg14;
            } else if (v18 == 4) {
                v9 = arg15;
            } else if (v18 == 5) {
                v9 = arg16;
            } else if (v18 == 6) {
                v9 = arg17;
            } else if (v18 == 7) {
                v9 = arg18;
            } else if (v18 == 8) {
                v9 = arg19;
            } else if (v18 == 9) {
                v9 = arg20;
            } else if (v18 == 10) {
                v9 = arg21;
            } else if (v18 == 11) {
                v9 = arg22;
            } else if (v18 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v20 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v20 == 1) {
                v9 = arg12;
            } else if (v20 == 2) {
                v9 = arg13;
            } else if (v20 == 3) {
                v9 = arg14;
            } else if (v20 == 4) {
                v9 = arg15;
            } else if (v20 == 5) {
                v9 = arg16;
            } else if (v20 == 6) {
                v9 = arg17;
            } else if (v20 == 7) {
                v9 = arg18;
            } else if (v20 == 8) {
                v9 = arg19;
            } else if (v20 == 9) {
                v9 = arg20;
            } else if (v20 == 10) {
                v9 = arg21;
            } else if (v20 == 11) {
                v9 = arg22;
            } else if (v20 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v21 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v22 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v22 == 1) {
                v9 = arg12;
            } else if (v22 == 2) {
                v9 = arg13;
            } else if (v22 == 3) {
                v9 = arg14;
            } else if (v22 == 4) {
                v9 = arg15;
            } else if (v22 == 5) {
                v9 = arg16;
            } else if (v22 == 6) {
                v9 = arg17;
            } else if (v22 == 7) {
                v9 = arg18;
            } else if (v22 == 8) {
                v9 = arg19;
            } else if (v22 == 9) {
                v9 = arg20;
            } else if (v22 == 10) {
                v9 = arg21;
            } else if (v22 == 11) {
                v9 = arg22;
            } else if (v22 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v23 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v24 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v24 == 1) {
                v9 = arg12;
            } else if (v24 == 2) {
                v9 = arg13;
            } else if (v24 == 3) {
                v9 = arg14;
            } else if (v24 == 4) {
                v9 = arg15;
            } else if (v24 == 5) {
                v9 = arg16;
            } else if (v24 == 6) {
                v9 = arg17;
            } else if (v24 == 7) {
                v9 = arg18;
            } else if (v24 == 8) {
                v9 = arg19;
            } else if (v24 == 9) {
                v9 = arg20;
            } else if (v24 == 10) {
                v9 = arg21;
            } else if (v24 == 11) {
                v9 = arg22;
            } else if (v24 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v25 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v26 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v26 == 1) {
                v9 = arg12;
            } else if (v26 == 2) {
                v9 = arg13;
            } else if (v26 == 3) {
                v9 = arg14;
            } else if (v26 == 4) {
                v9 = arg15;
            } else if (v26 == 5) {
                v9 = arg16;
            } else if (v26 == 6) {
                v9 = arg17;
            } else if (v26 == 7) {
                v9 = arg18;
            } else if (v26 == 8) {
                v9 = arg19;
            } else if (v26 == 9) {
                v9 = arg20;
            } else if (v26 == 10) {
                v9 = arg21;
            } else if (v26 == 11) {
                v9 = arg22;
            } else if (v26 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v27 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v28 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v28 == 1) {
                v9 = arg12;
            } else if (v28 == 2) {
                v9 = arg13;
            } else if (v28 == 3) {
                v9 = arg14;
            } else if (v28 == 4) {
                v9 = arg15;
            } else if (v28 == 5) {
                v9 = arg16;
            } else if (v28 == 6) {
                v9 = arg17;
            } else if (v28 == 7) {
                v9 = arg18;
            } else if (v28 == 8) {
                v9 = arg19;
            } else if (v28 == 9) {
                v9 = arg20;
            } else if (v28 == 10) {
                v9 = arg21;
            } else if (v28 == 11) {
                v9 = arg22;
            } else if (v28 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v30 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v30 == 1) {
                v9 = arg12;
            } else if (v30 == 2) {
                v9 = arg13;
            } else if (v30 == 3) {
                v9 = arg14;
            } else if (v30 == 4) {
                v9 = arg15;
            } else if (v30 == 5) {
                v9 = arg16;
            } else if (v30 == 6) {
                v9 = arg17;
            } else if (v30 == 7) {
                v9 = arg18;
            } else if (v30 == 8) {
                v9 = arg19;
            } else if (v30 == 9) {
                v9 = arg20;
            } else if (v30 == 10) {
                v9 = arg21;
            } else if (v30 == 11) {
                v9 = arg22;
            } else if (v30 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v31 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T12>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T12>(&mut v31, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T12>(arg9, v31, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v32 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v32 == 1) {
                v9 = arg12;
            } else if (v32 == 2) {
                v9 = arg13;
            } else if (v32 == 3) {
                v9 = arg14;
            } else if (v32 == 4) {
                v9 = arg15;
            } else if (v32 == 5) {
                v9 = arg16;
            } else if (v32 == 6) {
                v9 = arg17;
            } else if (v32 == 7) {
                v9 = arg18;
            } else if (v32 == 8) {
                v9 = arg19;
            } else if (v32 == 9) {
                v9 = arg20;
            } else if (v32 == 10) {
                v9 = arg21;
            } else if (v32 == 11) {
                v9 = arg22;
            } else if (v32 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v33 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T13>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T13>(&mut v33, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T13>(arg9, v33, arg25);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            let v34 = 0x1::vector::pop_back<u8>(&mut arg4);
            if (v34 == 1) {
                v9 = arg12;
            } else if (v34 == 2) {
                v9 = arg13;
            } else if (v34 == 3) {
                v9 = arg14;
            } else if (v34 == 4) {
                v9 = arg15;
            } else if (v34 == 5) {
                v9 = arg16;
            } else if (v34 == 6) {
                v9 = arg17;
            } else if (v34 == 7) {
                v9 = arg18;
            } else if (v34 == 8) {
                v9 = arg19;
            } else if (v34 == 9) {
                v9 = arg20;
            } else if (v34 == 10) {
                v9 = arg21;
            } else if (v34 == 11) {
                v9 = arg22;
            } else if (v34 == 12) {
                v9 = arg23;
            } else {
                v9 = arg11;
            };
            let v35 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T14>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T14>(&mut v35, arg2, v9, arg10, arg25);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T14>(arg9, v35, arg25);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg25);
        let (v36, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg25);
        let v38 = v36;
        if (arg24 < v36) {
            v38 = arg24;
        };
        v38
    }

    // decompiled from Move bytecode v7
}

