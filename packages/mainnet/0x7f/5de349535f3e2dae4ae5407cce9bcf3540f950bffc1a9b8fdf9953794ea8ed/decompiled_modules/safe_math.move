module 0x7f5de349535f3e2dae4ae5407cce9bcf3540f950bffc1a9b8fdf9953794ea8ed::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

