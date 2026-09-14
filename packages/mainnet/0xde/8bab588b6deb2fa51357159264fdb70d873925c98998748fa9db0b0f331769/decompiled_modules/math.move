module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math {
    public fun align_tick_bits(arg0: u32, arg1: u32) : u32 {
        assert!(arg1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        let v0 = arg0 >> 31 == 1;
        let v1 = if (v0) {
            (arg0 ^ 4294967295) + 1
        } else {
            arg0
        };
        if (v0) {
            (v1 / arg1 * arg1 ^ 4294967295) + 1
        } else {
            v1 / arg1 * arg1
        }
    }

    public fun floor_tick_bits(arg0: u32, arg1: u32) : u32 {
        assert!(arg1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        if (!(arg0 >> 31 == 1)) {
            arg0 / arg1 * arg1
        } else {
            let v1 = (arg0 ^ 4294967295) + 1;
            let v2 = v1 % arg1;
            let v3 = if (v2 == 0) {
                v1
            } else {
                v1 + arg1 - v2
            };
            (v3 ^ 4294967295) + 1
        }
    }

    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_in());
        assert!(arg1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        assert!(arg2 > arg0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::insufficient_liquidity());
        let v0 = (arg0 as u128);
        let v1 = (arg2 as u128) - v0;
        assert!(v1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        let v2 = ((arg1 as u128) * v0 + v1 - 1) / v1;
        assert!(v2 <= 18446744073709551615, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        (v2 as u64)
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_in());
        assert!(arg1 > 0 && arg2 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        let v0 = (arg0 as u128);
        let v1 = v0 * (arg2 as u128) / ((arg1 as u128) + v0);
        assert!(v1 <= 18446744073709551615, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        (v1 as u64)
    }

    public fun i32_from_bits(arg0: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0)
    }

    public fun min_sqrt_price_x64() : u128 {
        4295048016
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        (v0 as u64)
    }

    public fun q64() : u128 {
        (18446744073709551616 as u128)
    }

    public fun sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        let v0 = sqrt_u256(((arg1 as u256) << 128) / (arg0 as u256));
        assert!(v0 <= 340282366920938463463374607431768211455, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        (v0 as u128)
    }

    fun sqrt_price_x64_at_negative_abs(arg0: u32) : u128 {
        let v0 = if (arg0 & 1 != 0) {
            18445821805675392311
        } else {
            18446744073709551616
        };
        let v1 = v0;
        if (arg0 & 2 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v0, 18444899583751176498, 64);
        };
        if (arg0 & 4 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 18443055278223354162, 64);
        };
        if (arg0 & 8 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 18439367220385604838, 64);
        };
        if (arg0 & 16 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 18431993317065449817, 64);
        };
        if (arg0 & 32 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 18417254355718160513, 64);
        };
        if (arg0 & 64 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 18387811781193591352, 64);
        };
        if (arg0 & 128 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 18329067761203520168, 64);
        };
        if (arg0 & 256 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 18212142134806087854, 64);
        };
        if (arg0 & 512 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 17980523815641551639, 64);
        };
        if (arg0 & 1024 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 17526086738831147013, 64);
        };
        if (arg0 & 2048 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 16651378430235024244, 64);
        };
        if (arg0 & 4096 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 15030750278693429944, 64);
        };
        if (arg0 & 8192 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 12247334978882834399, 64);
        };
        if (arg0 & 16384 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 8131365268884726200, 64);
        };
        if (arg0 & 32768 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 3584323654723342297, 64);
        };
        if (arg0 & 65536 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 696457651847595233, 64);
        };
        if (arg0 & 131072 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 26294789957452057, 64);
        };
        if (arg0 & 262144 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 37481735321082, 64);
        };
        v1
    }

    fun sqrt_price_x64_at_positive_abs(arg0: u32) : u128 {
        let v0 = if (arg0 & 1 != 0) {
            79232123823359799118286999567
        } else {
            79228162514264337593543950336
        };
        let v1 = v0;
        if (arg0 & 2 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v0, 79236085330515764027303304731, 96);
        };
        if (arg0 & 4 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 79244008939048815603706035061, 96);
        };
        if (arg0 & 8 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 79259858533276714757314932305, 96);
        };
        if (arg0 & 16 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 79291567232598584799939703904, 96);
        };
        if (arg0 & 32 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 79355022692464371645785046466, 96);
        };
        if (arg0 & 64 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 79482085999252804386437311141, 96);
        };
        if (arg0 & 128 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 79736823300114093921829183326, 96);
        };
        if (arg0 & 256 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 80248749790819932309965073892, 96);
        };
        if (arg0 & 512 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 81282483887344747381513967011, 96);
        };
        if (arg0 & 1024 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 83390072131320151908154831281, 96);
        };
        if (arg0 & 2048 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 87770609709833776024991924138, 96);
        };
        if (arg0 & 4096 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 97234110755111693312479820773, 96);
        };
        if (arg0 & 8192 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 119332217159966728226237229890, 96);
        };
        if (arg0 & 16384 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 179736315981702064433883588727, 96);
        };
        if (arg0 & 32768 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 407748233172238350107850275304, 96);
        };
        if (arg0 & 65536 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 2098478828474011932436660412517, 96);
        };
        if (arg0 & 131072 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 55581415166113811149459800483533, 96);
        };
        if (arg0 & 262144 != 0) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_shr(v1, 38992368544603139932233054999993551, 96);
        };
        v1 >> 32
    }

    public fun sqrt_price_x64_at_tick_bits(arg0: u32) : u128 {
        let v0 = arg0 >> 31 == 1;
        let v1 = if (v0) {
            (arg0 ^ 4294967295) + 1
        } else {
            arg0
        };
        assert!(v1 <= 443636, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        if (v0) {
            sqrt_price_x64_at_negative_abs(v1)
        } else {
            sqrt_price_x64_at_positive_abs(v1)
        }
    }

    public fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 == 0 || arg0 == 1) {
            return arg0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun tick_bits_at_sqrt_price_x64(arg0: u128) : u32 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(443636);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(443636);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1);
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1)) {
            let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::wrapping_add(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::shr(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::wrapping_add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::wrapping_sub(v1, v0), v2), 1));
            if (sqrt_price_x64_at_tick_bits(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3)) <= arg0) {
                v0 = v3;
                continue
            };
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::wrapping_sub(v3, v2);
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0)
    }

    // decompiled from Move bytecode v7
}

