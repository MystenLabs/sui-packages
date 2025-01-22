module 0xd683b30a655b25c49184002a4668e0f603e862598e9d57ae2ffbfdc8507155df::math {
    public fun check_compare_mul_u64(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        (arg0 as u128) * (arg1 as u128) >= (arg2 as u128) * (arg3 as u128)
    }

    public fun check_div_ceil_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / arg1;
        if (arg0 - v0 * arg1 > 0) {
            v0 + 1
        } else {
            v0
        }
    }

    public fun check_mul_div_ceil_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
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

    public fun check_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        check_u128_to_u64_overflow(v0);
        (v0 as u64)
    }

    public fun check_mul_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        check_u128_to_u64_overflow(v0);
        (v0 as u64)
    }

    public fun check_u128_to_u64_overflow(arg0: u128) {
        assert!(arg0 <= 18446744073709551615, 1);
    }

    public fun div_ceil(arg0: u64, arg1: u64) : u64 {
        check_mul_div_ceil_u64(arg0, 1000000000, arg1)
    }

    public fun div_floor(arg0: u64, arg1: u64) : u64 {
        check_mul_div_u64(arg0, 1000000000, arg1)
    }

    public fun eq_one(arg0: u64) : bool {
        arg0 == 1000000000
    }

    fun get_square_root(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1::u128::sqrt((arg2 as u128) * (arg2 as u128) + 4 * ((1000000000 - arg0) as u128) * (arg0 as u128) * (arg1 as u128) / (1000000000 as u128) * (arg1 as u128) / (1000000000 as u128));
        check_u128_to_u64_overflow(v0);
        (v0 as u64)
    }

    public fun gt_one(arg0: u64) : bool {
        arg0 > 1000000000
    }

    public fun gte_one(arg0: u64) : bool {
        arg0 >= 1000000000
    }

    public fun lt_one(arg0: u64) : bool {
        arg0 < 1000000000
    }

    public fun lte_one(arg0: u64) : bool {
        arg0 <= 1000000000
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        check_mul_div_u64(arg0, arg1, 1000000000)
    }

    public fun mul_ceil(arg0: u64, arg1: u64) : u64 {
        check_mul_div_ceil_u64(arg0, arg1, 1000000000)
    }

    public fun one() : u64 {
        1000000000
    }

    // decompiled from Move bytecode v6
}

