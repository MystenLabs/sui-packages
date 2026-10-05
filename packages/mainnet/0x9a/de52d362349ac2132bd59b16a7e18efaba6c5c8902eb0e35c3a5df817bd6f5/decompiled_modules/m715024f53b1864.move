module 0x9ade52d362349ac2132bd59b16a7e18efaba6c5c8902eb0e35c3a5df817bd6f5::m715024f53b1864 {
    public fun f4b2cff57c1cc<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::coin::send_funds<T0>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun f4fe6036ce8a4<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T1>, arg2: u64, arg3: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&arg3)) {
            0x1::option::destroy_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg3);
            return
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg1, arg2), arg4), 0x1::option::destroy_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg3));
    }

    public fun f6a337308870e<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&arg3)) {
            0x1::option::destroy_none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg3);
            return
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, arg2), arg4), 0x1::option::destroy_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg3));
    }

    public fun f70aa3a554dbf<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>) {
        if (arg1 == 0) {
            return (0x2::balance::zero<T1>(), 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>())
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        (0x2::coin::into_balance<T1>(v0), 0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v1))
    }

    public fun fc6c03d772312<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>) {
        if (arg1 == 0) {
            return (0x2::balance::zero<T0>(), 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>())
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        (0x2::coin::into_balance<T0>(v0), 0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v1))
    }

    // decompiled from Move bytecode v7
}

