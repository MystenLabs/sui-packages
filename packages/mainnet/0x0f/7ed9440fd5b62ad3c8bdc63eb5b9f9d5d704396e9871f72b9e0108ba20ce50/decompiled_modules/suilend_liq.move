module 0xf7ed9440fd5b62ad3c8bdc63eb5b9f9d5d704396e9871f72b9e0108ba20ce50::suilend_liq {
    struct SuilendCrossFlashDiag has copy, drop {
        flash_amount: u64,
        repay_used: u64,
        coll_seized: u64,
        debt_shortfall: u64,
        coll_owed: u64,
        final_profit: u64,
        variant: u8,
    }

    struct SuilendCross2HopDiag has copy, drop {
        flash_amount: u64,
        repay_used: u64,
        coll_seized: u64,
        mid_received: u64,
        debt_from_coll: u64,
        final_profit: u64,
        variant: u8,
    }

    public fun flash_liq_suilend_2hop_cA_mA<T0, T1, T2, T3>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg5, arg11, arg6, arg16);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg16);
        let v3 = 0x2::coin::value<T1>(&v2);
        let (v4, v5) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg7, arg8, arg9, arg10, arg15, &mut v2, arg16);
        let v6 = 0x2::coin::value<T1>(&v2);
        let v7 = if (v3 > v6) {
            v3 - v6
        } else {
            0
        };
        let v8 = 0x2::coin::into_balance<T1>(v2);
        let v9 = 0x2::coin::into_balance<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg7, arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg7, arg10, arg15, v4, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v5), arg16), arg16));
        let v10 = 0x2::balance::value<T2>(&v9);
        assert!(v10 > 0, 1);
        let v11 = swap_all_a_for_b<T2, T3>(arg1, arg2, v9, arg12, arg15);
        let v12 = swap_all_a_for_b<T3, T1>(arg1, arg3, v11, arg13, arg15);
        0x2::balance::join<T1>(&mut v8, v12);
        let v13 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg15, arg4, arg5, v1, v8, arg16);
        let v14 = 0x2::balance::value<T1>(&v13);
        let v15 = SuilendCross2HopDiag{
            flash_amount   : arg11,
            repay_used     : v7,
            coll_seized    : v10,
            mid_received   : 0x2::balance::value<T3>(&v11),
            debt_from_coll : 0x2::balance::value<T1>(&v12),
            final_profit   : v14,
            variant        : 0,
        };
        0x2::event::emit<SuilendCross2HopDiag>(v15);
        assert!(v14 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v13, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_suilend_2hop_cA_mA_csui<T0, T1, T2>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg5, arg11, arg6, arg16);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg16);
        let v3 = 0x2::coin::value<T1>(&v2);
        let (v4, v5) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, 0x2::sui::SUI>(arg7, arg8, arg9, arg10, arg15, &mut v2, arg16);
        let v6 = 0x2::coin::value<T1>(&v2);
        let v7 = if (v3 > v6) {
            v3 - v6
        } else {
            0
        };
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg7, arg10, arg15, v4, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(v5), arg16);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg7, arg10, &v8, arg6, arg16);
        let v9 = 0x2::coin::into_balance<T1>(v2);
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg7, arg10, v8, arg16));
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&v10);
        assert!(v11 > 0, 1);
        let v12 = swap_all_a_for_b<0x2::sui::SUI, T2>(arg1, arg2, v10, arg12, arg15);
        let v13 = swap_all_a_for_b<T2, T1>(arg1, arg3, v12, arg13, arg15);
        0x2::balance::join<T1>(&mut v9, v13);
        let v14 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg15, arg4, arg5, v1, v9, arg16);
        let v15 = 0x2::balance::value<T1>(&v14);
        let v16 = SuilendCross2HopDiag{
            flash_amount   : arg11,
            repay_used     : v7,
            coll_seized    : v11,
            mid_received   : 0x2::balance::value<T2>(&v12),
            debt_from_coll : 0x2::balance::value<T1>(&v13),
            final_profit   : v15,
            variant        : 10,
        };
        0x2::event::emit<SuilendCross2HopDiag>(v16);
        assert!(v15 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v14, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_suilend_2hop_cA_mB<T0, T1, T2, T3>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg5, arg11, arg6, arg16);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg16);
        let v3 = 0x2::coin::value<T1>(&v2);
        let (v4, v5) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg7, arg8, arg9, arg10, arg15, &mut v2, arg16);
        let v6 = 0x2::coin::value<T1>(&v2);
        let v7 = if (v3 > v6) {
            v3 - v6
        } else {
            0
        };
        let v8 = 0x2::coin::into_balance<T1>(v2);
        let v9 = 0x2::coin::into_balance<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg7, arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg7, arg10, arg15, v4, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v5), arg16), arg16));
        let v10 = 0x2::balance::value<T2>(&v9);
        assert!(v10 > 0, 1);
        let v11 = swap_all_a_for_b<T2, T3>(arg1, arg2, v9, arg12, arg15);
        let v12 = swap_all_b_for_a<T1, T3>(arg1, arg3, v11, arg13, arg15);
        0x2::balance::join<T1>(&mut v8, v12);
        let v13 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg15, arg4, arg5, v1, v8, arg16);
        let v14 = 0x2::balance::value<T1>(&v13);
        let v15 = SuilendCross2HopDiag{
            flash_amount   : arg11,
            repay_used     : v7,
            coll_seized    : v10,
            mid_received   : 0x2::balance::value<T3>(&v11),
            debt_from_coll : 0x2::balance::value<T1>(&v12),
            final_profit   : v14,
            variant        : 1,
        };
        0x2::event::emit<SuilendCross2HopDiag>(v15);
        assert!(v14 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v13, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_suilend_2hop_cA_mB_csui<T0, T1, T2>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg5, arg11, arg6, arg16);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg16);
        let v3 = 0x2::coin::value<T1>(&v2);
        let (v4, v5) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, 0x2::sui::SUI>(arg7, arg8, arg9, arg10, arg15, &mut v2, arg16);
        let v6 = 0x2::coin::value<T1>(&v2);
        let v7 = if (v3 > v6) {
            v3 - v6
        } else {
            0
        };
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg7, arg10, arg15, v4, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(v5), arg16);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg7, arg10, &v8, arg6, arg16);
        let v9 = 0x2::coin::into_balance<T1>(v2);
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg7, arg10, v8, arg16));
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&v10);
        assert!(v11 > 0, 1);
        let v12 = swap_all_a_for_b<0x2::sui::SUI, T2>(arg1, arg2, v10, arg12, arg15);
        let v13 = swap_all_b_for_a<T1, T2>(arg1, arg3, v12, arg13, arg15);
        0x2::balance::join<T1>(&mut v9, v13);
        let v14 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg15, arg4, arg5, v1, v9, arg16);
        let v15 = 0x2::balance::value<T1>(&v14);
        let v16 = SuilendCross2HopDiag{
            flash_amount   : arg11,
            repay_used     : v7,
            coll_seized    : v11,
            mid_received   : 0x2::balance::value<T2>(&v12),
            debt_from_coll : 0x2::balance::value<T1>(&v13),
            final_profit   : v15,
            variant        : 11,
        };
        0x2::event::emit<SuilendCross2HopDiag>(v16);
        assert!(v15 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v14, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_suilend_2hop_cB_mA<T0, T1, T2, T3>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg5, arg11, arg6, arg16);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg16);
        let v3 = 0x2::coin::value<T1>(&v2);
        let (v4, v5) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg7, arg8, arg9, arg10, arg15, &mut v2, arg16);
        let v6 = 0x2::coin::value<T1>(&v2);
        let v7 = if (v3 > v6) {
            v3 - v6
        } else {
            0
        };
        let v8 = 0x2::coin::into_balance<T1>(v2);
        let v9 = 0x2::coin::into_balance<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg7, arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg7, arg10, arg15, v4, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v5), arg16), arg16));
        let v10 = 0x2::balance::value<T2>(&v9);
        assert!(v10 > 0, 1);
        let v11 = swap_all_b_for_a<T3, T2>(arg1, arg2, v9, arg12, arg15);
        let v12 = swap_all_a_for_b<T3, T1>(arg1, arg3, v11, arg13, arg15);
        0x2::balance::join<T1>(&mut v8, v12);
        let v13 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg15, arg4, arg5, v1, v8, arg16);
        let v14 = 0x2::balance::value<T1>(&v13);
        let v15 = SuilendCross2HopDiag{
            flash_amount   : arg11,
            repay_used     : v7,
            coll_seized    : v10,
            mid_received   : 0x2::balance::value<T3>(&v11),
            debt_from_coll : 0x2::balance::value<T1>(&v12),
            final_profit   : v14,
            variant        : 2,
        };
        0x2::event::emit<SuilendCross2HopDiag>(v15);
        assert!(v14 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v13, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_suilend_2hop_cB_mA_csui<T0, T1, T2>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg5, arg11, arg6, arg16);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg16);
        let v3 = 0x2::coin::value<T1>(&v2);
        let (v4, v5) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, 0x2::sui::SUI>(arg7, arg8, arg9, arg10, arg15, &mut v2, arg16);
        let v6 = 0x2::coin::value<T1>(&v2);
        let v7 = if (v3 > v6) {
            v3 - v6
        } else {
            0
        };
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg7, arg10, arg15, v4, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(v5), arg16);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg7, arg10, &v8, arg6, arg16);
        let v9 = 0x2::coin::into_balance<T1>(v2);
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg7, arg10, v8, arg16));
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&v10);
        assert!(v11 > 0, 1);
        let v12 = swap_all_b_for_a<T2, 0x2::sui::SUI>(arg1, arg2, v10, arg12, arg15);
        let v13 = swap_all_a_for_b<T2, T1>(arg1, arg3, v12, arg13, arg15);
        0x2::balance::join<T1>(&mut v9, v13);
        let v14 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg15, arg4, arg5, v1, v9, arg16);
        let v15 = 0x2::balance::value<T1>(&v14);
        let v16 = SuilendCross2HopDiag{
            flash_amount   : arg11,
            repay_used     : v7,
            coll_seized    : v11,
            mid_received   : 0x2::balance::value<T2>(&v12),
            debt_from_coll : 0x2::balance::value<T1>(&v13),
            final_profit   : v15,
            variant        : 12,
        };
        0x2::event::emit<SuilendCross2HopDiag>(v16);
        assert!(v15 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v14, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_suilend_2hop_cB_mB<T0, T1, T2, T3>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T3>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg5, arg11, arg6, arg16);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg16);
        let v3 = 0x2::coin::value<T1>(&v2);
        let (v4, v5) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg7, arg8, arg9, arg10, arg15, &mut v2, arg16);
        let v6 = 0x2::coin::value<T1>(&v2);
        let v7 = if (v3 > v6) {
            v3 - v6
        } else {
            0
        };
        let v8 = 0x2::coin::into_balance<T1>(v2);
        let v9 = 0x2::coin::into_balance<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg7, arg10, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg7, arg10, arg15, v4, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v5), arg16), arg16));
        let v10 = 0x2::balance::value<T2>(&v9);
        assert!(v10 > 0, 1);
        let v11 = swap_all_b_for_a<T3, T2>(arg1, arg2, v9, arg12, arg15);
        let v12 = swap_all_b_for_a<T1, T3>(arg1, arg3, v11, arg13, arg15);
        0x2::balance::join<T1>(&mut v8, v12);
        let v13 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg15, arg4, arg5, v1, v8, arg16);
        let v14 = 0x2::balance::value<T1>(&v13);
        let v15 = SuilendCross2HopDiag{
            flash_amount   : arg11,
            repay_used     : v7,
            coll_seized    : v10,
            mid_received   : 0x2::balance::value<T3>(&v11),
            debt_from_coll : 0x2::balance::value<T1>(&v12),
            final_profit   : v14,
            variant        : 3,
        };
        0x2::event::emit<SuilendCross2HopDiag>(v15);
        assert!(v14 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v13, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_suilend_2hop_cB_mB_csui<T0, T1, T2>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg5, arg11, arg6, arg16);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg16);
        let v3 = 0x2::coin::value<T1>(&v2);
        let (v4, v5) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, 0x2::sui::SUI>(arg7, arg8, arg9, arg10, arg15, &mut v2, arg16);
        let v6 = 0x2::coin::value<T1>(&v2);
        let v7 = if (v3 > v6) {
            v3 - v6
        } else {
            0
        };
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg7, arg10, arg15, v4, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(v5), arg16);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg7, arg10, &v8, arg6, arg16);
        let v9 = 0x2::coin::into_balance<T1>(v2);
        let v10 = 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg7, arg10, v8, arg16));
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&v10);
        assert!(v11 > 0, 1);
        let v12 = swap_all_b_for_a<T2, 0x2::sui::SUI>(arg1, arg2, v10, arg12, arg15);
        let v13 = swap_all_b_for_a<T1, T2>(arg1, arg3, v12, arg13, arg15);
        0x2::balance::join<T1>(&mut v9, v13);
        let v14 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg15, arg4, arg5, v1, v9, arg16);
        let v15 = 0x2::balance::value<T1>(&v14);
        let v16 = SuilendCross2HopDiag{
            flash_amount   : arg11,
            repay_used     : v7,
            coll_seized    : v11,
            mid_received   : 0x2::balance::value<T2>(&v12),
            debt_from_coll : 0x2::balance::value<T1>(&v13),
            final_profit   : v15,
            variant        : 13,
        };
        0x2::event::emit<SuilendCross2HopDiag>(v16);
        assert!(v15 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v14, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_suilend_a<T0, T1, T2>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg4, arg10, arg5, arg14);
        let v2 = v1;
        let v3 = 0x2::coin::from_balance<T1>(v0, arg14);
        let v4 = 0x2::coin::value<T1>(&v3);
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg6, arg7, arg8, arg9, arg13, &mut v3, arg14);
        let v7 = 0x2::coin::value<T1>(&v3);
        let v8 = if (v4 > v7) {
            v4 - v7
        } else {
            0
        };
        let v9 = 0x2::coin::into_balance<T1>(v3);
        let v10 = 0x2::coin::into_balance<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg6, arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg6, arg9, arg13, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v6), arg14), arg14));
        let (_, _, _, _, v15, v16) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T1>(&v2);
        let v17 = arg10 + v15 + v16;
        let v18 = 0x2::balance::value<T2>(&v10);
        let v19 = 0x2::balance::value<T1>(&v9);
        let v20 = if (v17 > v19) {
            v17 - v19
        } else {
            0
        };
        let v21 = 0;
        if (v18 > 0 && v20 > 0) {
            let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg1, arg2, false, false, v20, arg11, arg13);
            let v25 = v24;
            0x2::balance::destroy_zero<T2>(v23);
            let v26 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v25);
            v21 = v26;
            assert!(v26 <= v18, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v10, v26), v25);
            0x2::balance::join<T1>(&mut v9, v22);
        };
        if (0x2::balance::value<T2>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v10, arg14), 0x2::tx_context::sender(arg14));
        } else {
            0x2::balance::destroy_zero<T2>(v10);
        };
        let v27 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg13, arg3, arg4, v2, v9, arg14);
        let v28 = 0x2::balance::value<T1>(&v27);
        let v29 = SuilendCrossFlashDiag{
            flash_amount   : arg10,
            repay_used     : v8,
            coll_seized    : v18,
            debt_shortfall : v20,
            coll_owed      : v21,
            final_profit   : v28,
            variant        : 0,
        };
        0x2::event::emit<SuilendCrossFlashDiag>(v29);
        assert!(v28 >= arg12, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v27, arg14), 0x2::tx_context::sender(arg14));
    }

    public fun flash_liq_suilend_a_csui<T0, T1>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg4, arg10, arg5, arg14);
        let v2 = v1;
        let v3 = 0x2::coin::from_balance<T1>(v0, arg14);
        let v4 = 0x2::coin::value<T1>(&v3);
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, 0x2::sui::SUI>(arg6, arg7, arg8, arg9, arg13, &mut v3, arg14);
        let v7 = 0x2::coin::value<T1>(&v3);
        let v8 = if (v4 > v7) {
            v4 - v7
        } else {
            0
        };
        let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg6, arg9, arg13, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(v6), arg14);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg6, arg9, &v9, arg5, arg14);
        let v10 = 0x2::coin::into_balance<T1>(v3);
        let v11 = 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg6, arg9, v9, arg14));
        let (_, _, _, _, v16, v17) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T1>(&v2);
        let v18 = arg10 + v16 + v17;
        let v19 = 0x2::balance::value<0x2::sui::SUI>(&v11);
        let v20 = 0x2::balance::value<T1>(&v10);
        let v21 = if (v18 > v20) {
            v18 - v20
        } else {
            0
        };
        let v22 = 0;
        if (v19 > 0 && v21 > 0) {
            let (v23, v24, v25) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, 0x2::sui::SUI>(arg1, arg2, false, false, v21, arg11, arg13);
            let v26 = v25;
            0x2::balance::destroy_zero<0x2::sui::SUI>(v24);
            let v27 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v26);
            v22 = v27;
            assert!(v27 <= v19, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v11, v27), v26);
            0x2::balance::join<T1>(&mut v10, v23);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v11, arg14), 0x2::tx_context::sender(arg14));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v11);
        };
        let v28 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg13, arg3, arg4, v2, v10, arg14);
        let v29 = 0x2::balance::value<T1>(&v28);
        let v30 = SuilendCrossFlashDiag{
            flash_amount   : arg10,
            repay_used     : v8,
            coll_seized    : v19,
            debt_shortfall : v21,
            coll_owed      : v22,
            final_profit   : v29,
            variant        : 10,
        };
        0x2::event::emit<SuilendCrossFlashDiag>(v30);
        assert!(v29 >= arg12, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v28, arg14), 0x2::tx_context::sender(arg14));
    }

    public fun flash_liq_suilend_b<T0, T1, T2>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg4, arg10, arg5, arg14);
        let v2 = v1;
        let v3 = 0x2::coin::from_balance<T1>(v0, arg14);
        let v4 = 0x2::coin::value<T1>(&v3);
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg6, arg7, arg8, arg9, arg13, &mut v3, arg14);
        let v7 = 0x2::coin::value<T1>(&v3);
        let v8 = if (v4 > v7) {
            v4 - v7
        } else {
            0
        };
        let v9 = 0x2::coin::into_balance<T1>(v3);
        let v10 = 0x2::coin::into_balance<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg6, arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg6, arg9, arg13, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v6), arg14), arg14));
        let (_, _, _, _, v15, v16) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T1>(&v2);
        let v17 = arg10 + v15 + v16;
        let v18 = 0x2::balance::value<T2>(&v10);
        let v19 = 0x2::balance::value<T1>(&v9);
        let v20 = if (v17 > v19) {
            v17 - v19
        } else {
            0
        };
        let v21 = 0;
        if (v18 > 0 && v20 > 0) {
            let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg1, arg2, true, false, v20, arg11, arg13);
            let v25 = v24;
            0x2::balance::destroy_zero<T2>(v22);
            let v26 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v25);
            v21 = v26;
            assert!(v26 <= v18, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg1, arg2, 0x2::balance::split<T2>(&mut v10, v26), 0x2::balance::zero<T1>(), v25);
            0x2::balance::join<T1>(&mut v9, v23);
        };
        if (0x2::balance::value<T2>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v10, arg14), 0x2::tx_context::sender(arg14));
        } else {
            0x2::balance::destroy_zero<T2>(v10);
        };
        let v27 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg13, arg3, arg4, v2, v9, arg14);
        let v28 = 0x2::balance::value<T1>(&v27);
        let v29 = SuilendCrossFlashDiag{
            flash_amount   : arg10,
            repay_used     : v8,
            coll_seized    : v18,
            debt_shortfall : v20,
            coll_owed      : v21,
            final_profit   : v28,
            variant        : 1,
        };
        0x2::event::emit<SuilendCrossFlashDiag>(v29);
        assert!(v28 >= arg12, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v27, arg14), 0x2::tx_context::sender(arg14));
    }

    public fun flash_liq_suilend_b_csui<T0, T1>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg0, arg4, arg10, arg5, arg14);
        let v2 = v1;
        let v3 = 0x2::coin::from_balance<T1>(v0, arg14);
        let v4 = 0x2::coin::value<T1>(&v3);
        let (v5, v6) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, 0x2::sui::SUI>(arg6, arg7, arg8, arg9, arg13, &mut v3, arg14);
        let v7 = 0x2::coin::value<T1>(&v3);
        let v8 = if (v4 > v7) {
            v4 - v7
        } else {
            0
        };
        let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg6, arg9, arg13, v5, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(v6), arg14);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg6, arg9, &v9, arg5, arg14);
        let v10 = 0x2::coin::into_balance<T1>(v3);
        let v11 = 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg6, arg9, v9, arg14));
        let (_, _, _, _, v16, v17) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T1>(&v2);
        let v18 = arg10 + v16 + v17;
        let v19 = 0x2::balance::value<0x2::sui::SUI>(&v11);
        let v20 = 0x2::balance::value<T1>(&v10);
        let v21 = if (v18 > v20) {
            v18 - v20
        } else {
            0
        };
        let v22 = 0;
        if (v19 > 0 && v21 > 0) {
            let (v23, v24, v25) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T1>(arg1, arg2, true, false, v21, arg11, arg13);
            let v26 = v25;
            0x2::balance::destroy_zero<0x2::sui::SUI>(v23);
            let v27 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T1>(&v26);
            v22 = v27;
            assert!(v27 <= v19, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T1>(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v11, v27), 0x2::balance::zero<T1>(), v26);
            0x2::balance::join<T1>(&mut v10, v24);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v11, arg14), 0x2::tx_context::sender(arg14));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v11);
        };
        let v28 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg13, arg3, arg4, v2, v10, arg14);
        let v29 = 0x2::balance::value<T1>(&v28);
        let v30 = SuilendCrossFlashDiag{
            flash_amount   : arg10,
            repay_used     : v8,
            coll_seized    : v19,
            debt_shortfall : v21,
            coll_owed      : v22,
            final_profit   : v29,
            variant        : 11,
        };
        0x2::event::emit<SuilendCrossFlashDiag>(v30);
        assert!(v29 >= arg12, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v28, arg14), 0x2::tx_context::sender(arg14));
    }

    fun swap_all_a_for_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), arg3, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(arg2);
        v1
    }

    fun swap_all_b_for_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), arg3, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        0x2::balance::destroy_zero<T1>(arg2);
        v0
    }

    // decompiled from Move bytecode v7
}

