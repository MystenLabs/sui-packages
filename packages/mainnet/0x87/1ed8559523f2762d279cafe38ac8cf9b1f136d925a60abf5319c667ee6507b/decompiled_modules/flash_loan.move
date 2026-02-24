module 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::flash_loan {
    struct BorrowFlashLoanEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    struct RepayFlashLoanEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    public fun borrow_flash_loan<T0, T1>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::FlashLoan<T0, T1>) {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ensure_version_matches(arg0);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::validate_market<T0>(arg0, arg2);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ensure_has_permission(arg0, 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap>(arg1), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::whitelist_admin::flash_loan());
        borrow_flash_loan_inner<T0, T1>(arg2, arg4, arg3, arg5)
    }

    fun borrow_flash_loan_inner<T0, T1>(arg0: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::FlashLoan<T0, T1>) {
        assert!(!0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::has_circuit_break_triggered<T0>(arg0), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::error::market_under_circuit_break());
        let (v0, v1) = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::borrow_flash_loan<T0, T1>(arg0, arg2, arg1, arg3);
        let v2 = v1;
        let v3 = BorrowFlashLoanEvent{
            market   : 0x1::type_name::with_defining_ids<T0>(),
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::with_defining_ids<T1>(),
            amount   : arg1,
            fee      : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::fee<T0, T1>(&v2),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v3);
        (v0, v2)
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg1: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::FlashLoan<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ensure_version_matches(arg0);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::validate_market<T0>(arg0, arg1);
        let v0 = RepayFlashLoanEvent{
            market   : 0x1::type_name::with_defining_ids<T0>(),
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::with_defining_ids<T1>(),
            amount   : 0x2::coin::value<T1>(&arg2),
            fee      : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::fee<T0, T1>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::repay_flash_loan<T0, T1>(arg1, arg2, arg3, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::referral_mut(arg0), 0x1::option::none<0x1::string::String>(), arg4);
    }

    public fun repay_flash_loan_increase_referral_qualification<T0, T1>(arg0: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg1: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::FlashLoan<T0, T1>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ensure_version_matches(arg0);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::validate_market<T0>(arg0, arg1);
        let v0 = RepayFlashLoanEvent{
            market   : 0x1::type_name::with_defining_ids<T0>(),
            borrower : 0x2::tx_context::sender(arg8),
            asset    : 0x1::type_name::with_defining_ids<T1>(),
            amount   : 0x2::coin::value<T1>(&arg2),
            fee      : 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::fee<T0, T1>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        let v1 = 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::referral_mut(arg0);
        track_referral(v1, 0x2::tx_context::sender(arg8), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::loan_amount<T0, T1>(&arg3), 0x1::type_name::with_defining_ids<T1>(), arg5, arg6, arg7);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::repay_flash_loan<T0, T1>(arg1, arg2, arg3, v1, 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::referral::try_map_referral_code(v1, 0x2::tx_context::sender(arg8), arg4), arg8);
    }

    fun track_referral(arg0: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::referral::Referral, arg1: address, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::XOracle, arg6: &0x2::clock::Clock) {
        if (0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::referral::is_qualified_to_create_referral_code(arg0, arg1)) {
            return
        };
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::referral::increase_usd_qualification(arg0, arg1, 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::value::coin_value(0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::user_oracle::get_price(arg5, arg3, 0x1814e6627da87fd0f998d978b664adaed87e7d072ab93ddc8453b9b0aaa2d733::x_oracle::usd(), arg6), 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from(arg2), 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::coin_decimals_registry::decimals(arg4, arg3))));
    }

    // decompiled from Move bytecode v6
}

