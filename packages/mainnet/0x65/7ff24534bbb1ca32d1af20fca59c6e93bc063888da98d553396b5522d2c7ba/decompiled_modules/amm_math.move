module 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_math {
    public fun safe_compare_mul_u128(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : bool {
        arg0 * arg1 >= arg2 * arg3
    }

    public fun safe_compare_mul_u64(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        (arg0 as u128) * (arg1 as u128) >= (arg2 as u128) * (arg3 as u128)
    }

    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun safe_mul_div_u64_u128(arg0: u128, arg1: u128, arg2: u128) : u64 {
        ((arg0 * arg1 / arg2) as u64)
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun safe_mul_u64_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    // decompiled from Move bytecode v6
}

