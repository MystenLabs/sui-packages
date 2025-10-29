module 0x49976b7e9ab07feca81806b65eaf2d65472eece3f6ac083ba5fe6752954ee4b3::arithmetic {
    public fun div_128(arg0: u128, arg1: u128) : u128 {
        ((((arg0 as u256) << 64) / (arg1 as u256)) as u128)
    }

    public fun floor(arg0: u128) : u64 {
        ((arg0 >> 64) as u64)
    }

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

