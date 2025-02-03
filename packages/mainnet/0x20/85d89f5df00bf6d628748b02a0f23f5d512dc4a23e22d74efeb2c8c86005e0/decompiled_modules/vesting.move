module 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::vesting {
    public fun linear_vested_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        linear_vesting_schedule(arg0, arg1, arg2 + arg3, arg4)
    }

    fun linear_vesting_schedule(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 < arg0) {
            return 0
        };
        if (arg3 > arg0 + arg1) {
            return arg2
        };
        arg2 * (arg3 - arg0) / arg1
    }

    // decompiled from Move bytecode v6
}

