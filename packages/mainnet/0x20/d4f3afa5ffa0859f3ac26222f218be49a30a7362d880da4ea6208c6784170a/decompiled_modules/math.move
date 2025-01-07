module 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::math {
    public fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) + (arg1 as u128)) as u64)
    }

    public fun safe_div_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun safe_sub_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            return 0
        };
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

