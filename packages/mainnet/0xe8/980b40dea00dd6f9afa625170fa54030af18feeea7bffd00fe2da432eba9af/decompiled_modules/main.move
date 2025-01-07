module 0xe8980b40dea00dd6f9afa625170fa54030af18feeea7bffd00fe2da432eba9af::main {
    public fun calc_input_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u8, arg5: u64, arg6: u64) : u64 {
        assert!(arg2 > 0, 0);
        assert!(arg1 > arg2, 0);
        assert!(arg5 < arg6, 0);
        let (v0, v1) = if (arg3 >= arg4) {
            (arg0 * 0x2::math::pow(10, arg3 - arg4), arg2)
        } else {
            (arg0, arg2 * 0x2::math::pow(10, arg4 - arg3))
        };
        if (arg3 >= arg4) {
            ((((v0 as u128) * (v1 as u128) * (arg6 as u128) / ((arg1 - arg2) as u128) * (arg5 as u128)) as u64) + 1) / 0x2::math::pow(10, arg3 - arg4)
        } else {
            ((((v0 as u128) * (v1 as u128) * (arg6 as u128) / ((arg1 - arg2) as u128) * (arg5 as u128)) as u64) + 1) * 0x2::math::pow(10, arg4 - arg3)
        }
    }

    // decompiled from Move bytecode v6
}

