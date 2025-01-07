module 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

