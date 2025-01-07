module 0x97b123c429e3c5c9d7ff16418b336a5bbebbd847f098c2583dc29a41410ec969::db {
    fun sui_deep_usdc<T0, T1, T2>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T2, T0>(arg0, arg2, arg3);
        let (v3, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T2, T1>(arg1, v0, arg3);
        (v1, v3, v4)
    }

    public fun usdc_out<T0, T1, T2>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T1>, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        let (_, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, arg3, arg4);
        let (v3, v4, v5) = sui_deep_usdc<T0, T1, T2>(arg1, arg2, arg3, arg4);
        (v1, v3, v4, v5)
    }

    // decompiled from Move bytecode v6
}

