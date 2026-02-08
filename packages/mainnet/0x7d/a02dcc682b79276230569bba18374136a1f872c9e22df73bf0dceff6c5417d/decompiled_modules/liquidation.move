module 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::liquidation {
    struct LoanLiquidated has copy, drop {
        loan_id: 0x2::object::ID,
        liquidator: address,
        lender: address,
        borrower: address,
        principal: u64,
        collateral_seized: u64,
        liquidation_time: u64,
    }

    entry fun liquidate<T0>(arg0: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::CollateralVault<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::has_collateral<T0>(arg0, arg1), 401);
        let v0 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::get_loan_info<T0>(arg0, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 > 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_maturity_time(&v0), 400);
        let v2 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_lender(&v0);
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::remove_loan_info<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::withdraw<T0>(arg0, arg1), arg3), v2);
        let v3 = LoanLiquidated{
            loan_id           : arg1,
            liquidator        : 0x2::tx_context::sender(arg3),
            lender            : v2,
            borrower          : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_borrower(&v0),
            principal         : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_principal(&v0),
            collateral_seized : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_collateral_amount(&v0),
            liquidation_time  : v1,
        };
        0x2::event::emit<LoanLiquidated>(v3);
    }

    entry fun liquidate_unhealthy<T0, T1>(arg0: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::CollateralVault<T1>, arg1: &0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::has_collateral<T1>(arg0, arg3), 401);
        let v0 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::get_loan_info<T1>(arg0, arg3);
        assert!(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::compute_health_factor(&v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T1, T0>(arg2, arg4), 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::max_ltv_bps<T0, T1>(arg1)) < 10000, 402);
        let v1 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_lender(&v0);
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::remove_loan_info<T1>(arg0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::withdraw<T1>(arg0, arg3), arg5), v1);
        let v2 = LoanLiquidated{
            loan_id           : arg3,
            liquidator        : 0x2::tx_context::sender(arg5),
            lender            : v1,
            borrower          : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_borrower(&v0),
            principal         : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_principal(&v0),
            collateral_seized : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_collateral_amount(&v0),
            liquidation_time  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LoanLiquidated>(v2);
    }

    entry fun liquidate_unhealthy_inverse<T0, T1>(arg0: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::CollateralVault<T1>, arg1: &0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::has_collateral<T1>(arg0, arg3), 401);
        let v0 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::get_loan_info<T1>(arg0, arg3);
        assert!(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::compute_health_factor_inverse(&v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg2, arg4), 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::max_ltv_bps<T0, T1>(arg1)) < 10000, 402);
        let v1 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_lender(&v0);
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::remove_loan_info<T1>(arg0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::withdraw<T1>(arg0, arg3), arg5), v1);
        let v2 = LoanLiquidated{
            loan_id           : arg3,
            liquidator        : 0x2::tx_context::sender(arg5),
            lender            : v1,
            borrower          : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_borrower(&v0),
            principal         : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_principal(&v0),
            collateral_seized : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_collateral_amount(&v0),
            liquidation_time  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LoanLiquidated>(v2);
    }

    entry fun liquidate_via_deepbook<T0, T1>(arg0: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::CollateralVault<T1>, arg1: &0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::has_collateral<T1>(arg0, arg4), 401);
        let v0 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::get_loan_info<T1>(arg0, arg4);
        assert!(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::compute_health_factor(&v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T1, T0>(arg2, arg5), 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::max_ltv_bps<T0, T1>(arg1)) < 10000, 402);
        let v1 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_lender(&v0);
        let v2 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_borrower(&v0);
        let v3 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_principal(&v0);
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::remove_loan_info<T1>(arg0, arg4);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T0>(arg2, 0x2::coin::from_balance<T1>(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::withdraw<T1>(arg0, arg4), arg6), arg3, 0, arg5, arg6);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3 + v3 * 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_rate(&v0) / 10000;
        if (0x2::coin::value<T0>(&v8) >= v10) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v8, v10, arg6), v1);
            let v11 = 0x2::coin::value<T0>(&v8);
            let v12 = v10 * 500 / 10000;
            let v13 = if (v12 < v11) {
                v12
            } else {
                v11
            };
            if (v13 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v8, v13, arg6), 0x2::tx_context::sender(arg6));
            };
            if (0x2::coin::value<T0>(&v8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v2);
            } else {
                0x2::coin::destroy_zero<T0>(v8);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v1);
        };
        if (0x2::coin::value<T1>(&v9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, v2);
        } else {
            0x2::coin::destroy_zero<T1>(v9);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v7, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
        };
        let v14 = LoanLiquidated{
            loan_id           : arg4,
            liquidator        : 0x2::tx_context::sender(arg6),
            lender            : v1,
            borrower          : v2,
            principal         : v3,
            collateral_seized : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_collateral_amount(&v0),
            liquidation_time  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<LoanLiquidated>(v14);
    }

    entry fun liquidate_via_deepbook_inverse<T0, T1>(arg0: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::CollateralVault<T1>, arg1: &0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::has_collateral<T1>(arg0, arg4), 401);
        let v0 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::get_loan_info<T1>(arg0, arg4);
        assert!(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::compute_health_factor_inverse(&v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg2, arg5), 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::max_ltv_bps<T0, T1>(arg1)) < 10000, 402);
        let v1 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_lender(&v0);
        let v2 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_borrower(&v0);
        let v3 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_principal(&v0);
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::remove_loan_info<T1>(arg0, arg4);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg2, 0x2::coin::from_balance<T1>(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::withdraw<T1>(arg0, arg4), arg6), arg3, 0, arg5, arg6);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3 + v3 * 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_rate(&v0) / 10000;
        if (0x2::coin::value<T0>(&v9) >= v10) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v9, v10, arg6), v1);
            let v11 = 0x2::coin::value<T0>(&v9);
            let v12 = v10 * 500 / 10000;
            let v13 = if (v12 < v11) {
                v12
            } else {
                v11
            };
            if (v13 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v9, v13, arg6), 0x2::tx_context::sender(arg6));
            };
            if (0x2::coin::value<T0>(&v9) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, v2);
            } else {
                0x2::coin::destroy_zero<T0>(v9);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, v1);
        };
        if (0x2::coin::value<T1>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, v2);
        } else {
            0x2::coin::destroy_zero<T1>(v8);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v7, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
        };
        let v14 = LoanLiquidated{
            loan_id           : arg4,
            liquidator        : 0x2::tx_context::sender(arg6),
            lender            : v1,
            borrower          : v2,
            principal         : v3,
            collateral_seized : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::loan_info_collateral_amount(&v0),
            liquidation_time  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<LoanLiquidated>(v14);
    }

    // decompiled from Move bytecode v6
}

