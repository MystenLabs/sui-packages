module 0xbbf273670b913be0c7d3de2358f4a293f2d9e12e8a5beb74ba7d4dd19a461d1a::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

