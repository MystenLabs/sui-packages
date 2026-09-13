module 0xf24cafda9a9982c3936223b14418c2c6daf4388b81766de03c13cca620ad5f62::curves {
    public fun calculate_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xf24cafda9a9982c3936223b14418c2c6daf4388b81766de03c13cca620ad5f62::full_math_u64::mul_div_ceil(arg1, arg2, arg2 - arg0) - arg1
    }

    public fun calculate_quote_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 - 0xf24cafda9a9982c3936223b14418c2c6daf4388b81766de03c13cca620ad5f62::full_math_u64::mul_div_ceil(arg1, arg2, arg2 + arg0)
    }

    public fun calculate_token_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 - 0xf24cafda9a9982c3936223b14418c2c6daf4388b81766de03c13cca620ad5f62::full_math_u64::mul_div_ceil(arg1, arg2, arg1 + arg0)
    }

    // decompiled from Move bytecode v7
}

