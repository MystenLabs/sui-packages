module 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::flash_loan {
    struct BorrowFlashLoanEvent has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct RepayFlashLoanEvent has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct BorrowFlashLoanV2Event has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
        fee_discount_numerator: u64,
        fee_discount_denominator: u64,
    }

    struct RepayFlashLoanV2Event has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    public fun borrow_flash_loan<T0>(arg0: &0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::version::Version, arg1: &mut 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::reserve::FlashLoan<T0>) {
        0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::version::assert_current_version(arg0);
        borrow_flash_loan_internal<T0>(arg1, arg2, arg3)
    }

    fun borrow_flash_loan_internal<T0>(arg0: &mut 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::reserve::FlashLoan<T0>) {
        assert!(0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::uid(arg0), 0x2::tx_context::sender(arg2)), 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::error::whitelist_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::is_base_asset_active(arg0, v0), 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::error::base_asset_not_active_error());
        let (v1, v2) = 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::borrow_flash_loan<T0>(arg0, arg1, arg2);
        let v3 = v2;
        let v4 = BorrowFlashLoanV2Event{
            borrower                 : 0x2::tx_context::sender(arg2),
            asset                    : v0,
            amount                   : arg1,
            fee                      : 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::reserve::flash_loan_fee<T0>(&v3),
            fee_discount_numerator   : 0,
            fee_discount_denominator : 0,
        };
        0x2::event::emit<BorrowFlashLoanV2Event>(v4);
        (v1, v3)
    }

    public fun repay_flash_loan<T0>(arg0: &0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::version::Version, arg1: &mut 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::reserve::FlashLoan<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::version::assert_current_version(arg0);
        let v0 = RepayFlashLoanV2Event{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<T0>(),
            amount   : 0x2::coin::value<T0>(&arg2),
            fee      : 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::reserve::flash_loan_fee<T0>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanV2Event>(v0);
        0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::market::repay_flash_loan<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

