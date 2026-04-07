module 0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::full_math_u128 {
    public fun full_mul(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    public fun mul_div_ceil(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((full_mul(arg0, arg1) + (arg2 as u256) - 1) / (arg2 as u256)) as u128)
    }

    public fun mul_div_floor(arg0: u128, arg1: u128, arg2: u128) : u128 {
        ((full_mul(arg0, arg1) / (arg2 as u256)) as u128)
    }

    public fun mul_div_round(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((full_mul(arg0, arg1) + ((arg2 as u256) >> 1)) / (arg2 as u256)) as u128)
    }

    public fun mul_shl(arg0: u128, arg1: u128, arg2: u8) : u128 {
        ((full_mul(arg0, arg1) << arg2) as u128)
    }

    public fun mul_shr(arg0: u128, arg1: u128, arg2: u8) : u128 {
        ((full_mul(arg0, arg1) >> arg2) as u128)
    }

    // decompiled from Move bytecode v6
}

