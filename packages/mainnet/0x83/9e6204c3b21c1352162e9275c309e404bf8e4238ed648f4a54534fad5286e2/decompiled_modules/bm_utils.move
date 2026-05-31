module 0x839e6204c3b21c1352162e9275c309e404bf8e4238ed648f4a54534fad5286e2::bm_utils {
    public fun get_locked_and_settled_amounts<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : (u64, u64, u64, 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<T0, T1>(arg0, arg1);
        (v0, v1, v2, get_settled_amounts<T0, T1>(arg0, arg1))
    }

    public fun get_settled_amounts<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances> {
        if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_exists<T0, T1>(arg0, arg1)) {
            return 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances>()
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg0, arg1);
        0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::settled_balances(&v0))
    }

    // decompiled from Move bytecode v7
}

