module 0x4554d6b3ca3db2d99af2916b371255d5a87f605860eab097291e6ea979c29883::flash_deepbook {
    struct Loan<phantom T0> {
        receipt: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        repay_amount: u64,
    }

    public fun borrow_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Loan<T0>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        let v2 = Loan<T0>{
            receipt      : v1,
            repay_amount : arg1,
        };
        (0x2::coin::into_balance<T0>(v0), v2)
    }

    public fun borrow_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Loan<T1>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = Loan<T1>{
            receipt      : v1,
            repay_amount : arg1,
        };
        (0x2::coin::into_balance<T1>(v0), v2)
    }

    public fun repay_amount<T0>(arg0: &Loan<T0>) : u64 {
        arg0.repay_amount
    }

    public fun repay_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: Loan<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let Loan {
            receipt      : v0,
            repay_amount : v1,
        } = arg2;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v1), arg3), v0);
        arg1
    }

    public fun repay_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: Loan<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let Loan {
            receipt      : v0,
            repay_amount : v1,
        } = arg2;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1, v1), arg3), v0);
        arg1
    }

    // decompiled from Move bytecode v7
}

