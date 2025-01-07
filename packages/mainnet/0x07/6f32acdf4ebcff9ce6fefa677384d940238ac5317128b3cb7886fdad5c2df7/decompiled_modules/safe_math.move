module 0x76f32acdf4ebcff9ce6fefa677384d940238ac5317128b3cb7886fdad5c2df7::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

