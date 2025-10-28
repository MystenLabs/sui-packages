module 0x51097d628de7a1b0086b76d2659a21b0e18b3d7be5811ae5e31e44c84e8436b::math {
    public fun add_u64(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun m_round_down(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun pct_bps(arg0: u64, arg1: u64) : u64 {
        mul_div_u64(arg0, arg1, 10000)
    }

    public fun sub_u64(arg0: u64, arg1: u64) : u64 {
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

