module 0x1b55d504f53203d203f133a6dfe48d0c9e3fb2930d377c54fe9267e4f44ee221::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

