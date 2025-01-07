module 0xe72e764bf13ee1aa37e211b2a10510c72972499c02dba027cef98af0183cf4e0::math_utils {
    public fun average_u64(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u256) + (arg1 as u256)) / 2) as u64)
    }

    public fun sqrt_u64(arg0: u64) : u64 {
        0x2::math::sqrt(arg0)
    }

    // decompiled from Move bytecode v6
}

