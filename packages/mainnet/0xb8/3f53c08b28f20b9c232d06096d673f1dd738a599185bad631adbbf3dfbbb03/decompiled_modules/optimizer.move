module 0xb83f53c08b28f20b9c232d06096d673f1dd738a599185bad631adbbf3dfbbb03::optimizer {
    struct Scaled has copy, drop {
        mantissa: u256,
        exponent: u16,
    }

    struct RouteFormula has drop {
        a: Scaled,
        b: Scaled,
        c: Scaled,
    }

    fun add(arg0: Scaled, arg1: Scaled) : Scaled {
        let v0 = if (arg0.exponent >= arg1.exponent) {
            arg0.exponent
        } else {
            arg1.exponent
        };
        normalize_one_bit(align(arg0, v0) + align(arg1, v0), v0)
    }

    fun align(arg0: Scaled, arg1: u16) : u256 {
        let v0 = arg1 - arg0.exponent;
        if (v0 >= 256) {
            0
        } else {
            arg0.mantissa >> (v0 as u8)
        }
    }

    public fun append_v2_edge(arg0: RouteFormula, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : RouteFormula {
        assert!(arg1 > 0 && arg2 > 0, 1);
        assert!(arg4 > arg3, 1);
        let v0 = arg4 - arg3;
        let v1 = from_u256((arg1 as u256) * (arg4 as u256));
        let RouteFormula {
            a : v2,
            b : v3,
            c : v4,
        } = arg0;
        RouteFormula{
            a : mul(from_u256((arg2 as u256) * (v0 as u256)), v2),
            b : mul(v1, v3),
            c : add(mul(v1, v4), mul_u64(v2, v0)),
        }
    }

    public fun append_v3_edge(arg0: RouteFormula, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool) : RouteFormula {
        let (v0, v1, v2) = v3_coefficients(arg1, arg2, arg3, arg4, arg5);
        let RouteFormula {
            a : v3,
            b : v4,
            c : v5,
        } = arg0;
        RouteFormula{
            a : mul(v0, v3),
            b : mul(v1, v4),
            c : add(mul(v1, v5), mul_u64(v3, v2)),
        }
    }

    fun bit_length_nonzero(arg0: u256) : u16 {
        let v0 = arg0;
        let v1 = 0;
        let v2 = v1;
        if (arg0 >= 340282366920938463463374607431768211456) {
            v0 = arg0 >> 128;
            v2 = v1 + 128;
        };
        if (v0 >= 18446744073709551616) {
            v0 = v0 >> 64;
            v2 = v2 + 64;
        };
        if (v0 >= 4294967296) {
            v0 = v0 >> 32;
            v2 = v2 + 32;
        };
        if (v0 >= 65536) {
            v0 = v0 >> 16;
            v2 = v2 + 16;
        };
        if (v0 >= 256) {
            v0 = v0 >> 8;
            v2 = v2 + 8;
        };
        if (v0 >= 16) {
            v0 = v0 >> 4;
            v2 = v2 + 4;
        };
        if (v0 >= 4) {
            v0 = v0 >> 2;
            v2 = v2 + 2;
        };
        if (v0 >= 2) {
            v2 = v2 + 1;
        };
        v2 + 1
    }

    fun div(arg0: Scaled, arg1: Scaled) : Scaled {
        let v0 = (arg0.mantissa << (120 as u8)) / arg1.mantissa;
        if (v0 == 0) {
            return zero()
        };
        normalize_one_bit(v0, (((arg0.exponent as u32) + (4096 as u32) - (arg1.exponent as u32) - (120 as u32)) as u16))
    }

    fun from_u256(arg0: u256) : Scaled {
        normalize_nonzero(arg0, 4096)
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun mul(arg0: Scaled, arg1: Scaled) : Scaled {
        normalize_product(arg0.mantissa * arg1.mantissa, (((arg0.exponent as u32) + (arg1.exponent as u32) - (4096 as u32)) as u16))
    }

    fun mul_u64(arg0: Scaled, arg1: u64) : Scaled {
        normalize_nonzero(arg0.mantissa * (arg1 as u256), arg0.exponent)
    }

    fun normalize_nonzero(arg0: u256, arg1: u16) : Scaled {
        let v0 = bit_length_nonzero(arg0);
        if (v0 > 120) {
            let v2 = v0 - 120;
            let v3 = arg0 >> (v2 as u8);
            let v4 = v3;
            if (arg0 - (v3 << (v2 as u8)) > 1 << ((v2 - 1) as u8)) {
                v4 = v3 + 1;
            };
            let v5 = arg1 + v2;
            let v6 = v5;
            if (v4 >= 1 << (120 as u8)) {
                v4 = v4 >> 1;
                v6 = v5 + 1;
            };
            Scaled{mantissa: v4, exponent: v6}
        } else {
            let v7 = 120 - v0;
            Scaled{mantissa: arg0 << (v7 as u8), exponent: arg1 - v7}
        }
    }

    fun normalize_one_bit(arg0: u256, arg1: u16) : Scaled {
        if (arg0 >= 1 << (120 as u8)) {
            Scaled{mantissa: arg0 >> 1, exponent: arg1 + 1}
        } else {
            Scaled{mantissa: arg0, exponent: arg1}
        }
    }

    fun normalize_product(arg0: u256, arg1: u16) : Scaled {
        let v0 = if (arg0 >= 883423532389192164791648750371459257913741948437809479060803100646309888) {
            120
        } else {
            119
        };
        let v1 = arg0 >> (v0 as u8);
        let v2 = v1;
        if (arg0 - (v1 << (v0 as u8)) > 1 << ((v0 - 1) as u8)) {
            v2 = v1 + 1;
        };
        let v3 = arg1 + v0;
        let v4 = v3;
        if (v2 >= 1 << (120 as u8)) {
            v2 = v2 >> 1;
            v4 = v3 + 1;
        };
        Scaled{
            mantissa : v2,
            exponent : v4,
        }
    }

    fun positive_difference(arg0: Scaled, arg1: Scaled) : Scaled {
        let v0 = if (arg0.exponent >= arg1.exponent) {
            arg0.exponent
        } else {
            arg1.exponent
        };
        let v1 = align(arg0, v0);
        let v2 = align(arg1, v0);
        if (v1 <= v2) {
            return zero()
        };
        normalize_nonzero(v1 - v2, v0)
    }

    public fun prepend_v3_edge(arg0: RouteFormula, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool) : RouteFormula {
        let (v0, v1, v2) = v3_coefficients(arg1, arg2, arg3, arg4, arg5);
        let RouteFormula {
            a : v3,
            b : v4,
            c : v5,
        } = arg0;
        RouteFormula{
            a : mul(v3, v0),
            b : mul(v4, v1),
            c : add(mul_u64(v4, v2), mul(v5, v0)),
        }
    }

    public fun select_input(arg0: RouteFormula, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0 && arg1 <= arg2, 2);
        assert!(arg0.a.exponent > arg0.b.exponent || arg0.a.exponent == arg0.b.exponent && arg0.a.mantissa > arg0.b.mantissa, 2);
        let v0 = min_u64(to_u64_floor(div(positive_difference(sqrt(mul(arg0.a, arg0.b)), arg0.b), arg0.c)), arg2);
        assert!(v0 > 0 && v0 >= arg1, 2);
        v0
    }

    fun sqrt(arg0: Scaled) : Scaled {
        let v0 = arg0.mantissa;
        let v1 = v0;
        let v2 = arg0.exponent;
        let v3 = v2;
        let v4 = v2 % 2 == 1;
        if (v4) {
            v1 = v0 << 1;
            v3 = v2 - 1;
        };
        if (v4) {
            Scaled{mantissa: sqrt_u256(v1 << (120 as u8)) >> 1, exponent: ((((v3 as u32) + (4096 as u32) - (120 as u32)) / 2) as u16) + 1}
        } else {
            Scaled{mantissa: sqrt_u256(v1 << (120 as u8)), exponent: ((((v3 as u32) + (4096 as u32) - (120 as u32)) / 2) as u16)}
        }
    }

    fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 < 2) {
            return arg0
        };
        let v0 = 1 << (((bit_length_nonzero(arg0) + 1) / 2) as u8);
        loop {
            let v1 = (v0 + arg0 / v0) / 2;
            if (v1 >= v0) {
                break
            };
            v0 = v1;
        };
        v0
    }

    fun to_u64_floor(arg0: Scaled) : u64 {
        let v0 = if (arg0.exponent >= 4096) {
            arg0.mantissa << ((arg0.exponent - 4096) as u8)
        } else {
            let v1 = 4096 - arg0.exponent;
            if (v1 >= 256) {
                0
            } else {
                arg0.mantissa >> (v1 as u8)
            }
        };
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun v2_route(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : RouteFormula {
        assert!(arg0 > 0 && arg1 > 0, 1);
        assert!(arg3 > arg2, 1);
        let v0 = arg3 - arg2;
        RouteFormula{
            a : from_u256((arg1 as u256) * (v0 as u256)),
            b : from_u256((arg0 as u256) * (arg3 as u256)),
            c : from_u256((v0 as u256)),
        }
    }

    fun v3_coefficients(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool) : (Scaled, Scaled, u64) {
        assert!(arg0 > 0 && arg1 > 0, 1);
        assert!(arg3 > arg2, 1);
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = v0 * 18446744073709551616 / v1;
        let v3 = v0 * v1 / 18446744073709551616;
        assert!(v2 > 0 && v3 > 0, 1);
        let (v4, v5) = if (arg4) {
            (v2, v3)
        } else {
            (v3, v2)
        };
        let v6 = arg3 - arg2;
        (from_u256(v5 * (v6 as u256)), from_u256(v4 * (arg3 as u256)), v6)
    }

    public fun v3_route(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool) : RouteFormula {
        let (v0, v1, v2) = v3_coefficients(arg0, arg1, arg2, arg3, arg4);
        RouteFormula{
            a : v0,
            b : v1,
            c : from_u256((v2 as u256)),
        }
    }

    fun zero() : Scaled {
        Scaled{
            mantissa : 0,
            exponent : 4096,
        }
    }

    // decompiled from Move bytecode v7
}

