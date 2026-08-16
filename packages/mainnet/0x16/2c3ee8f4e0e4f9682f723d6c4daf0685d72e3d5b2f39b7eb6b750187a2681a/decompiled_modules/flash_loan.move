module 0x7e7d1eaf043d2d27234150408aa31ccd8b9449e4604ae97400edeb5306fffc89::flash_loan {
    struct Receipt {
        inner: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        amount: u64,
        min_profit: u64,
    }

    public fun return_flashloan_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: Receipt, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Receipt {
            inner      : v0,
            amount     : v1,
            min_profit : v2,
        } = arg2;
        assert!(0x2::coin::value<T0>(&arg1) >= v1 + v2, 187);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg1, v1, arg3), v0);
        arg1
    }

    public fun return_flashloan_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: Receipt, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let Receipt {
            inner      : v0,
            amount     : v1,
            min_profit : v2,
        } = arg2;
        assert!(0x2::coin::value<T1>(&arg1) >= v1 + v2, 187);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg1, v1, arg3), v0);
        arg1
    }

    public fun flashloan_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg3);
        let v2 = Receipt{
            inner      : v1,
            amount     : arg1,
            min_profit : arg2,
        };
        (v0, v2)
    }

    public fun flashloan_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Receipt) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg3);
        let v2 = Receipt{
            inner      : v1,
            amount     : arg1,
            min_profit : arg2,
        };
        (v0, v2)
    }

    public fun loan_amount(arg0: &Receipt) : u64 {
        arg0.amount
    }

    public fun min_profit(arg0: &Receipt) : u64 {
        arg0.min_profit
    }

    public fun return_flashloan_base_plus<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: Receipt, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = return_flashloan_base<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun return_flashloan_base_plus_min<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: Receipt, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let Receipt {
            inner      : v0,
            amount     : v1,
            min_profit : v2,
        } = arg2;
        let v3 = if (arg3 > v2) {
            arg3
        } else {
            v2
        };
        assert!(0x2::coin::value<T0>(&arg1) >= v1 + v3, 187);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg1, v1, arg4), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
    }

    public fun return_flashloan_quote_plus<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: Receipt, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = return_flashloan_quote<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun return_flashloan_quote_plus_min<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: Receipt, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let Receipt {
            inner      : v0,
            amount     : v1,
            min_profit : v2,
        } = arg2;
        let v3 = if (arg3 > v2) {
            arg3
        } else {
            v2
        };
        assert!(0x2::coin::value<T1>(&arg1) >= v1 + v3, 187);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg1, v1, arg4), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

