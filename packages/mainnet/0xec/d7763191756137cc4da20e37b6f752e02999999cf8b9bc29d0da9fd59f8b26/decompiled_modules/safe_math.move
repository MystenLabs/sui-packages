module 0xecd7763191756137cc4da20e37b6f752e02999999cf8b9bc29d0da9fd59f8b26::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

