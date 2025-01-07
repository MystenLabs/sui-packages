module 0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

