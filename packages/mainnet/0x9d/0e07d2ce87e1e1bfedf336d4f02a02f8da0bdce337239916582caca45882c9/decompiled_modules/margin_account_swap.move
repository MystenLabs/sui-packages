module 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account_swap {
    public fun swap_with_future_token_and_lending_pool<T0, T1, T2>(arg0: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::Account, arg1: u128, arg2: u128, arg3: u64, arg4: vector<u8>, arg5: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount, arg6: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::future_token::Pool<T0, T1>, arg7: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::lending_pool::LendingPool<T2>, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2::balance::Balance<T2>, arg12: &0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::risk_params::RiskParams, arg13: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::trusted_prices::TrustedPriceData, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::verify_signature<T2, T0>(arg0, arg1, 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount>(arg5), arg2, arg8, arg9, arg10, arg3, arg4, arg14);
        let v0 = 0x2::balance::value<T2>(&arg11);
        let v1 = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::calc_output_by_quote(arg8, arg9, arg10, v0);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::assert_for_account(arg5, arg0);
        let (v2, v3) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::unsafe_borrow_margin_account(arg5);
        let v4 = v2;
        let v5 = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::open_debt<T2>(&v4);
        if (v5 > 0) {
            0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::lending_pool::internal_swap_repay_for_margin_account<T2>(arg7, &mut v4, 0x2::balance::split<T2>(&mut arg11, 0x1::u64::min(v0, v5)), arg12, arg14, arg15);
        };
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::deposit_collateral<T2>(&mut v4, arg11, arg12);
        let v6 = 0x1::u64::min(v1, 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::collateral_value<T0>(&v4));
        let v7 = v1 - v6;
        let v8 = 0x2::balance::zero<T0>();
        let (v9, v10) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::withdraw_collateral<T0>(&mut v4, v6);
        let v11 = v10;
        0x2::balance::join<T0>(&mut v8, v9);
        if (v7 > 0) {
            let (v12, _, v14) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::future_token::internal_swap_borrow_and_check_later<T0, T1>(arg6, &mut v4, v7, arg12, arg14, arg15);
            0x2::balance::join<T0>(&mut v8, v12);
            0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::join_must_check_borrow_limits(&v11, v14);
        };
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::check_borrow_limits(&v4, arg13, arg12, v11);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::return_margin_account(arg5, v4, v3);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::swap::emit_swap_event<T2, T0>(arg1, 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::Account>(arg0), 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount>(arg5), arg2, v0, 0x2::balance::value<T0>(&v8));
        v8
    }

    public fun swap_with_future_tokens<T0, T1, T2, T3>(arg0: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::Account, arg1: u128, arg2: u128, arg3: u64, arg4: vector<u8>, arg5: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount, arg6: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::future_token::Pool<T0, T1>, arg7: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::future_token::Pool<T2, T3>, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2::balance::Balance<T2>, arg12: &0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::risk_params::RiskParams, arg13: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::trusted_prices::TrustedPriceData, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::verify_signature<T2, T0>(arg0, arg1, 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount>(arg5), arg2, arg8, arg9, arg10, arg3, arg4, arg14);
        let v0 = 0x2::balance::value<T2>(&arg11);
        let v1 = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::calc_output_by_quote(arg8, arg9, arg10, v0);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::assert_for_account(arg5, arg0);
        let (v2, v3) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::unsafe_borrow_margin_account(arg5);
        let v4 = v2;
        let v5 = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::open_debt<T2>(&v4);
        if (v5 > 0) {
            0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::future_token::internal_swap_repay_for_margin_account<T2, T3>(arg7, &mut v4, 0x2::balance::split<T2>(&mut arg11, 0x1::u64::min(v0, v5)), arg12, arg14, arg15);
        };
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::deposit_collateral<T2>(&mut v4, arg11, arg12);
        let v6 = 0x1::u64::min(v1, 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::collateral_value<T0>(&v4));
        let v7 = v1 - v6;
        let v8 = 0x2::balance::zero<T0>();
        let (v9, v10) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::withdraw_collateral<T0>(&mut v4, v6);
        let v11 = v10;
        0x2::balance::join<T0>(&mut v8, v9);
        if (v7 > 0) {
            let (v12, _, v14) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::future_token::internal_swap_borrow_and_check_later<T0, T1>(arg6, &mut v4, v7, arg12, arg14, arg15);
            0x2::balance::join<T0>(&mut v8, v12);
            0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::join_must_check_borrow_limits(&v11, v14);
        };
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::check_borrow_limits(&v4, arg13, arg12, v11);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::return_margin_account(arg5, v4, v3);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::swap::emit_swap_event<T2, T0>(arg1, 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::Account>(arg0), 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount>(arg5), arg2, v0, 0x2::balance::value<T0>(&v8));
        v8
    }

    public fun swap_with_lending_pool_and_future_token<T0, T1, T2>(arg0: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::Account, arg1: u128, arg2: u128, arg3: u64, arg4: vector<u8>, arg5: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount, arg6: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::lending_pool::LendingPool<T0>, arg7: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::future_token::Pool<T1, T2>, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2::balance::Balance<T1>, arg12: &0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::risk_params::RiskParams, arg13: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::trusted_prices::TrustedPriceData, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::verify_signature<T1, T0>(arg0, arg1, 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount>(arg5), arg2, arg8, arg9, arg10, arg3, arg4, arg14);
        let v0 = 0x2::balance::value<T1>(&arg11);
        let v1 = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::calc_output_by_quote(arg8, arg9, arg10, v0);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::assert_for_account(arg5, arg0);
        let (v2, v3) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::unsafe_borrow_margin_account(arg5);
        let v4 = v2;
        let v5 = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::open_debt<T1>(&v4);
        if (v5 > 0) {
            0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::future_token::internal_swap_repay_for_margin_account<T1, T2>(arg7, &mut v4, 0x2::balance::split<T1>(&mut arg11, 0x1::u64::min(v0, v5)), arg12, arg14, arg15);
        };
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::deposit_collateral<T1>(&mut v4, arg11, arg12);
        let v6 = 0x1::u64::min(v1, 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::collateral_value<T0>(&v4));
        let v7 = v1 - v6;
        let v8 = 0x2::balance::zero<T0>();
        let (v9, v10) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::withdraw_collateral<T0>(&mut v4, v6);
        let v11 = v10;
        0x2::balance::join<T0>(&mut v8, v9);
        if (v7 > 0) {
            let (v12, _, v14) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::lending_pool::internal_swap_borrow_and_check_later<T0>(arg6, &mut v4, v7, arg12, arg14, arg15);
            0x2::balance::join<T0>(&mut v8, v12);
            0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::join_must_check_borrow_limits(&v11, v14);
        };
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::check_borrow_limits(&v4, arg13, arg12, v11);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::return_margin_account(arg5, v4, v3);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::swap::emit_swap_event<T1, T0>(arg1, 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::Account>(arg0), 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount>(arg5), arg2, v0, 0x2::balance::value<T0>(&v8));
        v8
    }

    public fun swap_with_lending_pools<T0, T1>(arg0: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::Account, arg1: u128, arg2: u128, arg3: u64, arg4: vector<u8>, arg5: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount, arg6: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::lending_pool::LendingPool<T0>, arg7: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::lending_pool::LendingPool<T1>, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2::balance::Balance<T1>, arg12: &0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::risk_params::RiskParams, arg13: &mut 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::trusted_prices::TrustedPriceData, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::verify_signature<T1, T0>(arg0, arg1, 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount>(arg5), arg2, arg8, arg9, arg10, arg3, arg4, arg14);
        let v0 = 0x2::balance::value<T1>(&arg11);
        let v1 = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::calc_output_by_quote(arg8, arg9, arg10, v0);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::assert_for_account(arg5, arg0);
        let (v2, v3) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::unsafe_borrow_margin_account(arg5);
        let v4 = v2;
        let v5 = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::open_debt<T1>(&v4);
        if (v5 > 0) {
            0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::lending_pool::internal_swap_repay_for_margin_account<T1>(arg7, &mut v4, 0x2::balance::split<T1>(&mut arg11, 0x1::u64::min(v0, v5)), arg12, arg14, arg15);
        };
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::deposit_collateral<T1>(&mut v4, arg11, arg12);
        let v6 = 0x1::u64::min(v1, 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::collateral_value<T0>(&v4));
        let v7 = v1 - v6;
        let v8 = 0x2::balance::zero<T0>();
        let (v9, v10) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::withdraw_collateral<T0>(&mut v4, v6);
        let v11 = v10;
        0x2::balance::join<T0>(&mut v8, v9);
        if (v7 > 0) {
            let (v12, _, v14) = 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::lending_pool::internal_swap_borrow_and_check_later<T0>(arg6, &mut v4, v7, arg12, arg14, arg15);
            0x2::balance::join<T0>(&mut v8, v12);
            0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::join_must_check_borrow_limits(&v11, v14);
        };
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::check_borrow_limits(&v4, arg13, arg12, v11);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::return_margin_account(arg5, v4, v3);
        0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::swap::emit_swap_event<T1, T0>(arg1, 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::rfq_account::Account>(arg0), 0x2::object::id<0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::margin_account::ProtectedMarginAccount>(arg5), arg2, v0, 0x2::balance::value<T0>(&v8));
        v8
    }

    // decompiled from Move bytecode v6
}

