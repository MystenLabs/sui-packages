module 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::flash_loan {
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

    public fun borrow_flash_loan<T0>(arg0: &0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::version::Version, arg1: &mut 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::reserve::FlashLoan<T0>) {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::version::assert_current_version(arg0);
        let v0 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::get<T0>(),
            amount   : arg2,
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v0);
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::market::borrow_flash_loan<T0>(arg1, arg2, arg3)
    }

    public fun repay_flash_loan<T0>(arg0: &0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::version::Version, arg1: &mut 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::reserve::FlashLoan<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::version::assert_current_version(arg0);
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<T0>(),
            amount   : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::market::repay_flash_loan<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

