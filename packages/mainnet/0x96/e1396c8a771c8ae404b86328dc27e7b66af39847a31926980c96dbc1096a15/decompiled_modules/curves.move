module 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::curves {
    public fun calculate_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::full_math_u64::mul_div_ceil(arg0, arg1, arg1 - arg2) - arg0
    }

    public fun calculate_sui_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 - 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::full_math_u64::mul_div_ceil(arg1, arg2, arg2 + arg0)
    }

    public fun calculate_token_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg2 - 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::full_math_u64::mul_div_ceil(arg1, arg2, arg1 + arg0)
    }

    // decompiled from Move bytecode v6
}

