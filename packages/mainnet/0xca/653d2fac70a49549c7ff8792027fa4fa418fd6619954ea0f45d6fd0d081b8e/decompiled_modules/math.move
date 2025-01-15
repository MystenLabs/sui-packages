module 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math {
    public fun calculate_dynamic_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg1 <= arg2) {
            arg4
        } else {
            arg3 - multiply_and_divide(arg3 - arg4, (arg2 as u128), (arg1 as u128))
        };
        multiply_and_divide(arg0, (v0 as u128), 1000000000000000000)
    }

    public fun exchange_rate_one_to_one() : u128 {
        1000000000000000000
    }

    public fun multiply_and_divide(arg0: u64, arg1: u128, arg2: u128) : u64 {
        (((arg0 as u128) * arg1 / arg2) as u64)
    }

    public fun normalize_decimals(arg0: u64, arg1: u8, arg2: u8) : u64 {
        if (arg1 == arg2) {
            arg0
        } else if (arg1 < arg2) {
            arg0 * 0x1::u64::pow(10, arg2 - arg1)
        } else {
            assert!(arg1 > arg2, 9223372492121505796);
            let v1 = arg1 - arg2;
            assert!(arg0 >= 0x1::u64::pow(10, v1), 9223372474941505538);
            arg0 / 0x1::u64::pow(10, v1)
        }
    }

    public fun one_hundred_percent_base_18() : u128 {
        1000000000000000000
    }

    // decompiled from Move bytecode v6
}

