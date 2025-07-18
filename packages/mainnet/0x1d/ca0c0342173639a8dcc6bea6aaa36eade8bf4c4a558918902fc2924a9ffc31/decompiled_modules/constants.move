module 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::constants {
    public fun amount_after_fee(arg0: u64, arg1: u64) : u64 {
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::safe_math::mul_div_u64(arg0, 1000000 - arg1, 1000000)
    }

    public fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::safe_math::mul_div_u64(arg0, 1000000, 1000000 - arg1)
    }

    public fun current_version() : u64 {
        1
    }

    public fun scaling_pips() : u64 {
        1000000
    }

    public fun scaling_pips_u128() : u128 {
        (1000000 as u128)
    }

    public fun scaling_pips_u256() : u256 {
        (1000000 as u256)
    }

    // decompiled from Move bytecode v6
}

