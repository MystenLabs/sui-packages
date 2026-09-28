module 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::math {
    public fun diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun div_up_u128(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 != 0, 0);
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0);
        to_u64((arg0 as u128) * (arg1 as u128) / (arg2 as u128))
    }

    public fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0);
        to_u64(div_up_u128((arg0 as u128) * (arg1 as u128), (arg2 as u128)))
    }

    public fun to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 1);
        (arg0 as u64)
    }

    // decompiled from Move bytecode v7
}

