module 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math {
    struct I32 has copy, drop, store {
        bits: u32,
    }

    fun amount0_for_liquidity(arg0: u128, arg1: u256, arg2: u256) : u256 {
        mul_div_u256(mul_div_u256((arg0 as u256), arg2 - arg1, arg2), 79228162514264337593543950336, arg1)
    }

    fun amount1_for_liquidity(arg0: u128, arg1: u256, arg2: u256) : u256 {
        mul_div_u256((arg0 as u256), arg2 - arg1, 79228162514264337593543950336)
    }

    public fun approx_tick_at_sqrt_ratio(arg0: u256) : u32 {
        if (arg0 < 4316055825262872218 || arg0 >= 7922644845311496243882047550464776895664) {
            abort 1
        };
        3319046925
    }

    public fun get_amounts_for_liquidity(arg0: u256, arg1: u256, arg2: u256, arg3: u128) : (u64, u64) {
        let v0 = arg1;
        let v1 = arg2;
        if (arg1 > arg2) {
            v0 = arg2;
            v1 = arg1;
        };
        if (arg0 <= v0) {
            ((amount0_for_liquidity(arg3, v0, v1) as u64), 0)
        } else if (arg0 < v1) {
            ((amount0_for_liquidity(arg3, arg0, v1) as u64), (amount1_for_liquidity(arg3, v0, arg0) as u64))
        } else {
            (0, (amount1_for_liquidity(arg3, v0, v1) as u64))
        }
    }

    public fun get_liquidity_for_amounts(arg0: u256, arg1: u256, arg2: u256, arg3: u64, arg4: u64) : u128 {
        let v0 = arg1;
        let v1 = arg2;
        if (arg1 > arg2) {
            v0 = arg2;
            v1 = arg1;
        };
        if (arg0 <= v0) {
            liquidity_for_amount0(arg3, v0, v1)
        } else if (arg0 < v1) {
            let v3 = liquidity_for_amount0(arg3, arg0, v1);
            let v4 = liquidity_for_amount1(arg4, v0, arg0);
            if (v3 < v4) {
                v3
            } else {
                v4
            }
        } else {
            liquidity_for_amount1(arg4, v0, v1)
        }
    }

    public fun get_sqrt_ratio_at_tick(arg0: u32) : u256 {
        let (v0, v1) = if (arg0 > 2147483647) {
            let v2 = (arg0 ^ 4294967295) + 1;
            let v3 = if (v2 == 0) {
                2147483648
            } else {
                v2
            };
            (v3, true)
        } else {
            (arg0, false)
        };
        if (v0 > 887272) {
            abort 0
        };
        let v4 = if (v0 & 1 != 0) {
            340265354078544963557816517032075149313
        } else {
            340282366920938463463374607431768211456
        };
        let v5 = v4;
        if (v0 & 2 != 0) {
            v5 = v4 * 340248342086729790484326174814286782778 >> 128;
        };
        if (v0 & 4 != 0) {
            let v6 = v5 * 340214320654664324051920982716015181260;
            v5 = v6 >> 128;
        };
        if (v0 & 8 != 0) {
            let v7 = v5 * 340146287995795927057998642642967994049;
            v5 = v7 >> 128;
        };
        if (v0 & 16 != 0) {
            let v8 = v5 * 340010263488231146823593991679159461444;
            v5 = v8 >> 128;
        };
        if (v0 & 32 != 0) {
            let v9 = v5 * 339738377640345403698831111720137521654;
            v5 = v9 >> 128;
        };
        if (v0 & 64 != 0) {
            let v10 = v5 * 339195258003219539373482677213611478476;
            v5 = v10 >> 128;
        };
        if (v0 & 128 != 0) {
            let v11 = v5 * 338111622100601834632666963926359382891;
            v5 = v11 >> 128;
        };
        if (v0 & 256 != 0) {
            let v12 = v5 * 335955098043561705034794361372611817427;
            v5 = v12 >> 128;
        };
        if (v0 & 512 != 0) {
            let v13 = v5 * 20730132571148702945448301786235927030;
            v5 = v13 >> 128;
        };
        if (v0 & 1024 != 0) {
            let v14 = v5 * 20206202292802879497842582678989671175;
            v5 = v14 >> 128;
        };
        if (v0 & 2048 != 0) {
            let v15 = v5 * 307163716377032990231171387755677925553;
            v5 = v15 >> 128;
        };
        if (v0 & 4096 != 0) {
            let v16 = v5 * 277268403626896247668986516045119835416;
            v5 = v16 >> 128;
        };
        if (v0 & 8192 != 0) {
            let v17 = v5 * 225935096042776674494020055212333111827;
            v5 = v17 >> 128;
        };
        if (v0 & 16384 != 0) {
            let v18 = v5 * 149997214084966998907914442109093572063;
            v5 = v18 >> 128;
        };
        if (v0 & 32768 != 0) {
            let v19 = v5 * 66119101098097755308578593895530364162;
            v5 = v19 >> 128;
        };
        if (v0 & 65536 != 0) {
            let v20 = v5 * 12847375598114843236913384864314157147;
            v5 = v20 >> 128;
        };
        if (v0 & 131072 != 0) {
            let v21 = v5 * 44975186959934997841088444569163969055;
            v5 = v21 >> 128;
        };
        if (v0 & 262144 != 0) {
            let v22 = v5 * 64243811104584818497661420215266079;
            v5 = v22 >> 128;
        };
        if (v0 & 524288 != 0) {
            let v23 = v5 * 21936081089770445708603273765316785;
            v5 = v23 >> 128;
        };
        if (v0 & 1048576 != 0) {
            let v24 = v5 * 7368253497661975854452981310789812;
            v5 = v24 >> 128;
        };
        if (v1) {
            v5 = 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v5;
        };
        v5 >> 32
    }

    public fun i32_abs(arg0: &I32) : u32 {
        if (i32_is_negative(arg0)) {
            let v1 = (arg0.bits ^ 4294967295) + 1;
            if (v1 == 0) {
                2147483648
            } else {
                v1
            }
        } else {
            arg0.bits
        }
    }

    public fun i32_from_u32(arg0: u32) : I32 {
        I32{bits: arg0}
    }

    public fun i32_is_negative(arg0: &I32) : bool {
        arg0.bits > 2147483647
    }

    public fun i32_lt(arg0: u32, arg1: u32) : bool {
        let v0 = arg0 > 2147483647;
        let v1 = arg1 > 2147483647;
        v0 && !v1 || !v0 && v1 && false || v0 && v1 && arg0 < arg1 || arg0 < arg1
    }

    fun liquidity_for_amount0(arg0: u64, arg1: u256, arg2: u256) : u128 {
        (mul_div_u256(mul_div_u256((arg0 as u256), arg1, 79228162514264337593543950336), arg2, arg2 - arg1) as u128)
    }

    fun liquidity_for_amount1(arg0: u64, arg1: u256, arg2: u256) : u128 {
        (mul_div_u256((arg0 as u256), 79228162514264337593543950336, arg2 - arg1) as u128)
    }

    public fun max_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg2 == 0) {
            0
        } else {
            arg0 * arg1 / arg2
        }
    }

    // decompiled from Move bytecode v7
}

