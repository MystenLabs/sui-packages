module 0x7d8b582fa0c12a9921654c31341885f6dad35d6b37fc206b6591219ebb60e903::vesting {
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

