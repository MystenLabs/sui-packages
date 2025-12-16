module 0x92f4cb8739f22c63a82206191aa4aceafe59c083dbc2c27274f55474faaf4eb0::math {
    public fun basis_points(arg0: u128, arg1: u64) : u128 {
        mul_div(arg0, (arg1 as u128), 10000)
    }

    public fun clamp(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        }
    }

    public fun ease_in_quad(arg0: u128, arg1: u128, arg2: u128) : u128 {
        lerp(arg0, arg1, mul_div(arg2, arg2, (1000000000000000000 as u128)))
    }

    public fun ease_out_quad(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = (1000000000000000000 as u128);
        let v1 = if (arg2 > v0) {
            0
        } else {
            v0 - arg2
        };
        lerp(arg0, arg1, v0 - mul_div(v1, v1, v0))
    }

    public fun exp_approx(arg0: u128) : u128 {
        let v0 = (arg0 as u256);
        let v1 = 1000000000000000000;
        if (v0 > v1 * 10) {
            return 340282366920938463463374607431768211455
        };
        let v2 = v0 * v0 / v1 / 2;
        let v3 = v2 * v0 / v1 / 3;
        let v4 = v3 * v0 / v1 / 4;
        let v5 = v4 * v0 / v1 / 5;
        let v6 = v1 + v0 + v2 + v3 + v4 + v5 + v5 * v0 / v1 / 6;
        if (v6 > 340282366920938463463374607431768211455) {
            return 340282366920938463463374607431768211455
        };
        (v6 as u128)
    }

    public fun get_precision() : u128 {
        (1000000000000000000 as u128)
    }

    public fun lerp(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = (1000000000000000000 as u128);
        if (arg2 >= v0) {
            return arg1
        };
        if (arg2 == 0) {
            return arg0
        };
        if (arg1 >= arg0) {
            arg0 + mul_div(arg1 - arg0, arg2, v0)
        } else {
            arg0 - mul_div(arg0 - arg1, arg2, v0)
        }
    }

    public fun linear_integral(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = (1000000000000000000 as u128);
        safe_add(mul_div(arg1, arg0, v0), mul_div(arg2, mul_div(arg0, arg0, v0), v0 * 2))
    }

    public fun linear_price(arg0: u128, arg1: u128, arg2: u128) : u128 {
        safe_add(arg1, mul_div(arg0, arg2, (1000000000000000000 as u128)))
    }

    public fun ln_approx(arg0: u128) : u128 {
        let v0 = (arg0 as u256);
        let v1 = 1000000000000000000;
        if (v0 <= v1) {
            return 0
        };
        let v2 = (v0 - v1) * v1 / (v0 + v1);
        let v3 = v2 * v2 / v1;
        let v4 = v2 * v3 / v1;
        let v5 = v4 * v3 / v1;
        let v6 = (v2 + v4 / 3 + v5 / 5 + v5 * v3 / v1 / 7) * 2;
        if (v6 > 340282366920938463463374607431768211455) {
            return 340282366920938463463374607431768211455
        };
        (v6 as u128)
    }

    public fun max(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 201);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 200);
        (v0 as u128)
    }

    public fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 201);
        let v0 = (arg2 as u256);
        let v1 = ((arg0 as u256) * (arg1 as u256) + v0 - 1) / v0;
        assert!(v1 <= 340282366920938463463374607431768211455, 200);
        (v1 as u128)
    }

    public fun percentage(arg0: u128, arg1: u64) : u128 {
        mul_div(arg0, (arg1 as u128), 10000)
    }

    public fun pow(arg0: u128, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 1
        };
        let v0 = 1;
        let v1 = (arg0 as u256);
        let v2 = arg1;
        while (v2 > 0) {
            if (v2 & 1 == 1) {
                let v3 = v0 * v1;
                v0 = v3;
                assert!(v3 <= 340282366920938463463374607431768211455, 200);
            };
            v2 = v2 >> 1;
            if (v2 > 0) {
                v1 = v1 * v1;
            };
        };
        (v0 as u128)
    }

    public fun quadratic_price(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = (1000000000000000000 as u128);
        safe_add(arg1, mul_div(mul_div(arg0, arg0, v0), arg2, v0))
    }

    public fun safe_add(arg0: u128, arg1: u128) : u128 {
        let v0 = (arg0 as u256) + (arg1 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 200);
        (v0 as u128)
    }

    public fun safe_div(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 > 0, 201);
        arg0 / arg1
    }

    public fun safe_mul(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    public fun safe_sub(arg0: u128, arg1: u128) : u128 {
        if (arg1 > arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    public fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun sqrt_precision(arg0: u128) : u128 {
        let v0 = (arg0 as u256) * 1000000000000000000;
        if (v0 == 0) {
            return 0
        };
        let v1 = (v0 + 1) / 2;
        while (v1 < v0) {
            let v2 = v0 / v1 + v1;
            v1 = v2 / 2;
        };
        (v0 as u128)
    }

    public fun tokens_for_sui_linear(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        let v0 = linear_price(arg0, arg2, arg3);
        if (v0 == 0) {
            return 0
        };
        mul_div(arg1, (1000000000000000000 as u128), v0)
    }

    // decompiled from Move bytecode v6
}

