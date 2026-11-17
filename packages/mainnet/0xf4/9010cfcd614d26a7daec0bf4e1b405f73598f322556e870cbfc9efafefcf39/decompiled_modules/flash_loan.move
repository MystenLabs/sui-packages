module 0xf49010cfcd614d26a7daec0bf4e1b405f73598f322556e870cbfc9efafefcf39::flash_loan {
    struct FlashLoanBorrowEvent has copy, drop {
        pool_id: 0x2::object::ID,
        borrower: address,
        amount: u64,
        is_base: bool,
    }

    struct FlashLoanRepayEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        is_base: bool,
    }

    public fun borrow_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        assert!(arg1 > 0, 550);
        let v0 = FlashLoanBorrowEvent{
            pool_id  : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            borrower : 0x2::tx_context::sender(arg2),
            amount   : arg1,
            is_base  : true,
        };
        0x2::event::emit<FlashLoanBorrowEvent>(v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2)
    }

    public fun borrow_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        assert!(arg1 > 0, 550);
        let v0 = FlashLoanBorrowEvent{
            pool_id  : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            borrower : 0x2::tx_context::sender(arg2),
            amount   : arg1,
            is_base  : false,
        };
        0x2::event::emit<FlashLoanBorrowEvent>(v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2)
    }

    public fun return_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, arg1, arg2);
        let v0 = FlashLoanRepayEvent{
            pool_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            amount  : 0x2::coin::value<T0>(&arg1),
            is_base : true,
        };
        0x2::event::emit<FlashLoanRepayEvent>(v0);
    }

    public fun return_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v0 = FlashLoanRepayEvent{
            pool_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            amount  : 0x2::coin::value<T1>(&arg1),
            is_base : false,
        };
        0x2::event::emit<FlashLoanRepayEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

