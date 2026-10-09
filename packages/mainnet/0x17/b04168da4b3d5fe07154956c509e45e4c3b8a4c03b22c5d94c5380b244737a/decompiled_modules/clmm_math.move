module 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math {
    public fun amount_x_delta(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u256 {
        let (v0, v1) = ordered(arg0, arg1);
        assert_prices(v0, v1);
        let (v2, v3) = shl64_div((arg2 as u256) * ((v1 - v0) as u256), (v0 as u256) * (v1 as u256));
        if (arg3 && !v3) {
            v2 + 1
        } else {
            v2
        }
    }

    public fun amount_y_delta(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u256 {
        let (v0, v1) = ordered(arg0, arg1);
        assert_prices(v0, v1);
        let v2 = (arg2 as u256) * ((v1 - v0) as u256);
        if (arg3 && v2 & 18446744073709551615 != 0) {
            (v2 >> 64) + 1
        } else {
            v2 >> 64
        }
    }

    public fun amounts_for_liquidity(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: bool) : (u256, u256) {
        assert!(arg1 < arg2, 1);
        if (arg0 <= arg1) {
            (amount_x_delta(arg1, arg2, arg3, arg4), 0)
        } else if (arg0 < arg2) {
            (amount_x_delta(arg0, arg2, arg3, arg4), amount_y_delta(arg1, arg0, arg3, arg4))
        } else {
            (0, amount_y_delta(arg1, arg2, arg3, arg4))
        }
    }

    fun assert_prices(arg0: u128, arg1: u128) {
        let v0 = if (arg0 >= 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::min_sqrt_price()) {
            if (arg1 <= 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::max_sqrt_price()) {
                arg0 <= arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    public fun basis() : u64 {
        10000
    }

    public fun fee_precision() : u64 {
        1000000
    }

    public fun fees_earned(arg0: u128, arg1: u256) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        if (arg1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / (arg0 as u256)) {
            return (18446744073709551615 as u64)
        };
        let v0 = (arg0 as u256) * arg1 >> 128;
        let v1 = if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            v0
        };
        (v1 as u64)
    }

    public fun liquidity_for_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        assert!(arg1 < arg2, 1);
        let v0 = if (arg0 <= arg1) {
            liquidity_for_x(arg1, arg2, arg3)
        } else if (arg0 < arg2) {
            let v1 = liquidity_for_x(arg0, arg2, arg3);
            let v2 = liquidity_for_y(arg1, arg0, arg4);
            if (v1 < v2) {
                v1
            } else {
                v2
            }
        } else {
            liquidity_for_y(arg1, arg2, arg4)
        };
        let v3 = if (v0 > 340282366920938463463374607431768211455) {
            340282366920938463463374607431768211455
        } else {
            v0
        };
        (v3 as u128)
    }

    public fun liquidity_for_x(arg0: u128, arg1: u128, arg2: u64) : u256 {
        let (v0, v1) = ordered(arg0, arg1);
        assert_prices(v0, v1);
        assert!(v0 < v1, 1);
        (arg2 as u256) * (v0 as u256) * (v1 as u256) / (((v1 - v0) as u256) << 64)
    }

    public fun liquidity_for_y(arg0: u128, arg1: u128, arg2: u64) : u256 {
        let (v0, v1) = ordered(arg0, arg1);
        assert_prices(v0, v1);
        assert!(v0 < v1, 1);
        ((arg2 as u256) << 64) / ((v1 - v0) as u256)
    }

    public fun max_fee_rate() : u64 {
        100000
    }

    public fun next_sqrt_price_from_x(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        assert!(arg1 > 0, 3);
        if (arg2 == 0) {
            return arg0
        };
        let v0 = (arg1 as u256) << 64;
        let v1 = (arg2 as u256) * (arg0 as u256);
        let v2 = if (arg3) {
            v0 + v1
        } else {
            assert!(v0 > v1, 2);
            v0 - v1
        };
        let (v3, v4) = shl64_div((arg1 as u256) * (arg0 as u256), v2);
        let v5 = if (v4) {
            v3
        } else {
            v3 + 1
        };
        assert!(v5 <= (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::max_sqrt_price() as u256), 1);
        (v5 as u128)
    }

    public fun next_sqrt_price_from_y(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        assert!(arg1 > 0, 3);
        if (arg3) {
            let v1 = (arg0 as u256) + ((arg2 as u256) << 64) / (arg1 as u256);
            assert!(v1 <= (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::max_sqrt_price() as u256), 1);
            (v1 as u128)
        } else {
            let v2 = 0x1::u256::div_ceil((arg2 as u256) << 64, (arg1 as u256));
            assert!((arg0 as u256) > v2, 2);
            (((arg0 as u256) - v2) as u128)
        }
    }

    fun ordered(arg0: u128, arg1: u128) : (u128, u128) {
        if (arg0 <= arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        }
    }

    public fun protocol_part(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun shl64_div(arg0: u256, arg1: u256) : (u256, bool) {
        assert!(arg1 > 0 && arg1 < 26959946667150639794667015087019630673637144422540572481103610249216, 1);
        let v0 = arg0 / arg1;
        let v1 = arg0 % arg1;
        let v2 = 0;
        while (v2 < 2) {
            assert!(v0 < 26959946667150639794667015087019630673637144422540572481103610249216, 2);
            let v3 = v1 << 32;
            let v4 = v0 << 32;
            v0 = v4 + v3 / arg1;
            v1 = v3 % arg1;
            v2 = v2 + 1;
        };
        (v0, v1 == 0)
    }

    public fun swap_step(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool) : (u128, u64, u64, u64) {
        assert!(arg4 <= 100000, 4);
        let v0 = arg1 <= arg0;
        if (arg2 == 0) {
            return (arg1, 0, 0, 0)
        };
        let v1 = ((1000000 - arg4) as u256);
        if (arg5) {
            let v6 = (arg3 as u256) * v1 / (1000000 as u256);
            let v7 = if (v0) {
                amount_x_delta(arg1, arg0, arg2, true)
            } else {
                amount_y_delta(arg0, arg1, arg2, true)
            };
            let (v8, v9, v10) = if (v6 >= v7) {
                (arg1, v7, 0x1::u256::div_ceil(v7 * (arg4 as u256), v1))
            } else {
                let v11 = if (v0) {
                    next_sqrt_price_from_x(arg0, arg2, (v6 as u64), true)
                } else {
                    next_sqrt_price_from_y(arg0, arg2, (v6 as u64), true)
                };
                let v12 = if (v0) {
                    amount_x_delta(v11, arg0, arg2, true)
                } else {
                    amount_y_delta(arg0, v11, arg2, true)
                };
                (v11, v12, (arg3 as u256) - v12)
            };
            let v13 = if (v0) {
                amount_y_delta(v8, arg0, arg2, false)
            } else {
                amount_x_delta(arg0, v8, arg2, false)
            };
            (v8, to_u64(v9), to_u64(v13), to_u64(v10))
        } else {
            let v14 = if (v0) {
                amount_y_delta(arg1, arg0, arg2, false)
            } else {
                amount_x_delta(arg0, arg1, arg2, false)
            };
            let (v15, v16) = if ((arg3 as u256) >= v14) {
                (arg1, v14)
            } else {
                let v17 = if (v0) {
                    next_sqrt_price_from_y(arg0, arg2, arg3, false)
                } else {
                    next_sqrt_price_from_x(arg0, arg2, arg3, false)
                };
                let v18 = if (v0) {
                    if (v17 < arg1) {
                        arg1
                    } else {
                        v17
                    }
                } else if (v17 > arg1) {
                    arg1
                } else {
                    v17
                };
                (v18, (arg3 as u256))
            };
            let v19 = if (v0) {
                amount_x_delta(v15, arg0, arg2, true)
            } else {
                amount_y_delta(arg0, v15, arg2, true)
            };
            (v15, to_u64(v19), to_u64(v16), to_u64(0x1::u256::div_ceil(v19 * (arg4 as u256), v1)))
        }
    }

    public fun to_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 2);
        (arg0 as u64)
    }

    public fun wrapping_sub(arg0: u256, arg1: u256) : u256 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1 + arg0 + 1
        }
    }

    // decompiled from Move bytecode v7
}

