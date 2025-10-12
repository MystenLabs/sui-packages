module 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::flash_loan {
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

    public fun borrow_flash_loan<T0, T1>(arg0: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::FlashLoan<T0, T1>) {
        borrow_flash_loan_inner<T0, T1>(arg0, arg1, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::emode::default_emode_group(), arg2)
    }

    public(friend) fun borrow_flash_loan_inner<T0, T1>(arg0: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::FlashLoan<T0, T1>) {
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::ensure_version_matches<T0>(arg0);
        assert!(!0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::has_circuit_break_triggered<T0>(arg0), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::market_under_circuit_break());
        let (v0, v1) = 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::borrow_flash_loan<T0, T1>(arg0, arg2, arg1, arg3);
        let v2 = v1;
        let v3 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::get<T1>(),
            amount   : arg1,
            fee      : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::fee<T0, T1>(&v2),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v3);
        (v0, v2)
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::Market<T0>, arg1: 0x2::coin::Coin<T1>, arg2: 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::FlashLoan<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::ensure_version_matches<T0>(arg0);
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::get<T1>(),
            amount   : 0x2::coin::value<T1>(&arg1),
            fee      : 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::reserve::fee<T0, T1>(&arg2),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::market::repay_flash_loan<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

