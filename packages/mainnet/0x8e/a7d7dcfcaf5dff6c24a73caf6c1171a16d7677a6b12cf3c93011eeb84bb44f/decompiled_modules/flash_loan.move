module 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::flash_loan {
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

    public fun borrow_flash_loan<T0>(arg0: &0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::version::Version, arg1: &mut 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::reserve::FlashLoan<T0>) {
        0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::version::assert_current_version(arg0);
        let v0 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::get<T0>(),
            amount   : arg2,
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v0);
        0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::borrow_flash_loan<T0>(arg1, arg2, arg3)
    }

    public fun repay_flash_loan<T0>(arg0: &0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::version::Version, arg1: &mut 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::reserve::FlashLoan<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::version::assert_current_version(arg0);
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg4),
            asset    : 0x1::type_name::get<T0>(),
            amount   : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::repay_flash_loan<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

