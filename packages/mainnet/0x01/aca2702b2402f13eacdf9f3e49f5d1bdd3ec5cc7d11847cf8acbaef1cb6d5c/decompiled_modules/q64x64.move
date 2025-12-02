module 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::q64x64 {
    public fun add(arg0: u128, arg1: u128) : u128 {
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0, 403);
        v0
    }

    public fun div(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 > 0, 402);
        mul_div_round_down_u128(arg0, 18446744073709551616, arg1)
    }

    fun get_integer(arg0: u128) : u64 {
        ((arg0 >> 64) as u64)
    }

    public fun liquidity(arg0: u64, arg1: u64, arg2: u128) : u128 {
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::u256_to_u128(((arg0 as u256) * (arg2 as u256) >> 64) + (arg1 as u256))
    }

    public fun log2(arg0: u128) : u128 {
        if (arg0 == 1) {
            return (64 << 64 ^ 340282366920938463463374607431768211455) + 1
        };
        if (arg0 == 0) {
            abort 400
        };
        let v0 = arg0 >> 1;
        let v1 = v0;
        let v2 = if (v0 >= 9223372036854775808) {
            1
        } else {
            v1 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::div_u128(85070591730234615865843651857942052864, v0);
            340282366920938463463374607431768211455
        };
        let v3 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::bit_math::most_significant_bit(v1 >> 63);
        let v4 = (v3 as u128) << 63;
        let v5 = v1 >> v3;
        let v6 = v5;
        if (v5 != 9223372036854775808) {
            let v7 = 1 << 63 - 1;
            while (v7 > 0) {
                v6 = v6 * v6 >> 63;
                if (v6 >= 1 << 63 + 1) {
                    v4 = v4 + v7;
                    v6 = v6 >> 1;
                };
                v7 = v7 >> 1;
            };
        };
        if (v2 == 1) {
            v4 << 1
        } else {
            340282366920938463463374607431768211455 - (v4 << 1) + 1
        }
    }

    public fun max_input_for_exact_output(arg0: u64, arg1: u128, arg2: bool) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg2) {
            shift_div_round_up(arg0, scale_offset(), arg1)
        } else {
            mul_shift_round_up(arg0, arg1, scale_offset())
        }
    }

    public fun mul(arg0: u128, arg1: u128) : u128 {
        mul_div_round_down_u128(arg0, arg1, 18446744073709551616)
    }

    public fun mul_div_round_down_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
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
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::u256_to_u128((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
    }

    public fun mul_div_round_up_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 402);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::u256_to_u128(((arg0 as u256) * (arg1 as u256) - 1) / (arg2 as u256) + 1)
    }

    public fun mul_shift_round_down(arg0: u64, arg1: u128, arg2: u8) : u64 {
        assert!(arg2 <= 64, 403);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::u256_to_u64((arg0 as u256) * (arg1 as u256) / (1 << arg2))
    }

    public fun mul_shift_round_up(arg0: u64, arg1: u128, arg2: u8) : u64 {
        assert!(arg2 <= 64, 403);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::u256_to_u64(((arg0 as u256) * (arg1 as u256) - 1) / (1 << arg2) + 1)
    }

    public fun pow(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 18446744073709551616
        };
        if (arg0 == 0) {
            return 0
        };
        if (arg0 == 18446744073709551616) {
            return 18446744073709551616
        };
        let v0 = arg1 > 170141183460469231731687303715884105727;
        let v1 = if (v0) {
            340282366920938463463374607431768211455 - arg1 + 1
        } else {
            arg1
        };
        assert!(v1 < 1048576, 401);
        if (arg0 > 18446744073709551616 && v1 > 64) {
            if (get_integer(arg0) >= 2) {
                assert!(v1 <= 64, 403);
            };
        };
        let v2 = if (v1 > 1000) {
            pow_iterative(arg0, v1, 18446744073709551616)
        } else {
            pow_recursive(arg0, v1, 18446744073709551616)
        };
        assert!(v2 > 0, 401);
        if (v0) {
            mul_div_round_down_u128(18446744073709551616, 18446744073709551616, v2)
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
        let v0 = arg2;
        let v1 = arg1;
        while (v1 > 0) {
            if (v1 & 1 == 1) {
                v0 = mul_div_round_down_u128(v0, arg0, arg2);
            };
            v1 = v1 >> 1;
            if (v1 > 0) {
                arg0 = mul_div_round_down_u128(arg0, arg0, arg2);
            };
        };
        v0
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
            pow_recursive(mul_div_round_down_u128(arg0, arg0, arg2), arg1 >> 1, arg2)
        } else {
            mul_div_round_down_u128(arg0, pow_recursive(arg0, arg1 - 1, arg2), arg2)
        }
    }

    public fun scale() : u128 {
        18446744073709551616
    }

    public fun scale_offset() : u8 {
        64
    }

    public fun shift_div_round_down(arg0: u64, arg1: u8, arg2: u128) : u64 {
        assert!(arg2 > 0, 402);
        assert!(arg1 <= 64, 403);
        if (arg0 == 0) {
            return 0
        };
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::u128_to_u64(((arg0 as u128) << arg1) / arg2)
    }

    public fun shift_div_round_up(arg0: u64, arg1: u8, arg2: u128) : u64 {
        assert!(arg2 > 0, 402);
        assert!(arg1 <= 64, 403);
        if (arg0 == 0) {
            return 0
        };
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::u128_to_u64((((arg0 as u128) << arg1) - 1) / arg2 + 1)
    }

    fun shl(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return arg0
        };
        if (arg1 >= 128) {
            abort 406
        };
        let v0 = arg0;
        let v1 = arg1;
        if (arg1 >= 64) {
            if (arg0 == 0) {
                return 0
            };
            if (arg0 > 340282366920938463463374607431768211455 / 18446744073709551616) {
                abort 405
            };
            v0 = arg0 * 18446744073709551616;
            v1 = arg1 - 64;
        };
        if (v1 >= 32) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 4294967296) {
                abort 405
            };
            v0 = v0 * 4294967296;
            v1 = v1 - 32;
        };
        if (v1 >= 16) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 65536) {
                abort 405
            };
            v0 = v0 * 65536;
            v1 = v1 - 16;
        };
        if (v1 >= 8) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 256) {
                abort 405
            };
            v0 = v0 * 256;
            v1 = v1 - 8;
        };
        if (v1 >= 4) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 16) {
                abort 405
            };
            v0 = v0 * 16;
            v1 = v1 - 4;
        };
        if (v1 >= 2) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 4) {
                abort 405
            };
            v0 = v0 * 4;
            v1 = v1 - 2;
        };
        if (v1 >= 1) {
            if (v0 == 0) {
                return 0
            };
            if (v0 > 340282366920938463463374607431768211455 / 2) {
                abort 405
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
            abort 406
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

    public fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = shl(1, shr((0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::bit_math::most_significant_bit(arg0) as u128), 1));
        let v1 = shr(add(v0, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::div_u128(arg0, v0)), 1);
        let v2 = shr(add(v1, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::div_u128(arg0, v1)), 1);
        let v3 = shr(add(v2, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::div_u128(arg0, v2)), 1);
        let v4 = shr(add(v3, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::div_u128(arg0, v3)), 1);
        let v5 = shr(add(v4, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::div_u128(arg0, v4)), 1);
        let v6 = shr(add(v5, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::div_u128(arg0, v5)), 1);
        let v7 = shr(add(v6, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::div_u128(arg0, v6)), 1);
        let v8 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::div_u128(arg0, v7);
        if (v7 < v8) {
            v7
        } else {
            v8
        }
    }

    public fun sub(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 >= arg1, 403);
        arg0 - arg1
    }

    public fun swap_amount_out(arg0: u64, arg1: u128, arg2: bool) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg2) {
            y_from_x_price(arg0, arg1)
        } else {
            x_from_y_price(arg0, arg1)
        }
    }

    fun x_from_y_price(arg0: u64, arg1: u128) : u64 {
        shift_div_round_down(arg0, 64, arg1)
    }

    fun y_from_x_price(arg0: u64, arg1: u128) : u64 {
        mul_shift_round_down(arg0, arg1, 64)
    }

    // decompiled from Move bytecode v6
}

