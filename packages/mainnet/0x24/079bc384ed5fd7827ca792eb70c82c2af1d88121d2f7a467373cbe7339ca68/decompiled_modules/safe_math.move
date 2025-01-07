module 0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

