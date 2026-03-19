module 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::flash_loan {
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

    public fun borrow_flash_loan<T0, T1>(arg0: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg1: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::PackageCallerCap, arg2: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::FlashLoan<T0, T1>) {
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ensure_version_matches(arg0);
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::validate_market<T0>(arg0, arg2);
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ensure_has_permission(arg0, 0x2::object::id<0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::PackageCallerCap>(arg1), 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::whitelist_admin::flash_loan());
        borrow_flash_loan_inner<T0, T1>(arg2, arg4, arg3, arg5)
    }

    fun borrow_flash_loan_inner<T0, T1>(arg0: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::FlashLoan<T0, T1>) {
        assert!(!0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::has_circuit_break_triggered<T0>(arg0), 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::error::market_under_circuit_break());
        let (v0, v1) = 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::borrow_flash_loan<T0, T1>(arg0, arg2, arg1, arg3);
        let v2 = v1;
        let v3 = BorrowFlashLoanEvent{
            market   : 0x1::type_name::with_defining_ids<T0>(),
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::with_defining_ids<T1>(),
            amount   : arg1,
            fee      : 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::fee<T0, T1>(&v2),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v3);
        (v0, v2)
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg1: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::FlashLoan<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ensure_version_matches(arg0);
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::validate_market<T0>(arg0, arg1);
        let v0 = RepayFlashLoanEvent{
            market   : 0x1::type_name::with_defining_ids<T0>(),
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::with_defining_ids<T1>(),
            amount   : 0x2::coin::value<T1>(&arg2),
            fee      : 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::fee<T0, T1>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::repay_flash_loan<T0, T1>(arg1, arg2, arg3, 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::referral_mut(arg0), 0x1::option::none<0x1::string::String>(), arg4);
    }

    public fun repay_flash_loan_increase_referral_qualification<T0, T1>(arg0: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg1: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::FlashLoan<T0, T1>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x91eff0477a2ed085f95d0e72a83b63e40e7258e3b3dcc7d54554ca4038794463::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ensure_version_matches(arg0);
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::validate_market<T0>(arg0, arg1);
        let v0 = RepayFlashLoanEvent{
            market   : 0x1::type_name::with_defining_ids<T0>(),
            borrower : 0x2::tx_context::sender(arg8),
            asset    : 0x1::type_name::with_defining_ids<T1>(),
            amount   : 0x2::coin::value<T1>(&arg2),
            fee      : 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::fee<T0, T1>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        let v1 = 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::referral_mut(arg0);
        track_referral(v1, 0x2::tx_context::sender(arg8), 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::loan_amount<T0, T1>(&arg3), 0x1::type_name::with_defining_ids<T1>(), arg5, arg6, arg7);
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::repay_flash_loan<T0, T1>(arg1, arg2, arg3, v1, 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::referral::try_map_referral_code(v1, 0x2::tx_context::sender(arg8), arg4), arg8);
    }

    fun track_referral(arg0: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::referral::Referral, arg1: address, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x91eff0477a2ed085f95d0e72a83b63e40e7258e3b3dcc7d54554ca4038794463::x_oracle::XOracle, arg6: &0x2::clock::Clock) {
        if (0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::referral::is_qualified_to_create_referral_code(arg0, arg1)) {
            return
        };
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::referral::increase_usd_qualification(arg0, arg1, 0x3912ba0e6903a9c51f43d46c4fce460af4990cc33296b0c1e2d7294cfb9110ce::float::floor(0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::value::coin_value(0x91eff0477a2ed085f95d0e72a83b63e40e7258e3b3dcc7d54554ca4038794463::user_oracle::get_price(arg5, arg3, 0x91eff0477a2ed085f95d0e72a83b63e40e7258e3b3dcc7d54554ca4038794463::x_oracle::usd(), arg6), 0x3912ba0e6903a9c51f43d46c4fce460af4990cc33296b0c1e2d7294cfb9110ce::float::from(arg2), 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::coin_decimals_registry::decimals(arg4, arg3))));
    }

    // decompiled from Move bytecode v6
}

