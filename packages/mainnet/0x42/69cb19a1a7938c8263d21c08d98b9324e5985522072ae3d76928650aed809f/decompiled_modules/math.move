module 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math {
    public fun diff_abs(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun diff_percent(arg0: u64, arg1: u64) : u64 {
        div(diff_abs(arg0, arg1), arg0)
    }

    public fun div(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 3001);
        safely_cast_to_u64((arg0 as u128) * (1000000000 as u128) / (arg1 as u128))
    }

    public fun div_ceil(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 3001);
        safely_cast_to_u64(((arg0 as u128) * (1000000000 as u128) + (arg1 as u128) - 1) / (arg1 as u128))
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        safely_cast_to_u64((arg0 as u128) * (arg1 as u128) / (1000000000 as u128))
    }

    public fun percent_change_from(arg0: u64, arg1: u64) : u64 {
        div(diff_abs(arg0, arg1), arg0)
    }

    public fun safe_cast_to_u64(arg0: u128) : u64 {
        safely_cast_to_u64(arg0)
    }

    fun safely_cast_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 3000);
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

