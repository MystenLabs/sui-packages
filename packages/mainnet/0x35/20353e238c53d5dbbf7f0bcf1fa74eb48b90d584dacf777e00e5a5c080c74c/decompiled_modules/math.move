module 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::math {
    public fun full_mul(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((full_mul(arg0, arg1) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

