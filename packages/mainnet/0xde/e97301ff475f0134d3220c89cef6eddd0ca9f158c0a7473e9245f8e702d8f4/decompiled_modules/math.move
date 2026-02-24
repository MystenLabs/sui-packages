module 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::math {
    public fun basis_points_scale() : u64 {
        10000
    }

    public fun lerp(arg0: u128, arg1: u128, arg2: u64) : u128 {
        arg0 + mul_div(arg1, (arg2 as u128), (10000 as u128))
    }

    public fun ln_2() : u128 {
        693147180559945309
    }

    public fun ln_wei() : u128 {
        41446531673892822312
    }

    public fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div_down(arg0, arg1, arg2)
    }

    public fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg2 == 0) {
            abort 0
        };
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        if (v0 > (340282366920938463463374607431768211455 as u256)) {
            abort 1
        };
        (v0 as u128)
    }

    public fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg2 == 0) {
            abort 0
        };
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (arg1 as u256);
        let v1 = (arg2 as u256);
        let v2 = v0 / v1;
        let v3 = v2;
        if (v0 % v1 > 0) {
            v3 = v2 + 1;
        };
        if (v3 > (340282366920938463463374607431768211455 as u256)) {
            abort 1
        };
        (v3 as u128)
    }

    public fun to_assets_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div_down(arg0, arg1 + 1, arg2 + 1000000)
    }

    public fun to_assets_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div_up(arg0, arg1 + 1, arg2 + 1000000)
    }

    public fun to_shares_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div_down(arg0, arg2 + 1000000, arg1 + 1)
    }

    public fun to_shares_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        mul_div_up(arg0, arg2 + 1000000, arg1 + 1)
    }

    public fun to_u64(arg0: u128) : u64 {
        if (arg0 > 18446744073709551615) {
            abort 1
        };
        (arg0 as u64)
    }

    public fun to_u64_saturating(arg0: u128) : u64 {
        if (arg0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (arg0 as u64)
        }
    }

    public fun w_div_down(arg0: u128, arg1: u128) : u128 {
        mul_div(arg0, 1000000000000000000, arg1)
    }

    public fun w_div_up(arg0: u128, arg1: u128) : u128 {
        mul_div_up(arg0, 1000000000000000000, arg1)
    }

    public fun w_mul_down(arg0: u128, arg1: u128) : u128 {
        mul_div(arg0, arg1, 1000000000000000000)
    }

    public fun w_mul_up(arg0: u128, arg1: u128) : u128 {
        mul_div_up(arg0, arg1, 1000000000000000000)
    }

    public fun w_taylor_compounded(arg0: u128, arg1: u128) : u128 {
        let v0 = arg0 * arg1;
        let v1 = mul_div_down(v0, v0, 2 * 1000000000000000000);
        v0 + v1 + mul_div_down(v1, v0, 3 * 1000000000000000000)
    }

    public fun wad() : u128 {
        1000000000000000000
    }

    public fun wexp_upper_bound() : u128 {
        47276307437780172800
    }

    public fun wexp_upper_value() : u128 {
        340282366920938463463374607431768211455
    }

    public fun zero_floor_sub(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

