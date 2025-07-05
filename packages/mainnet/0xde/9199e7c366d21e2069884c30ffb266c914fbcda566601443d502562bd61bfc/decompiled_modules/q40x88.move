module 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::q40x88 {
    public fun add(arg0: u128, arg1: u128) : u128 {
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0, 403);
        v0
    }

    public fun div(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 > 0, 402);
        mul_div(arg0, 309485009821345068724781056, arg1)
    }

    public fun from_integer(arg0: u64) : u128 {
        assert!(arg0 <= (1099511627775 as u64), 404);
        (arg0 as u128) << 88
    }

    public fun from_parts(arg0: u64, arg1: u128) : u128 {
        assert!(arg0 <= (1099511627775 as u64), 404);
        assert!(arg1 < 1 << 88, 403);
        (arg0 as u128) << 88 | arg1
    }

    public fun get_fraction(arg0: u128) : u128 {
        arg0 & (1 << 88) - 1
    }

    public fun get_integer(arg0: u128) : u64 {
        ((arg0 >> 88) as u64)
    }

    public fun log2(arg0: u128) : u128 {
        assert!(arg0 > 0, 400);
        if (arg0 == 309485009821345068724781056) {
            return 0
        };
        let v0 = 309485009821345068724781056;
        let (v1, v2) = if (arg0 >= v0) {
            (arg0, 1)
        } else {
            (mul_div(v0, v0, arg0), 0)
        };
        let v3 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::most_significant_bit_u128(v1);
        let v4 = 0xde9199e7c366d21e2069884c30ffb266c914fbcda566601443d502562bd61bfc::bit_math::most_significant_bit_u128(v0);
        let v5 = if (v3 >= v4) {
            let v6 = ((v3 - v4) as u128);
            v1 = shr(v1, (v6 as u128));
            v6 * v0
        } else {
            let v7 = ((v4 - v3) as u128);
            let v5 = v7 * v0;
            v1 = shl(v1, (v7 as u128));
            if (v2 == 1) {
                v5 = 0;
            };
            v5
        };
        if (v1 > v0 && v1 < 2 * v0) {
            let v8 = v1 - v0;
            v5 = v5 + v8 + shr(v8 * 7, 4) + shr(v8, 7);
        };
        if (v2 == 0) {
            if (v5 > 340282366920938463463374607431768211455 - 1) {
                return 1
            };
            340282366920938463463374607431768211455 - v5 + 1
        } else {
            v5
        }
    }

    public fun max_integer_40() : u64 {
        (1099511627775 as u64)
    }

    public fun mul(arg0: u128, arg1: u128) : u128 {
        mul_div(arg0, arg1, 309485009821345068724781056)
    }

    fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 402);
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
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= (340282366920938463463374607431768211455 as u256), 403);
        (v0 as u128)
    }

    public fun pow(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 309485009821345068724781056
        };
        if (arg0 == 0) {
            return 0
        };
        let v0 = arg1 > 170141183460469231731687303715884105727;
        let v1 = if (v0) {
            340282366920938463463374607431768211455 - arg1 + 1
        } else {
            arg1
        };
        assert!(v1 < 1048576, 401);
        let v2 = pow_recursive(arg0, v1, 309485009821345068724781056);
        assert!(v2 > 0, 401);
        if (v0) {
            mul_div(309485009821345068724781056, 309485009821345068724781056, v2)
        } else {
            v2
        }
    }

    fun pow_iterative(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg1 == 0) {
            return arg2
        };
        if (arg1 == 1) {
            return arg0
        };
        pow_iterative_loop(arg0, arg1, arg2, arg2)
    }

    fun pow_iterative_loop(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        if (arg1 == 0) {
            arg3
        } else if (arg1 & 1 == 1) {
            pow_iterative_loop(mul_div(arg0, arg0, arg2), arg1 >> 1, arg2, mul_div(arg3, arg0, arg2))
        } else {
            pow_iterative_loop(mul_div(arg0, arg0, arg2), arg1 >> 1, arg2, arg3)
        }
    }

    fun pow_recursive(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg1 > 1000) {
            return pow_iterative(arg0, arg1, arg2)
        };
        if (arg1 == 0) {
            arg2
        } else if (arg1 == 1) {
            arg0
        } else if (arg1 & 1 == 0) {
            pow_recursive(mul_div(arg0, arg0, arg2), arg1 >> 1, arg2)
        } else {
            mul_div(arg0, pow_recursive(arg0, arg1 - 1, arg2), arg2)
        }
    }

    public fun scale_40x88() : u128 {
        309485009821345068724781056
    }

    public fun scale_offset_40x88() : u8 {
        88
    }

    fun shl(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return arg0
        };
        if (arg1 >= 128) {
            return 0
        };
        let v0 = arg0;
        let v1 = arg1;
        if (arg1 >= 64) {
            if (arg0 == 0) {
                return 0
            };
            if (arg0 > 340282366920938463463374607431768211455 / 18446744073709551616) {
                return 0
            };
            v0 = arg0 * 18446744073709551616;
            v1 = arg1 - 64;
        };
        if (v1 >= 32) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 4294967296) {
                return 0
            };
            v0 = v0 * 4294967296;
            v1 = v1 - 32;
        };
        if (v1 >= 16) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 65536) {
                return 0
            };
            v0 = v0 * 65536;
            v1 = v1 - 16;
        };
        if (v1 >= 8) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 256) {
                return 0
            };
            v0 = v0 * 256;
            v1 = v1 - 8;
        };
        if (v1 >= 4) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 16) {
                return 0
            };
            v0 = v0 * 16;
            v1 = v1 - 4;
        };
        if (v1 >= 2) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 4) {
                return 0
            };
            v0 = v0 * 4;
            v1 = v1 - 2;
        };
        if (v1 >= 1) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 2) {
                return 0
            };
            v0 = v0 * 2;
        };
        v0
    }

    fun shr(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return arg0
        };
        if (arg1 >= 128) {
            return 0
        };
        let v0 = arg0;
        let v1 = arg1;
        if (arg1 >= 64) {
            v0 = arg0 / 18446744073709551616;
            v1 = arg1 - 64;
        };
        if (v1 >= 32) {
            v0 = v0 / 4294967296;
            v1 = v1 - 32;
        };
        if (v1 >= 16) {
            v0 = v0 / 65536;
            v1 = v1 - 16;
        };
        if (v1 >= 8) {
            v0 = v0 / 256;
            v1 = v1 - 8;
        };
        if (v1 >= 4) {
            v0 = v0 / 16;
            v1 = v1 - 4;
        };
        if (v1 >= 2) {
            v0 = v0 / 4;
            v1 = v1 - 2;
        };
        if (v1 >= 1) {
            v0 = v0 / 2;
        };
        v0
    }

    public fun sub(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 >= arg1, 403);
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

