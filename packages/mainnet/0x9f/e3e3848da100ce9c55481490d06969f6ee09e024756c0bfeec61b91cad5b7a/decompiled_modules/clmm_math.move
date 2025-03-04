module 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::clmm_math {
    public fun compute_swap_step(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool, arg6: bool) : (u64, u64, u128, u64) {
        if (arg2 == 0) {
            return (0, 0, arg1, 0)
        };
        if (arg5) {
            assert!(arg0 >= arg1, 4);
        } else {
            assert!(arg0 < arg1, 4);
        };
        let (v0, v1, v2, v3) = if (arg6) {
            let v4 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u64::mul_div_floor(arg3, 1000000 - arg4, 1000000);
            let v5 = v4;
            if (arg4 > 0 && v4 == arg3) {
                v5 = v4 - 1;
            };
            let v6 = get_delta_up_from_input(arg0, arg1, arg2, arg5);
            let (v7, v8, v9) = if (v6 > (v5 as u256)) {
                (v5, arg3 - v5, get_next_sqrt_price_from_input(arg0, arg2, v5, arg5))
            } else {
                ((v6 as u64), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u64::mul_div_ceil((v6 as u64), arg4, 1000000 - arg4), arg1)
            };
            (v8, v9, v7, (get_delta_down_from_output(arg0, v9, arg2, arg5) as u64))
        } else {
            let v10 = get_delta_down_from_output(arg0, arg1, arg2, arg5);
            let (v11, v12) = if (v10 > (arg3 as u256)) {
                (arg3, get_next_sqrt_price_from_output(arg0, arg2, arg3, arg5))
            } else {
                ((v10 as u64), arg1)
            };
            let v13 = (get_delta_up_from_input(arg0, v12, arg2, arg5) as u64);
            let v14 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u64::mul_div_ceil(v13, arg4, 1000000 - arg4);
            let v15 = v14;
            if (arg4 > 0 && v14 == 0) {
                v15 = 1;
            };
            (v15, v12, v13, v11)
        };
        (v2, v3, v1, v0)
    }

    public fun fee_rate_denominator() : u64 {
        1000000
    }

    public fun get_amount_by_liquidity(arg0: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg1: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg2: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg3: u128, arg4: u128, arg5: bool) : (u64, u64) {
        if (arg4 == 0) {
            return (0, 0)
        };
        if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::lt(arg2, arg0)) {
            (get_delta_a(0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg0), 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5), 0)
        } else if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::lt(arg2, arg1)) {
            (get_delta_a(arg3, 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5), get_delta_b(0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg0), arg3, arg4, arg5))
        } else {
            (0, get_delta_b(0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg0), 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg1), arg4, arg5))
        }
    }

    public fun get_delta_a(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        let (v1, v2) = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u256::checked_shlw(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg2, v0));
        if (v2) {
            abort 2
        };
        (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u256::div_round(v1, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg0, arg1), arg3) as u64)
    }

    public fun get_delta_b(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        let v1 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg2, v0);
        if (arg3 && v1 & 18446744073709551615 > 0) {
            return (((v1 >> 64) + 1) as u64)
        };
        ((v1 >> 64) as u64)
    }

    public fun get_delta_down_from_output(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u256 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        if (arg3) {
            0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg2, v0) >> 64
        } else {
            let (v2, v3) = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u256::checked_shlw(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg2, v0));
            if (v3) {
                abort 2
            };
            0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u256::div_round(v2, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg0, arg1), false)
        }
    }

    public fun get_delta_up_from_input(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u256 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        if (arg3) {
            let (v2, v3) = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u256::checked_shlw(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg2, v0));
            if (v3) {
                abort 2
            };
            0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u256::div_round(v2, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg0, arg1), true)
        } else {
            let v4 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg2, v0);
            if (v4 & 18446744073709551615 > 0) {
                (v4 >> 64) + 1
            } else {
                v4 >> 64
            }
        }
    }

    public fun get_liquidity_by_amount(arg0: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg1: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg2: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg3: u128, arg4: u64, arg5: bool) : (u128, u64, u64) {
        if (arg5) {
            let (v3, v4) = if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::lt(arg2, arg0)) {
                (get_liquidity_from_a(0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg0), 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg1), arg4, false), 0)
            } else {
                assert!(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::lt(arg2, arg1), 3018);
                let v5 = get_liquidity_from_a(arg3, 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg1), arg4, false);
                (v5, get_delta_b(arg3, 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg0), v5, true))
            };
            (v3, arg4, v4)
        } else {
            let (v6, v7) = if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::gte(arg2, arg1)) {
                (get_liquidity_from_b(0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg0), 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg1), arg4, false), 0)
            } else {
                assert!(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::gte(arg2, arg0), 3018);
                let v8 = get_liquidity_from_b(0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg0), arg3, arg4, false);
                (v8, get_delta_a(arg3, 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::get_sqrt_price_at_tick(arg1), v8, true))
            };
            (v6, v7, arg4)
        }
    }

    public fun get_liquidity_from_a(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u256::div_round((0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg0, arg1) >> 64) * (arg2 as u256), (v0 as u256), arg3) as u128)
    }

    public fun get_liquidity_from_b(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u256::div_round((arg2 as u256) << 64, (v0 as u256), arg3) as u128)
    }

    public fun get_next_sqrt_price_a_up(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        if (arg2 == 0) {
            return arg0
        };
        let (v0, v1) = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u256::checked_shlw(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg0, arg1));
        if (v1) {
            abort 2
        };
        let v2 = if (arg3) {
            (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u256::div_round(v0, ((arg1 as u256) << 64) + 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg0, (arg2 as u128)), true) as u128)
        } else {
            (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u256::div_round(v0, ((arg1 as u256) << 64) - 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::full_math_u128::full_mul(arg0, (arg2 as u128)), true) as u128)
        };
        if (v2 > 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::max_sqrt_price()) {
            abort 0
        };
        if (v2 < 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::min_sqrt_price()) {
            abort 1
        };
        v2
    }

    public fun get_next_sqrt_price_b_down(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        let v0 = if (arg3) {
            arg0 + 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u128::checked_div_round((arg2 as u128) << 64, arg1, !arg3)
        } else {
            arg0 - 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::math_u128::checked_div_round((arg2 as u128) << 64, arg1, !arg3)
        };
        if (v0 > 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::max_sqrt_price()) {
            abort 0
        };
        if (v0 < 0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::tick_math::min_sqrt_price()) {
            abort 1
        };
        v0
    }

    public fun get_next_sqrt_price_from_input(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        if (arg3) {
            get_next_sqrt_price_a_up(arg0, arg1, arg2, true)
        } else {
            get_next_sqrt_price_b_down(arg0, arg1, arg2, true)
        }
    }

    public fun get_next_sqrt_price_from_output(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        if (arg3) {
            get_next_sqrt_price_b_down(arg0, arg1, arg2, false)
        } else {
            get_next_sqrt_price_a_up(arg0, arg1, arg2, false)
        }
    }

    // decompiled from Move bytecode v6
}

