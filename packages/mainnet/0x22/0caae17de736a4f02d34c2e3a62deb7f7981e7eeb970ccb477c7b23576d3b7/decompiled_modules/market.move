module 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::market {
    struct LoanRepaid has copy, drop {
        loan_id: 0x2::object::ID,
        borrower: address,
        lender: address,
        principal: u64,
        interest: u64,
        total_repaid: u64,
    }

    entry fun cancel_order<T0, T1>(arg0: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::remove_order<T0, T1>(arg0, arg1, v0);
        if (0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::order_side(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::borrow_order<T0, T1>(arg0, arg1)) == 0 && 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::has_deposit<T0, T1>(arg0, arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::withdraw_deposit<T0, T1>(arg0, arg1), arg2), v0);
        };
    }

    entry fun create_market<T0, T1>(arg0: u64, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::share<T0, T1>(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::new<T0, T1>(arg0, arg1, arg2, arg3));
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::share<T1>(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::new<T1>(arg3));
    }

    entry fun create_pool<T0, T1>(arg0: &0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::pool::share<T0>(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::pool::new<T0>(0x2::tx_context::sender(arg4), 0x2::object::id<0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>>(arg0), arg1, arg2, arg3, arg4));
    }

    public fun match_orders<T0, T1>(arg0: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::MatchReceipt {
        let (v0, v1, v2, v3, v4, v5, v6) = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::execute_match<T0, T1>(arg0, arg1, arg2);
        0x2::clock::timestamp_ms(arg3);
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::new_match_receipt(0x2::object::id<0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>>(arg0), v2, v3, v0, v1, 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::duration_bucket<T0, T1>(arg0), v6, v4, v5)
    }

    entry fun place_borrow_order<T0, T1>(arg0: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::add_order<T0, T1>(arg0, 1, arg1, arg2, 0x2::clock::timestamp_ms(arg3), 0x2::tx_context::sender(arg4));
    }

    entry fun place_lend_order<T0, T1>(arg0: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::store_deposit<T0, T1>(arg0, 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::add_order<T0, T1>(arg0, 0, 0x2::coin::value<T0>(&arg1), arg2, 0x2::clock::timestamp_ms(arg3), 0x2::tx_context::sender(arg4)), 0x2::coin::into_balance<T0>(arg1));
    }

    entry fun rebalance_pool<T0, T1>(arg0: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::pool::LiquidityPool<T0>, arg1: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::pool::rebalance<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun repay<T0, T1>(arg0: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::LoanPosition, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::CollateralVault<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::side(arg0) == 1, 302);
        0x2::clock::timestamp_ms(arg3);
        let v0 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::principal(arg0);
        let v1 = v0 * 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::rate(arg0) / 10000;
        let v2 = v0 + v1;
        assert!(0x2::coin::value<T0>(&arg1) >= v2, 301);
        let v3 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::lender(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2, arg4), v3);
        let v4 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::loan_id(arg0);
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::remove_loan_info<T1>(arg2, v4);
        let v5 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::withdraw<T1>(arg2, v4), arg4), v5);
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::set_status(arg0, 1);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v5);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        let v6 = LoanRepaid{
            loan_id      : v4,
            borrower     : v5,
            lender       : v3,
            principal    : v0,
            interest     : v1,
            total_repaid : v2,
        };
        0x2::event::emit<LoanRepaid>(v6);
    }

    public fun settle<T0, T1>(arg0: 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::MatchReceipt, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg3: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::CollateralVault<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::receipt_lender(&arg0);
        let v1 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::receipt_borrower(&arg0);
        let v2 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::receipt_matched_amount(&arg0);
        let v3 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::receipt_collateral_required(&arg0);
        assert!(0x2::coin::value<T1>(&arg1) >= v3, 300);
        let v4 = 0x2::coin::from_balance<T0>(0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::withdraw_deposit<T0, T1>(arg2, 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::receipt_lend_order_id(&arg0)), arg5);
        let (v5, v6) = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::settle_receipt(arg0, 0x2::clock::timestamp_ms(arg4), arg5);
        let v7 = v5;
        let v8 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::loan_id(&v7);
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::deposit<T1>(arg3, v8, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v3, arg5)));
        0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::vault::store_loan_info<T1>(arg3, v8, v0, v1, v2, 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::receipt_rate(&arg0), 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::maturity_time(&v7), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v4, v2, arg5), v1);
        0x2::transfer::public_transfer<0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::LoanPosition>(v7, v0);
        0x2::transfer::public_transfer<0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::position::LoanPosition>(v6, v1);
        if (0x2::coin::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
        if (0x2::coin::value<T1>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T1>(arg1);
        };
    }

    // decompiled from Move bytecode v6
}

