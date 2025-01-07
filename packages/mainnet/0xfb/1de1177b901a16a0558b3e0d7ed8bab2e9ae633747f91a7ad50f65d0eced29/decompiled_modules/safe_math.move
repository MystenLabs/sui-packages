module 0xfb1de1177b901a16a0558b3e0d7ed8bab2e9ae633747f91a7ad50f65d0eced29::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

