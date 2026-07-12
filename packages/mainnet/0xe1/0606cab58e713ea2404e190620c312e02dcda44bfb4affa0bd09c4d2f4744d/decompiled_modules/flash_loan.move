module 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::flash_loan {
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

    public fun borrow_flash_loan<T0, T1>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::PackageCallerCap, arg2: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::FlashLoan<T0, T1>) {
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ensure_version_matches(arg0);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::validate_market<T0>(arg0, arg2);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ensure_has_permission(arg0, 0x2::object::id<0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::PackageCallerCap>(arg1), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::whitelist_admin::flash_loan());
        borrow_flash_loan_inner<T0, T1>(arg2, arg4, arg3, arg5)
    }

    fun borrow_flash_loan_inner<T0, T1>(arg0: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::FlashLoan<T0, T1>) {
        assert!(!0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::has_circuit_break_triggered<T0>(arg0), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::error::market_under_circuit_break());
        let (v0, v1) = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::borrow_flash_loan<T0, T1>(arg0, arg2, arg1, arg3);
        let v2 = v1;
        let v3 = BorrowFlashLoanEvent{
            market   : 0x1::type_name::with_defining_ids<T0>(),
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::with_defining_ids<T1>(),
            amount   : arg1,
            fee      : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::fee<T0, T1>(&v2),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v3);
        (v0, v2)
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg1: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::FlashLoan<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ensure_version_matches(arg0);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::validate_market<T0>(arg0, arg1);
        let v0 = RepayFlashLoanEvent{
            market   : 0x1::type_name::with_defining_ids<T0>(),
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::with_defining_ids<T1>(),
            amount   : 0x2::coin::value<T1>(&arg2),
            fee      : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::fee<T0, T1>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::repay_flash_loan<T0, T1>(arg1, arg2, arg3, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::referral_mut(arg0), 0x1::option::none<0x1::string::String>(), arg4);
    }

    public fun repay_flash_loan_increase_referral_qualification<T0, T1>(arg0: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg1: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::FlashLoan<T0, T1>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ensure_version_matches(arg0);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::validate_market<T0>(arg0, arg1);
        let v0 = RepayFlashLoanEvent{
            market   : 0x1::type_name::with_defining_ids<T0>(),
            borrower : 0x2::tx_context::sender(arg8),
            asset    : 0x1::type_name::with_defining_ids<T1>(),
            amount   : 0x2::coin::value<T1>(&arg2),
            fee      : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::fee<T0, T1>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        let v1 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::referral_mut(arg0);
        track_referral(v1, 0x2::tx_context::sender(arg8), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::loan_amount<T0, T1>(&arg3), 0x1::type_name::with_defining_ids<T1>(), arg5, arg6, arg7);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::repay_flash_loan<T0, T1>(arg1, arg2, arg3, v1, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::referral::try_map_referral_code(v1, 0x2::tx_context::sender(arg8), arg4), arg8);
    }

    fun track_referral(arg0: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::referral::Referral, arg1: address, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle, arg6: &0x2::clock::Clock) {
        if (0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::referral::is_qualified_to_create_referral_code(arg0, arg1)) {
            return
        };
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::referral::increase_usd_qualification(arg0, arg1, 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::floor(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::value::coin_value(0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::user_oracle::get_price(arg5, arg3, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::usd(), arg6), 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from(arg2), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::coin_decimals_registry::decimals(arg4, arg3))));
    }

    // decompiled from Move bytecode v6
}

