module 0xd4747583bd10a04a19b6402b3e4b1edf4ee8d9591573be0fd497e6e17be7abf8::deepbook {
    struct DeepBookFlashReceipt {
        flash_loan: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        borrow_quantity: u64,
    }

    public fun deepbook_flash_borrow_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (DeepBookFlashReceipt, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        let v2 = DeepBookFlashReceipt{
            flash_loan      : v1,
            borrow_quantity : arg1,
        };
        (v2, 0x2::coin::into_balance<T0>(v0))
    }

    public fun deepbook_flash_borrow_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (DeepBookFlashReceipt, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = DeepBookFlashReceipt{
            flash_loan      : v1,
            borrow_quantity : arg1,
        };
        (v2, 0x2::coin::into_balance<T1>(v0))
    }

    public fun deepbook_flash_repay_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: DeepBookFlashReceipt, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let DeepBookFlashReceipt {
            flash_loan      : v0,
            borrow_quantity : v1,
        } = arg1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v1), arg3), v0);
        arg2
    }

    public fun deepbook_flash_repay_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: DeepBookFlashReceipt, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let DeepBookFlashReceipt {
            flash_loan      : v0,
            borrow_quantity : v1,
        } = arg1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2, v1), arg3), v0);
        arg2
    }

    // decompiled from Move bytecode v7
}

