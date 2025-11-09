module 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::flash_loan {
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

    public fun borrow_flash_loan<T0, T1>(arg0: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg1: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::PackageCallerCap, arg2: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::FlashLoan<T0, T1>) {
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::validate_market<T0>(arg0, arg2);
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::ensure_version_matches<T0>(arg2);
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ensure_has_permission(arg0, 0x2::object::id<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::PackageCallerCap>(arg1), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::whitelist_admin::flash_loan());
        borrow_flash_loan_inner<T0, T1>(arg2, arg4, arg3, arg5)
    }

    fun borrow_flash_loan_inner<T0, T1>(arg0: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::FlashLoan<T0, T1>) {
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::ensure_version_matches<T0>(arg0);
        assert!(!0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::has_circuit_break_triggered<T0>(arg0), 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::error::market_under_circuit_break());
        let (v0, v1) = 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::borrow_flash_loan<T0, T1>(arg0, arg2, arg1, arg3);
        let v2 = v1;
        let v3 = BorrowFlashLoanEvent{
            market   : 0x1::type_name::get<T0>(),
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::get<T1>(),
            amount   : arg1,
            fee      : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::fee<T0, T1>(&v2),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v3);
        (v0, v2)
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg1: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::FlashLoan<T0, T1>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::ensure_version_matches<T0>(arg1);
        let v0 = RepayFlashLoanEvent{
            market   : 0x1::type_name::get<T0>(),
            borrower : 0x2::tx_context::sender(arg5),
            asset    : 0x1::type_name::get<T1>(),
            amount   : 0x2::coin::value<T1>(&arg2),
            fee      : 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::fee<T0, T1>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::repay_flash_loan<T0, T1>(arg1, arg2, arg3, 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::referral_mut(arg0), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

