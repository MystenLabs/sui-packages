module 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::fixed {
    public fun close_enough(arg0: u256, arg1: u256, arg2: u256) : bool {
        if (arg0 < arg1) {
            return close_enough(arg1, arg0, arg2)
        };
        arg0 > 115792089237316195423570985008687907853269984665640564039457 && arg0 - arg1 <= arg0 / 1000000000000000000 * arg2 || (arg0 - arg1) * 1000000000000000000 <= arg0 * arg2
    }

    public fun close_enough_128(arg0: u128, arg1: u128, arg2: u256) : bool {
        close_enough((arg0 as u256), (arg1 as u256), arg2)
    }

    public fun close_enough_and_compare(arg0: u256, arg1: u256, arg2: u256, arg3: bool) : bool {
        close_enough(arg0, arg1, arg2) && (arg3 && arg0 <= arg1 || arg0 >= arg1)
    }

    public fun close_enough_int(arg0: u64, arg1: u64, arg2: u256) : bool {
        close_enough(convert_int_to_fixed(arg0), convert_int_to_fixed(arg1), arg2)
    }

    public fun complement(arg0: u256) : u256 {
        if (arg0 < 1000000000000000000) {
            1000000000000000000 - arg0
        } else {
            0
        }
    }

    public fun complement128(arg0: u128) : u128 {
        if (arg0 < 1000000000000000000) {
            1000000000000000000 - arg0
        } else {
            0
        }
    }

    public fun complement64(arg0: u64) : u64 {
        if (arg0 < 1000000000000000000) {
            1000000000000000000 - arg0
        } else {
            0
        }
    }

    public fun convert_balance9_to_fixed(arg0: u64) : u256 {
        (arg0 as u256) * 1000000000
    }

    public fun convert_fixed_to_balance9(arg0: u256) : u64 {
        ((arg0 / 1000000000) as u64)
    }

    public fun convert_fixed_to_int(arg0: u256) : u64 {
        ((arg0 / 1000000000000000000) as u64)
    }

    public fun convert_fixed_to_int_128(arg0: u128) : u64 {
        ((arg0 / 1000000000000000000) as u64)
    }

    public fun convert_int_to_fixed(arg0: u64) : u256 {
        (arg0 as u256) * 1000000000000000000
    }

    public fun convert_int_to_fixed_128(arg0: u64) : u128 {
        (arg0 as u128) * 1000000000000000000
    }

    public fun div_by_fraction(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 1000000000000000000 / (arg1 as u128)) as u64)
    }

    public fun div_by_fraction_128_64(arg0: u128, arg1: u64) : u128 {
        (((arg0 as u256) * 1000000000000000000 / (arg1 as u256)) as u128)
    }

    public fun div_by_fraction_64_128(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * 1000000000000000000 / arg1) as u64)
    }

    public fun div_down(arg0: u256, arg1: u256) : u256 {
        arg0 * 1000000000000000000 / arg1
    }

    public fun div_down_128(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * 1000000000000000000 / (arg1 as u256)) as u128)
    }

    public fun div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        (arg0 * 1000000000000000000 - 1) / arg1 + 1
    }

    public fun div_up_by_fraction(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        ((((arg0 as u128) * 1000000000000000000 - 1) / (arg1 as u128)) as u64) + 1
    }

    public fun div_up_by_fraction_64_128(arg0: u64, arg1: u128) : u64 {
        if (arg0 == 0) {
            return 0
        };
        ((((arg0 as u128) * 1000000000000000000 - 1) / arg1) as u64) + 1
    }

    public fun div_up_unfixed(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            1 + (arg0 - 1) / arg1
        }
    }

    public fun exp(arg0: u256) : u256 {
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::log_exp::exp(arg0)
    }

    public fun exp_up(arg0: u256) : u256 {
        pow_up(2718281828459045235, arg0)
    }

    public fun int_exp(arg0: u256, arg1: u64) : u256 {
        let v0 = 1;
        loop {
            if (arg1 & 1 != 0) {
                v0 = mul_down(arg0, v0);
            };
            arg1 = arg1 >> 1;
            if (arg1 == 0) {
                break
            };
            arg0 = arg0 * arg0;
        };
        v0
    }

    public fun ln(arg0: u256) : u256 {
        0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::log_exp::ln(arg0)
    }

    public fun mul_by_fraction(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    public fun mul_by_fraction_128_64(arg0: u128, arg1: u64) : u128 {
        (((arg0 as u256) * (arg1 as u256) / 1000000000000000000) as u128)
    }

    public fun mul_by_fraction_64_128(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 1000000000000000000) as u64)
    }

    public fun mul_down(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000000000000
    }

    public fun mul_down_128(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / 1000000000000000000) as u128)
    }

    public fun mul_up(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 * arg1;
        if (v0 == 0) {
            return v0
        };
        (v0 - 1) / 1000000000000000000 + 1
    }

    public fun pow_down(arg0: u256, arg1: u256) : u256 {
        if (arg1 == 1000000000000000000) {
            arg0
        } else if (arg1 == 2000000000000000000) {
            mul_down(arg0, arg0)
        } else if (arg1 == 4000000000000000000) {
            let v1 = mul_down(arg0, arg0);
            mul_down(v1, v1)
        } else {
            let v2 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::log_exp::pow(arg0, arg1);
            let v3 = mul_up(v2, 10000) + 1;
            if (v2 < v3) {
                0
            } else {
                v2 - v3
            }
        }
    }

    public fun pow_up(arg0: u256, arg1: u256) : u256 {
        if (arg1 == 1000000000000000000) {
            arg0
        } else if (arg1 == 2000000000000000000) {
            mul_up(arg0, arg0)
        } else if (arg1 == 4000000000000000000) {
            let v1 = mul_up(arg0, arg0);
            mul_up(v1, v1)
        } else {
            let v2 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::log_exp::pow(arg0, arg1);
            v2 + mul_up(v2, 10000) + 1
        }
    }

    public fun rel_err(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            rel_err(arg1, arg0)
        } else {
            div_down(arg0 - arg1, arg0)
        }
    }

    public fun rel_err_128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            rel_err_128(arg1, arg0)
        } else {
            div_down_128(arg0 - arg1, arg0)
        }
    }

    public fun rel_err_int(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            rel_err_int(arg1, arg0)
        } else {
            div_by_fraction(arg0 - arg1, arg0)
        }
    }

    public fun sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 < 1000000000000000000) {
            return div_down(1000000000000000000, sqrt(div_down(1000000000000000000, arg0)))
        };
        let v0 = 0xaca10f85b508736ebce633d33581b0c511cc1b098283dbd2a4c359cab8e66a84::numerical::sqrt_estimate_256(arg0) * 1000000000 + 1;
        let v1 = v0 + div_down(arg0, v0) >> 1;
        while (v1 < v0) {
            let v2 = v1 + div_down(arg0, v1);
            v1 = v2 >> 1;
        };
        v0
    }

    public fun very_close_int(arg0: u64, arg1: u64) : bool {
        arg0 < arg1 && very_close_int(arg1, arg0) || arg0 - arg1 <= 1
    }

    public fun very_close_int_128(arg0: u128, arg1: u128) : bool {
        arg0 < arg1 && very_close_int_128(arg1, arg0) || arg0 - arg1 <= 1
    }

    public fun very_close_int_256(arg0: u256, arg1: u256) : bool {
        arg0 < arg1 && very_close_int_256(arg1, arg0) || arg0 - arg1 <= 1
    }

    // decompiled from Move bytecode v6
}

