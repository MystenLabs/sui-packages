module 0x3ef20df3c56afea13ec04afed64260f01a92b9066ce2ad517caa136274692a85::loan {
    public fun borrow_base<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::open_loan<T0>(arg0), arg2);
        (0x2::coin::into_balance<T0>(v0), v1)
    }

    public fun borrow_quote<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::open_loan<T1>(arg0), arg2);
        (0x2::coin::into_balance<T1>(v0), v1)
    }

    public fun repay_base<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg1, 0x2::coin::from_balance<T0>(0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::close_loan<T0>(arg0, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::amount<T0>(arg0)), arg3), arg2);
    }

    public fun repay_quote<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg1, 0x2::coin::from_balance<T1>(0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::close_loan<T1>(arg0, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::amount<T1>(arg0)), arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

