module 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::safe_math {
    public fun add_u128(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455 - arg1, 101);
        arg0 + arg1
    }

    public fun add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 101);
        arg0 + arg1
    }

    public fun div_round_up_u128(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 > 0, 100);
        if (arg0 == 0) {
            return 0
        };
        (arg0 - 1) / arg1 + 1
    }

    public fun div_round_up_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 100);
        if (arg0 == 0) {
            return 0
        };
        (arg0 - 1) / arg1 + 1
    }

    fun gcd(arg0: u128, arg1: u128) : u128 {
        while (arg1 != 0) {
            let v0 = arg1;
            arg1 = arg0 % arg1;
            arg0 = v0;
        };
        arg0
    }

    public fun max_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun max_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 100);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        if (arg0 == arg2) {
            return arg1
        };
        if (arg1 == arg2) {
            return arg0
        };
        if (arg0 <= 340282366920938463463374607431768211455 / arg1) {
            return arg0 * arg1 / arg2
        };
        let v0 = gcd(gcd(arg0, arg2), arg1);
        if (v0 > 1) {
            arg0 = arg0 / v0;
            arg1 = arg1 / v0;
            arg2 = arg2 / v0;
        };
        if (arg0 <= 340282366920938463463374607431768211455 / arg1) {
            return arg0 * arg1 / arg2
        };
        let v1 = arg0 / arg2;
        let v2 = arg0 % arg2;
        if (v1 > 0 && v1 > 340282366920938463463374607431768211455 / arg1) {
            abort 101
        };
        let v3 = v1 * arg1;
        let v4 = v3;
        if (v2 > 0) {
            v4 = add_u128(v3, v2 * arg1 / arg2);
        };
        v4
    }

    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 100);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        u128_to_u64((arg0 as u128) * (arg1 as u128) / (arg2 as u128))
    }

    public fun mul_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 340282366920938463463374607431768211455 / arg1, 101);
        arg0 * arg1
    }

    public fun mul_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 101);
        arg0 * arg1
    }

    public fun sqrt_u128(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 <= 3) {
            return 1
        };
        let v0 = 1 << (0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bit_math::most_significant_bit_u128(arg0) + 1) / 2;
        let v1 = (arg0 / v0 + v0) / 2;
        while (v1 < v0) {
            let v2 = arg0 / v1 + v1;
            v1 = v2 / 2;
        };
        v0
    }

    public fun sub_u128(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 >= arg1, 101);
        arg0 - arg1
    }

    public fun sub_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 101);
        arg0 - arg1
    }

    public fun u128_to_u32(arg0: u128) : u32 {
        assert!(arg0 <= 4294967295, 101);
        (arg0 as u32)
    }

    public fun u128_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= (18446744073709551615 as u128), 101);
        (arg0 as u64)
    }

    public fun u64_to_u16(arg0: u64) : u16 {
        assert!(arg0 <= 65535, 101);
        (arg0 as u16)
    }

    public fun u64_to_u32(arg0: u64) : u32 {
        assert!(arg0 <= 4294967295, 101);
        (arg0 as u32)
    }

    public fun u64_to_u8(arg0: u64) : u8 {
        assert!(arg0 <= 255, 101);
        (arg0 as u8)
    }

    // decompiled from Move bytecode v6
}

