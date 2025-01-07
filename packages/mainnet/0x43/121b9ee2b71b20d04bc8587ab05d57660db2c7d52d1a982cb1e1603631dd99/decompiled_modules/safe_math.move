module 0x43121b9ee2b71b20d04bc8587ab05d57660db2c7d52d1a982cb1e1603631dd99::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

