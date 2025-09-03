module 0x4cc1d664120bbfe7d31f56a3b7153a84f6362bf37458f9e92cce7de42e730ba3::q64x64 {
    public fun add(arg0: u128, arg1: u128) : u128 {
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0, 403);
        v0
    }

    public fun div(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 > 0, 402);
        mul_div(arg0, 18446744073709551616, arg1)
    }

    public fun from_integer(arg0: u64) : u128 {
        (arg0 as u128) << 64
    }

    public fun from_parts(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) << 64 | (arg1 as u128)
    }

    public fun get_fraction(arg0: u128) : u128 {
        arg0 & (1 << 64) - 1
    }

    public fun get_integer(arg0: u128) : u64 {
        ((arg0 >> 64) as u64)
    }

    public fun integer_of_div(arg0: u128, arg1: u128) : u64 {
        assert!(arg1 > 0, 402);
        ((mul_div(arg0, 18446744073709551616, arg1) >> 64) as u64)
    }

    public fun integer_of_mul(arg0: u128, arg1: u128) : u64 {
        ((mul_div(arg0, arg1, 18446744073709551616) >> 64) as u64)
    }

    public fun liquidity_components(arg0: u64, arg1: u64, arg2: u128) : (u128, u128) {
        let v0 = if (arg0 > 0 && arg2 > 0) {
            (arg0 as u128) * arg2 >> 64
        } else {
            0
        };
        (v0, v0 + (arg1 as u128))
    }

    public fun liquidity_from_amounts(arg0: u64, arg1: u64, arg2: u128) : u128 {
        0x4cc1d664120bbfe7d31f56a3b7153a84f6362bf37458f9e92cce7de42e730ba3::safe_math::u256_to_u128(((arg0 as u256) * (arg2 as u256) >> 64) + (arg1 as u256))
    }

    public fun log2(arg0: u128) : u128 {
        assert!(arg0 > 0, 400);
        if (arg0 == 18446744073709551616) {
            return 0
        };
        let v0 = 18446744073709551616;
        let (v1, v2) = if (arg0 >= v0) {
            (arg0, 1)
        } else {
            assert!(arg0 >= 2, 407);
            (mul_div(v0, v0, arg0), 0)
        };
        let v3 = 0x4cc1d664120bbfe7d31f56a3b7153a84f6362bf37458f9e92cce7de42e730ba3::bit_math::most_significant_bit(v1);
        let v4 = 64;
        let v5 = if (v3 >= v4) {
            let v6 = ((v3 - v4) as u128);
            v1 = shr(v1, v6);
            v6 * v0
        } else {
            let v7 = ((v4 - v3) as u128);
            let v5 = v7 * v0;
            v1 = shl(v1, v7);
            if (v2 == 1) {
                v5 = 0;
            };
            v5
        };
        if (v1 > v0 && v1 < 2 * v0) {
            let v8 = v1 - v0;
            let v9 = mul_div(v8, v8, v0);
            let v10 = mul_div(v9, v8, v0);
            let v11 = mul_div(v10, v8, v0);
            let v12 = mul_div(v11, v8, v0);
            let v13 = mul_div(v12, v8, v0);
            let v14 = mul_div(v13, v8, v0);
            let v15 = mul_div(v14, v8, v0);
            let v16 = mul_div(v15, v8, v0);
            let v17 = mul_div(v8, 26613026195688644608, v0) + mul_div(v10, 8871008731896215552, v0) + mul_div(v12, 5322605239137728512, v0) + mul_div(v14, 3801860885098378240, v0) + mul_div(v16, 2957002910632071680, v0);
            let v18 = mul_div(v9, 13306513097844322304, v0) + mul_div(v11, 6653256548922161152, v0) + mul_div(v13, 4435504365948107776, v0) + mul_div(v15, 3326628274461080576, v0) + mul_div(mul_div(v16, v8, v0), 2661302619568864256, v0);
            if (v17 > v18) {
                v5 = v5 + v17 - v18;
            } else {
                let v19 = v18 - v17;
                if (v5 > v19) {
                    v5 = v5 - v19;
                } else {
                    v5 = 0;
                };
            };
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

    public fun max_input_for_exact_output(arg0: u64, arg1: u128, arg2: bool) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg2) {
            x_from_y_price(arg0, arg1)
        } else {
            y_from_x_price(arg0, arg1)
        }
    }

    public fun max_integer_64() : u64 {
        18446744073709551615
    }

    public fun mul(arg0: u128, arg1: u128) : u128 {
        mul_div(arg0, arg1, 18446744073709551616)
    }

    public fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
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
            mul_div(18446744073709551616, 18446744073709551616, v2)
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
                v0 = mul_div(v0, arg0, arg2);
            };
            v1 = v1 >> 1;
            if (v1 > 0) {
                arg0 = mul_div(arg0, arg0, arg2);
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
            pow_recursive(mul_div(arg0, arg0, arg2), arg1 >> 1, arg2)
        } else {
            mul_div(arg0, pow_recursive(arg0, arg1 - 1, arg2), arg2)
        }
    }

    public fun scale_64x64() : u128 {
        18446744073709551616
    }

    public fun scale_offset_64x64() : u8 {
        64
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
        if (arg0 == 18446744073709551616) {
            return 18446744073709551616
        };
        let v0 = 0x4cc1d664120bbfe7d31f56a3b7153a84f6362bf37458f9e92cce7de42e730ba3::bit_math::most_significant_bit(arg0);
        let v1 = if (v0 >= 64) {
            1 << (v0 + 64) / 2
        } else {
            1 << (v0 + 64) / 2
        };
        let v2 = v1;
        let v3 = 0;
        while (v3 < 10) {
            let v4 = (v2 + mul_div(arg0, 18446744073709551616, v2)) / 2;
            if (v4 >= v1) {
                if (v4 - v1 <= 1) {
                    break
                };
            } else if (v1 - v4 <= 1) {
                break
            };
            v2 = v4;
            v3 = v3 + 1;
        };
        v2
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

    public fun to_integer(arg0: u128) : u64 {
        get_integer(arg0)
    }

    public fun to_integer_rounded(arg0: u128) : u64 {
        let v0 = get_integer(arg0);
        if (get_fraction(arg0) >= 18446744073709551616 >> 1) {
            assert!(v0 < 18446744073709551615, 404);
            v0 + 1
        } else {
            v0
        }
    }

    public fun x_from_y_price(arg0: u64, arg1: u128) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        ((((arg0 as u128) << 64) / arg1) as u64)
    }

    public fun y_from_x_price(arg0: u64, arg1: u128) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        (((arg0 as u128) * arg1 >> 64) as u64)
    }

    // decompiled from Move bytecode v6
}

