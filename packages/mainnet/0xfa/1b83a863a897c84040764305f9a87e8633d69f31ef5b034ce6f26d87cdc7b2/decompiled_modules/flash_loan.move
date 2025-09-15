module 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::flash_loan {
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

    public fun borrow_flash_loan<T0>(arg0: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::version::Version, arg1: &mut 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::reserve::FlashLoan<T0>) {
        0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::version::assert_current_version(arg0);
        assert!(0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::whitelist::is_address_allowed(0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::market::uid(arg1), 0x2::tx_context::sender(arg3)), 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::error::whitelist_error());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::market::is_base_asset_active(arg1, v0), 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::error::base_asset_not_active_error());
        let v1 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : v0,
            amount   : arg2,
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v1);
        0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::market::borrow_flash_loan<T0>(arg1, arg2, arg3)
    }

    public fun repay_flash_loan<T0>(arg0: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::version::Version, arg1: &mut 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::reserve::FlashLoan<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::version::assert_current_version(arg0);
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<T0>(),
            amount   : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::market::repay_flash_loan<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

