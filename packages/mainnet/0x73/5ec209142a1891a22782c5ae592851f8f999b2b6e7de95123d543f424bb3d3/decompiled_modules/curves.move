module 0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::curves {
    public fun calculate_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::full_math_u64::mul_div_ceil(arg0, arg1, arg1 - arg2) - arg0
    }

    public fun calculate_sui_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 - 0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::full_math_u64::mul_div_ceil(arg1, arg2, arg2 + arg0)
    }

    public fun calculate_token_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 - 0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::full_math_u64::mul_div_ceil(arg1, arg2, arg1 + arg0)
    }

    // decompiled from Move bytecode v6
}

