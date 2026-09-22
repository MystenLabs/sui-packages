module 0x8cd69dbaf6e02225bb4a02444fd2f40987c6c0e7a141682551d950dcff383b5d::curves {
    public fun calculate_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x8cd69dbaf6e02225bb4a02444fd2f40987c6c0e7a141682551d950dcff383b5d::full_math_u64::mul_div_ceil(arg1, arg2, arg2 - arg0) - arg1
    }

    public fun calculate_quote_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 - 0x8cd69dbaf6e02225bb4a02444fd2f40987c6c0e7a141682551d950dcff383b5d::full_math_u64::mul_div_ceil(arg1, arg2, arg2 + arg0)
    }

    public fun calculate_token_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 - 0x8cd69dbaf6e02225bb4a02444fd2f40987c6c0e7a141682551d950dcff383b5d::full_math_u64::mul_div_ceil(arg1, arg2, arg1 + arg0)
    }

    // decompiled from Move bytecode v7
}

