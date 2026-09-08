module 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math {
    public fun div_down(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 1000000000 / (arg1 as u128)) as u64)
    }

    public fun exp(arg0: &0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::I64) : u64 {
        let v0 = 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::magnitude(arg0);
        let v1 = 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::is_negative(arg0);
        if (v0 == 0) {
            return 1000000000
        };
        assert!(v1 || v0 <= 23638153618, 2);
        let v2 = v0 / (693147180 as u64);
        (exp_u128(((v0 - v2 * (693147180 as u64)) as u128), (v2 as u128), v1) as u64)
    }

    fun exp_series_u128(arg0: u128) : u128 {
        let v0 = 1000000000;
        let v1 = 1000000000;
        let v2 = 1;
        while (v2 <= 12) {
            v1 = v1 * arg0 / v2 * 1000000000;
            if (v1 == 0) {
                break
            };
            v0 = v0 + v1;
            v2 = v2 + 1;
        };
        v0
    }

    fun exp_u128(arg0: u128, arg1: u128, arg2: bool) : u128 {
        let v0 = exp_series_u128(arg0);
        if (arg2) {
            let v2 = 1000000000 * 1000000000 / v0;
            let v3 = v2;
            let v4 = arg1;
            if (arg1 >= 32) {
                let v5 = v2 >> 32;
                v3 = v5;
                if (v5 == 0) {
                    return 0
                };
                v4 = arg1 - 32;
            };
            if (v4 >= 16) {
                let v6 = v3 >> 16;
                v3 = v6;
                if (v6 == 0) {
                    return 0
                };
                v4 = v4 - 16;
            };
            if (v4 >= 8) {
                let v7 = v3 >> 8;
                v3 = v7;
                if (v7 == 0) {
                    return 0
                };
                v4 = v4 - 8;
            };
            if (v4 >= 4) {
                let v8 = v3 >> 4;
                v3 = v8;
                if (v8 == 0) {
                    return 0
                };
                v4 = v4 - 4;
            };
            if (v4 >= 2) {
                let v9 = v3 >> 2;
                v3 = v9;
                if (v9 == 0) {
                    return 0
                };
                v4 = v4 - 2;
            };
            if (v4 >= 1) {
                v3 = v3 >> 1;
            };
            v3
        } else {
            let v10 = v0;
            let v11 = arg1;
            if (arg1 >= 32) {
                v10 = v0 << 32;
                v11 = arg1 - 32;
            };
            if (v11 >= 16) {
                v10 = v10 << 16;
                v11 = v11 - 16;
            };
            if (v11 >= 8) {
                v10 = v10 << 8;
                v11 = v11 - 8;
            };
            if (v11 >= 4) {
                v10 = v10 << 4;
                v11 = v11 - 4;
            };
            if (v11 >= 2) {
                v10 = v10 << 2;
                v11 = v11 - 2;
            };
            if (v11 >= 1) {
                v10 = v10 << 1;
            };
            v10
        }
    }

    public fun ln(arg0: u64) : 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::I64 {
        assert!(arg0 > 0, 0);
        if (arg0 == 1000000000) {
            return 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::zero()
        };
        if (arg0 < 1000000000) {
            let v0 = ln(((1000000000 * 1000000000 / (arg0 as u128)) as u64));
            return 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::neg(&v0)
        };
        let (v1, v2) = normalize(arg0);
        0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::from_u64((ln_u128((v1 as u128), (v2 as u128)) as u64))
    }

    fun ln_u128(arg0: u128, arg1: u128) : u128 {
        let v0 = (arg0 - 1000000000) * 1000000000 / (arg0 + 1000000000);
        let v1 = mul_scaled_u128(v0, v0);
        arg1 * 693147180 + mul_scaled_u128(mul_scaled_u128(2 * 1000000000, v0), 1000000000 + mul_scaled_u128(333333333 + mul_scaled_u128(200000000 + mul_scaled_u128(142857143 + mul_scaled_u128(111111111 + mul_scaled_u128(90909091 + mul_scaled_u128(v1, 76923077), v1), v1), v1), v1), v1))
    }

    public fun mul_div_down(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    public fun mul_down(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    fun mul_scaled_u128(arg0: u128, arg1: u128) : u128 {
        arg0 * arg1 / 1000000000
    }

    public fun normal_cdf(arg0: &0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::I64) : u64 {
        let v0 = 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::magnitude(arg0);
        if (v0 > 8000000000) {
            return if (0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::is_negative(arg0)) {
                0
            } else {
                1000000000
            }
        };
        (normal_cdf_u128((v0 as u128), 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::is_negative(arg0)) as u64)
    }

    fun normal_cdf_u128(arg0: u128, arg1: bool) : u128 {
        if (arg0 < 662910000) {
            let v1 = arg0 * arg0 / 1000000000;
            if (arg1) {
                1000000000 / 2 - arg0 * ((((65682338 * v1 / 1000000000 + 2235252035) * v1 / 1000000000 + 161028231069) * v1 / 1000000000 + 1067689485460) * v1 / 1000000000 + 18154981253344) * 1000000000 / ((((v1 + 47202581905) * v1 / 1000000000 + 976098551738) * v1 / 1000000000 + 10260932208619) * v1 / 1000000000 + 45507789335027) / 1000000000
            } else {
                1000000000 / 2 + arg0 * ((((65682338 * v1 / 1000000000 + 2235252035) * v1 / 1000000000 + 161028231069) * v1 / 1000000000 + 1067689485460) * v1 / 1000000000 + 18154981253344) * 1000000000 / ((((v1 + 47202581905) * v1 / 1000000000 + 976098551738) * v1 / 1000000000 + 10260932208619) * v1 / 1000000000 + 45507789335027) / 1000000000
            }
        } else if (arg0 < 5656854249) {
            let v2 = arg0 * arg0 / 1000000000 * 2;
            let v3 = v2 / 693147180;
            if (arg1) {
                exp_u128(v2 - v3 * 693147180, v3, true) * ((((((((11 * arg0 / 1000000000 + 398941512) * arg0 / 1000000000 + 8883149794) * arg0 / 1000000000 + 93506656132) * arg0 / 1000000000 + 597270276395) * arg0 / 1000000000 + 2494537585290) * arg0 / 1000000000 + 6848190450536) * arg0 / 1000000000 + 11602651437647) * arg0 / 1000000000 + 9842714838384) * 1000000000 / ((((((((arg0 + 22266688044) * arg0 / 1000000000 + 235387901782) * arg0 / 1000000000 + 1519377599408) * arg0 / 1000000000 + 6485558298267) * arg0 / 1000000000 + 18615571640885) * arg0 / 1000000000 + 34900952721146) * arg0 / 1000000000 + 38912003286093) * arg0 / 1000000000 + 19685429676860) / 1000000000
            } else {
                1000000000 - exp_u128(v2 - v3 * 693147180, v3, true) * ((((((((11 * arg0 / 1000000000 + 398941512) * arg0 / 1000000000 + 8883149794) * arg0 / 1000000000 + 93506656132) * arg0 / 1000000000 + 597270276395) * arg0 / 1000000000 + 2494537585290) * arg0 / 1000000000 + 6848190450536) * arg0 / 1000000000 + 11602651437647) * arg0 / 1000000000 + 9842714838384) * 1000000000 / ((((((((arg0 + 22266688044) * arg0 / 1000000000 + 235387901782) * arg0 / 1000000000 + 1519377599408) * arg0 / 1000000000 + 6485558298267) * arg0 / 1000000000 + 18615571640885) * arg0 / 1000000000 + 34900952721146) * arg0 / 1000000000 + 38912003286093) * arg0 / 1000000000 + 19685429676860) / 1000000000
            }
        } else if (arg1) {
            0
        } else {
            1000000000
        }
    }

    public fun normal_pdf(arg0: &0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::I64) : u64 {
        let v0 = 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::magnitude(arg0);
        if (v0 > 8000000000) {
            return 0
        };
        let v1 = 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64::from_parts((((v0 as u128) * (v0 as u128) / 2 * 1000000000) as u64), true);
        mul_down(exp(&v1), 398942280)
    }

    fun normalize(arg0: u64) : (u64, u64) {
        let v0 = arg0;
        let v1 = 0;
        let v2 = v1;
        let v3 = 1000000000;
        if (arg0 >> 32 >= v3) {
            v0 = arg0 >> 32;
            v2 = v1 + 32;
        };
        if (v0 >> 16 >= v3) {
            v0 = v0 >> 16;
            v2 = v2 + 16;
        };
        if (v0 >> 8 >= v3) {
            v0 = v0 >> 8;
            v2 = v2 + 8;
        };
        if (v0 >> 4 >= v3) {
            v0 = v0 >> 4;
            v2 = v2 + 4;
        };
        if (v0 >> 2 >= v3) {
            v0 = v0 >> 2;
            v2 = v2 + 2;
        };
        if (v0 >> 1 >= v3) {
            v0 = v0 >> 1;
            v2 = v2 + 1;
        };
        (v0, v2)
    }

    public fun pow10(arg0: u64) : u64 {
        assert!(arg0 <= 18, 1);
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun sqrt_down(arg0: u64) : u64 {
        (sqrt_u128_down((arg0 as u128) * 1000000000) as u64)
    }

    fun sqrt_initial_guess_u128(arg0: u128) : u128 {
        let v0 = 0;
        let v1 = v0;
        let v2 = arg0;
        if (arg0 >= 18446744073709551616) {
            v2 = arg0 >> 64;
            v1 = v0 + 64;
        };
        if (v2 >= 4294967296) {
            v2 = v2 >> 32;
            v1 = v1 + 32;
        };
        if (v2 >= 65536) {
            v2 = v2 >> 16;
            v1 = v1 + 16;
        };
        if (v2 >= 256) {
            v2 = v2 >> 8;
            v1 = v1 + 8;
        };
        if (v2 >= 16) {
            v2 = v2 >> 4;
            v1 = v1 + 4;
        };
        if (v2 >= 4) {
            v2 = v2 >> 2;
            v1 = v1 + 2;
        };
        if (v2 >= 2) {
            v1 = v1 + 1;
        };
        1 << (((v1 + 1) / 2) as u8)
    }

    public fun sqrt_u128_down(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 < 4) {
            return 1
        };
        let v0 = sqrt_initial_guess_u128(arg0);
        let v1 = (v0 + arg0 / v0) / 2;
        let v2 = (v1 + arg0 / v1) / 2;
        let v3 = (v2 + arg0 / v2) / 2;
        let v4 = (v3 + arg0 / v3) / 2;
        let v5 = (v4 + arg0 / v4) / 2;
        let v6 = (v5 + arg0 / v5) / 2;
        let v7 = (v6 + arg0 / v6) / 2;
        let v8 = v7;
        if (v7 > arg0 / v7) {
            v8 = v7 - 1;
        };
        v8
    }

    public fun try_mul_div_down(arg0: u64, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        if (arg2 == 0) {
            return 0x1::option::none<u64>()
        };
        try_u64((arg0 as u128) * (arg1 as u128) / (arg2 as u128))
    }

    public fun try_mul_div_up(arg0: u64, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        if (arg2 == 0) {
            return 0x1::option::none<u64>()
        };
        try_u64(((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128))
    }

    fun try_u64(arg0: u128) : 0x1::option::Option<u64> {
        if (arg0 > 18446744073709551615) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>((arg0 as u64))
        }
    }

    // decompiled from Move bytecode v7
}

