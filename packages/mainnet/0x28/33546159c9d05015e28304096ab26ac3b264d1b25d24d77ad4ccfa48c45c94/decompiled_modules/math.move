module 0x2833546159c9d05015e28304096ab26ac3b264d1b25d24d77ad4ccfa48c45c94::math {
    public fun full_mul(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((full_mul(arg0, arg1) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

