module 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account_swap {
    public fun swap_with_future_token_and_lending_pool<T0, T1, T2>(arg0: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::Account, arg1: u128, arg2: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::NonceLane, arg3: u64, arg4: vector<u8>, arg5: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::ProtectedMarginAccount, arg6: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::future_token::Pool<T0, T1>, arg7: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::lending_pool::LendingPool<T2>, arg8: u64, arg9: 0x2::balance::Balance<T2>, arg10: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::risk_params::RiskParams, arg11: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::trusted_prices::TrustedPriceData, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T2>(&arg9);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::verify_signature<T2, T0>(arg0, arg1, 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::ProtectedMarginAccount>(arg5), arg2, arg8, v0, arg3, arg4, arg12);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::assert_for_account(arg5, arg0);
        let (v1, v2) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::unsafe_borrow_margin_account(arg5);
        let v3 = v1;
        let v4 = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::open_debt<T2>(&v3);
        if (v4 > 0) {
            0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::lending_pool::internal_swap_repay_for_margin_account<T2>(arg7, &mut v3, 0x2::balance::split<T2>(&mut arg9, 0x1::u64::min(v0, v4)), arg10, arg12, arg13);
        };
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::deposit_collateral<T2>(&mut v3, arg9, arg10);
        let v5 = 0x1::u64::min(arg8, 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::collateral_value<T0>(&v3));
        let v6 = arg8 - v5;
        let v7 = 0x2::balance::zero<T0>();
        let (v8, v9) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::withdraw_collateral<T0>(&mut v3, v5);
        let v10 = v9;
        0x2::balance::join<T0>(&mut v7, v8);
        if (v6 > 0) {
            let (v11, _, v13) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::future_token::internal_swap_borrow_and_check_later<T0, T1>(arg6, &mut v3, v6, arg10, arg12, arg13);
            0x2::balance::join<T0>(&mut v7, v11);
            0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::join_must_check_borrow_limits(&v10, v13);
        };
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::check_borrow_limits(&v3, arg11, arg10, v10);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::return_margin_account(arg5, v3, v2);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::swap::emit_swap_event<T2, T0>(arg1, 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::Account>(arg0), 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::NonceLane>(arg2), 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::nonce_lane_value(arg2), v0, 0x2::balance::value<T0>(&v7));
        v7
    }

    public fun swap_with_future_tokens<T0, T1, T2, T3>(arg0: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::Account, arg1: u128, arg2: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::NonceLane, arg3: u64, arg4: vector<u8>, arg5: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::ProtectedMarginAccount, arg6: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::future_token::Pool<T0, T1>, arg7: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::future_token::Pool<T2, T3>, arg8: u64, arg9: 0x2::balance::Balance<T2>, arg10: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::risk_params::RiskParams, arg11: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::trusted_prices::TrustedPriceData, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T2>(&arg9);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::verify_signature<T2, T0>(arg0, arg1, 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::ProtectedMarginAccount>(arg5), arg2, arg8, v0, arg3, arg4, arg12);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::assert_for_account(arg5, arg0);
        let (v1, v2) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::unsafe_borrow_margin_account(arg5);
        let v3 = v1;
        let v4 = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::open_debt<T2>(&v3);
        if (v4 > 0) {
            0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::future_token::internal_swap_repay_for_margin_account<T2, T3>(arg7, &mut v3, 0x2::balance::split<T2>(&mut arg9, 0x1::u64::min(v0, v4)), arg10, arg12, arg13);
        };
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::deposit_collateral<T2>(&mut v3, arg9, arg10);
        let v5 = 0x1::u64::min(arg8, 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::collateral_value<T0>(&v3));
        let v6 = arg8 - v5;
        let v7 = 0x2::balance::zero<T0>();
        let (v8, v9) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::withdraw_collateral<T0>(&mut v3, v5);
        let v10 = v9;
        0x2::balance::join<T0>(&mut v7, v8);
        if (v6 > 0) {
            let (v11, _, v13) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::future_token::internal_swap_borrow_and_check_later<T0, T1>(arg6, &mut v3, v6, arg10, arg12, arg13);
            0x2::balance::join<T0>(&mut v7, v11);
            0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::join_must_check_borrow_limits(&v10, v13);
        };
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::check_borrow_limits(&v3, arg11, arg10, v10);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::return_margin_account(arg5, v3, v2);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::swap::emit_swap_event<T2, T0>(arg1, 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::Account>(arg0), 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::NonceLane>(arg2), 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::nonce_lane_value(arg2), v0, 0x2::balance::value<T0>(&v7));
        v7
    }

    public fun swap_with_lending_pool_and_future_token<T0, T1, T2>(arg0: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::Account, arg1: u128, arg2: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::NonceLane, arg3: u64, arg4: vector<u8>, arg5: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::ProtectedMarginAccount, arg6: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::lending_pool::LendingPool<T0>, arg7: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::future_token::Pool<T1, T2>, arg8: u64, arg9: 0x2::balance::Balance<T1>, arg10: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::risk_params::RiskParams, arg11: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::trusted_prices::TrustedPriceData, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg9);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::verify_signature<T1, T0>(arg0, arg1, 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::ProtectedMarginAccount>(arg5), arg2, arg8, v0, arg3, arg4, arg12);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::assert_for_account(arg5, arg0);
        let (v1, v2) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::unsafe_borrow_margin_account(arg5);
        let v3 = v1;
        let v4 = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::open_debt<T1>(&v3);
        if (v4 > 0) {
            0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::future_token::internal_swap_repay_for_margin_account<T1, T2>(arg7, &mut v3, 0x2::balance::split<T1>(&mut arg9, 0x1::u64::min(v0, v4)), arg10, arg12, arg13);
        };
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::deposit_collateral<T1>(&mut v3, arg9, arg10);
        let v5 = 0x1::u64::min(arg8, 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::collateral_value<T0>(&v3));
        let v6 = arg8 - v5;
        let v7 = 0x2::balance::zero<T0>();
        let (v8, v9) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::withdraw_collateral<T0>(&mut v3, v5);
        let v10 = v9;
        0x2::balance::join<T0>(&mut v7, v8);
        if (v6 > 0) {
            let (v11, _, v13) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::lending_pool::internal_swap_borrow_and_check_later<T0>(arg6, &mut v3, v6, arg10, arg12, arg13);
            0x2::balance::join<T0>(&mut v7, v11);
            0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::join_must_check_borrow_limits(&v10, v13);
        };
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::check_borrow_limits(&v3, arg11, arg10, v10);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::return_margin_account(arg5, v3, v2);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::swap::emit_swap_event<T1, T0>(arg1, 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::Account>(arg0), 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::NonceLane>(arg2), 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::nonce_lane_value(arg2), v0, 0x2::balance::value<T0>(&v7));
        v7
    }

    public fun swap_with_lending_pools<T0, T1>(arg0: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::Account, arg1: u128, arg2: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::NonceLane, arg3: u64, arg4: vector<u8>, arg5: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::ProtectedMarginAccount, arg6: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::lending_pool::LendingPool<T0>, arg7: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::lending_pool::LendingPool<T1>, arg8: u64, arg9: 0x2::balance::Balance<T1>, arg10: &0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::risk_params::RiskParams, arg11: &mut 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::trusted_prices::TrustedPriceData, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg9);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::verify_signature<T1, T0>(arg0, arg1, 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::ProtectedMarginAccount>(arg5), arg2, arg8, v0, arg3, arg4, arg12);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::assert_for_account(arg5, arg0);
        let (v1, v2) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::unsafe_borrow_margin_account(arg5);
        let v3 = v1;
        let v4 = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::open_debt<T1>(&v3);
        if (v4 > 0) {
            0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::lending_pool::internal_swap_repay_for_margin_account<T1>(arg7, &mut v3, 0x2::balance::split<T1>(&mut arg9, 0x1::u64::min(v0, v4)), arg10, arg12, arg13);
        };
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::deposit_collateral<T1>(&mut v3, arg9, arg10);
        let v5 = 0x1::u64::min(arg8, 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::collateral_value<T0>(&v3));
        let v6 = arg8 - v5;
        let v7 = 0x2::balance::zero<T0>();
        let (v8, v9) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::withdraw_collateral<T0>(&mut v3, v5);
        let v10 = v9;
        0x2::balance::join<T0>(&mut v7, v8);
        if (v6 > 0) {
            let (v11, _, v13) = 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::lending_pool::internal_swap_borrow_and_check_later<T0>(arg6, &mut v3, v6, arg10, arg12, arg13);
            0x2::balance::join<T0>(&mut v7, v11);
            0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::join_must_check_borrow_limits(&v10, v13);
        };
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::check_borrow_limits(&v3, arg11, arg10, v10);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::margin_account::return_margin_account(arg5, v3, v2);
        0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::swap::emit_swap_event<T1, T0>(arg1, 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::Account>(arg0), 0x2::object::id<0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::NonceLane>(arg2), 0x579bba19087a2caa50244f489c5b715d7aacf44ad5bd81a72f32d6998346cab6::rfq_account::nonce_lane_value(arg2), v0, 0x2::balance::value<T0>(&v7));
        v7
    }

    // decompiled from Move bytecode v6
}

