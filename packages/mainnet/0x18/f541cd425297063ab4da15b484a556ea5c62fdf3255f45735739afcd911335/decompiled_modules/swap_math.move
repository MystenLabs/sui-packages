module 0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::swap_math {
    public fun compute_swap_step(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool) : (u128, u64, u64, u64) {
        let v0 = arg0 >= arg1;
        let v1 = 0;
        let v2 = 0;
        let v3 = if (arg5) {
            let v4 = 0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::full_math_u64::mul_div_floor(arg3, 0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::constants::fee_rate_denominator() - arg4, 0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::constants::fee_rate_denominator());
            let v5 = if (v0) {
                0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::sqrt_price_math::get_amount_x_delta(arg1, arg0, arg2, true)
            } else {
                0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::sqrt_price_math::get_amount_y_delta(arg0, arg1, arg2, true)
            };
            v1 = v5;
            if (v4 >= v5) {
                arg1
            } else {
                0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::sqrt_price_math::get_next_sqrt_price_from_input(arg0, arg2, v4, v0)
            }
        } else {
            let v6 = if (v0) {
                0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::sqrt_price_math::get_amount_y_delta(arg1, arg0, arg2, false)
            } else {
                0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::sqrt_price_math::get_amount_x_delta(arg0, arg1, arg2, false)
            };
            v2 = v6;
            if (arg3 >= v6) {
                arg1
            } else {
                0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::sqrt_price_math::get_next_sqrt_price_from_output(arg0, arg2, arg3, v0)
            }
        };
        let v7 = arg1 == v3;
        if (v0) {
            let v8 = if (v7 && arg5) {
                v1
            } else {
                0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::sqrt_price_math::get_amount_x_delta(v3, arg0, arg2, true)
            };
            v1 = v8;
            let v9 = if (v7 && !arg5) {
                v2
            } else {
                0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::sqrt_price_math::get_amount_y_delta(v3, arg0, arg2, false)
            };
            v2 = v9;
        } else {
            let v10 = if (v7 && arg5) {
                v1
            } else {
                0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::sqrt_price_math::get_amount_y_delta(arg0, v3, arg2, true)
            };
            v1 = v10;
            let v11 = if (v7 && !arg5) {
                v2
            } else {
                0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::sqrt_price_math::get_amount_x_delta(arg0, v3, arg2, false)
            };
            v2 = v11;
        };
        if (!arg5 && v2 > arg3) {
            v2 = arg3;
        };
        let v12 = if (arg5 && v3 != arg1) {
            arg3 - v1
        } else {
            0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::full_math_u64::mul_div_round(v1, arg4, 0x18f541cd425297063ab4da15b484a556ea5c62fdf3255f45735739afcd911335::constants::fee_rate_denominator() - arg4)
        };
        (v3, v1, v2, v12)
    }

    // decompiled from Move bytecode v6
}

