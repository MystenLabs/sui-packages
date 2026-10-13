module 0xd72e5db9141b2dcb229863050f37e3719f91522f747001ae5cbb2ab63d6f0a26::flash_deepbook {
    public fun borrow_base<T0, T1>(arg0: &0xd72e5db9141b2dcb229863050f37e3719f91522f747001ae5cbb2ab63d6f0a26::router::Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0xd72e5db9141b2dcb229863050f37e3719f91522f747001ae5cbb2ab63d6f0a26::router::ArbSession<T0>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, arg2, arg3);
        (0x2::coin::into_balance<T0>(v0), 0xd72e5db9141b2dcb229863050f37e3719f91522f747001ae5cbb2ab63d6f0a26::router::begin<T0>(arg0, arg2, arg3), v1)
    }

    public fun borrow_quote<T0, T1>(arg0: &0xd72e5db9141b2dcb229863050f37e3719f91522f747001ae5cbb2ab63d6f0a26::router::Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0xd72e5db9141b2dcb229863050f37e3719f91522f747001ae5cbb2ab63d6f0a26::router::ArbSession<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, arg2, arg3);
        (0x2::coin::into_balance<T1>(v0), 0xd72e5db9141b2dcb229863050f37e3719f91522f747001ae5cbb2ab63d6f0a26::router::begin<T1>(arg0, arg2, arg3), v1)
    }

    public fun repay_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3), arg2);
    }

    public fun repay_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

