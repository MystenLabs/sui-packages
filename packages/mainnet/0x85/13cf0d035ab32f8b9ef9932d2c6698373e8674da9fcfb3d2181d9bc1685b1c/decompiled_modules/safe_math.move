module 0x8513cf0d035ab32f8b9ef9932d2c6698373e8674da9fcfb3d2181d9bc1685b1c::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

