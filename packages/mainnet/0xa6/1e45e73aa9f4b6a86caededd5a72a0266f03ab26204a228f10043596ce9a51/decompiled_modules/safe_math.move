module 0xa61e45e73aa9f4b6a86caededd5a72a0266f03ab26204a228f10043596ce9a51::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

