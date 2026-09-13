module 0x35959a94cc60a5aaa38df0327f6d313fd7f5a8f97301aa40d2e9a049775bb01b::curves {
    public fun calculate_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x35959a94cc60a5aaa38df0327f6d313fd7f5a8f97301aa40d2e9a049775bb01b::full_math_u64::mul_div_ceil(arg1, arg2, arg2 - arg0) - arg1
    }

    public fun calculate_quote_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 - 0x35959a94cc60a5aaa38df0327f6d313fd7f5a8f97301aa40d2e9a049775bb01b::full_math_u64::mul_div_ceil(arg1, arg2, arg2 + arg0)
    }

    public fun calculate_token_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 - 0x35959a94cc60a5aaa38df0327f6d313fd7f5a8f97301aa40d2e9a049775bb01b::full_math_u64::mul_div_ceil(arg1, arg2, arg1 + arg0)
    }

    // decompiled from Move bytecode v7
}

