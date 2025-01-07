module 0xfb8c4cba0c00b461ce4396edcab59306e71b0815b3863868200470bb786b4c61::z {
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
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223379398428721151);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
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
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223379677601595391);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun E<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 79226673515401279992447579055;
        let v1 = false;
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, v1, false, arg13, v0, arg12);
        let v5 = v4;
        0x2::balance::destroy_zero<T0>(v3);
        let (v6, v7) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v2, arg14), arg6, arg7, arg12, arg14);
        let v8 = v7;
        let v9 = v6;
        if (0x2::coin::value<T2>(&v9) == 0) {
            0x2::coin::destroy_zero<T2>(v9);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v9, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, v1, true, 0x2::coin::value<T1>(&v8), v0, arg12);
        let v13 = v10;
        0x2::balance::destroy_zero<T1>(v11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v8), v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v5)), v5);
        let v14 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v14 & 18446744073709551615) as u64) ^ ((v14 >> 64 & 18446744073709551615) as u64) ^ ((v14 >> 128 & 18446744073709551615) as u64) ^ ((v14 >> 192) as u64) == 9459194608057385379, 9223380008314077183);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun F<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
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
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v6), 79226673515401279992447579055, arg12);
        let v11 = v8;
        0x2::balance::destroy_zero<T1>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v6), v10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::split<T0>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v3)), 0x2::balance::zero<T2>(), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223380339026558975);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun G<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
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
        if (0x2::coin::value<T2>(&v7) == 0) {
            0x2::coin::destroy_zero<T2>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v6), 4295048016, arg12);
        let v11 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v6), 0x2::balance::zero<T1>(), v10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v3)), v3);
        let v12 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v12 & 18446744073709551615) as u64) ^ ((v12 >> 64 & 18446744073709551615) as u64) ^ ((v12 >> 128 & 18446744073709551615) as u64) ^ ((v12 >> 192) as u64) == 9459194608057385379, 9223380669739040767);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun H<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0x2::clock::Clock, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 4295048016;
        let v1 = true;
        if (arg13 == 0) {
            return
        };
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg4)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg9, arg10, arg11, arg4, arg5, arg6, arg7, arg12, arg14);
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, v1, false, arg13, v0, arg12);
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v2);
        let (v6, v7) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T2, T0>(arg3, arg4, arg5, 0x2::coin::from_balance<T2>(v3, arg14), arg6, arg7, arg12, arg14);
        let v8 = v7;
        let v9 = v6;
        if (0x2::coin::value<T2>(&v9) == 0) {
            0x2::coin::destroy_zero<T2>(v9);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v9, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, v1, true, 0x2::coin::value<T0>(&v8), v0, arg12);
        let v13 = v11;
        0x2::balance::destroy_zero<T0>(v10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v8), 0x2::balance::zero<T1>(), v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v5)), 0x2::balance::zero<T2>(), v5);
        let v14 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v14 & 18446744073709551615) as u64) ^ ((v14 >> 64 & 18446744073709551615) as u64) ^ ((v14 >> 128 & 18446744073709551615) as u64) ^ ((v14 >> 192) as u64) == 9459194608057385379, 9223381000451522559);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v13, arg14), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun b<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u64 {
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
            let v5 = 0x2::address::to_u256(0x2::tx_context::sender(arg13));
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223372419106865151);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg12), arg12);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg13), arg12);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg13));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223372496416276479);
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v9 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v9, arg2, arg11, arg10, arg12);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v9, arg12);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v10, arg2, arg11, arg10, arg12);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v10, arg12);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v11, arg2, arg11, arg10, arg12);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v11, arg12);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v12, arg2, arg11, arg10, arg12);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v12, arg12);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v13, arg2, arg11, arg10, arg12);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v13, arg12);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v14, arg2, arg11, arg10, arg12);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v14, arg12);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v15, arg2, arg11, arg10, arg12);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v15, arg12);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v16, arg2, arg11, arg10, arg12);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v16, arg12);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v17, arg2, arg11, arg10, arg12);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v17, arg12);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            0x1::vector::pop_back<u8>(&mut arg4);
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v18, arg2, arg11, arg10, arg12);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v18, arg12);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg12);
        let (v19, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg12);
        v19
    }

    public fun c<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
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
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223373196495945727);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v4);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v4);
            let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v4, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v4) as u64)), arg13), arg13);
            let v7 = v6;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v6, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223373295280193535);
        let v9;
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v10 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T2>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v10, arg2, v9, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v10, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v11 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T3>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v11, arg2, v9, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v11, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v12 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T4>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v12, arg2, v9, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v12, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v13 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T5>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v13, arg2, v9, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v13, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v14 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T6>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v14, arg2, v9, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v14, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v15 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T7>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v15, arg2, v9, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v15, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v16 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T8>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v16, arg2, v9, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v16, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v17 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T9>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v17, arg2, v9, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v17, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v18 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T10>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v18, arg2, v9, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v18, arg13);
        };
        if (!0x1::vector::is_empty<u8>(&arg4)) {
            if (0x1::vector::pop_back<u8>(&mut arg4) == 1) {
                v9 = arg12;
            } else {
                v9 = arg11;
            };
            let v19 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v19, arg2, v9, arg10, arg13);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v19, arg13);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg13);
        let (v20, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg13);
        v20
    }

    public fun d<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
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
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223374003949797375);
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
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223374124208881663);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg14);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg14);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg14);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg14);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg14);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg14);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg14);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg14);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg14);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg14);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg14);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg14);
        let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg14);
        v30
    }

    public fun e<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
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
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223374841468420095);
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
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223374983202340863);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T2>(&mut v11, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T2>(arg9, v11, arg15);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T3>(&mut v13, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T3>(arg9, v13, arg15);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T4>(&mut v15, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T4>(arg9, v15, arg15);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T5>(&mut v17, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T5>(arg9, v17, arg15);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T6>(&mut v19, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T6>(arg9, v19, arg15);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T7>(&mut v21, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T7>(arg9, v21, arg15);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T8>(&mut v23, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T8>(arg9, v23, arg15);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T9>(&mut v25, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T9>(arg9, v25, arg15);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T10>(&mut v27, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T10>(arg9, v27, arg15);
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
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg15);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg15);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg15);
        let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg15);
        v30
    }

    public fun f<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u64 {
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
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223375709051813887);
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
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223375872260571135);
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
            } else if (v12 == 4) {
                v9 = arg15;
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
            } else if (v14 == 4) {
                v9 = arg15;
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
            } else if (v16 == 4) {
                v9 = arg15;
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
            } else if (v18 == 4) {
                v9 = arg15;
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
            } else if (v20 == 4) {
                v9 = arg15;
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
            } else if (v22 == 4) {
                v9 = arg15;
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
            } else if (v24 == 4) {
                v9 = arg15;
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
            } else if (v26 == 4) {
                v9 = arg15;
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
            } else if (v28 == 4) {
                v9 = arg15;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg16);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg16);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg16);
        let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg16);
        v30
    }

    public fun g<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : u64 {
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
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223376606699978751);
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
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223376791383572479);
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
            } else if (v12 == 5) {
                v9 = arg16;
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
            } else if (v14 == 5) {
                v9 = arg16;
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
            } else if (v16 == 5) {
                v9 = arg16;
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
            } else if (v18 == 5) {
                v9 = arg16;
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
            } else if (v20 == 5) {
                v9 = arg16;
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
            } else if (v22 == 5) {
                v9 = arg16;
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
            } else if (v24 == 5) {
                v9 = arg16;
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
            } else if (v26 == 5) {
                v9 = arg16;
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
            } else if (v28 == 5) {
                v9 = arg16;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg17);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg17);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg17);
        let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg17);
        v30
    }

    public fun h<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : u64 {
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
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223377534412914687);
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
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223377740571344895);
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
            } else if (v12 == 6) {
                v9 = arg17;
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
            } else if (v14 == 6) {
                v9 = arg17;
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
            } else if (v16 == 6) {
                v9 = arg17;
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
            } else if (v18 == 6) {
                v9 = arg17;
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
            } else if (v20 == 6) {
                v9 = arg17;
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
            } else if (v22 == 6) {
                v9 = arg17;
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
            } else if (v24 == 6) {
                v9 = arg17;
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
            } else if (v26 == 6) {
                v9 = arg17;
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
            } else if (v28 == 6) {
                v9 = arg17;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg18);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg18);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg18);
        let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg18);
        v30
    }

    public fun i<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::pyth_registry::PythRegistry, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : u64 {
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
            assert!(((v5 & 18446744073709551615) as u64) ^ ((v5 >> 64 & 18446744073709551615) as u64) ^ ((v5 >> 128 & 18446744073709551615) as u64) ^ ((v5 >> 192) as u64) == 9459194608057385379, 9223378492190621695);
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
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v7);
        };
        let v8 = 0x2::address::to_u256(0x2::tx_context::sender(arg20));
        assert!(((v8 & 18446744073709551615) as u64) ^ ((v8 >> 64 & 18446744073709551615) as u64) ^ ((v8 >> 128 & 18446744073709551615) as u64) ^ ((v8 >> 192) as u64) == 9459194608057385379, 9223378719823888383);
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
            } else if (v12 == 7) {
                v9 = arg18;
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
            } else if (v14 == 7) {
                v9 = arg18;
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
            } else if (v16 == 7) {
                v9 = arg18;
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
            } else if (v18 == 7) {
                v9 = arg18;
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
            } else if (v20 == 7) {
                v9 = arg18;
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
            } else if (v22 == 7) {
                v9 = arg18;
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
            } else if (v24 == 7) {
                v9 = arg18;
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
            } else if (v26 == 7) {
                v9 = arg18;
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
            } else if (v28 == 7) {
                v9 = arg18;
            } else {
                v9 = arg11;
            };
            let v29 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T11>(arg9);
            0x910f30cbc7f601f75a5141a01265cd47c62d468707c5e1aecb32a18f448cb25a::rule::set_price<T11>(&mut v29, arg2, v9, arg10, arg19);
            0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T11>(arg9, v29, arg19);
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg5, arg7, arg6, arg19);
        let (v30, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg6, arg7, arg8, arg9, arg19);
        v30
    }

    // decompiled from Move bytecode v7
}

