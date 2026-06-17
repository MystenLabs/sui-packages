module 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::gated_spot {
    public fun gated_spot_market_order<T0, T1>(arg0: &mut 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::operator_policy::OperatorPolicy, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg6: u64, arg7: u8, arg8: u64, arg9: bool, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::operator_policy::record_spend(arg0, arg1, arg2, arg11, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    // decompiled from Move bytecode v7
}

