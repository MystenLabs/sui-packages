module 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::flash_loan {
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

    public fun borrow_flash_loan<T0, T1>(arg0: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::ProtocolApp, arg1: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::PackageCallerCap, arg2: &mut 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::FlashLoan<T0, T1>) {
        0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::validate_market<T0>(arg0, arg2);
        0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::ensure_version_matches<T0>(arg2);
        0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::ensure_has_permission(arg0, 0x2::object::id<0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::PackageCallerCap>(arg1), 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::whitelist_admin::flash_loan());
        borrow_flash_loan_inner<T0, T1>(arg2, arg4, arg3, arg5)
    }

    fun borrow_flash_loan_inner<T0, T1>(arg0: &mut 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::FlashLoan<T0, T1>) {
        0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::ensure_version_matches<T0>(arg0);
        assert!(!0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::has_circuit_break_triggered<T0>(arg0), 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::error::market_under_circuit_break());
        let (v0, v1) = 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::borrow_flash_loan<T0, T1>(arg0, arg2, arg1, arg3);
        let v2 = v1;
        let v3 = BorrowFlashLoanEvent{
            market   : 0x1::type_name::get<T0>(),
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::get<T1>(),
            amount   : arg1,
            fee      : 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::fee<T0, T1>(&v2),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v3);
        (v0, v2)
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::ProtocolApp, arg1: &mut 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::FlashLoan<T0, T1>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::ensure_version_matches<T0>(arg1);
        let v0 = RepayFlashLoanEvent{
            market   : 0x1::type_name::get<T0>(),
            borrower : 0x2::tx_context::sender(arg5),
            asset    : 0x1::type_name::get<T1>(),
            amount   : 0x2::coin::value<T1>(&arg2),
            fee      : 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::fee<T0, T1>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        let v1 = 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::referral_mut(arg0);
        0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::repay_flash_loan<T0, T1>(arg1, arg2, arg3, v1, 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::referral::try_map_referral_code(v1, 0x2::tx_context::sender(arg5), arg4), arg5);
    }

    // decompiled from Move bytecode v6
}

