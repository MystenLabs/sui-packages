module 0xd84b2f1cd526830ad2e565bb68d4f71c3ecd3b4422024528f18e439a441251e7::flash {
    public entry fun flash_collect<T0, T1, T2, T3>(arg0: &0xd84b2f1cd526830ad2e565bb68d4f71c3ecd3b4422024528f18e439a441251e7::owner::OwnerCap, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &0x8d1aee27f8537c06d19c16641f27008caafc42affd2d2fb7adb96919470481ec::bucketus::CetusLpVault, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, arg2, arg6);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T2, T3>(arg4, arg5, 0x8d1aee27f8537c06d19c16641f27008caafc42affd2d2fb7adb96919470481ec::bucketus::borrow_cetus_position(arg3), true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v2, arg6), 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v3, arg6), 0x2::tx_context::sender(arg6));
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg1, v0, v1);
    }

    public entry fun flash_probe<T0, T1>(arg0: &0xd84b2f1cd526830ad2e565bb68d4f71c3ecd3b4422024528f18e439a441251e7::owner::OwnerCap, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, arg2, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg1, v0, v1);
        let (v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, arg3, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg1, v2, v3);
    }

    // decompiled from Move bytecode v7
}

