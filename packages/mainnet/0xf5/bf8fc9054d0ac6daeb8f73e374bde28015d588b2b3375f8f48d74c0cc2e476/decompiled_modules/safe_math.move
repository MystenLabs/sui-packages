module 0xf5bf8fc9054d0ac6daeb8f73e374bde28015d588b2b3375f8f48d74c0cc2e476::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

