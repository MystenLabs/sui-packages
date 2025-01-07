module 0x88ce04e6f4a403372fa94d9b937270fe472391db2c47a861157b071c55813db0::arithmetic {
    public fun inv_128(arg0: u128) : u128 {
        170141183460469231731687303715884105728 / arg0 << 1
    }

    public fun mul_128(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) >> 64) as u128)
    }

    public fun sqrt_128(arg0: u128) : u128 {
        0x1::u128::sqrt(arg0) << 32
    }

    public fun to_128(arg0: u64) : u128 {
        (arg0 as u128) << 64
    }

    // decompiled from Move bytecode v6
}

