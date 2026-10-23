module 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::model_math {
    public fun a6(arg0: u8) : u8 {
        if (arg0 == 1) {
            10
        } else if (arg0 == 5) {
            12
        } else {
            arg0
        }
    }

    public fun cap_curvature_linear() : u256 {
        0
    }

    public fun cap_curvature_orderbook() : u256 {
        0
    }

    public fun cap_curvature_v2(arg0: u128, arg1: u256) : u256 {
        arg1 / (arg0 as u256)
    }

    public fun cap_curvature_v3(arg0: u128, arg1: u128, arg2: bool, arg3: u256) : u256 {
        if (arg2) {
            arg3 * (arg1 as u256) / q64() / (arg0 as u256)
        } else {
            arg3 * q64() / (arg1 as u256) / (arg0 as u256)
        }
    }

    public fun cap_marginal_v2(arg0: u128, arg1: u128) : u256 {
        (arg1 as u256) * q64() / (arg0 as u256)
    }

    public fun cap_marginal_v3(arg0: u128, arg1: bool) : u256 {
        let v0 = (arg0 as u256);
        if (arg1) {
            v0 * v0 / q64()
        } else {
            q64() * q64() * q64() / v0 * v0
        }
    }

    public fun cap_segment_quote_v2(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: u128) : u128 {
        effective_output(0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::v2_curve_output(arg0, arg1, arg4, arg5, arg6, arg7), arg3, arg2)
    }

    public fun cap_upper_v2(arg0: u128, arg1: u128) : u256 {
        div_ceil((arg1 as u256) * q64(), (arg0 as u256))
    }

    public fun div_ceil(arg0: u256, arg1: u256) : u256 {
        if (arg0 % arg1 == 0) {
            arg0 / arg1
        } else {
            arg0 / arg1 + 1
        }
    }

    public fun effective_output(arg0: u128, arg1: u64, arg2: u64) : u128 {
        if (arg1 == 0) {
            arg0
        } else {
            mul_div_down(arg0, ((arg2 - arg1) as u128), (arg2 as u128))
        }
    }

    public fun h6(arg0: u128, arg1: bool) : u256 {
        if (arg1) {
            (arg0 as u256) * (arg0 as u256) / q64()
        } else {
            q64() * q64() / (arg0 as u256) * q64() / (arg0 as u256)
        }
    }

    public fun model_effective_input(arg0: u128, arg1: u64, arg2: u64) : u128 {
        mul_div_down(arg0, ((arg2 - arg1) as u128), (arg2 as u128))
    }

    public fun model_nq(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / 1000000000) as u128)
    }

    public fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun mul_fraction_ceil(arg0: u256, arg1: u256, arg2: u256) : u256 {
        arg0 / arg2 * arg1 + div_ceil(arg0 % arg2 * arg1, arg2)
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

    public fun prepared_auxiliary_fee(arg0: &vector<u64>, arg1: u128) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::numeric::saturating_add(v0, (arg1 as u256) * (*0x1::vector::borrow<u64>(arg0, v1) as u256) / (*0x1::vector::borrow<u64>(arg0, v1 + 1) as u256));
            v1 = v1 + 2;
        };
        v0
    }

    public fun q64() : u256 {
        (18446744073709551616 as u256)
    }

    public fun round_down_to_quantum(arg0: u128, arg1: u128) : u128 {
        arg0 - arg0 % arg1
    }

    public fun round_up_to_quantum(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            0
        } else {
            arg0 + (arg1 - arg0 % arg1) % arg1
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

    public fun to_u128(arg0: u256) : u128 {
        (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

