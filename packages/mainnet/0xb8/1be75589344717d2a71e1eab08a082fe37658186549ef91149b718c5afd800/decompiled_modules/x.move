module 0xb81be75589344717d2a71e1eab08a082fe37658186549ef91149b718c5afd800::x {
    public fun AAA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::AAA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun AAC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::AAC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun AA__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, false, arg8, 4295048017, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg10);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let v5 = if (arg6 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, arg7, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg10);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6, &v8, arg9, arg10);
            let v9 = 0x2::object::new(arg10);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, v8, arg10)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T0>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T0>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, arg6, arg7, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v11), arg10))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&v12), 4295048017, arg7);
        let v16 = v14;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v12, 0x2::balance::zero<T1>(), v15);
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v16) < v17) {
            let (v19, v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, false, true, v18, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T2>(v20);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(v4), v21);
            0x2::balance::join<T1>(&mut v16, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v16) < v17) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v16, v17), 0x2::balance::zero<T2>(), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906855567575482367);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v16, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AA_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, true, false, arg8, 4295048017, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg11);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg11);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg3, arg6, arg7, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg11), arg9, arg11));
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T1>(arg0, arg1, true, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 4295048017, arg7);
        let v11 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg2, false, true, v13, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T2>(v15);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(v4), v16);
            0x2::balance::join<T1>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v11) < v12) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906856941965017087);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AAa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::AAa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun AAc_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::AAc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun ACA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::ACA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun ACC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::ACC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun AC__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg8, arg1, arg3, true, false, arg9, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg11);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let v5 = if (arg7 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, arg8, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg11);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg4, arg7, &v8, arg10, arg11);
            let v9 = 0x2::object::new(arg11);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, v8, arg11)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T0>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T0>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg4, arg7, arg8, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v11), arg11))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v12), 4295048017, arg8);
        let v16 = v14;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v12, 0x2::balance::zero<T1>(), v15);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v16) < v17) {
            let (v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg8, arg1, arg3, false, true, v18, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T2>(v20);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg3, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(v4), v21);
            0x2::balance::join<T1>(&mut v16, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v16) < v17) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg3, 0x2::balance::split<T1>(&mut v16, v17), 0x2::balance::zero<T2>(), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906858505333112831);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v16, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AC_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg8, arg1, arg3, true, false, arg9, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg12);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg12);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg11, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg4, arg7, arg8, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg12), arg10, arg12));
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T1>(arg0, arg2, true, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 4295048017, arg8);
        let v11 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg8, arg1, arg3, false, true, v13, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T2>(v15);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg3, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(v4), v16);
            0x2::balance::join<T1>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v11) < v12) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg3, 0x2::balance::split<T1>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg12));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906859914082385919);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg12), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ACa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::ACa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun ACc_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::ACc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun A___<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg7 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg7, 4295048017, arg6);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg9);
        if (0x2::coin::value<T1>(&v4) < arg7) {
            abort 1888
        };
        let v5 = if (arg5 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1, 0x2::sui::SUI>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg9);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2, arg5, arg6, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg9);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, arg5, &v8, arg8, arg9);
            let v9 = 0x2::object::new(arg9);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2, arg5, v8, arg9)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T0>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1, T0>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg9);
            0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, arg5, arg6, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v11), arg9))
        };
        let v12 = v5;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v14 = 0x2::coin::value<T1>(&v4);
        if (v14 == 0) {
            0x2::coin::destroy_zero<T1>(v4);
        } else if (0x2::balance::value<T0>(&v12) < v13) {
            let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v14, 79226673515401279992447579054, arg6);
            0x2::balance::destroy_zero<T1>(v16);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v4), v17);
            0x2::balance::join<T0>(&mut v12, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v12) < v13) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v12, v13), 0x2::balance::zero<T1>(), v3);
        let v18 = 0x2::address::to_u256(0x2::tx_context::sender(arg9));
        assert!(((v18 & 18446744073709551615) as u64) ^ ((v18 >> 192) as u64) == 12024643074136871427, 13906852810206478335);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg9), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun A__u<T0, T1, T2: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg7 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T1>(arg0, arg1, true, false, arg7, 4295048017, arg6);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg10);
        if (0x2::coin::value<T1>(&v4) < arg7) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1, T2>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg10);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T2>(arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2>(arg2, arg5, arg6, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2>>(v6), arg10), arg8, arg10));
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T1>(&v3);
        let v9 = 0x2::coin::value<T1>(&v4);
        if (v9 == 0) {
            0x2::coin::destroy_zero<T1>(v4);
        } else if (0x2::balance::value<0x2::sui::SUI>(&v7) < v8) {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T1>(arg0, arg1, false, true, v9, 79226673515401279992447579054, arg6);
            0x2::balance::destroy_zero<T1>(v11);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg0, arg1, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<T1>(v4), v12);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v10);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v7) < v8) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v8), 0x2::balance::zero<T1>(), v3);
        let v13 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v13 & 18446744073709551615) as u64) ^ ((v13 >> 192) as u64) == 12024643074136871427, 13906852157371449343);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun AaA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::AaA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun AaC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::AaC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun Aa__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, false, arg8, 79226673515401279992447579054, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg10);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let v5 = if (arg6 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, arg7, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg10);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6, &v8, arg9, arg10);
            let v9 = 0x2::object::new(arg10);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, v8, arg10)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T0>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T0>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, arg6, arg7, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v11), arg10))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&v12), 4295048017, arg7);
        let v16 = v14;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v12, 0x2::balance::zero<T1>(), v15);
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v16) < v17) {
            let (v19, v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, true, true, v18, 4295048017, arg7);
            0x2::balance::destroy_zero<T2>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T1>(), v21);
            0x2::balance::join<T1>(&mut v16, v20);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v16) < v17) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v16, v17), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906855185323393023);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v16, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Aa_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, false, false, arg8, 79226673515401279992447579054, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg11);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg11);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg3, arg6, arg7, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg11), arg9, arg11));
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T1>(arg0, arg1, true, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 4295048017, arg7);
        let v11 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg2, true, true, v13, 4295048017, arg7);
            0x2::balance::destroy_zero<T2>(v14);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T1>(), v16);
            0x2::balance::join<T1>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v11) < v12) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906856598367633407);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Aaa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::Aaa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun Aac_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::Aac_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun AcA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::AcA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun AcC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::AcC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun Ac__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg8, arg1, arg3, false, false, arg9, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg11);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let v5 = if (arg7 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, arg8, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg11);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg4, arg7, &v8, arg10, arg11);
            let v9 = 0x2::object::new(arg11);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, v8, arg11)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T0>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T0>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg4, arg7, arg8, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v11), arg11))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, true, true, 0x2::balance::value<T0>(&v12), 4295048017, arg8);
        let v16 = v14;
        0x2::balance::destroy_zero<T0>(v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, v12, 0x2::balance::zero<T1>(), v15);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v16) < v17) {
            let (v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg8, arg1, arg3, true, true, v18, 4295048017);
            0x2::balance::destroy_zero<T2>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T1>(), v21);
            0x2::balance::join<T1>(&mut v16, v20);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v16) < v17) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v16, v17), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906858114491088895);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v16, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Ac_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg8, arg1, arg3, false, false, arg9, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg12);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg12);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg11, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg4, arg7, arg8, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg12), arg10, arg12));
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T1>(arg0, arg2, true, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 4295048017, arg8);
        let v11 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg0, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg8, arg1, arg3, true, true, v13, 4295048017);
            0x2::balance::destroy_zero<T2>(v14);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T1>(), v16);
            0x2::balance::join<T1>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v11) < v12) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg12));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906859561895067647);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg12), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Aca_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::Aca_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun Acc_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::Acc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun CAA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CAA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun CAC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CAC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun CA__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, true, false, arg9, 4295048017, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg11);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let v5 = if (arg7 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, arg8, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg11);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg4, arg7, &v8, arg10, arg11);
            let v9 = 0x2::object::new(arg11);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, v8, arg11)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T0>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T0>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg4, arg7, arg8, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v11), arg11))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg8, arg1, arg2, true, true, 0x2::balance::value<T0>(&v12), 4295048017);
        let v16 = v14;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v12, 0x2::balance::zero<T1>(), v15);
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v16) < v17) {
            let (v19, v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, false, true, v18, 79226673515401279992447579054, arg8);
            0x2::balance::destroy_zero<T2>(v20);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(v4), v21);
            0x2::balance::join<T1>(&mut v16, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v16) < v17) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, 0x2::balance::split<T1>(&mut v16, v17), 0x2::balance::zero<T2>(), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906861477450481663);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v16, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CA_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, true, false, arg9, 4295048017, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg12);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg12);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg11, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg4, arg7, arg8, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg12), arg10, arg12));
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T1>(arg8, arg1, arg2, true, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg3, false, true, v13, 79226673515401279992447579054, arg8);
            0x2::balance::destroy_zero<T2>(v15);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(v4), v16);
            0x2::balance::join<T1>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v11) < v12) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg3, 0x2::balance::split<T1>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg12));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906862886199754751);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg12), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CAa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CAa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun CAc_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CAc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun CCA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CCA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun CCC_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CCC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun CC__<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg7, arg0, arg2, true, false, arg8, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg10);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let v5 = if (arg6 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, arg7, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg10);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6, &v8, arg9, arg10);
            let v9 = 0x2::object::new(arg10);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, v8, arg10)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T0>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T0>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, arg6, arg7, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v11), arg10))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg0, arg1, true, true, 0x2::balance::value<T0>(&v12), 4295048017);
        let v16 = v14;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v12, 0x2::balance::zero<T1>(), v15);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v16) < v17) {
            let (v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg7, arg0, arg2, false, true, v18, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T2>(v20);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(v4), v21);
            0x2::balance::join<T1>(&mut v16, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v16) < v17) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v16, v17), 0x2::balance::zero<T2>(), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906864415208112127);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v16, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CC_u<T0, T1, T2, T3: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg7, arg0, arg2, true, false, arg8, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg11);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg11);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg3, arg6, arg7, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg11), arg9, arg11));
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T1>(arg7, arg0, arg1, true, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg7, arg0, arg2, false, true, v13, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T2>(v15);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(v4), v16);
            0x2::balance::join<T1>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v11) < v12) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg0, arg2, 0x2::balance::split<T1>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906865789597646847);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CCa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CCa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun CCc_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CCc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun C___<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg7 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg6, arg0, arg1, true, false, arg7, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg9);
        if (0x2::coin::value<T1>(&v4) < arg7) {
            abort 1888
        };
        let v5 = if (arg5 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1, 0x2::sui::SUI>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg9);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2, arg5, arg6, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg9);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, arg5, &v8, arg8, arg9);
            let v9 = 0x2::object::new(arg9);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2, arg5, v8, arg9)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T0>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1, T0>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg9);
            0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, arg5, arg6, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v11), arg9))
        };
        let v12 = v5;
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3);
        let v14 = 0x2::coin::value<T1>(&v4);
        if (v14 == 0) {
            0x2::coin::destroy_zero<T1>(v4);
        } else if (0x2::balance::value<T0>(&v12) < v13) {
            let (v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg6, arg0, arg1, false, true, v14, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T1>(v16);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v4), v17);
            0x2::balance::join<T0>(&mut v12, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v12) < v13) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v12, v13), 0x2::balance::zero<T1>(), v3);
        let v18 = 0x2::address::to_u256(0x2::tx_context::sender(arg9));
        assert!(((v18 & 18446744073709551615) as u64) ^ ((v18 >> 192) as u64) == 12024643074136871427, 13906854038567124991);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg9), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun C__u<T0, T1, T2: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg7 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T1>(arg6, arg0, arg1, true, false, arg7, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg10);
        if (0x2::coin::value<T1>(&v4) < arg7) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1, T2>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg10);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T2>(arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2>(arg2, arg5, arg6, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2>>(v6), arg10), arg8, arg10));
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T1>(&v3);
        let v9 = 0x2::coin::value<T1>(&v4);
        if (v9 == 0) {
            0x2::coin::destroy_zero<T1>(v4);
        } else if (0x2::balance::value<0x2::sui::SUI>(&v7) < v8) {
            let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T1>(arg6, arg0, arg1, false, true, v9, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T1>(v11);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg0, arg1, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::coin::into_balance<T1>(v4), v12);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v10);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v7) < v8) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v8), 0x2::balance::zero<T1>(), v3);
        let v13 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v13 & 18446744073709551615) as u64) ^ ((v13 >> 192) as u64) == 12024643074136871427, 13906853385732095999);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun CaA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CaA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun CaC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CaC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun Ca__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, arg9, 79226673515401279992447579054, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg11);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let v5 = if (arg7 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, arg8, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg11);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg4, arg7, &v8, arg10, arg11);
            let v9 = 0x2::object::new(arg11);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, v8, arg11)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T0>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T0>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg4, arg7, arg8, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v11), arg11))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg8, arg1, arg2, true, true, 0x2::balance::value<T0>(&v12), 4295048017);
        let v16 = v14;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v12, 0x2::balance::zero<T1>(), v15);
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v16) < v17) {
            let (v19, v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, true, true, v18, 4295048017, arg8);
            0x2::balance::destroy_zero<T2>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T1>(), v21);
            0x2::balance::join<T1>(&mut v16, v20);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v16) < v17) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v16, v17), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906861086608457727);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v16, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Ca_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, false, false, arg9, 79226673515401279992447579054, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg12);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg12);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg11, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg4, arg7, arg8, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg12), arg10, arg12));
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T1>(arg8, arg1, arg2, true, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg3, true, true, v13, 4295048017, arg8);
            0x2::balance::destroy_zero<T2>(v14);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T1>(), v16);
            0x2::balance::join<T1>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v11) < v12) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg12));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906862534012436479);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg12), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Caa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::Caa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun Cac_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::Cac_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun CcA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CcA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun CcC_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::CcC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun Cc__<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg7, arg0, arg2, false, false, arg8, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg10);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let v5 = if (arg6 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, arg7, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg10);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6, &v8, arg9, arg10);
            let v9 = 0x2::object::new(arg10);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, v8, arg10)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T0>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T0>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, arg6, arg7, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v11), arg10))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg0, arg1, true, true, 0x2::balance::value<T0>(&v12), 4295048017);
        let v16 = v14;
        0x2::balance::destroy_zero<T0>(v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v12, 0x2::balance::zero<T1>(), v15);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v16) < v17) {
            let (v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg7, arg0, arg2, true, true, v18, 4295048017);
            0x2::balance::destroy_zero<T2>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T1>(), v21);
            0x2::balance::join<T1>(&mut v16, v20);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v16) < v17) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v16, v17), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906864032956022783);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v16, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Cc_u<T0, T1, T2, T3: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg7, arg0, arg2, false, false, arg8, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg11);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg11);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg3, arg6, arg7, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg11), arg9, arg11));
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T1>(arg7, arg0, arg1, true, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 4295048017);
        let v11 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg0, arg1, v7, 0x2::balance::zero<T1>(), v10);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T1>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg7, arg0, arg2, true, true, v13, 4295048017);
            0x2::balance::destroy_zero<T2>(v14);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T1>(), v16);
            0x2::balance::join<T1>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v11) < v12) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906865446000263167);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun Cca_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::Cca_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun Ccc_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::Ccc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun aAA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aAA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun aAC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aAC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun aA__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, true, false, arg8, 4295048017, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg10);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let v5 = if (arg6 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, arg7, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg10);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6, &v8, arg9, arg10);
            let v9 = 0x2::object::new(arg10);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, v8, arg10)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T1>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T1>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg3, arg6, arg7, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(v11), arg10))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v12), 79226673515401279992447579054, arg7);
        let v16 = v13;
        0x2::balance::destroy_zero<T1>(v14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v12, v15);
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v16) < v17) {
            let (v19, v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, false, true, v18, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T2>(v20);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(v4), v21);
            0x2::balance::join<T0>(&mut v16, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v16) < v17) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::split<T0>(&mut v16, v17), 0x2::balance::zero<T2>(), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906854803071303679);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aA_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, true, false, arg8, 4295048017, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg11);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg11);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg3, arg6, arg7, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg11), arg9, arg11));
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 79226673515401279992447579054, arg7);
        let v11 = v8;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, false, true, v13, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T2>(v15);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(v4), v16);
            0x2::balance::join<T0>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v11) < v12) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::split<T0>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906856254770249727);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aAa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aAa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun aAc_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aAc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun aCA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aCA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun aCC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aCC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun aC__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg8, arg1, arg3, true, false, arg9, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg11);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let v5 = if (arg7 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, arg8, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg11);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg4, arg7, &v8, arg10, arg11);
            let v9 = 0x2::object::new(arg11);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, v8, arg11)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T1>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T1>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg4, arg7, arg8, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(v11), arg11))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v12), 79226673515401279992447579054, arg8);
        let v16 = v13;
        0x2::balance::destroy_zero<T1>(v14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v12, v15);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T2>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v16) < v17) {
            let (v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg8, arg1, arg3, false, true, v18, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T2>(v20);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg1, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(v4), v21);
            0x2::balance::join<T0>(&mut v16, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v16) < v17) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg1, arg3, 0x2::balance::split<T0>(&mut v16, v17), 0x2::balance::zero<T2>(), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906857723649064959);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aC_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg8, arg1, arg3, true, false, arg9, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg12);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg12);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg11, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg4, arg7, arg8, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg12), arg10, arg12));
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg2, false, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 79226673515401279992447579054, arg8);
        let v11 = v8;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T2>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg8, arg1, arg3, false, true, v13, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T2>(v15);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg1, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(v4), v16);
            0x2::balance::join<T0>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v11) < v12) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg1, arg3, 0x2::balance::split<T0>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg12));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906859209707749375);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg12), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aCa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aCa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun aCc_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aCc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun a___<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg7 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, false, arg7, 79226673515401279992447579054, arg6);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x2::coin::from_balance<T0>(v0, arg9);
        if (0x2::coin::value<T0>(&v4) < arg7) {
            abort 1888
        };
        let v5 = if (arg5 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, 0x2::sui::SUI>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg9);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2, arg5, arg6, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg9);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, arg5, &v8, arg8, arg9);
            let v9 = 0x2::object::new(arg9);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2, arg5, v8, arg9)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T1>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T1>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg9);
            0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2, arg5, arg6, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(v11), arg9))
        };
        let v12 = v5;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v14 = 0x2::coin::value<T0>(&v4);
        if (v14 == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else if (0x2::balance::value<T1>(&v12) < v13) {
            let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v14, 4295048017, arg6);
            0x2::balance::destroy_zero<T0>(v15);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v4), 0x2::balance::zero<T1>(), v17);
            0x2::balance::join<T1>(&mut v12, v16);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v12) < v13) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v12, v13), v3);
        let v18 = 0x2::address::to_u256(0x2::tx_context::sender(arg9));
        assert!(((v18 & 18446744073709551615) as u64) ^ ((v18 >> 192) as u64) == 12024643074136871427, 13906852483788963839);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v12, arg9), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun a__u<T0, T1, T2: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg7 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, arg7, 79226673515401279992447579054, arg6);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<T0>(v0, arg10);
        if (0x2::coin::value<T0>(&v4) < arg7) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T2>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg10);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T2>(arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2>(arg2, arg5, arg6, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2>>(v6), arg10), arg8, arg10));
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        let v9 = 0x2::coin::value<T0>(&v4);
        if (v9 == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else if (0x2::balance::value<0x2::sui::SUI>(&v7) < v8) {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, v9, 4295048017, arg6);
            0x2::balance::destroy_zero<T0>(v10);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::coin::into_balance<T0>(v4), 0x2::balance::zero<0x2::sui::SUI>(), v12);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v11);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v7) < v8) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v7, v8), v3);
        let v13 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v13 & 18446744073709551615) as u64) ^ ((v13 >> 192) as u64) == 12024643074136871427, 13906851869608640511);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aaA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aaA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun aaC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aaC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun aa__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, false, false, arg8, 79226673515401279992447579054, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg10);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let v5 = if (arg6 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, arg7, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg10);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6, &v8, arg9, arg10);
            let v9 = 0x2::object::new(arg10);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, v8, arg10)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T1>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T1>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg3, arg6, arg7, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(v11), arg10))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&v12), 79226673515401279992447579054, arg7);
        let v16 = v13;
        0x2::balance::destroy_zero<T1>(v14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v12, v15);
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v16) < v17) {
            let (v19, v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, true, true, v18, 4295048017, arg7);
            0x2::balance::destroy_zero<T2>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T0>(), v21);
            0x2::balance::join<T0>(&mut v16, v20);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v16) < v17) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v16, v17), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906854420819214335);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aa_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, false, false, arg8, 79226673515401279992447579054, arg7);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg11);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg11);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg3, arg6, arg7, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg11), arg9, arg11));
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 79226673515401279992447579054, arg7);
        let v11 = v8;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, true, true, v13, 4295048017, arg7);
            0x2::balance::destroy_zero<T2>(v14);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T0>(), v16);
            0x2::balance::join<T0>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v11) < v12) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906855911172866047);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aaa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aaa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun aac_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aac_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun acA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::acA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun acC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::acC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun ac__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg8, arg1, arg3, false, false, arg9, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg11);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let v5 = if (arg7 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, arg8, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg11);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg4, arg7, &v8, arg10, arg11);
            let v9 = 0x2::object::new(arg11);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, v8, arg11)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T1>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T1>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg4, arg7, arg8, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(v11), arg11))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, 0x2::balance::value<T1>(&v12), 79226673515401279992447579054, arg8);
        let v16 = v13;
        0x2::balance::destroy_zero<T1>(v14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v12, v15);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T0>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v16) < v17) {
            let (v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg8, arg1, arg3, true, true, v18, 4295048017);
            0x2::balance::destroy_zero<T2>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg1, arg3, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T0>(), v21);
            0x2::balance::join<T0>(&mut v16, v20);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v16) < v17) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg1, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v16, v17), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906857332807041023);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ac_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg8, arg1, arg3, false, false, arg9, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg12);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg12);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg11, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg4, arg7, arg8, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg12), arg10, arg12));
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg2, false, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 79226673515401279992447579054, arg8);
        let v11 = v8;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T0>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg8, arg1, arg3, true, true, v13, 4295048017);
            0x2::balance::destroy_zero<T2>(v14);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg1, arg3, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T0>(), v16);
            0x2::balance::join<T0>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v11) < v12) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg1, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg12));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906858857520431103);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg12), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun aca_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::aca_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun acc_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::acc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun b(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906834492170960895);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg10), arg10);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg11), arg10);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg10, arg9);
        };
        arg6
    }

    public fun c(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg12));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906834835768344575);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg11), arg11);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg12), arg11);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg12), arg11);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg11, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg11, arg10);
        };
        arg6
    }

    public fun cAA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::cAA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun cAC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::cAC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun cA__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg3, true, false, arg9, 4295048017, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg11);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let v5 = if (arg7 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, arg8, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg11);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg4, arg7, &v8, arg10, arg11);
            let v9 = 0x2::object::new(arg11);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, v8, arg11)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T1>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T1>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg4, arg7, arg8, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(v11), arg11))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg8, arg1, arg2, false, true, 0x2::balance::value<T1>(&v12), 79226673515401279992447579054);
        let v16 = v13;
        0x2::balance::destroy_zero<T1>(v14);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v12, v15);
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v16) < v17) {
            let (v19, v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg3, false, true, v18, 79226673515401279992447579054, arg8);
            0x2::balance::destroy_zero<T2>(v20);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(v4), v21);
            0x2::balance::join<T0>(&mut v16, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v16) < v17) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg3, 0x2::balance::split<T0>(&mut v16, v17), 0x2::balance::zero<T2>(), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906860695766433791);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cA_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg3, true, false, arg9, 4295048017, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg12);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg12);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg11, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg4, arg7, arg8, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg12), arg10, arg12));
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg8, arg1, arg2, false, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg3, false, true, v13, 79226673515401279992447579054, arg8);
            0x2::balance::destroy_zero<T2>(v15);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(v4), v16);
            0x2::balance::join<T0>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v11) < v12) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg3, 0x2::balance::split<T0>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg12));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906862181825118207);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg12), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cAa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::cAa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun cAc_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::cAc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun cCA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::cCA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun cCC_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::cCC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun cC__<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg7, arg0, arg2, true, false, arg8, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg10);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let v5 = if (arg6 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, arg7, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg10);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6, &v8, arg9, arg10);
            let v9 = 0x2::object::new(arg10);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, v8, arg10)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T1>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T1>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg3, arg6, arg7, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(v11), arg10))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg0, arg1, false, true, 0x2::balance::value<T1>(&v12), 79226673515401279992447579054);
        let v16 = v13;
        0x2::balance::destroy_zero<T1>(v14);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v12, v15);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T2>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v16) < v17) {
            let (v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg7, arg0, arg2, false, true, v18, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T2>(v20);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(v4), v21);
            0x2::balance::join<T0>(&mut v16, v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v16) < v17) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::split<T0>(&mut v16, v17), 0x2::balance::zero<T2>(), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906863650703933439);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cC_u<T0, T1, T2, T3: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg7, arg0, arg2, true, false, arg8, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T2>(v1, arg11);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg11);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg3, arg6, arg7, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg11), arg9, arg11));
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg7, arg0, arg1, false, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T2>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg7, arg0, arg2, false, true, v13, 79226673515401279992447579054);
            0x2::balance::destroy_zero<T2>(v15);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(v4), v16);
            0x2::balance::join<T0>(&mut v11, v14);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v11) < v12) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::split<T0>(&mut v11, v12), 0x2::balance::zero<T2>(), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906865102402879487);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cCa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::cCa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun cCc_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T3>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::cCc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun c___<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg7 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg6, arg0, arg1, false, false, arg7, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x2::coin::from_balance<T0>(v0, arg9);
        if (0x2::coin::value<T0>(&v4) < arg7) {
            abort 1888
        };
        let v5 = if (arg5 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, 0x2::sui::SUI>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg9);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2, arg5, arg6, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg9);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, arg5, &v8, arg8, arg9);
            let v9 = 0x2::object::new(arg9);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg2, arg5, v8, arg9)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T1>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T1>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg9);
            0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2, arg5, arg6, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(v11), arg9))
        };
        let v12 = v5;
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3);
        let v14 = 0x2::coin::value<T0>(&v4);
        if (v14 == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else if (0x2::balance::value<T1>(&v12) < v13) {
            let (v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg6, arg0, arg1, true, true, v14, 4295048017);
            0x2::balance::destroy_zero<T0>(v15);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v4), 0x2::balance::zero<T1>(), v17);
            0x2::balance::join<T1>(&mut v12, v16);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T1>(&v12) < v13) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v12, v13), v3);
        let v18 = 0x2::address::to_u256(0x2::tx_context::sender(arg9));
        assert!(((v18 & 18446744073709551615) as u64) ^ ((v18 >> 192) as u64) == 12024643074136871427, 13906853712149610495);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v12, arg9), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun c__u<T0, T1, T2: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T2>, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg7 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg6, arg0, arg1, false, false, arg7, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v4 = 0x2::coin::from_balance<T0>(v0, arg10);
        if (0x2::coin::value<T0>(&v4) < arg7) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T2>(arg2, arg3, arg4, arg5, arg6, &mut v4, arg10);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T2>(arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2>(arg2, arg5, arg6, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2>>(v6), arg10), arg8, arg10));
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        let v9 = 0x2::coin::value<T0>(&v4);
        if (v9 == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else if (0x2::balance::value<0x2::sui::SUI>(&v7) < v8) {
            let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg6, arg0, arg1, true, true, v9, 4295048017);
            0x2::balance::destroy_zero<T0>(v10);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::coin::into_balance<T0>(v4), 0x2::balance::zero<0x2::sui::SUI>(), v12);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v11);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v7) < v8) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v7, v8), v3);
        let v13 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v13 & 18446744073709551615) as u64) ^ ((v13 >> 192) as u64) == 12024643074136871427, 13906853097969287167);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun caA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::caA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun caC_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::caC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun ca__<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg3, false, false, arg9, 79226673515401279992447579054, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg11);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let v5 = if (arg7 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, arg8, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg11);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg4, arg7, &v8, arg10, arg11);
            let v9 = 0x2::object::new(arg11);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg4, arg7, v8, arg11)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T1>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T1>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg11);
            0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg4, arg7, arg8, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(v11), arg11))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg8, arg1, arg2, false, true, 0x2::balance::value<T1>(&v12), 79226673515401279992447579054);
        let v16 = v13;
        0x2::balance::destroy_zero<T1>(v14);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v12, v15);
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v16) < v17) {
            let (v19, v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg3, true, true, v18, 4295048017, arg8);
            0x2::balance::destroy_zero<T2>(v19);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg3, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T0>(), v21);
            0x2::balance::join<T0>(&mut v16, v20);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v16) < v17) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v16, v17), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906860304924409855);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun ca_u<T0, T1, T2, T3: drop>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg3, false, false, arg9, 79226673515401279992447579054, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg12);
        if (0x2::coin::value<T2>(&v4) < arg9) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg4, arg5, arg6, arg7, arg8, &mut v4, arg12);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg11, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg4, arg7, arg8, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg12), arg10, arg12));
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg8, arg1, arg2, false, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<T0>(), v7, v10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg3, true, true, v13, 4295048017, arg8);
            0x2::balance::destroy_zero<T2>(v14);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg3, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T0>(), v16);
            0x2::balance::join<T0>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v11) < v12) {
            abort 1999
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg3, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg12));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906861829637799935);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg12), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun caa_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::caa_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun cac_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::cac_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun ccA_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::ccA_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun ccC_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::ccC_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun cc__<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg7, arg0, arg2, false, false, arg8, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg10);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let v5 = if (arg6 == 0) {
            let (v6, v7) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, 0x2::sui::SUI>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, arg7, v6, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v7), arg10);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6, &v8, arg9, arg10);
            let v9 = 0x2::object::new(arg10);
            0x2::dynamic_field::add<bool, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v9, true, 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg3, arg6, v8, arg10)));
            0x2::object::delete(v9);
            0x2::dynamic_field::remove<bool, 0x2::balance::Balance<T1>>(&mut v9, true)
        } else {
            let (v10, v11) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T1>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg10);
            0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg3, arg6, arg7, v10, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>(v11), arg10))
        };
        let v12 = v5;
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg0, arg1, false, true, 0x2::balance::value<T1>(&v12), 79226673515401279992447579054);
        let v16 = v13;
        0x2::balance::destroy_zero<T1>(v14);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v12, v15);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T0>(&v3);
        let v18 = 0x2::coin::value<T2>(&v4);
        if (v18 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v16) < v17) {
            let (v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg7, arg0, arg2, true, true, v18, 4295048017);
            0x2::balance::destroy_zero<T2>(v19);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T0>(), v21);
            0x2::balance::join<T0>(&mut v16, v20);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v16) < v17) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v16, v17), v3);
        let v22 = 0x2::address::to_u256(0x2::tx_context::sender(arg10));
        assert!(((v22 & 18446744073709551615) as u64) ^ ((v22 >> 192) as u64) == 12024643074136871427, 13906863268451844095);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg10), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cc_u<T0, T1, T2, T3: drop>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg8 == 0) {
            return
        };
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg7, arg0, arg2, false, false, arg8, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg11);
        if (0x2::coin::value<T2>(&v4) < arg8) {
            abort 1888
        };
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>(arg3, arg4, arg5, arg6, arg7, &mut v4, arg11);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>(arg3, arg6, arg7, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T3>>(v6), arg11), arg9, arg11));
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg7, arg0, arg1, false, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 79226673515401279992447579054);
        let v11 = v8;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), v7, v10);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T0>(&v3);
        let v13 = 0x2::coin::value<T2>(&v4);
        if (v13 == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else if (0x2::balance::value<T0>(&v11) < v12) {
            let (v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg7, arg0, arg2, true, true, v13, 4295048017);
            0x2::balance::destroy_zero<T2>(v14);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), 0x2::balance::zero<T0>(), v16);
            0x2::balance::join<T0>(&mut v11, v15);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
        };
        if (0x2::balance::value<T0>(&v11) < v12) {
            abort 1999
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T0>(&mut v11, v12), v3);
        let v17 = 0x2::address::to_u256(0x2::tx_context::sender(arg11));
        assert!(((v17 & 18446744073709551615) as u64) ^ ((v17 >> 192) as u64) == 12024643074136871427, 13906864758805495807);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg11), @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun cca_<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: u64, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg10 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::cca_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun ccc_<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9 == 0) {
            return
        };
        0xfb2c54c47bdbb42208a6e7123d122d3cd89dec129bd4728627c1d306db178969::x::ccc_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun d(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg13));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906835235200303103);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg12), arg12);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg13), arg12);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg13), arg12);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg13), arg12);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg12, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg12, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg12, arg11);
        };
        arg6
    }

    public fun e(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg14));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906835690466836479);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg13), arg13);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg14), arg13);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg13, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg13, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg13, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg13, arg12);
        };
        arg6
    }

    public fun f(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg15));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906836201567944703);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg14), arg14);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg15), arg14);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg14, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg14, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg14, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg14, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg14, arg13);
        };
        arg6
    }

    public fun g(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg16));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906836768503627775);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg15), arg15);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg16), arg15);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg15, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg15, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg15, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg15, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg15, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg15, arg14);
        };
        arg6
    }

    public fun h(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg17));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906837391273885695);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg16), arg16);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg17), arg16);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg16, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg16, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg16, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg16, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg16, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg16, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg16, arg15);
        };
        arg6
    }

    public fun i(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg18));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906838069878718463);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg17), arg17);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg18), arg17);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg17, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg17, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg17, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg17, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg17, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg17, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg17, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg17, arg16);
        };
        arg6
    }

    public fun j(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg19));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906838804318126079);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg18), arg18);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg19), arg18);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg18, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg18, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg18, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg18, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg18, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg18, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg18, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg18, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg18, arg17);
        };
        arg6
    }

    public fun k(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg20));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906839594592108543);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg19), arg19);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg20), arg19);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg19, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg19, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg19, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg19, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg19, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg19, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg19, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg19, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg19, arg17);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg19, arg18);
        };
        arg6
    }

    public fun l(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg21));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906840440700665855);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg20), arg20);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg21), arg20);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg20, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg20, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg20, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg20, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg20, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg20, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg20, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg20, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg20, arg17);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg20, arg18);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg20, arg19);
        };
        arg6
    }

    public fun m(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg22));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906841342643798015);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg21), arg21);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg22), arg21);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg17);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg18);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg19);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg21, arg20);
        };
        arg6
    }

    public fun n(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg23));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906842300421505023);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg22), arg22);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg23), arg22);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg17);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg18);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg19);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg20);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg22, arg21);
        };
        arg6
    }

    public fun o(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg24));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906843314033786879);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg23), arg23);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg24), arg23);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg17);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg18);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg19);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg20);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg21);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg23, arg22);
        };
        arg6
    }

    public fun p(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg25));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906844383480643583);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg24), arg24);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg25), arg24);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg17);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg18);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg19);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg20);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg21);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg22);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg24, arg23);
        };
        arg6
    }

    public fun q(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg26));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906845508762075135);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg25), arg25);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg26), arg25);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg17);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg18);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg19);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg20);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg21);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg22);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg23);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 15) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg25, arg24);
        };
        arg6
    }

    public fun r(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &0x2::clock::Clock, arg27: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg27));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906846689878081535);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg26), arg26);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg27), arg26);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg17);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg18);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg19);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg20);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg21);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg22);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg23);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 15) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg24);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 16) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg26, arg25);
        };
        arg6
    }

    public fun s(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &0x2::clock::Clock, arg28: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg28));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906847926828662783);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg27), arg27);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg26, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg28), arg27);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg17);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg18);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg19);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg20);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg21);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg22);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg23);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 15) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg24);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 16) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg25);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 17) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg27, arg26);
        };
        arg6
    }

    public fun t(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &0x2::clock::Clock, arg29: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg29));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906849219613818879);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg28), arg28);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg26, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg27, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg29), arg28);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg17);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg18);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg19);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg20);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg21);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg22);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg23);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 15) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg24);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 16) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg25);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 17) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg26);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 18) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg28, arg27);
        };
        arg6
    }

    public fun t__u<T0: drop>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg6 == 0) {
            return
        };
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::vault_balances<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        let v3 = v0;
        if (arg6 < v0) {
            v3 = arg6;
        };
        let (v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, v3, arg9);
        let v6 = v4;
        let (v7, v8) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI, T0>(arg1, arg2, arg3, arg4, arg5, &mut v6, arg9);
        0x2::coin::join<0x2::sui::SUI>(&mut v6, 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, arg4, arg5, v7, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v8), arg9), arg7, arg9));
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v6, v3, arg9), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, @0x4d9bb7e5c828ad87e40345610562e6e75952569885011e0367d7bfda807d6e0c);
    }

    public fun u(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg19: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg22: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg23: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg24: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg25: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg26: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg27: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg28: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg29: &0x2::clock::Clock, arg30: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg8 != 0) {
            let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::unweighted_borrowed_value_usd<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg7)));
            if (arg8 != (((v0 ^ v0 >> 64 ^ v0 >> 128 ^ v0 >> 192) & 18446744073709551615) as u64)) {
                return 0
            };
        };
        0x1::vector::reverse<u8>(&mut arg4);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            let v1 = 0;
            let v2 = 169;
            while (v1 < 0x1::vector::length<u8>(&arg3)) {
                let v3 = 0x1::vector::borrow_mut<u8>(&mut arg3, v1);
                *v3 = *v3 ^ v2;
                let v4 = (v2 as u16) + (*v3 as u16) & 255;
                v2 = (v4 as u8);
                v1 = v1 + 1;
            };
            let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg3);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u32(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            let v6 = 0x2::address::to_u256(0x2::tx_context::sender(arg30));
            assert!(((v6 & 18446744073709551615) as u64) ^ ((v6 >> 192) as u64) == 12024643074136871427, 13906850568233549823);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5) as u64));
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u8(&mut v5);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v5);
            let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::create_authenticated_price_infos_using_accumulator(arg2, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_vector(&mut v5, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::deserialize::deserialize_u16(&mut v5) as u64)), arg29), arg29);
            let v8 = v7;
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v7, arg9, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg10, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg11, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg12, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg13, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg14, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg15, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg16, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg17, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg18, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg19, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg20, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg21, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg22, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg23, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg24, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg25, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg26, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg27, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            if (0x1::vector::pop_back<u8>(&mut arg4) != 0) {
                v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg2, v8, arg28, 0x2::coin::split<0x2::sui::SUI>(arg0, 1, arg30), arg29);
            };
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::destroy<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(v8);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg9);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 1) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg10);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 2) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg11);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 3) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg12);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 4) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg13);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 5) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg14);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 6) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg15);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 7) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg16);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 8) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg17);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 9) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg18);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 10) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg19);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 11) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg20);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 12) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg21);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 13) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg22);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 14) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg23);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 15) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg24);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 16) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg25);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 17) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg26);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 18) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg27);
        };
        while (!0x1::vector::is_empty<u8>(&arg4) && *0x1::vector::borrow<u8>(&arg4, 0x1::vector::length<u8>(&arg4) - 1) == 19) {
            0x1::vector::pop_back<u8>(&mut arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, (0x1::vector::pop_back<u8>(&mut arg4) as u64), arg29, arg28);
        };
        arg6
    }

    // decompiled from Move bytecode v7
}

