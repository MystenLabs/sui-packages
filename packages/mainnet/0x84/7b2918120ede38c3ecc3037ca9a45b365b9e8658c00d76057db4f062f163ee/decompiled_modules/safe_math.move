module 0x847b2918120ede38c3ecc3037ca9a45b365b9e8658c00d76057db4f062f163ee::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

