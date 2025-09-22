module 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::flash_loan {
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

    public fun borrow_flash_loan<T0, T1>(arg0: &mut 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::FlashLoan<T0, T1>) {
        0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::ensure_version_matches<T0>(arg0);
        let (v0, v1) = 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::borrow_flash_loan<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = BorrowFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg2),
            asset    : 0x1::type_name::get<T1>(),
            amount   : arg1,
            fee      : 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::fee<T0, T1>(&v2),
        };
        0x2::event::emit<BorrowFlashLoanEvent>(v3);
        (v0, v2)
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::Market<T0>, arg1: 0x2::coin::Coin<T1>, arg2: 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::FlashLoan<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::ensure_version_matches<T0>(arg0);
        let v0 = RepayFlashLoanEvent{
            borrower : 0x2::tx_context::sender(arg3),
            asset    : 0x1::type_name::get<T1>(),
            amount   : 0x2::coin::value<T1>(&arg1),
            fee      : 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::fee<T0, T1>(&arg2),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v0);
        0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::repay_flash_loan<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

