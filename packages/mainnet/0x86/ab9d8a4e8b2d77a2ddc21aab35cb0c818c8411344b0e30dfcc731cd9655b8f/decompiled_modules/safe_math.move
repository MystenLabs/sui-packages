module 0x86ab9d8a4e8b2d77a2ddc21aab35cb0c818c8411344b0e30dfcc731cd9655b8f::safe_math {
    public fun check_u128_to_u64_overflow(arg0: u128) {
        assert!(arg0 <= 18446744073709551615, 1);
    }

    public fun get_one() : u64 {
        1000000000
    }

    public fun get_one_decimals() : u8 {
        9
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        safe_mul_div_u64(arg0, arg1, 1000000000)
    }

    public fun safe_mul_div_ceil_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = v0 / (arg2 as u128);
        let v2 = if (v0 - v1 * (arg2 as u128) > 0) {
            v1 + 1
        } else {
            v1
        };
        check_u128_to_u64_overflow(v2);
        (v2 as u64)
    }

    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        check_u128_to_u64_overflow(v0);
        (v0 as u64)
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        check_u128_to_u64_overflow(v0);
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

