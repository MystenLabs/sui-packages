module 0xcf1fc98b09bc29b7747412ca3bbf36e63f0f213a485db7fe19c8500d4b3d9bab::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

