module 0x7fad60b9c8e4bada9fc81fe16d56a662f399c31de2aad523d9735e567d013ebb::bm_utils {
    public fun get_settled_amounts<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances> {
        if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_exists<T0, T1>(arg0, arg1)) {
            return 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances>()
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg0, arg1);
        0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::Balances>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::settled_balances(&v0))
    }

    // decompiled from Move bytecode v7
}

