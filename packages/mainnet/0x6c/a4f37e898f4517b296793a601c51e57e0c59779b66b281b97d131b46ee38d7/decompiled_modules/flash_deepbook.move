module 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::flash_deepbook {
    public fun begin_base<T0, T1>(arg0: &0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, arg2, arg4);
        (0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::router::start<T0>(arg0, 0x2::coin::into_balance<T0>(v0), arg2, arg3), v1)
    }

    public fun begin_quote<T0, T1>(arg0: &0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::config::Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, arg2, arg4);
        (0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::router::start<T1>(arg0, 0x2::coin::into_balance<T1>(v0), arg2, arg3), v1)
    }

    public fun settle_base<T0, T1>(arg0: 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::finish<T0>(arg0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::principal<T0>(&arg0)), arg3), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun settle_quote<T0, T1>(arg0: 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::finish<T1>(arg0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0, 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::principal<T1>(&arg0)), arg3), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

