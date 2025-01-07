module 0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

