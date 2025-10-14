module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::flash_loan {
    struct BorrowFlashLoanEvent has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    struct RepayFlashLoanEvent has copy, drop {
        borrower: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    public fun borrow_flash_loan<T0, T1>(arg0: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::FlashLoan<T0, T1>) {
        borrow_flash_loan_inner<T0, T1>(arg0, arg1, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::emode::default_emode_group(), arg2)
    }

    public(friend) fun borrow_flash_loan_inner<T0, T1>(arg0: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::FlashLoan<T0, T1>) {
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::ensure_version_matches<T0>(arg0);
        assert!(!0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::has_circuit_break_triggered<T0>(arg0), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_under_circuit_break());
        let (v0, v1) = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::borrow_flash_loan<T0, T1>(arg0, arg2, arg1, arg3);
        let v2 = v1;
        let v3 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::get<T1>(),
            amount   : arg1,
            fee      : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::fee<T0, T1>(&v2),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v3);
        (v0, v2)
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: 0x2::coin::Coin<T1>, arg2: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::FlashLoan<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::ensure_version_matches<T0>(arg0);
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::get<T1>(),
            amount   : 0x2::coin::value<T1>(&arg1),
            fee      : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::fee<T0, T1>(&arg2),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::repay_flash_loan<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

