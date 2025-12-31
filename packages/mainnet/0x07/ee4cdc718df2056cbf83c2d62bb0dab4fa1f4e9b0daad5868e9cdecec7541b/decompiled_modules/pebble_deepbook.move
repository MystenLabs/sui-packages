module 0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::pebble_deepbook {
    public fun liquidate_c2d<T0, T1, T2>(arg0: &0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::Liquidator, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg9: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg11));
        let (v0, v1, v2) = liquidate_with_deepbook_c2d<T0, T1, T2>(arg1, 0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::borrow_package_caller_cap(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::transfer_to_recipient<T2>(arg0, v0);
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::transfer_to_recipient<T1>(arg0, v1);
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::transfer_to_recipient<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, v2);
    }

    public fun liquidate_d2c<T0, T1, T2>(arg0: &0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::Liquidator, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg9: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg11));
        let (v0, v1, v2) = liquidate_with_deepbook_d2c<T0, T1, T2>(arg1, 0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::borrow_package_caller_cap(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::transfer_to_recipient<T2>(arg0, v0);
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::transfer_to_recipient<T1>(arg0, v1);
        0x7ee4cdc718df2056cbf83c2d62bb0dab4fa1f4e9b0daad5868e9cdecec7541b::liquidator::transfer_to_recipient<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, v2);
    }

    fun liquidate_with_deepbook_c2d<T0, T1, T2>(arg0: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg9: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1) = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::borrow_flash_loan<T0, T1>(arg0, arg1, arg3, arg6, arg7, arg11);
        let v2 = v0;
        let v3 = (((0x2::coin::value<T1>(&v2) as u128) * ((5 + 10000) as u128) / 10000) as u64);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T2, T1>(arg8, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::liquidate::liquidate_as_coin<T0, T1, T2>(arg0, arg1, arg2, arg3, v2, arg4, arg5, arg10, arg11), arg9, v3, arg10, arg11);
        let v7 = v5;
        let v8 = v4;
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::repay_flash_loan<T0, T1>(arg0, arg3, 0x2::coin::split<T1>(&mut v7, v3, arg11), v1, 0x1::option::none<0x1::string::String>(), arg11);
        let (v9, v10) = if (0x2::coin::value<T1>(&v7) > 0) {
            let (v11, v12, v13) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T2, T1>(arg8, v7, v6, 0, arg10, arg11);
            0x2::coin::join<T2>(&mut v8, v11);
            (v12, v13)
        } else {
            (v7, v6)
        };
        (v8, v9, v10)
    }

    fun liquidate_with_deepbook_d2c<T0, T1, T2>(arg0: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap, arg2: 0x2::object::ID, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg6: u8, arg7: u64, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg9: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1) = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::borrow_flash_loan<T0, T1>(arg0, arg1, arg3, arg6, arg7, arg11);
        let v2 = v0;
        let v3 = (((0x2::coin::value<T1>(&v2) as u128) * ((5 + 10000) as u128) / 10000) as u64);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg8, 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::liquidate::liquidate_as_coin<T0, T1, T2>(arg0, arg1, arg2, arg3, v2, arg4, arg5, arg10, arg11), arg9, v3, arg10, arg11);
        let v7 = v5;
        let v8 = v4;
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::repay_flash_loan<T0, T1>(arg0, arg3, 0x2::coin::split<T1>(&mut v8, v3, arg11), v1, 0x1::option::none<0x1::string::String>(), arg11);
        let (v9, v10) = if (0x2::coin::value<T1>(&v8) > 0) {
            let (v11, v12, v13) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg8, v8, v6, 0, arg10, arg11);
            0x2::coin::join<T2>(&mut v7, v12);
            (v11, v13)
        } else {
            (v8, v6)
        };
        (v7, v9, v10)
    }

    // decompiled from Move bytecode v6
}

