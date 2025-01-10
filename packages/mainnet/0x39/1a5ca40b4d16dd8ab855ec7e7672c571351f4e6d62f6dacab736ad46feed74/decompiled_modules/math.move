module 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::math {
    public fun exchange_rate_one_to_one() : u128 {
        1000000000000000000
    }

    public fun multiply_and_divide(arg0: u128, arg1: u128, arg2: u128) : u64 {
        ((arg0 * arg1 / arg2) as u64)
    }

    public fun multiply_by_exchange_rate(arg0: u64, arg1: u64) : u64 {
        multiply_and_divide((arg0 as u128), (arg1 as u128), 1000000000000000000)
    }

    public fun normalize_decimals(arg0: u64, arg1: u8, arg2: u8) : u64 {
        if (arg1 == arg2) {
            arg0
        } else if (arg1 < arg2) {
            arg0 * 0x1::u64::pow(10, arg2 - arg1)
        } else {
            assert!(arg1 > arg2, 9223372307437912068);
            let v1 = arg1 - arg2;
            assert!(arg0 >= 0x1::u64::pow(10, v1), 9223372290257911810);
            arg0 / 0x1::u64::pow(10, v1)
        }
    }

    // decompiled from Move bytecode v6
}

