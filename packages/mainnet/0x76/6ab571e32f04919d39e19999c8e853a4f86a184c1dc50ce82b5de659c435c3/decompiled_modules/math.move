module 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::math {
    public fun calculate_claimable_amount(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            return 0
        };
        arg0 - arg1
    }

    public fun calculate_unvested_amount(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            return 0
        };
        arg0 - arg1
    }

    public fun calculate_vested_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 < arg1) {
            return 0
        };
        if (arg3 >= arg2) {
            return arg0
        };
        (((arg0 as u128) * ((arg3 - arg1) as u128) / ((arg2 - arg1) as u128)) as u64)
    }

    public fun calculate_vested_amount_with_cliff(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg2 >= arg1, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::emath_invalid_cliff());
        assert!(arg2 <= arg3, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::emath_invalid_cliff());
        if (arg4 < arg2) {
            return 0
        };
        calculate_vested_amount(arg0, arg1, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

