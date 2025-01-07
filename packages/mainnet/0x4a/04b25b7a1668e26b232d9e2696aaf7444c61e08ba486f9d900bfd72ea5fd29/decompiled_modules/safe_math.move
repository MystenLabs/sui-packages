module 0x4a04b25b7a1668e26b232d9e2696aaf7444c61e08ba486f9d900bfd72ea5fd29::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

