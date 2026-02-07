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

    // decompiled from Move bytecode v6
}

