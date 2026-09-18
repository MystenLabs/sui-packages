module 0x222363c2aa700b387914d26441ea45f1caaec1219105c8c2efaf7f2ba643a52f::curves {
    public fun calculate_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x222363c2aa700b387914d26441ea45f1caaec1219105c8c2efaf7f2ba643a52f::full_math_u64::mul_div_ceil(arg1, arg2, arg2 - arg0) - arg1
    }

    public fun calculate_quote_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 - 0x222363c2aa700b387914d26441ea45f1caaec1219105c8c2efaf7f2ba643a52f::full_math_u64::mul_div_ceil(arg1, arg2, arg2 + arg0)
    }

    public fun calculate_token_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 - 0x222363c2aa700b387914d26441ea45f1caaec1219105c8c2efaf7f2ba643a52f::full_math_u64::mul_div_ceil(arg1, arg2, arg1 + arg0)
    }

    // decompiled from Move bytecode v7
}

