module 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

