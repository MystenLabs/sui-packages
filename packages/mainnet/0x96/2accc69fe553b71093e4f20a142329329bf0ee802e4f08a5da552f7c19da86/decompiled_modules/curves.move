module 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::curves {
    public fun calculate_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(arg1, arg2, arg2 - arg0) - arg1
    }

    public fun calculate_quote_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 - 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(arg1, arg2, arg2 + arg0)
    }

    public fun calculate_token_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 - 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(arg1, arg2, arg1 + arg0)
    }

    // decompiled from Move bytecode v7
}

