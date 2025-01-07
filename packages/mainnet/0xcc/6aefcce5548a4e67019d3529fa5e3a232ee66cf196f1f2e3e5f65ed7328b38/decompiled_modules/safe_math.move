module 0xcc6aefcce5548a4e67019d3529fa5e3a232ee66cf196f1f2e3e5f65ed7328b38::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

