module 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::safe_math {
    public fun check_u128_to_u64_overflow(arg0: u128) {
        assert!(arg0 <= 18446744073709551615, 1);
    }

    public fun div_ceil(arg0: u64, arg1: u64) : u64 {
        safe_mul_div_ceil_u64(arg0, 1000000000, arg1)
    }

    public fun div_floor(arg0: u64, arg1: u64) : u64 {
        safe_mul_div_u64(arg0, 1000000000, arg1)
    }

    public fun eq_one(arg0: u64) : bool {
        arg0 == 1000000000
    }

    public fun general_integrate(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg0 > 0, 2);
        mul(arg3, 1000000000 - arg4 + mul(arg4, div_ceil(safe_mul_div_u64(arg0, arg0, arg1), arg2)))
    }

    public fun get_one() : u64 {
        1000000000
    }

    public fun get_one_decimals() : u8 {
        9
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
        safe_mul_div_u64(arg0, arg1, 1000000000)
    }

    public fun mul_ceil(arg0: u64, arg1: u64) : u64 {
        safe_mul_div_ceil_u64(arg0, arg1, 1000000000)
    }

    public fun safe_compare_mul_u64(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        (arg0 as u128) * (arg1 as u128) >= (arg2 as u128) * (arg3 as u128)
    }

    public fun safe_div_ceil_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / arg1;
        if (arg0 - v0 * arg1 > 0) {
            v0 + 1
        } else {
            v0
        }
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

    public fun solve_quadratic_function_for_target(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        mul(arg0, 1000000000 + div_ceil((0x1::u128::sqrt(((div_ceil(mul(arg1, arg2) * 4, arg0) as u128) + (1000000000 as u128)) * (1000000000 as u128)) as u64) - 1000000000, safe_mul_u64(arg1, 2)))
    }

    public fun solve_quadratic_function_for_trade(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u64) : u64 {
        assert!(arg0 > 0, 2);
        let v0 = safe_mul_div_u64(mul(arg4, arg0), arg0, arg1);
        let v1 = v0;
        let v2 = mul(1000000000 - arg4, arg1);
        let v3 = v2;
        if (arg3) {
            v3 = v2 + arg2;
        } else {
            v1 = v0 + arg2;
        };
        let v4 = if (v3 >= v1) {
            v3 = v3 - v1;
            true
        } else {
            v3 = v1 - v3;
            false
        };
        let v5 = if (v4) {
            v3 + get_square_root(arg4, arg0, v3)
        } else {
            get_square_root(arg4, arg0, v3) - v3
        };
        if (arg3) {
            div_floor(v5, safe_mul_u64(1000000000 - arg4, 2))
        } else {
            div_ceil(v5, safe_mul_u64(1000000000 - arg4, 2))
        }
    }

    // decompiled from Move bytecode v6
}

