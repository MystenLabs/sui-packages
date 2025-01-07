module 0x8c6e5d67f9d33484ce6f09a8f158cc11b5b0d1387187958ea6579be6a4039086::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

