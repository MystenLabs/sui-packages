module 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::constants::float_scaling_u128() / (arg1 as u128)) as u64)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 0x1e290a1aa6e278daec347d542a4b81d8fd02ec287b5f97e05c8e206ccdb6f8f::constants::float_scaling_u128()) as u64)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

