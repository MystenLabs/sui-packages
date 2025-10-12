module 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::flash_loan {
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

    public fun borrow_flash_loan<T0, T1>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>) {
        let (v0, v1) = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::borrow_flash_loan<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg2),
            asset    : 0x1::type_name::get<T1>(),
            amount   : arg1,
            fee      : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::fee<T0, T1>(&v2),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v3);
        (v0, v2)
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: 0x2::coin::Coin<T1>, arg2: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::get<T1>(),
            amount   : 0x2::coin::value<T1>(&arg1),
            fee      : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::fee<T0, T1>(&arg2),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::repay_flash_loan<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

