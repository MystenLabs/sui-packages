module 0x8ea6c5c2cd199fe14f5803e1dbdf929b681db1da4ebc4d9275d23325787944bd::numeric {
    struct AftermathMathSigned has copy, drop {
        negative: bool,
        magnitude: u256,
    }

    public fun advance_segment_v2(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128) : (u128, u128, u128) {
        let v0 = mul_div_down(arg4, arg3, arg2 + arg4);
        (effective_output(v0, arg1, arg0), arg2 + arg4, arg3 - v0)
    }

    public fun affine_ratio(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u128, arg6: u128) : (bool, u256, u256) {
        let v0 = if (arg2 == 10 || arg2 == 11) {
            1
        } else {
            0
        };
        (true, mul_fraction_ceil(mul_fraction_ceil(mul_ratio_up_saturating(q64(), (arg6 as u256), (arg5 as u256)), ((arg0 - arg1) as u256), (arg0 as u256)), ((arg3 - arg4) as u256), (arg3 as u256)), v0)
    }

    public fun affine_steamm_cpmm(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128) : (bool, u256, u256) {
        let (v0, v1) = steamm_btoken_supplies(arg4);
        (true, mul_ratio_up_saturating(mul_fraction_ceil(mul_ratio_up_saturating(mul_ratio_up_saturating(q64(), (v0 as u256) * 1000000000000000000, (arg5 as u256)), (arg3 as u256), (arg2 as u256)), ((arg0 - arg1) as u256), (arg0 as u256)), (arg6 as u256), (v1 as u256) * 1000000000000000000), 0)
    }

    public fun affine_steamm_omm(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u128) : (bool, u256, u256) {
        let (_, v1) = steamm_btoken_supplies(arg5);
        let v2 = (arg7 as u256) / (v1 as u256);
        if (v2 == 0) {
            return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
        };
        let v3 = mul_ratio_up_saturating(q64(), (arg3 as u256), (arg0 as u256));
        let v4 = 0;
        loop {
            let v5 = if (arg4 > arg6) {
                arg4 - arg6
            } else {
                arg6 - arg4
            };
            if (v4 < v5) {
                let v6 = if (arg4 > arg6) {
                    div_ceil(v3, 10)
                } else {
                    saturating_mul(v3, 10)
                };
                v3 = v6;
                v4 = v4 + 1;
            } else {
                break
            };
        };
        (true, mul_ratio_up_saturating(mul_fraction_ceil(v3, ((arg1 - arg2) as u256), (arg1 as u256)), (arg7 as u256), (v1 as u256) * v2), 0)
    }

    public fun affine_virtual_cpmm(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: bool) : (bool, u256, u256) {
        let v0 = if (arg8) {
            arg2
        } else {
            arg3
        };
        let v1 = (arg4 as u256) * (arg5 as u256);
        let v2 = v1 * v1 * (arg6 as u256) / (arg7 as u256);
        let v3 = v1 + (v0 as u256) - (arg4 as u256);
        if (v3 == 0 || v2 == 0) {
            return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
        };
        let v4 = if (arg8) {
            if (v3 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v3) {
                return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
            };
            mul_ratio_up_saturating(q64(), v2, v3 * v3)
        } else {
            let v5 = v2 / v3;
            if (v5 == 0) {
                return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
            };
            mul_ratio_up_saturating(q64(), v3, v5)
        };
        (true, mul_fraction_ceil(v4, ((arg0 - arg1) as u256), (arg0 as u256)), 2)
    }

    public fun aftermath_a20(arg0: u64) : u256 {
        if (arg0 == 2) {
            7896296018268069516100000000000000
        } else if (arg0 == 3) {
            888611052050787263676000000
        } else if (arg0 == 4) {
            298095798704172827474000
        } else if (arg0 == 5) {
            5459815003314423907810
        } else if (arg0 == 6) {
            738905609893065022723
        } else if (arg0 == 7) {
            271828182845904523536
        } else if (arg0 == 8) {
            164872127070012814685
        } else if (arg0 == 9) {
            128402541668774148407
        } else if (arg0 == 10) {
            113314845306682631683
        } else {
            assert!(arg0 == 11, 3);
            106449445891785942956
        }
    }

    fun aftermath_exp(arg0: AftermathMathSigned) : u256 {
        if (arg0.negative) {
            return 1000000000000000000 * 1000000000000000000 / aftermath_exp(aftermath_signed_neg(arg0))
        };
        let v0 = arg0.magnitude;
        let v1 = v0;
        let v2 = if (v0 >= 128000000000000000000) {
            v1 = v0 - 128000000000000000000;
            38877084059945950922200000000000000000000000000000000000
        } else if (v0 >= 64000000000000000000) {
            v1 = v0 - 64000000000000000000;
            6235149080811616882910000000
        } else {
            1
        };
        v1 = v1 * 100;
        let v3 = 100000000000000000000;
        let v4 = 2;
        while (v4 <= 9) {
            let v5 = aftermath_x20(v4);
            if (v1 >= v5) {
                v1 = v1 - v5;
                let v6 = v3 * aftermath_a20(v4);
                v3 = v6 / 100000000000000000000;
            };
            v4 = v4 + 1;
        };
        let v7 = v1;
        let v8 = 100000000000000000000 + v1;
        v4 = 2;
        while (v4 <= 12) {
            v7 = v7 * v1 / 100000000000000000000 / (v4 as u256);
            v8 = v8 + v7;
            v4 = v4 + 1;
        };
        v3 * v8 / 100000000000000000000 * v2 / 100
    }

    public fun aftermath_exp_parts(arg0: bool, arg1: u256) : u256 {
        let v0 = AftermathMathSigned{
            negative  : arg0,
            magnitude : arg1,
        };
        aftermath_exp(v0)
    }

    public fun aftermath_fixed_div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 * 1000000000000000000 - 1) / arg1 + 1
        }
    }

    public fun aftermath_fixed_mul_down(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000000000000
    }

    public fun aftermath_fixed_mul_up(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 * arg1;
        if (v0 == 0) {
            0
        } else {
            (v0 - 1) / 1000000000000000000 + 1
        }
    }

    fun aftermath_ln(arg0: u256) : AftermathMathSigned {
        if (arg0 < 1000000000000000000) {
            return aftermath_signed_neg(aftermath_ln(1000000000000000000 * 1000000000000000000 / arg0))
        };
        let v0 = 0;
        let v1 = v0;
        if (arg0 >= 38877084059945950922200000000000000000000000000000000000 * 1000000000000000000) {
            arg0 = arg0 / 38877084059945950922200000000000000000000000000000000000;
            v1 = v0 + 128000000000000000000;
        };
        if (arg0 >= 6235149080811616882910000000 * 1000000000000000000) {
            arg0 = arg0 / 6235149080811616882910000000;
            v1 = v1 + 64000000000000000000;
        };
        v1 = v1 * 100;
        arg0 = arg0 * 100;
        let v2 = 2;
        while (v2 <= 11) {
            let v3 = aftermath_a20(v2);
            if (arg0 >= v3) {
                let v4 = arg0 * 100000000000000000000;
                arg0 = v4 / v3;
                v1 = v1 + aftermath_x20(v2);
            };
            v2 = v2 + 1;
        };
        let v5 = (arg0 - 100000000000000000000) * 100000000000000000000 / (arg0 + 100000000000000000000);
        let v6 = v5;
        let v7 = v5;
        v2 = 3;
        while (v2 <= 11) {
            v6 = v6 * v5 * v5 / 100000000000000000000 / 100000000000000000000;
            v7 = v7 + v6 / (v2 as u256);
            v2 = v2 + 2;
        };
        aftermath_signed((v1 + 2 * v7) / 100, false)
    }

    fun aftermath_ln_36(arg0: u256) : AftermathMathSigned {
        let v0 = arg0 * 1000000000000000000;
        let v1 = 1000000000000000000 * 1000000000000000000;
        let v2 = if (v0 >= v1) {
            aftermath_signed(v0 - v1, false)
        } else {
            aftermath_signed(v1 - v0, true)
        };
        let v3 = aftermath_signed_div_u(aftermath_signed_mul_u(v2, v1), v0 + v1);
        let v4 = v3;
        let v5 = v3;
        let v6 = 3;
        while (v6 <= 15) {
            v4 = aftermath_signed_div_u(aftermath_signed_mul_u(v4, v3.magnitude * v3.magnitude / v1), v1);
            v5 = aftermath_signed_add(v5, aftermath_signed_div_u(v4, (v6 as u256)));
            v6 = v6 + 2;
        };
        aftermath_signed_mul_u(v5, 2)
    }

    public fun aftermath_ln_36_parts(arg0: u256) : (bool, u256) {
        let v0 = aftermath_ln_36(arg0);
        (v0.negative, v0.magnitude)
    }

    public fun aftermath_ln_parts(arg0: u256) : (bool, u256) {
        let v0 = aftermath_ln(arg0);
        (v0.negative, v0.magnitude)
    }

    public fun aftermath_log_exp_pow(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg1 == 0) {
            return (1000000000000000000, true)
        };
        if (arg0 == 0) {
            return (0, true)
        };
        let v0 = if (1000000000000000000 - 100000000000000000 < arg0 && arg0 < 1000000000000000000 + 100000000000000000) {
            let v1 = aftermath_ln_36(arg0);
            aftermath_signed_div_u(aftermath_signed_add(aftermath_signed_mul_u(aftermath_signed_div_u(v1, 1000000000000000000), arg1), aftermath_signed_div_u(aftermath_signed_mul_u(aftermath_signed_rem_u(v1, 1000000000000000000), arg1), 1000000000000000000)), 1000000000000000000)
        } else {
            aftermath_signed_div_u(aftermath_signed_mul_u(aftermath_ln(arg0), arg1), 1000000000000000000)
        };
        let v2 = v0;
        if (!v2.negative && v2.magnitude > 130 * 1000000000000000000 || v2.negative && v2.magnitude > 41 * 1000000000000000000) {
            return (0, false)
        };
        (aftermath_exp(v2), true)
    }

    public fun aftermath_pow_up(arg0: u256, arg1: u256) : (u256, bool) {
        let v0 = if (arg1 == 1000000000000000000) {
            arg0
        } else if (arg1 == 2 * 1000000000000000000) {
            aftermath_fixed_mul_up(arg0, arg0)
        } else if (arg1 == 4 * 1000000000000000000) {
            let v1 = aftermath_fixed_mul_up(arg0, arg0);
            aftermath_fixed_mul_up(v1, v1)
        } else {
            let (v2, v3) = aftermath_log_exp_pow(arg0, arg1);
            if (!v3) {
                return (0, false)
            };
            v2
        };
        let v4 = aftermath_fixed_mul_up(v0, 10000) + 1;
        if (v0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v4) {
            (0, false)
        } else {
            (v0 + v4, true)
        }
    }

    fun aftermath_signed(arg0: u256, arg1: bool) : AftermathMathSigned {
        let v0 = arg1 && arg0 != 0;
        AftermathMathSigned{
            negative  : v0,
            magnitude : arg0,
        }
    }

    fun aftermath_signed_add(arg0: AftermathMathSigned, arg1: AftermathMathSigned) : AftermathMathSigned {
        if (arg0.negative == arg1.negative) {
            aftermath_signed(arg0.magnitude + arg1.magnitude, arg0.negative)
        } else if (arg0.magnitude >= arg1.magnitude) {
            aftermath_signed(arg0.magnitude - arg1.magnitude, arg0.negative)
        } else {
            aftermath_signed(arg1.magnitude - arg0.magnitude, arg1.negative)
        }
    }

    fun aftermath_signed_div_u(arg0: AftermathMathSigned, arg1: u256) : AftermathMathSigned {
        aftermath_signed(arg0.magnitude / arg1, arg0.negative)
    }

    fun aftermath_signed_mul_u(arg0: AftermathMathSigned, arg1: u256) : AftermathMathSigned {
        aftermath_signed(arg0.magnitude * arg1, arg0.negative)
    }

    fun aftermath_signed_neg(arg0: AftermathMathSigned) : AftermathMathSigned {
        aftermath_signed(arg0.magnitude, !arg0.negative)
    }

    fun aftermath_signed_rem_u(arg0: AftermathMathSigned, arg1: u256) : AftermathMathSigned {
        aftermath_signed(arg0.magnitude % arg1, arg0.negative)
    }

    public fun aftermath_weights(arg0: u128) : (u64, u64) {
        (((arg0 >> 64) as u64), ((arg0 & (18446744073709551615 as u128)) as u64))
    }

    public fun aftermath_x20(arg0: u64) : u256 {
        if (arg0 == 2) {
            3200000000000000000000
        } else if (arg0 == 3) {
            1600000000000000000000
        } else if (arg0 == 4) {
            800000000000000000000
        } else if (arg0 == 5) {
            400000000000000000000
        } else if (arg0 == 6) {
            200000000000000000000
        } else if (arg0 == 7) {
            100000000000000000000
        } else if (arg0 == 8) {
            50000000000000000000
        } else if (arg0 == 9) {
            25000000000000000000
        } else if (arg0 == 10) {
            12500000000000000000
        } else {
            assert!(arg0 == 11, 3);
            6250000000000000000
        }
    }

    public fun aligned_in_range(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        let v0 = if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        };
        let v1 = v0 - v0 % arg3;
        let v2 = v1;
        if (v1 < arg1) {
            let v3 = arg1 % arg3;
            let v4 = if (v3 == 0) {
                arg1
            } else {
                let v5 = arg3 - v3;
                if (arg1 > 340282366920938463463374607431768211455 - v5) {
                    0
                } else {
                    arg1 + v5
                }
            };
            v2 = v4;
        };
        if (v2 > arg2) {
            0
        } else {
            v2
        }
    }

    public fun amount0_delta_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = (arg2 as u256) << 64;
        let v1 = v0 / (arg0 as u256);
        let v2 = div_up_u256(v0, (arg1 as u256));
        if (v1 <= v2) {
            0
        } else {
            to_u128(v1 - v2)
        }
    }

    public fun amount0_delta_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = (arg2 as u256) << 64;
        to_u128(div_up_u256(v0, (arg1 as u256)) - v0 / (arg0 as u256))
    }

    public fun book_anchor_point(arg0: u128, arg1: u256, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: bool, arg12: u128) : (u128, u128, bool) {
        let (v0, v1, v2, _) = book_anchor_projected_point(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        (v0, v1, v2)
    }

    public fun book_anchor_projected_point(arg0: u128, arg1: u256, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: bool, arg12: u128) : (u128, u128, bool, bool) {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg2 > 18446744073709551615) {
            true
        } else if (arg3 > 18446744073709551615) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg6 == 0
        };
        if (v0) {
            return (0, 0, false, false)
        };
        let v1 = (arg0 as u256) * (arg2 as u256);
        let v2 = (arg3 as u256) * q64();
        if (v1 <= v2) {
            return (0, 0, false, false)
        };
        let v3 = (v1 - v2) / (arg2 as u256) * (arg3 as u256);
        if (v3 == 0) {
            return (0, 0, false, false)
        };
        let v4 = (arg0 as u256) * q64() / arg1;
        if (v4 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / q64()) {
            return (0, 0, false, false)
        };
        let v5 = coefficient_root(v4, v3, arg5);
        let (v6, v7, v8) = book_joint_points(v5, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v9 = if (v8) {
            true
        } else if (arg7 == 0) {
            true
        } else if (arg8 == 0) {
            true
        } else {
            arg12 == 0
        };
        if (v9) {
            return (v6, v7, v8, false)
        };
        let v10 = if (arg11) {
            (arg12 as u256) * 1000000000 / (arg7 as u256)
        } else {
            (arg12 as u256)
        };
        let v11 = if (arg11) {
            (arg5 as u256)
        } else {
            (arg5 as u256) * 1000000000 / (arg7 as u256)
        };
        let v12 = 0x1::u256::min(0x1::u256::min(v10, v11), (arg10 as u256));
        let v13 = v12 - v12 % (arg8 as u256);
        if (v13 == 0 || v13 < (arg9 as u256)) {
            return (v6, v7, v8, false)
        };
        let v14 = if (arg11) {
            v13
        } else {
            div_ceil(v13 * (arg7 as u256), 1000000000)
        };
        let v15 = if (v14 >= (v5 as u256)) {
            true
        } else if (v14 < (arg4 as u256)) {
            true
        } else if (v14 > (arg5 as u256)) {
            true
        } else {
            v14 > (18446744073709551615 as u256)
        };
        if (v15) {
            return (v6, v7, v8, false)
        };
        let (v16, v17, v18) = book_joint_points((v14 as u128), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let (v19, v20, v21, v22) = if (v18) {
            (v18, true, v16, v17)
        } else {
            (v8, false, v6, v7)
        };
        (v21, v22, v19, v20)
    }

    public fun book_coverage_cell(arg0: u128, arg1: u64, arg2: bool, arg3: u128, arg4: u128, arg5: u8, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128) : bool {
        if (arg1 == 0) {
            if (arg5 == 0) {
                if (arg6 > 0) {
                    if (arg7 > 0) {
                        if (arg8 > 0) {
                            if (arg9 == 340282366920938463463374607431768211455) {
                                if (arg10 == 340282366920938463463374607431768211455) {
                                    arg2 && arg0 <= arg3 || (arg0 as u256) * 1000000000 <= (arg3 as u256) * (arg4 as u256)
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun book_joint_points(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: bool, arg9: u128) : (u128, u128, bool) {
        let v0 = if (arg4 == 0) {
            true
        } else if (arg5 == 0) {
            true
        } else {
            (arg4 as u256) * (arg5 as u256) % 1000000000 != 0
        };
        if (v0) {
            return (0, 0, false)
        };
        let v1 = if (arg8) {
            (arg0 as u256)
        } else {
            (arg0 as u256) * 1000000000 / (arg4 as u256)
        };
        let v2 = v1 - v1 % (arg5 as u256);
        let v3 = v2 + (arg5 as u256);
        let v4 = if (v2 > 0) {
            if (v2 >= (arg6 as u256)) {
                v2 <= (arg7 as u256)
            } else {
                false
            }
        } else {
            false
        };
        let v5 = v3 >= (arg6 as u256) && v3 <= (arg7 as u256);
        let v6 = if (!v4) {
            0
        } else if (arg8) {
            v2
        } else {
            div_ceil(v2 * (arg4 as u256), 1000000000)
        };
        let v7 = if (!v5) {
            0
        } else if (arg8) {
            v3
        } else {
            div_ceil(v3 * (arg4 as u256), 1000000000)
        };
        let v8 = if (v4) {
            if (v6 >= (arg1 as u256)) {
                if (v6 <= (arg2 as u256)) {
                    v6 % (arg3 as u256) == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v9 = if (v5) {
            if (v7 >= (arg1 as u256)) {
                if (v7 <= (arg2 as u256)) {
                    v7 % (arg3 as u256) == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (!v8 && !v9) {
            return (0, 0, false)
        };
        let v10 = if (v8) {
            v2
        } else {
            v3
        };
        let v11 = if (arg8) {
            mul_div_down((v10 as u128), arg4, 1000000000)
        } else {
            (v10 as u128)
        };
        if (v11 > arg9) {
            return (0, 1, false)
        };
        let v12 = if (v8) {
            v6
        } else {
            v7
        };
        let v13 = if (!v8 || !v9) {
            0
        } else {
            ((v7 - v6) as u128)
        };
        ((v12 as u128), v13, true)
    }

    public fun cap_endpoint_v3(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: u128, arg5: u128) : u256 {
        let v0 = if (arg5 == 0) {
            (arg2 as u256)
        } else {
            (next_sqrt_price(arg0, arg1, arg2, arg3, arg5, arg4) as u256)
        };
        if (arg3) {
            v0 * v0 / q64()
        } else {
            q64() * q64() * q64() / v0 * v0
        }
    }

    public fun cap_inverse_v2(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128) : (u128, bool) {
        let v0 = gross_from_effective(arg6, arg3, arg2);
        if (v0 >= arg5) {
            return (0, false)
        };
        (gross_from_effective(mul_div_up(arg4, v0, arg5 - v0), arg1, arg0), true)
    }

    public fun cap_inverse_v3(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: u128, arg6: u128) : (u128, bool) {
        let v0 = if (arg4) {
            if (arg6 > mul_div_down(arg2, arg3 - arg5, 18446744073709551616)) {
                return (0, false)
            };
            let v1 = mul_div_up(arg6, 18446744073709551616, arg2);
            if (v1 >= arg3) {
                return (0, false)
            };
            let v2 = arg3 - v1;
            if (v2 < arg5) {
                return (0, false)
            };
            amount0_delta_up(arg3, v2, arg2)
        } else {
            if (arg6 > amount0_delta_down(arg3, arg5, arg2)) {
                return (0, false)
            };
            let v3 = (arg2 as u256) << 64;
            let v4 = v3 / (arg3 as u256);
            if ((arg6 as u256) >= v4) {
                return (0, false)
            };
            let v5 = to_u128(div_up_u256(v3, v4 - (arg6 as u256)));
            if (v5 > arg5) {
                return (0, false)
            };
            mul_div_up(arg2, v5 - arg3, 18446744073709551616)
        };
        (gross_from_effective(v0, arg1, arg0), true)
    }

    public fun cap_marginal_aftermath_geometric(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: u128, arg5: u128) : u256 {
        let (v0, v1) = aftermath_weights(arg3);
        mul_ratio_down_saturating(mul_ratio_down_saturating(mul_ratio_down_saturating((arg1 as u256) * q64() / (arg0 as u256), (v0 as u256), (v1 as u256)), (arg4 as u256), (arg5 as u256)), 1000000000000000000 - (arg2 as u256), 1000000000000000000)
    }

    public fun cap_marginal_bucket_psm(arg0: u128, arg1: u128, arg2: bool) : u256 {
        if (arg2) {
            q64() / (arg0 as u256)
        } else {
            q64() * (arg1 as u256)
        }
    }

    public fun cap_segment_quote_v3(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: u128, arg5: u128) : u128 {
        if (arg3) {
            mul_div_down(arg0, arg2 - next_sqrt_price(arg0, arg1, arg2, arg3, arg5, arg4), 18446744073709551616)
        } else {
            amount0_delta_down(arg2, next_sqrt_price(arg0, arg1, arg2, arg3, arg5, arg4), arg0)
        }
    }

    public fun cap_upper_aftermath_prepared(arg0: u128, arg1: u128, arg2: u64, arg3: u256, arg4: u128, arg5: u128) : u256 {
        mul_ratio_up_saturating(mul_ratio_up_saturating(mul_ratio_up_saturating(div_ceil((arg1 as u256) * q64(), (arg0 as u256)), arg3 + 1, 1000000000000000000), (arg4 as u256), (arg5 as u256)), 1000000000000000000 - (arg2 as u256), 1000000000000000000)
    }

    public fun cap_upper_bucket_psm(arg0: u128, arg1: u128, arg2: bool) : u256 {
        if (arg2) {
            div_ceil(q64(), (arg0 as u256))
        } else {
            q64() * (arg1 as u256)
        }
    }

    public fun cap_upper_v3(arg0: u128, arg1: bool) : u256 {
        let v0 = (arg0 as u256);
        if (arg1) {
            div_ceil(v0 * v0, q64())
        } else {
            div_ceil(q64() * q64() * q64(), v0 * v0)
        }
    }

    public fun clmm_input_boundary(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: u128) : u128 {
        let v0 = if (arg4) {
            amount0_delta_up(arg3, arg5, arg2)
        } else {
            mul_div_up(arg2, arg5 - arg3, 18446744073709551616)
        };
        gross_from_effective(v0, arg1, arg0)
    }

    fun clmm_log2(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0 >> 128 > 0) {
            arg0 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (arg0 >> 64 > 0) {
            arg0 = arg0 >> 64;
            v1 = v1 + 64;
        };
        if (arg0 >> 32 > 0) {
            arg0 = arg0 >> 32;
            v1 = v1 + 32;
        };
        if (arg0 >> 16 > 0) {
            arg0 = arg0 >> 16;
            v1 = v1 + 16;
        };
        if (arg0 >> 8 > 0) {
            arg0 = arg0 >> 8;
            v1 = v1 + 8;
        };
        if (arg0 >> 4 > 0) {
            arg0 = arg0 >> 4;
            v1 = v1 + 4;
        };
        if (arg0 >> 2 > 0) {
            arg0 = arg0 >> 2;
            v1 = v1 + 2;
        };
        if (arg0 >> 1 > 0) {
            v1 = v1 + 1;
        };
        v1
    }

    public fun clmm_residual_proposal(arg0: u128, arg1: u128, arg2: u256, arg3: u256, arg4: u256, arg5: u128, arg6: u256, arg7: u128, arg8: u128, arg9: u128) : (u128, bool) {
        let v0 = if (arg1 <= arg0) {
            true
        } else if (arg2 <= arg4) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg3 >= arg4) {
            true
        } else if (arg9 == 0) {
            true
        } else if (arg8 < arg7) {
            true
        } else {
            arg5 != arg0 && arg5 != arg1
        };
        if (v0) {
            return (0, false)
        };
        let v1 = clmm_sqrt(arg2);
        let v2 = clmm_sqrt(arg3);
        let v3 = if (arg4 == q64()) {
            4294967296
        } else {
            clmm_sqrt(arg4)
        };
        let v4 = if (v1 <= v3) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v2 >= v3
        };
        if (v4) {
            return (0, false)
        };
        let v5 = (v1 - v3) * v2;
        let v6 = ((arg1 - arg0) as u256);
        if (v6 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v5) {
            return (0, false)
        };
        let v7 = 0x1::u128::min(0x1::u128::max(arg0 + ((v6 * v5 / (v1 - v2) * v3) as u128), arg7), arg8);
        let v8 = v7 - v7 % arg9;
        let v9 = v8;
        if (v8 < arg7) {
            let v10 = arg7 % arg9;
            let v11 = if (v10 == 0) {
                0
            } else {
                arg9 - v10
            };
            if (arg7 > 340282366920938463463374607431768211455 - v11) {
                return (0, false)
            };
            v9 = arg7 + v11;
        };
        let v12 = if (v9 > arg8) {
            true
        } else if (v9 <= arg0) {
            true
        } else if (v9 >= arg1) {
            true
        } else {
            v9 == arg5
        };
        if (v12) {
            return (0, false)
        };
        let v13 = if (v9 > arg5) {
            v9 - arg5
        } else {
            arg5 - v9
        };
        let v14 = if (arg6 > arg4) {
            arg6 - arg4
        } else {
            arg4 - arg6
        };
        if (v13 <= arg9 || v14 <= (2 * q64() - 1) / (v13 as u256)) {
            return (0, false)
        };
        (v9, true)
    }

    fun clmm_sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1 << ((clmm_log2(arg0) >> 1) as u8);
        let v1 = v0 + arg0 / v0 >> 1;
        let v2 = v1 + arg0 / v1 >> 1;
        let v3 = v2 + arg0 / v2 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        0x1::u256::min(v7, arg0 / v7)
    }

    public fun closed_form_root(arg0: u128, arg1: u128, arg2: u256) : (u128, bool) {
        if (arg2 <= q64()) {
            return (0, true)
        };
        let v0 = arg2 * (arg0 as u256);
        let v1 = (arg1 as u256) * q64();
        if (v0 <= v1 || arg1 == 0) {
            return (arg0, false)
        };
        let v2 = (sqrt_down(arg2 * q64()) - q64()) * (arg1 as u256) * q64() / (v0 - v1);
        if (v2 > q64()) {
            return (arg0, false)
        };
        (to_u128((arg0 as u256) * v2 / q64()), true)
    }

    public fun coefficient_root(arg0: u256, arg1: u256, arg2: u128) : u128 {
        if (arg1 == 0) {
            return arg2
        };
        let v0 = sqrt_down(arg0 * q64());
        if (v0 <= q64()) {
            return 0
        };
        let v1 = to_u128((v0 - q64()) / arg1);
        if (v1 > arg2) {
            arg2
        } else {
            v1
        }
    }

    public fun div_ceil(arg0: u256, arg1: u256) : u256 {
        if (arg0 % arg1 == 0) {
            arg0 / arg1
        } else {
            arg0 / arg1 + 1
        }
    }

    public fun div_up_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    fun effective_input(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_down(arg0, ((arg2 - arg1) as u128), (arg2 as u128))
    }

    public fun effective_output(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_down(arg0, ((arg2 - arg1) as u128), (arg2 as u128))
    }

    public fun gross_from_effective(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_up(arg0, (arg2 as u128), ((arg2 - arg1) as u128))
    }

    public fun liquidity_after_boundary(arg0: u128, arg1: bool, arg2: u128, arg3: bool) : (u128, bool) {
        if (arg3 && !arg1 || arg1) {
            if (arg0 < arg2) {
                (0, false)
            } else {
                (arg0 - arg2, true)
            }
        } else if (arg0 > 340282366920938463463374607431768211455 - arg2) {
            (0, false)
        } else {
            (arg0 + arg2, true)
        }
    }

    public fun log2_down(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0 >> 128 > 0) {
            arg0 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (arg0 >> 64 > 0) {
            arg0 = arg0 >> 64;
            v1 = v1 + 64;
        };
        if (arg0 >> 32 > 0) {
            arg0 = arg0 >> 32;
            v1 = v1 + 32;
        };
        if (arg0 >> 16 > 0) {
            arg0 = arg0 >> 16;
            v1 = v1 + 16;
        };
        if (arg0 >> 8 > 0) {
            arg0 = arg0 >> 8;
            v1 = v1 + 8;
        };
        if (arg0 >> 4 > 0) {
            arg0 = arg0 >> 4;
            v1 = v1 + 4;
        };
        if (arg0 >> 2 > 0) {
            arg0 = arg0 >> 2;
            v1 = v1 + 2;
        };
        if (arg0 >> 1 > 0) {
            v1 = v1 + 1;
        };
        v1
    }

    public fun meta_exchange(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : (u128, u8) {
        let v0 = if (arg4 > arg3) {
            (arg0 as u256) * (arg4 as u256) / (arg3 as u256)
        } else {
            (arg0 as u256)
        };
        if (v0 > (18446744073709551615 as u256)) {
            return (0, 12)
        };
        let v1 = v0 * (arg1 as u256) / (arg2 as u256);
        if (v1 > (18446744073709551615 as u256)) {
            return (0, 12)
        };
        let v2 = if (arg4 < arg3) {
            if (v1 > 0) {
                v1 < ((arg3 / arg4) as u256)
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            return (0, 10)
        };
        let v3 = if (arg4 < arg3) {
            ((v1 / ((arg3 / arg4) as u256)) as u128)
        } else {
            (v1 as u128)
        };
        (v3, 0)
    }

    public fun meta_quote(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: u128, arg10: &mut u64) : (u128, u8, u64) {
        if (*arg10 == 0) {
            return (0, 6, 0)
        };
        *arg10 = *arg10 - 1;
        let (v0, v1) = if (arg0) {
            meta_exchange(arg9, arg1, 1000000000000000000, arg2, arg3)
        } else {
            meta_exchange(arg9, 1000000000000000000, arg1, arg3, arg2)
        };
        if (v1 != 0) {
            return (0, v1, 0)
        };
        if (v0 == 0) {
            return (0, 10, 0)
        };
        if (arg0) {
            if (v0 > 18446744073709551615 - arg4) {
                return (0, 7, 0)
            };
            return (v0, 0, 0)
        };
        if (v0 > arg5) {
            return (0, 7, 0)
        };
        let v2 = arg5 - v0;
        let v3 = if (v2 >= arg6) {
            (arg7 as u128)
        } else {
            (arg8 as u128) - ((arg8 - arg7) as u128) * v2 / arg6
        };
        let v4 = v0 - v0 * v3 / 1000000000000000000;
        let v5 = if (v4 == 0) {
            10
        } else {
            0
        };
        (v4, v5, 0)
    }

    public fun meta_rate(arg0: u8, arg1: u128, arg2: bool, arg3: u128, arg4: u128, arg5: u128, arg6: u64) : u256 {
        if (arg0 != 0 || arg1 == 0) {
            return 0
        };
        let (v0, v1, v2, v3) = if (arg2) {
            (arg3, 1000000000000000000, arg4, arg5)
        } else {
            (1000000000000000000, arg3, arg5, arg4)
        };
        if (arg2) {
            mul_ratio_up_saturating(mul_ratio_up_saturating(q64(), (v0 as u256), (v1 as u256)), (v3 as u256), (v2 as u256))
        } else {
            mul_ratio_up_saturating(mul_ratio_up_saturating(mul_ratio_up_saturating(q64(), (v0 as u256), (v1 as u256)), (v3 as u256), (v2 as u256)), 1000000000000000000 - (arg6 as u256), 1000000000000000000)
        }
    }

    fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        to_u128((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
    }

    public fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        to_u128(div_up_u256((arg0 as u256) * (arg1 as u256), (arg2 as u256)))
    }

    public fun mul_fraction_ceil(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0 && arg1 <= arg2, 2);
        arg0 / arg2 * arg1 + div_ceil(arg0 % arg2 * arg1, arg2)
    }

    public fun mul_q64_ceil(arg0: u256, arg1: u256) : u256 {
        let v0 = q64();
        let v1 = arg0 % v0;
        saturating_add(saturating_add(saturating_mul(arg0 / v0, arg1), v1 * arg1 / v0), div_ceil(v1 * arg1 % v0, v0))
    }

    public fun mul_ratio_down_saturating(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 * arg1 / arg2
        }
    }

    public fun mul_ratio_up_saturating(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            div_ceil(arg0 * arg1, arg2)
        }
    }

    public fun next_sqrt_price(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: u128, arg5: u128) : u128 {
        let v0 = if (arg3) {
            amount0_delta_up(arg2, arg5, arg0)
        } else {
            mul_div_up(arg0, arg5 - arg2, 18446744073709551616)
        };
        if (arg4 >= v0) {
            return arg5
        };
        if (arg3) {
            0x1::u128::max(next_sqrt_price_partial(arg2, arg0, arg3, arg4, arg1), arg5)
        } else {
            0x1::u128::min(next_sqrt_price_partial(arg2, arg0, arg3, arg4, arg1), arg5)
        }
    }

    public fun next_sqrt_price_partial(arg0: u128, arg1: u128, arg2: bool, arg3: u128, arg4: bool) : u128 {
        if (arg2) {
            let v1 = (arg0 as u256);
            let v2 = (arg3 as u256) * v1;
            arg0 - ((v2 * v1 / (((arg1 as u256) << 64) + v2)) as u128)
        } else {
            arg0 + mul_div_down(arg3, 18446744073709551616, arg1)
        }
    }

    public fun profit_chord_left(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : u128 {
        let v0 = if (arg0 >= arg2) {
            true
        } else if (arg1 >= arg4) {
            true
        } else if (arg3 < arg4) {
            true
        } else {
            arg1 >= arg3
        };
        if (v0) {
            return arg2
        };
        let v1 = ((arg2 - arg0) as u256) * ((arg4 - arg1) as u256);
        let v2 = ((arg3 - arg1) as u256);
        let v3 = if (v1 % v2 > 0) {
            1
        } else {
            0
        };
        arg0 + ((v1 / v2 + v3) as u128)
    }

    public fun q64() : u256 {
        (18446744073709551616 as u256)
    }

    public fun quote_aftermath_with_exponent(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u64, arg5: u256, arg6: u128, arg7: u128, arg8: u128, arg9: &mut u64) : (u128, u8, u64) {
        if (arg8 == 0) {
            return (0, 0, 0)
        };
        if (arg8 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg9 < 40) {
            return (0, 6, 0)
        };
        *arg9 = *arg9 - 40;
        let v0 = (effective_input(arg8, arg4, (1000000000000000000 as u64)) as u256) * (arg6 as u256);
        if (v0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / 1000000000000000000) {
            return (0, 5, 0)
        };
        let v1 = aftermath_fixed_mul_down(v0, 1000000000000000000 - (arg0 as u256));
        let v2 = (arg2 as u256);
        if (v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v2) {
            return (0, 5, 0)
        };
        let (v3, v4) = aftermath_pow_up(aftermath_fixed_div_up(v2, v2 + v1), arg5);
        if (!v4) {
            return (0, 5, 0)
        };
        let v5 = if (v3 < 1000000000000000000) {
            1000000000000000000 - v3
        } else {
            0
        };
        let v6 = aftermath_fixed_mul_down(aftermath_fixed_mul_down((arg3 as u256), v5), 1000000000000000000 - (arg1 as u256)) / (arg7 as u256);
        if (v6 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v6 as u128), 0, 0)
    }

    public fun quote_bucket_psm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: bool, arg6: u128, arg7: &mut u64) : (u128, u8, u64) {
        if (arg6 == 0) {
            return (0, 0, 0)
        };
        if (*arg7 == 0) {
            return (0, 6, 0)
        };
        *arg7 = *arg7 - 1;
        if (arg6 > arg2) {
            return (0, 7, 0)
        };
        let v0 = if (arg5) {
            arg6 / arg3
        } else {
            if (arg6 > 340282366920938463463374607431768211455 / arg4) {
                return (0, 5, 0)
            };
            arg6 * arg4
        };
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = div_ceil((v0 as u256) * (arg1 as u256), (arg0 as u256));
        if (v1 > (v0 as u256)) {
            return (0, 0, 0)
        };
        ((((v0 as u256) - v1) as u128), 0, 0)
    }

    public fun quote_capped_ratio_hop(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: &mut u64) : (u128, u8, u64) {
        if (arg3 > arg2) {
            return (0, 7, 0)
        };
        if (*arg4 == 0) {
            return (0, 6, 0)
        };
        *arg4 = *arg4 - 1;
        let v0 = (arg3 as u256) * (arg1 as u256) / (arg0 as u256);
        if (v0 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v0 as u128), 0, 0)
    }

    public fun quote_cpmm_cached_with_slope(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128) : (u128, u256) {
        let v0 = effective_input(arg6, arg1, arg0);
        let v1 = arg4 + v0;
        (effective_output(mul_div_down(v0, arg5, v1), arg3, arg2), mul_ratio_down_saturating(mul_ratio_down_saturating((arg5 as u256) * q64() / (v1 as u256), (arg4 as u256), (v1 as u256)), ((arg2 - arg3) as u256), (arg2 as u256)))
    }

    public fun quote_hasui_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: &mut u64) : (u128, u8, u64) {
        if (arg8 == 0) {
            return (0, 0, 0)
        };
        if (arg8 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg9 == 0) {
            return (0, 6, 0)
        };
        *arg9 = *arg9 - 1;
        if (arg8 < arg4) {
            return (0, 10, 0)
        };
        let v0 = (arg8 as u256) * (arg3 as u256) / (arg2 as u256);
        if (v0 == 0) {
            return (0, 10, 0)
        };
        if (v0 > (18446744073709551615 as u256)) {
            return (0, 12, 0)
        };
        if (!arg7) {
            if (v0 > (arg6 as u256)) {
                return (0, 7, 0)
            };
            if (v0 < (arg5 as u256)) {
                return (0, 10, 0)
            };
        };
        let v1 = v0 * (arg1 as u256) / (arg0 as u256);
        if (v1 > v0) {
            return (0, 5, 0)
        };
        (((v0 - v1) as u128), 0, 0)
    }

    public fun quote_hawal_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: bool, arg7: u128, arg8: &mut u64) : (u128, u8, u64) {
        if (arg7 == 0) {
            return (0, 0, 0)
        };
        if (arg7 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg8 == 0) {
            return (0, 6, 0)
        };
        *arg8 = *arg8 - 1;
        if (arg6 && arg7 < arg4) {
            return (0, 0, 0)
        };
        let v0 = (arg7 as u256) * (arg3 as u256) / (arg2 as u256);
        if (v0 == 0) {
            return (0, 10, 0)
        };
        if (v0 > (18446744073709551615 as u256)) {
            return (0, 12, 0)
        };
        if (!arg6) {
            if (v0 < (arg4 as u256)) {
                return (0, 10, 0)
            };
            if (v0 > (arg3 as u256) || v0 > (arg5 as u256)) {
                return (0, 7, 0)
            };
        };
        let v1 = v0 * (arg1 as u256) / (arg0 as u256);
        if (v1 > v0) {
            return (0, 5, 0)
        };
        (((v0 - v1) as u128), 0, 0)
    }

    public fun quote_kriya_v2_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: u128, arg10: u128, arg11: &mut u64) : (u128, u8, u64) {
        if (arg10 == 0) {
            return (0, 0, 0)
        };
        if (arg10 > 18446744073709551615) {
            return (0, 5, 0)
        };
        let v0 = arg10 - arg10 * (arg1 as u128) / (arg0 as u128);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        if (!arg7) {
            if (*arg11 == 0) {
                return (0, 6, 0)
            };
            *arg11 = *arg11 - 1;
            let v1 = (v0 as u256) * ((arg2 - arg3) as u256);
            let v2 = (arg4 as u256) * (arg2 as u256) + v1;
            if (v2 == 0) {
                return (0, 5, 0)
            };
            let v3 = v1 * (arg5 as u256) / v2;
            if (v3 > (18446744073709551615 as u256)) {
                return (0, 5, 0)
            };
            return ((v3 as u128), 0, 0)
        };
        let v4 = (arg6 as u256);
        let v5 = (arg8 as u256);
        let v6 = (arg9 as u256);
        let v7 = (arg4 as u256) * v4 / v5;
        let v8 = (arg5 as u256) * v4 / v6;
        let v9 = (v0 as u256) * v4 / v5 * ((arg2 - arg3) as u256) / (arg2 as u256);
        if (v9 > 10000000000000000000 || v7 > 10000000000000000000 - v9) {
            return (0, 5, 0)
        };
        let (v10, v11) = ve33_solve_y(v7 + v9, ve33_invariant(v7, v8), v8, arg11, 1);
        if (v11 != 0) {
            return (0, v11, 0)
        };
        if (v10 > v8) {
            return (0, 5, 0)
        };
        let v12 = (v8 - v10) * v6 / v4;
        if (v12 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v12 as u128), 0, 0)
    }

    public fun quote_lst_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: bool, arg6: u128, arg7: &mut u64) : (u128, u8, u64) {
        if (arg6 == 0) {
            return (0, 0, 0)
        };
        if (arg6 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg7 == 0) {
            return (0, 6, 0)
        };
        *arg7 = *arg7 - 1;
        if (arg6 < arg4) {
            return (0, 0, 0)
        };
        let v0 = (arg0 as u256);
        let v1 = div_ceil((arg6 as u256) * (arg1 as u256), v0);
        let v2 = if (arg5) {
            if (v1 > (arg6 as u256)) {
                return (0, 5, 0)
            };
            ((arg6 as u256) - v1) * (arg3 as u256) / (arg2 as u256)
        } else {
            let v3 = (arg6 as u256) * (arg3 as u256) / (arg2 as u256);
            let v4 = div_ceil(v3 * (arg1 as u256), v0);
            if (v4 > v3) {
                return (0, 5, 0)
            };
            v3 - v4
        };
        if (v2 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v2 as u128), 0, 0)
    }

    public fun quote_stable_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: bool, arg5: u64, arg6: u128, arg7: u128, arg8: u64, arg9: u128, arg10: &mut u64) : (u128, u8, u64) {
        let v0 = 0;
        let v1 = &mut v0;
        quote_stable_with_d(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v1)
    }

    public fun quote_stable_with_d(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: bool, arg5: u64, arg6: u128, arg7: u128, arg8: u64, arg9: u128, arg10: &mut u64, arg11: &mut u128) : (u128, u8, u64) {
        if (arg9 == 0) {
            return (0, 0, 0)
        };
        if (arg9 > 18446744073709551615) {
            return (0, 5, 0)
        };
        let v0 = arg9;
        if (arg4) {
            v0 = stable_fee_remainder(stable_fee_remainder(arg9, arg2), arg8);
        };
        let v1 = stable_fee_remainder(v0, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let v2 = (arg0 as u256) * (arg6 as u256);
        let v3 = (arg1 as u256) * (arg7 as u256);
        let v4 = (v1 as u256) * (arg6 as u256);
        if (v2 + v4 > 1267650600228229401496703205376) {
            return (0, 5, 0)
        };
        let v5 = if (*arg11 > 0) {
            (*arg11 as u256)
        } else {
            let (v6, v7) = stable_compute_d(v2, v3, (arg3 as u256), arg10);
            if (v7 != 0) {
                return (0, v7, 0)
            };
            *arg11 = (v6 as u128);
            v6
        };
        let (v8, v9) = stable_compute_y_seeded(v2 + v4, v5, (arg3 as u256), v3, true, arg10);
        if (v9 != 0) {
            return (0, v9, 0)
        };
        if (v3 <= v8 + 1) {
            return (0, 0, 0)
        };
        let v10 = (v3 - v8 - 1) / (arg7 as u256);
        if (v10 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        let v11 = (v10 as u128);
        let v12 = v11;
        if (!arg4) {
            v12 = stable_fee_remainder(stable_fee_remainder(v11, arg2), arg8);
        };
        (v12, 0, 0)
    }

    public fun quote_steamm_cpmm_hop(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: &mut u64) : (u128, u8, u64) {
        if (arg9 == 0) {
            return (0, 0, 0)
        };
        if (arg9 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg10 == 0) {
            return (0, 6, 0)
        };
        *arg10 = *arg10 - 1;
        let (v0, v1) = steamm_btoken_supplies(arg6);
        let v2 = (arg9 as u256) * (v0 as u256) * 1000000000000000000 / (arg7 as u256);
        if (v2 == 0) {
            return (0, 10, 0)
        };
        if (v2 > (18446744073709551615 as u256)) {
            return (0, 7, 0)
        };
        let v3 = (arg4 as u256) * v2 / ((arg3 as u256) + v2);
        if (v3 == 0) {
            return (0, 10, 0)
        };
        if (v3 > (arg0 as u256)) {
            return (0, 7, 0)
        };
        let v4 = div_ceil(v3 * (arg2 as u256), (arg1 as u256));
        if (v4 >= v3) {
            return (0, 0, 0)
        };
        let v5 = steamm_btoken_burn_amount(v3 - v4, v1);
        if (v5 == 0) {
            let v6 = if (v3 - v4 >= (v1 as u256) || v1 <= 1000) {
                7
            } else {
                10
            };
            return (0, v6, 0)
        };
        let v7 = v5 * (arg8 as u256) / (v1 as u256) * 1000000000000000000;
        if (v7 > (arg5 as u256) || v7 > (18446744073709551615 as u256)) {
            return (0, 7, 0)
        };
        ((v7 as u128), 0, 0)
    }

    public fun quote_steamm_omm_hop(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128, arg8: u64, arg9: u128, arg10: u128, arg11: u128, arg12: &mut u64) : (u128, u8, u64) {
        if (arg11 == 0) {
            return (0, 0, 0)
        };
        if (arg11 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg12 == 0) {
            return (0, 6, 0)
        };
        *arg12 = *arg12 - 1;
        let (v0, v1) = steamm_btoken_supplies(arg7);
        let v2 = (arg11 as u256) * (v0 as u256) * 1000000000000000000 / (arg9 as u256);
        if (v2 == 0) {
            return (0, 10, 0)
        };
        if (v2 > ((18446744073709551615 - (v0 as u128)) as u256)) {
            return (0, 7, 0)
        };
        let v3 = ((arg9 as u256) + (arg11 as u256) * 1000000000000000000) / ((v0 as u256) + v2);
        let v4 = (arg10 as u256) / (v1 as u256);
        if (v3 == 0 || v4 == 0) {
            return (0, 5, 0)
        };
        let (v5, v6) = steamm_decimal_mul(v2 * 1000000000000000000, v3);
        if (!v6) {
            return (0, 5, 0)
        };
        let (v7, v8) = steamm_decimal_mul(v5, (arg3 as u256));
        if (!v8) {
            return (0, 5, 0)
        };
        let (v9, v10) = steamm_decimal_div(v7, (arg0 as u256));
        if (!v10) {
            return (0, 5, 0)
        };
        let (v11, v12) = steamm_decimal_div(v9, v4);
        let v13 = v11;
        if (!v12) {
            return (0, 5, 0)
        };
        let v14 = (arg6 as u8);
        let v15 = (arg8 as u8);
        let v16 = if (v14 >= v15) {
            v14 - v15
        } else {
            v15 - v14
        };
        let v17 = 1;
        let v18 = 0;
        while (v18 < v16) {
            v17 = v17 * 10;
            v18 = v18 + 1;
        };
        if (v14 > v15) {
            v13 = v11 / v17;
        } else if (v15 > v14) {
            if (v11 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v17) {
                return (0, 5, 0)
            };
            v13 = v11 * v17;
        };
        let v19 = v13 / 1000000000000000000;
        if (v19 == 0) {
            return (0, 10, 0)
        };
        if (v19 >= (arg4 as u256) || v19 > (18446744073709551615 as u256)) {
            return (0, 7, 0)
        };
        let v20 = div_ceil(v19 * (arg2 as u256), (arg1 as u256));
        if (v20 >= v19) {
            return (0, 0, 0)
        };
        let v21 = steamm_btoken_burn_amount(v19 - v20, v1);
        if (v21 == 0) {
            let v22 = if (v19 - v20 >= (v1 as u256) || v1 <= 1000) {
                7
            } else {
                10
            };
            return (0, v22, 0)
        };
        let v23 = v21 * (arg10 as u256) / (v1 as u256) * 1000000000000000000;
        if (v23 > (arg5 as u256) || v23 > (18446744073709551615 as u256)) {
            return (0, 7, 0)
        };
        ((v23 as u128), 0, 0)
    }

    public fun quote_steamm_omm_v2_prepared(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u128, arg9: u64, arg10: u128, arg11: u128, arg12: u64, arg13: bool, arg14: bool, arg15: u128, arg16: &mut u64, arg17: &mut u64, arg18: &mut u64, arg19: &mut u128, arg20: &mut u128, arg21: &mut u128) : (u128, u8, u64) {
        if (arg15 == 0) {
            return (0, 0, 0)
        };
        if (arg15 > 18446744073709551615) {
            return (0, 5, 0)
        };
        if (*arg16 == 0) {
            return (0, 6, 0)
        };
        *arg16 = *arg16 - 1;
        let (v0, v1) = steamm_btoken_supplies(arg8);
        let v2 = (arg15 as u256) * (v0 as u256) * 1000000000000000000 / (arg10 as u256);
        if (v2 == 0) {
            return (0, 10, 0)
        };
        if (v2 > (18446744073709551615 as u256) || v2 > ((18446744073709551615 - (v0 as u128)) as u256)) {
            return (0, 12, 0)
        };
        let v3 = ((arg10 as u256) + (arg15 as u256) * 1000000000000000000) / ((v0 as u256) + v2);
        let v4 = if (*arg17 > 0) {
            (*arg17 as u256)
        } else {
            let v5 = (arg11 as u256) / (v1 as u256);
            if (v5 <= (18446744073709551615 as u256)) {
                *arg17 = (v5 as u64);
            };
            v5
        };
        if (v3 == 0 || v4 == 0) {
            return (0, 5, 0)
        };
        let v6 = if (arg13) {
            v3
        } else {
            v4
        };
        let v7 = if (arg13) {
            v4
        } else {
            v3
        };
        let v8 = (arg4 as u256) * v6;
        let v9 = (arg5 as u256) * v7;
        let (v10, v11) = steamm_q_from_decimal(v8);
        let (v12, v13) = steamm_q_from_decimal(v9);
        let (v14, v15) = steamm_q_from_decimal(v2 * v3);
        let (v16, v17) = steamm_effective_amp(arg12, arg14, v8, v9, arg0, arg1, (arg7 as u8), (arg9 as u8));
        if (!v17) {
            return (0, 12, 0)
        };
        let (v18, v19) = steamm_q_from_integer((v16 as u128));
        let v20 = if (!v11) {
            true
        } else if (!v13) {
            true
        } else if (!v15) {
            true
        } else {
            !v19
        };
        if (v20) {
            return (0, 5, 0)
        };
        let (v21, v22, v23) = if (*arg18 == 1) {
            (*arg19, *arg20, *arg21)
        } else {
            let (v24, v25) = steamm_q_from_decimal((arg0 as u256));
            let (v26, v27) = steamm_q_from_decimal((arg1 as u256));
            if (!v25 || !v27) {
                return (0, 5, 0)
            };
            let v28 = (arg7 as u8);
            let v29 = (arg9 as u8);
            let v30 = if (v28 >= v29) {
                v28 - v29
            } else {
                v29 - v28
            };
            let v31 = 1;
            let v32 = 0;
            while (v32 < v30) {
                v31 = v31 * 10;
                v32 = v32 + 1;
            };
            let (v33, v34) = steamm_q_from_integer(v31);
            if (!v34) {
                return (0, 5, 0)
            };
            let v35 = if (v28 >= v29) {
                v33
            } else {
                let (v36, v37) = steamm_q_div(18446744073709551616, v33);
                if (!v37) {
                    return (0, 5, 0)
                };
                v36
            };
            *arg19 = v24;
            *arg20 = v26;
            *arg21 = v35;
            *arg18 = 1;
            (v24, v26, v35)
        };
        let (v38, v39) = if (arg13) {
            steamm_q_multiply_divide(v14, v21, v12, v22, v23, false)
        } else {
            steamm_q_multiply_divide(v14, v23, v22, v10, v21, true)
        };
        if (!v39) {
            return (0, 5, 0)
        };
        let (v40, v41) = steamm_q_newton(v38, v18);
        if (!v41) {
            return (0, 5, 0)
        };
        let v42 = if (arg13) {
            v12
        } else {
            v10
        };
        let (v43, v44) = steamm_q_mul(v40, v42);
        if (!v44) {
            return (0, 5, 0)
        };
        let v45 = ((v43 >> 64) as u256) * 1000000000000000000 / v4;
        let v46 = if (arg13) {
            arg5
        } else {
            arg4
        };
        if (v45 == 0) {
            return (0, 10, 0)
        };
        if (v45 >= (v46 as u256)) {
            return (0, 7, 0)
        };
        let (v47, v48) = steamm_omm_v2_linear_btoken_output(arg0, arg1, arg7, arg9, arg13, v2, v3, v4);
        if (!v48 || v45 > v47) {
            return (0, 12, 0)
        };
        if (v45 == v47) {
            return (0, 10, 0)
        };
        let v49 = div_ceil(v45 * (arg3 as u256), (arg2 as u256));
        if (v49 >= v45) {
            return (0, 10, 0)
        };
        let v50 = steamm_btoken_burn_amount(v45 - v49, v1);
        if (v50 == 0) {
            return (0, 10, 0)
        };
        let v51 = v50 * (arg11 as u256) / (v1 as u256) * 1000000000000000000;
        if (v51 > (18446744073709551615 as u256)) {
            return (0, 12, 0)
        };
        if (v51 > (arg6 as u256)) {
            return (0, 7, 0)
        };
        ((v51 as u128), 0, 0)
    }

    public fun quote_ve33_stable_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: &mut u64) : (u128, u8, u64) {
        if (arg7 == 0) {
            return (0, 0, 0)
        };
        if (arg7 > 18446744073709551615) {
            return (0, 5, 0)
        };
        let v0 = arg7 - arg7 * (arg1 as u128) / (arg0 as u128);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = (arg4 as u256);
        let v2 = (arg2 as u256) * v1 / (arg5 as u256);
        let v3 = (arg3 as u256) * v1 / (arg6 as u256);
        let v4 = (v0 as u256) * v1 / (arg5 as u256);
        if (v4 > 10000000000000000000 || v2 > 10000000000000000000 - v4) {
            return (0, 5, 0)
        };
        let (v5, v6) = ve33_get_y(v2 + v4, ve33_invariant(v2, v3), v3, arg8);
        if (v6 != 0) {
            return (0, v6, 0)
        };
        if (v5 > v3) {
            return (0, 5, 0)
        };
        let v7 = (v3 - v5) * (arg6 as u256) / v1;
        if (v7 > (18446744073709551615 as u256)) {
            return (0, 5, 0)
        };
        ((v7 as u128), 0, 0)
    }

    public fun quote_virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: bool, arg9: u128, arg10: &mut u64) : (u128, u8, u64) {
        if (arg9 == 0) {
            return (0, 0, 0)
        };
        if (*arg10 == 0) {
            return (0, 6, 0)
        };
        *arg10 = *arg10 - 1;
        let v0 = if (arg8) {
            arg2
        } else {
            arg3
        };
        let v1 = if (arg8) {
            arg3
        } else {
            arg2
        };
        let v2 = (arg4 as u256) * (arg5 as u256);
        let v3 = v2 * v2 * (arg6 as u256) / (arg7 as u256);
        let v4 = v2 + (v0 as u256) - (arg4 as u256);
        if (v4 == 0 || v3 == 0) {
            return (0, 5, 0)
        };
        let v5 = (arg9 as u256);
        let v6 = if (arg8) {
            if (v4 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v5) {
                return (0, 5, 0)
            };
            v3 / v4 - v3 / (v4 + v5)
        } else {
            let v7 = v3 / v4;
            if (v7 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v5) {
                return (0, 5, 0)
            };
            let v8 = v3 / (v7 + v5);
            if (v8 >= v4) {
                0
            } else {
                v4 - v8
            }
        };
        let v9 = if (arg8) {
            v1
        } else {
            v0
        };
        if (v6 >= (v9 as u256)) {
            return (0, 7, 0)
        };
        let v10 = v6 - v6 * (arg1 as u256) / (arg0 as u256);
        if (v10 > (340282366920938463463374607431768211455 as u256)) {
            return (0, 5, 0)
        };
        ((v10 as u128), 0, 0)
    }

    public fun saturating_add(arg0: u256, arg1: u256) : u256 {
        if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 + arg1
        }
    }

    public fun saturating_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 * arg1
        }
    }

    public fun search_rejection_code(arg0: u8) : u64 {
        if (arg0 == 10) {
            return 418
        };
        if (arg0 == 7) {
            return 419
        };
        if (arg0 == 11) {
            return 420
        };
        if (arg0 == 12) {
            return 421
        };
        if (arg0 == 8) {
            return 416
        };
        if (arg0 == 9) {
            return 417
        };
        if (arg0 == 6) {
            return 406
        };
        if (arg0 == 5) {
            return 407
        };
        if (arg0 == 3) {
            return 408
        };
        if (arg0 == 4) {
            return 409
        };
        if (arg0 == 2) {
            return 410
        };
        412
    }

    public fun sqrt_down(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1 << ((log2_down(arg0) >> 1) as u8);
        let v1 = v0 + arg0 / v0 >> 1;
        let v2 = v1 + arg0 / v1 >> 1;
        let v3 = v2 + arg0 / v2 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        let v8 = arg0 / v7;
        if (v7 < v8) {
            v7
        } else {
            v8
        }
    }

    public fun stable_abs_diff(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg1 - arg0
        } else {
            arg0 - arg1
        }
    }

    public fun stable_compute_d(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        stable_compute_d_with_limit(arg0, arg1, arg2, arg3, 256)
    }

    public fun stable_compute_d_with_limit(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64, arg4: u64) : (u256, u8) {
        let v0 = arg0 + arg1;
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v1) {
            return (0, 5)
        };
        let v2 = arg2 * 2;
        let v3 = 0;
        while (v3 < arg4) {
            if (*arg3 == 0) {
                return (0, 6)
            };
            *arg3 = *arg3 - 1;
            let v4 = v0;
            let v5 = v0 * v0 / arg0 * 2 * v0 / arg1 * 2;
            let v6 = v0 * (v2 - 1) + v5 * 3;
            if (v6 == 0) {
                return (0, 5)
            };
            let v7 = v0 * (v5 * 2 + v0 * v2) / v6;
            v0 = v7;
            if (stable_abs_diff(v7, v4) <= 1) {
                return (v7, 0)
            };
            v3 = v3 + 1;
        };
        (0, 4)
    }

    public fun stable_compute_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        stable_compute_y_seeded(arg0, arg1, arg2, arg1, false, arg3)
    }

    fun stable_compute_y_seeded(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: bool, arg5: &mut u64) : (u256, u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return (0, 5)
        };
        let v1 = arg2 * 2;
        let v2 = arg1 * arg1 / arg0 * 2 * arg1 / v1 * 2;
        let v3 = arg1 / v1 + arg0;
        let v4 = arg1;
        if (arg4 && arg3 <= 1267650600228229401496703205376) {
            v4 = arg3;
            if (v3 > arg1) {
                let v5 = div_ceil(v2, v3 - arg1);
                if (v5 < arg3) {
                    v4 = v5;
                };
            };
            if (v4 * 2 + v3 <= arg1) {
                v4 = arg1;
            };
        };
        let v6 = 0;
        while (v6 < 256) {
            if (*arg5 == 0) {
                return (0, 6)
            };
            *arg5 = *arg5 - 1;
            let v7 = v4;
            let v8 = v4 * 2 + v3 - arg1;
            if (v8 == 0) {
                return (0, 5)
            };
            let v9 = (v4 * v4 + v2) / v8;
            v4 = v9;
            if (stable_abs_diff(v9, v7) <= 1) {
                return (v9, 0)
            };
            v6 = v6 + 1;
        };
        (0, 4)
    }

    public fun stable_fee_remainder(arg0: u128, arg1: u64) : u128 {
        arg0 - arg0 * (arg1 as u128) / 10000
    }

    public fun steamm_btoken_burn_amount(arg0: u256, arg1: u64) : u256 {
        if (arg1 <= 1000) {
            return 0
        };
        if (arg0 >= (arg1 as u256)) {
            return 0
        };
        if ((arg1 as u256) - arg0 < 1000) {
            (arg1 as u256) - 1000
        } else {
            arg0
        }
    }

    public fun steamm_btoken_supplies(arg0: u128) : (u64, u64) {
        (((arg0 >> 64) as u64), ((arg0 & 18446744073709551615) as u64))
    }

    public fun steamm_decimal_div(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg1 == 0 || arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / 1000000000000000000) {
            return (0, false)
        };
        (arg0 * 1000000000000000000 / arg1, true)
    }

    public fun steamm_decimal_mul(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg1 != 0 && arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            return (0, false)
        };
        (arg0 * arg1 / 1000000000000000000, true)
    }

    public fun steamm_effective_amp(arg0: u64, arg1: bool, arg2: u256, arg3: u256, arg4: u128, arg5: u128, arg6: u8, arg7: u8) : (u64, bool) {
        if (arg0 == 50 || arg0 == 100) {
            return (arg0, true)
        };
        if (arg0 != 20 && arg0 != 30) {
            return (arg0, false)
        };
        if (arg1) {
            return (arg0, true)
        };
        if (arg6 > 18 || arg7 > 18) {
            return (arg0, false)
        };
        let (v0, v1) = steamm_decimal_mul(arg2, (arg4 as u256));
        let (v2, v3) = steamm_decimal_mul(arg3, (arg5 as u256));
        if (!v1 || !v3) {
            return (arg0, false)
        };
        let v4 = v0 / (0x1::u64::pow(10, arg6) as u256);
        let v5 = v2 / (0x1::u64::pow(10, arg7) as u256);
        if (v4 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v5 || v4 + v5 == 0) {
            return (arg0, false)
        };
        let (v6, v7) = steamm_decimal_mul(v4, 100 * 1000000000000000000);
        if (!v7) {
            return (arg0, false)
        };
        let (v8, v9) = steamm_decimal_div(v6, v4 + v5);
        if (!v9) {
            return (arg0, false)
        };
        if (v8 >= 40 * 1000000000000000000 && v8 <= 60 * 1000000000000000000) {
            let v12 = if (arg0 == 20) {
                50
            } else {
                100
            };
            (v12, true)
        } else {
            (arg0, true)
        }
    }

    public fun steamm_omm_state_ok(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u8, arg10: u8, arg11: bool) : bool {
        if (arg11) {
            if (arg0 > 0) {
                if (arg1 < 10000) {
                    if (arg2 > 0) {
                        if (arg3 > 0) {
                            if (arg4 > 0) {
                                if (arg5 > 1000) {
                                    if (arg6 > 0) {
                                        if (arg7 > 0) {
                                            if (arg8 > 0) {
                                                if (arg9 <= 18) {
                                                    arg10 <= 18
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun steamm_omm_v2_linear_btoken_output(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool, arg5: u256, arg6: u256, arg7: u256) : (u256, bool) {
        let v0 = if (arg4) {
            (arg0 as u256)
        } else {
            (arg1 as u256)
        };
        let v1 = if (arg4) {
            (arg1 as u256)
        } else {
            (arg0 as u256)
        };
        let v2 = if (arg4) {
            (arg2 as u8)
        } else {
            (arg3 as u8)
        };
        let v3 = if (arg4) {
            (arg3 as u8)
        } else {
            (arg2 as u8)
        };
        let (v4, v5) = steamm_decimal_mul(arg5 * 1000000000000000000, arg6);
        if (!v5) {
            return (0, false)
        };
        let (v6, v7) = steamm_decimal_mul(v4, v0);
        if (!v7) {
            return (0, false)
        };
        let (v8, v9) = steamm_decimal_div(v6, v1);
        if (!v9) {
            return (0, false)
        };
        let (v10, v11) = steamm_decimal_div(v8, arg7);
        let v12 = v10;
        if (!v11) {
            return (0, false)
        };
        let v13 = if (v2 >= v3) {
            v2 - v3
        } else {
            v3 - v2
        };
        let v14 = 1;
        let v15 = 0;
        while (v15 < v13) {
            v14 = v14 * 10;
            v15 = v15 + 1;
        };
        if (v2 > v3) {
            v12 = v10 / v14;
        } else if (v3 > v2) {
            if (v10 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v14) {
                return (0, false)
            };
            v12 = v10 * v14;
        };
        (v12 / 1000000000000000000, true)
    }

    public fun steamm_omm_v2_state_ok(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u8, arg11: u8, arg12: u64, arg13: bool) : bool {
        if (arg13) {
            if (arg0 > 0) {
                if (arg1 > 0) {
                    if (arg2 < 10000) {
                        if (arg3 > 0) {
                            if (arg4 > 0) {
                                if (arg5 > 0) {
                                    if (arg6 > 1000) {
                                        if (arg7 > 0) {
                                            if (arg8 > 0) {
                                                if (arg9 > 0) {
                                                    if (arg10 <= 18) {
                                                        if (arg11 <= 18) {
                                                            if (arg12 == 20) {
                                                                true
                                                            } else if (arg12 == 30) {
                                                                true
                                                            } else if (arg12 == 50) {
                                                                true
                                                            } else {
                                                                arg12 == 100
                                                            }
                                                        } else {
                                                            false
                                                        }
                                                    } else {
                                                        false
                                                    }
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun steamm_q_compute_f(arg0: u128, arg1: u128, arg2: u128) : (u128, bool, bool) {
        if (arg0 > 18446744073709551616) {
            return (0, false, false)
        };
        let (v0, v1) = steamm_q_mul(arg0, 18446744073709551616 - arg1);
        if (!v1) {
            return (0, false, false)
        };
        let (v2, v3) = steamm_q_ln_plus_64ln2(18446744073709551616 - arg0);
        if (!v3) {
            return (0, false, false)
        };
        let v4 = 818323753292969962240;
        if (v2 > v4) {
            return (0, false, false)
        };
        let (v5, v6) = steamm_q_mul(arg1, v4 - v2);
        if (!v6 || v0 > 340282366920938463463374607431768211455 - v5) {
            return (0, false, false)
        };
        let v7 = v0 + v5;
        if (v7 >= arg2) {
            (v7 - arg2, true, true)
        } else {
            (arg2 - v7, false, true)
        }
    }

    public fun steamm_q_compute_f_prime(arg0: u128, arg1: u128, arg2: u128) : (u128, bool) {
        if (arg0 >= 18446744073709551616) {
            return (0, false)
        };
        let (v0, v1) = steamm_q_mul(arg1, 18446744073709551616 - arg0);
        if (!v1) {
            return (0, false)
        };
        let (v2, v3) = steamm_q_div(18446744073709551616, v0);
        if (!v3 || 18446744073709551616 - arg2 > 340282366920938463463374607431768211455 - v2) {
            return (0, false)
        };
        (18446744073709551616 - arg2 + v2, true)
    }

    public fun steamm_q_div(arg0: u128, arg1: u128) : (u128, bool) {
        if (arg1 == 0) {
            return (0, false)
        };
        if (arg0 == 0) {
            return (0, true)
        };
        let v0 = ((arg0 as u256) << 64) / (arg1 as u256);
        if (v0 == 0 || v0 > (340282366920938463463374607431768211455 as u256)) {
            (0, false)
        } else {
            ((v0 as u128), true)
        }
    }

    public fun steamm_q_floor_log2(arg0: u128) : u8 {
        let v0 = 0;
        let v1 = 64;
        while (v1 > 0) {
            if (arg0 >= 1 << v1) {
                arg0 = arg0 >> v1;
                v0 = v0 + v1;
            };
            v1 = v1 >> 1;
        };
        v0
    }

    public fun steamm_q_from_decimal(arg0: u256) : (u128, bool) {
        if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / (18446744073709551616 as u256)) {
            return (0, false)
        };
        let v0 = arg0 * (18446744073709551616 as u256) / 1000000000000000000;
        if (v0 > (340282366920938463463374607431768211455 as u256) || arg0 != 0 && v0 == 0) {
            (0, false)
        } else {
            ((v0 as u128), true)
        }
    }

    public fun steamm_q_from_integer(arg0: u128) : (u128, bool) {
        if (arg0 > 340282366920938463463374607431768211455 >> 64) {
            (0, false)
        } else {
            (arg0 << 64, true)
        }
    }

    public fun steamm_q_ln_plus_64ln2(arg0: u128) : (u128, bool) {
        if (arg0 == 0) {
            return (0, false)
        };
        let v0 = steamm_q_floor_log2(arg0);
        let v1 = if (arg0 >= 9223372036854775808) {
            arg0 >> v0 - 63
        } else {
            arg0 << 63 - v0
        };
        let v2 = v1;
        let v3 = 0;
        let v4 = 12;
        while (v4 != 0) {
            let v5 = v2 * v2 >> 63;
            let v6 = v5 >> 64;
            let v7 = v5 >> (v6 as u8);
            let v8 = v7 * v7 >> 63;
            let v9 = v8 >> 64;
            let v10 = v8 >> (v9 as u8);
            let v11 = v10 * v10 >> 63;
            let v12 = v11 >> 64;
            let v13 = v11 >> (v12 as u8);
            let v14 = v13 * v13 >> 63;
            let v15 = v14 >> 64;
            v2 = v14 >> (v15 as u8);
            let v16 = (((v3 << 1 | v6) << 1 | v9) << 1 | v12) << 1;
            v3 = v16 | v15;
            v4 = v4 - 1;
        };
        let v17 = ((((v0 as u128) << 64) + (v3 << 16)) as u256) * 12786308645202655660 >> 64;
        if (v17 > (340282366920938463463374607431768211455 as u256)) {
            (0, false)
        } else {
            ((v17 as u128), true)
        }
    }

    fun steamm_q_locator_f(arg0: u128, arg1: u128, arg2: u128) : (u128, bool, bool) {
        if (arg0 >= 18446744073709551616) {
            return (0, false, false)
        };
        let v0 = 12786308645202655660;
        let (v1, v2) = if (arg0 <= 18446744073709551616 / 2) {
            ((arg0 << 64) / (2 * 18446744073709551616 - arg0), 64 * v0)
        } else {
            let v3 = 18446744073709551616 - arg0;
            let v4 = steamm_q_floor_log2(v3);
            let v5 = if (v4 >= 63) {
                v3 >> v4 - 63
            } else {
                v3 << 63 - v4
            };
            ((18446744073709551616 - v5 << 64) / (18446744073709551616 + v5), ((v4 as u128) + 1) * v0)
        };
        let v6 = v1;
        let v7 = v1;
        let v8 = 1;
        while (v8 < 13) {
            v6 = v6 * (v1 * v1 >> 64) >> 64;
            if (v6 == 0) {
                break
            };
            v7 = v7 + v6 / (2 * v8 + 1);
            v8 = v8 + 1;
        };
        let v9 = v2 - 2 * v7;
        if (v9 > 64 * v0) {
            return steamm_q_compute_f(arg0, arg1, arg2)
        };
        let (v10, v11) = steamm_q_mul(arg0, 18446744073709551616 - arg1);
        if (!v11) {
            return (0, false, false)
        };
        let (v12, v13) = steamm_q_mul(arg1, 64 * v0 - v9);
        if (!v13 || v10 > 340282366920938463463374607431768211455 - v12) {
            return (0, false, false)
        };
        let v14 = v10 + v12;
        if (v14 >= arg2) {
            (v14 - arg2, true, true)
        } else {
            (arg2 - v14, false, true)
        }
    }

    fun steamm_q_locator_residual_budget(arg0: u128) : u128 {
        (arg0 * 250000 + 18446744073709551616 - 1) / 18446744073709551616
    }

    public fun steamm_q_mul(arg0: u128, arg1: u128) : (u128, bool) {
        let v0 = (arg0 as u256) * (arg1 as u256) >> 64;
        if (v0 > (340282366920938463463374607431768211455 as u256)) {
            (0, false)
        } else {
            ((v0 as u128), true)
        }
    }

    public fun steamm_q_multiply_divide(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: bool) : (u128, bool) {
        if (arg0 > arg1) {
            let v0 = arg0;
            arg0 = arg1;
            arg1 = v0;
        };
        if (arg3 < arg4) {
            let v1 = arg3;
            arg3 = arg4;
            arg4 = v1;
        };
        if (arg5) {
            if (arg1 > arg2) {
                let v2 = arg1;
                arg1 = arg2;
                arg2 = v2;
            };
            if (arg0 > arg1) {
                let v3 = arg0;
                arg0 = arg1;
                arg1 = v3;
            };
        } else {
            if (arg2 < arg3) {
                let v4 = arg2;
                arg2 = arg3;
                arg3 = v4;
            };
            if (arg3 < arg4) {
                let v5 = arg3;
                arg3 = arg4;
                arg4 = v5;
            };
        };
        let v6 = if (arg5) {
            3
        } else {
            2
        };
        let v7 = if (arg5) {
            2
        } else {
            3
        };
        let v8 = 0;
        let v9 = 0;
        let v10 = 18446744073709551616;
        while (v8 < v6 || v9 < v7) {
            if (v8 < v6) {
                let v11 = if (v8 == 0) {
                    arg0
                } else if (v8 == 1) {
                    arg1
                } else {
                    arg2
                };
                let (v12, v13) = steamm_q_mul(v10, v11);
                if (v13) {
                    v10 = v12;
                    v8 = v8 + 1;
                    continue
                };
            };
            if (v9 == v7) {
                return (0, false)
            };
            let v14 = if (arg5) {
                if (v9 == 0) {
                    arg4
                } else {
                    arg3
                }
            } else if (v9 == 0) {
                arg4
            } else if (v9 == 1) {
                arg3
            } else {
                arg2
            };
            let (v15, v16) = steamm_q_div(v10, v14);
            if (!v16) {
                return (0, false)
            };
            v10 = v15;
            v9 = v9 + 1;
        };
        (v10, true)
    }

    public fun steamm_q_newton(arg0: u128, arg1: u128) : (u128, bool) {
        let (v0, v1) = steamm_q_div(18446744073709551616, arg1);
        if (!v1 || v0 > 18446744073709551616) {
            return (0, false)
        };
        let v2 = 18446744073709551616 / 100000;
        let v3 = 18446744073709551597;
        let v4 = 18446744073709551616 / 100000000000000;
        let v5 = 18446744071864877208;
        let v6 = if (arg0 > v5) {
            v5
        } else {
            arg0
        };
        let v7 = v6;
        let v8 = 0;
        while (v8 < 20) {
            let (v9, v10, v11) = steamm_q_locator_f(v7, v0, arg0);
            let v12 = v10;
            let v13 = v9;
            if (!v11) {
                return (0, false)
            };
            if (v9 < v4) {
                let v14 = steamm_q_locator_residual_budget(v0);
                if (v14 < v4 && v9 < v4 - v14) {
                    return (v7, true)
                };
                let (v15, v16, v17) = steamm_q_compute_f(v7, v0, arg0);
                if (!v17) {
                    return (0, false)
                };
                if (v15 < v4) {
                    return (v7, true)
                };
                v13 = v15;
                v12 = v16;
            };
            let (v18, v19) = steamm_q_compute_f_prime(v7, arg1, v0);
            if (!v19 || v18 < 18446744073709551616 / 10000000000) {
                return (0, false)
            };
            let (v20, v21) = steamm_q_div(v13, v18);
            if (!v21) {
                return (0, false)
            };
            let v22 = if (v20 >= 18446744073709551616) {
                v20 / 2
            } else {
                v20
            };
            let v23 = v12 && v7 > v22 || v7 <= 340282366920938463463374607431768211455 - v22;
            let v24 = if (!v23) {
                0
            } else if (v12) {
                v7 - v22
            } else {
                v7 + v22
            };
            let v25 = v24;
            let v26 = if (!v23) {
                true
            } else if (v24 == 0) {
                true
            } else {
                v24 >= 18446744073709551616
            };
            if (v26) {
                let v27 = v20 / 2;
                let v28 = v12 && v6 > v27 || v6 <= 340282366920938463463374607431768211455 - v27;
                if (!v28) {
                    return (0, false)
                };
                let v29 = if (v12) {
                    v6 - v27
                } else {
                    v6 + v27
                };
                v25 = v29;
                if (v29 < v2) {
                    v25 = v2;
                } else if (v29 > v3) {
                    v25 = v3;
                };
            };
            let v30 = if (v25 >= v6) {
                v25 - v6
            } else {
                v6 - v25
            };
            if (v30 < v4) {
                return (v6, true)
            };
            v7 = v25;
            v8 = v8 + 1;
        };
        (v7, true)
    }

    public fun suiswap_stable_state_status(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: u8) : u8 {
        if (arg10 & 1 != 0) {
            2
        } else {
            let v1 = if (arg0 == 0) {
                true
            } else if (arg1 == 0) {
                true
            } else if (arg2 == 0) {
                true
            } else if (arg3 == 0) {
                true
            } else if (arg4 == 0) {
                true
            } else if (arg4 > 4294967295) {
                true
            } else if (arg8 != 101) {
                true
            } else if (arg9 != 200 && arg9 != 201) {
                true
            } else if ((arg5 as u128) + (arg6 as u128) + (arg7 as u128) >= 10000) {
                true
            } else if ((arg0 as u256) * (arg2 as u256) > 1267650600228229401496703205376) {
                true
            } else {
                (arg1 as u256) * (arg3 as u256) > 1267650600228229401496703205376
            };
            if (v1) {
                5
            } else {
                0
            }
        }
    }

    fun to_u128(arg0: u256) : u128 {
        (arg0 as u128)
    }

    public fun v2_curve_output(arg0: u64, arg1: u64, arg2: bool, arg3: u128, arg4: u128, arg5: u128) : u128 {
        if (arg2) {
            let v1 = if (arg5 > 18446744073709551615) {
                true
            } else if (arg3 > 18446744073709551615) {
                true
            } else {
                arg4 > 18446744073709551615
            };
            if (v1) {
                return 0
            };
            let v2 = (arg5 as u256) * ((arg0 - arg1) as u256);
            let v3 = (arg3 as u256) * (arg0 as u256) + v2;
            if (v3 == 0) {
                return 0
            };
            ((v2 * (arg4 as u256) / v3) as u128)
        } else {
            let v4 = effective_input(arg5, arg1, arg0);
            if (v4 == 0) {
                0
            } else {
                mul_div_down(v4, arg4, arg3 + v4)
            }
        }
    }

    public fun ve33_get_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        ve33_solve_y(arg0, arg1, arg2, arg3, 0)
    }

    public fun ve33_invariant(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * (arg0 * arg0 + arg1 * arg1)
    }

    public fun ve33_solve_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64, arg4: u256) : (u256, u8) {
        let v0 = arg0 * arg0 * arg0;
        let v1 = 0;
        while (v1 < 255) {
            if (*arg3 == 0) {
                return (0, 6)
            };
            *arg3 = *arg3 - 1;
            if (arg0 > 10000000000000000000 || arg2 > 10000000000000000000) {
                return (0, 5)
            };
            let v2 = arg0 * arg2 * arg2;
            let v3 = arg2 * (v2 + v0);
            let v4 = 3 * v2 + v0;
            if (v4 == 0) {
                return (0, 5)
            };
            let v5 = if (v3 < arg1) {
                let v6 = (arg1 - v3) / v4 + 1;
                if (v6 > 10000000000000000000 - arg2) {
                    return (0, 5)
                };
                arg2 = arg2 + v6;
                v6
            } else {
                let v7 = (v3 - arg1) / v4 + arg4;
                if (v7 > arg2) {
                    return (0, 5)
                };
                arg2 = arg2 - v7;
                v7
            };
            if (v5 <= 1) {
                return (arg2, 0)
            };
            v1 = v1 + 1;
        };
        (0, 4)
    }

    public fun ve33_stable_state_status(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool) : u8 {
        let v0 = if (arg2 == 0) {
            0
        } else {
            (arg0 as u256) * (arg4 as u256) / (arg2 as u256)
        };
        let v1 = if (arg3 == 0) {
            0
        } else {
            (arg1 as u256) * (arg4 as u256) / (arg3 as u256)
        };
        if (arg7) {
            2
        } else {
            let v3 = if (arg0 == 0) {
                true
            } else if (arg1 == 0) {
                true
            } else if (arg2 == 0) {
                true
            } else if (arg3 == 0) {
                true
            } else if (arg4 == 0) {
                true
            } else if (arg6 == 0) {
                true
            } else if (arg5 >= arg6) {
                true
            } else if (v0 == 0) {
                true
            } else if (v1 == 0) {
                true
            } else if (v0 > 10000000000000000000) {
                true
            } else {
                v1 > 10000000000000000000
            };
            if (v3) {
                5
            } else {
                0
            }
        }
    }

    public fun virtual_cpmm_state_status(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64) : u8 {
        if (arg8) {
            return 2
        };
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else if (arg6 == 0) {
            true
        } else {
            arg7 >= 1000000
        };
        if (v0) {
            return 5
        };
        let v1 = (arg4 as u256) * (arg6 as u256);
        let v2 = if (v1 == 0) {
            true
        } else if (v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v1) {
            true
        } else {
            v1 * v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / (arg2 as u256)
        };
        if (v2) {
            return 5
        };
        let v3 = (arg0 as u256) * (arg2 as u256);
        let v4 = (arg1 as u256) * (arg3 as u256);
        let v5 = (arg4 as u256) * (arg2 as u256);
        if (v3 + v4 < v5) {
            return 5
        };
        let v6 = (v3 + v4 - v5) / (arg3 as u256);
        let v7 = if (arg5 > 0) {
            if (v6 < (arg5 as u256)) {
                ((arg5 as u256) - v6) * 10000 / (arg5 as u256) > 500
            } else {
                false
            }
        } else {
            false
        };
        if (v7) {
            return 2
        };
        let v8 = if (arg9 >= arg10) {
            arg9 - arg10
        } else {
            0
        };
        let v9 = if (arg11 == 0) {
            true
        } else if (arg10 == 0) {
            true
        } else {
            v8 >= arg11
        };
        if (v9) {
            2
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

