module 0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::safe_math {
    public fun add_u128(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455 - arg1, 101);
        arg0 + arg1
    }

    public fun add_u32(arg0: u32, arg1: u32) : u32 {
        assert!(arg0 <= 4294967295 - arg1, 101);
        arg0 + arg1
    }

    public fun add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 101);
        arg0 + arg1
    }

    public fun add_u64_3(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 101);
        let v0 = arg0 + arg1;
        assert!(v0 <= 18446744073709551615 - arg2, 101);
        v0 + arg2
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

    public fun mul_add_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 101);
        let v0 = arg0 * arg1;
        assert!(v0 <= 18446744073709551615 - arg2, 101);
        v0 + arg2
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 100);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        u256_to_u128((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
    }

    public fun mul_div_u128_to_u64(arg0: u128, arg1: u128, arg2: u128) : u64 {
        assert!(arg2 > 0, 100);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        u256_to_u64((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
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
        let v0 = 1 << (0xd1d19c1462e98712b0e8a8befba4e561d6ce430e8f7e1240d0526032a7c82d88::bit_math::most_significant_bit(arg0) + 1) / 2;
        let v1 = (arg0 / v0 + v0) / 2;
        while (v1 < v0) {
            let v2 = arg0 / v1 + v1;
            v1 = v2 / 2;
        };
        v0
    }

    public fun sub_mul_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg0 >= arg1, 101);
        mul_u128(arg0 - arg1, arg2)
    }

    public fun sub_u128(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 >= arg1, 101);
        arg0 - arg1
    }

    public fun sub_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 101);
        arg0 - arg1
    }

    public fun sub_u64_cape_zero(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun u128_to_u32(arg0: u128) : u32 {
        assert!(arg0 <= 4294967295, 101);
        (arg0 as u32)
    }

    public fun u128_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= (18446744073709551615 as u128), 101);
        (arg0 as u64)
    }

    public fun u256_to_u128(arg0: u256) : u128 {
        assert!(arg0 <= (340282366920938463463374607431768211455 as u256), 101);
        (arg0 as u128)
    }

    public fun u256_to_u64(arg0: u256) : u64 {
        assert!(arg0 <= (18446744073709551615 as u256), 101);
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

