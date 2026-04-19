module 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::curves {
    public fun calculate_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::full_math_u64::mul_div_ceil(arg1, arg2, arg2 - arg0) - arg1
    }

    public fun calculate_quote_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 - 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::full_math_u64::mul_div_ceil(arg1, arg2, arg2 + arg0)
    }

    public fun calculate_token_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 - 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::full_math_u64::mul_div_ceil(arg1, arg2, arg1 + arg0)
    }

    // decompiled from Move bytecode v7
}

