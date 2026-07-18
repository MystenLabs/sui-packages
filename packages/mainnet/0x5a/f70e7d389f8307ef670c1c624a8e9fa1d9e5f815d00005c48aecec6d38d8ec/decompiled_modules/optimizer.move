module 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer {
    struct Scaled has copy, drop {
        mantissa: u256,
        exponent: u16,
    }

    struct DenominatorTerm has drop {
        b: Scaled,
        prefix_a: Scaled,
        fee_numerator: u64,
    }

    struct RouteFormula has drop {
        a: Scaled,
        b: Scaled,
        first_fee_numerator: u64,
        denominator_terms: vector<DenominatorTerm>,
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

    public fun append_suiswap_v2_edge(arg0: RouteFormula, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: bool) : RouteFormula {
        let (v0, v1, v2, v3) = suiswap_fee_factors(arg3, arg4, arg5, arg6, arg7);
        append_v2_edge_with_factors(arg0, arg1, arg2, v0, v1, v2, v3)
    }

    public fun append_v2_edge(arg0: RouteFormula, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : RouteFormula {
        let v0 = arg4 - arg3;
        let v1 = from_u256((arg1 as u256) * (arg4 as u256));
        let RouteFormula {
            a                   : v2,
            b                   : v3,
            first_fee_numerator : v4,
            denominator_terms   : v5,
        } = arg0;
        let v6 = v5;
        let v7 = DenominatorTerm{
            b             : v1,
            prefix_a      : v2,
            fee_numerator : v0,
        };
        0x1::vector::push_back<DenominatorTerm>(&mut v6, v7);
        RouteFormula{
            a                   : mul(from_u256((arg2 as u256) * (v0 as u256)), v2),
            b                   : mul(v1, v3),
            first_fee_numerator : v4,
            denominator_terms   : v6,
        }
    }

    public fun append_v2_edge_with_factors(arg0: RouteFormula, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : RouteFormula {
        let v0 = from_u256((arg1 as u256) * (arg4 as u256) * (arg6 as u256));
        let RouteFormula {
            a                   : v1,
            b                   : v2,
            first_fee_numerator : v3,
            denominator_terms   : v4,
        } = arg0;
        let v5 = v4;
        let v6 = DenominatorTerm{
            b             : v0,
            prefix_a      : v1,
            fee_numerator : arg3 * arg6,
        };
        0x1::vector::push_back<DenominatorTerm>(&mut v5, v6);
        RouteFormula{
            a                   : mul(from_u256((arg2 as u256) * (arg3 as u256) * (arg5 as u256)), v1),
            b                   : mul(v0, v2),
            first_fee_numerator : v3,
            denominator_terms   : v5,
        }
    }

    public fun append_v3_edge(arg0: RouteFormula, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool) : RouteFormula {
        let (v0, v1, v2) = v3_coefficients(arg1, arg2, arg3, arg4, arg5);
        let RouteFormula {
            a                   : v3,
            b                   : v4,
            first_fee_numerator : v5,
            denominator_terms   : v6,
        } = arg0;
        let v7 = v6;
        let v8 = DenominatorTerm{
            b             : v1,
            prefix_a      : v3,
            fee_numerator : v2,
        };
        0x1::vector::push_back<DenominatorTerm>(&mut v7, v8);
        RouteFormula{
            a                   : mul(v0, v3),
            b                   : mul(v1, v4),
            first_fee_numerator : v5,
            denominator_terms   : v7,
        }
    }

    fun assert_bounds(arg0: u64, arg1: u64) {
        assert!(arg1 > 0 && arg0 <= arg1, 2);
    }

    fun assert_ordered(arg0: &Scaled, arg1: &Scaled) {
        assert!(arg0.exponent > arg1.exponent || arg0.exponent == arg1.exponent && arg0.mantissa > arg1.mantissa, 2);
    }

    fun assert_profitable(arg0: &Scaled, arg1: &Scaled, arg2: u64, arg3: u64) {
        assert_bounds(arg2, arg3);
        assert_ordered(arg0, arg1);
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

    fun denominator(arg0: &RouteFormula) : Scaled {
        let v0 = from_u256((arg0.first_fee_numerator as u256));
        let v1 = 0;
        while (v1 < 0x1::vector::length<DenominatorTerm>(&arg0.denominator_terms)) {
            let v2 = 0x1::vector::borrow<DenominatorTerm>(&arg0.denominator_terms, v1);
            let v3 = mul(v2.b, v0);
            v0 = add(v3, mul_u64(v2.prefix_a, v2.fee_numerator));
            v1 = v1 + 1;
        };
        v0
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

    fun optimum(arg0: Scaled, arg1: Scaled, arg2: Scaled, arg3: u64, arg4: u64) : u64 {
        let v0 = min_u64(to_u64_floor(div(positive_difference(sqrt(mul(arg0, arg1)), arg1), arg2)), arg4);
        assert!(v0 > 0 && v0 >= arg3, 2);
        v0
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

    fun profitable_products(arg0: Scaled, arg1: Scaled, arg2: Scaled, arg3: Scaled) : (Scaled, Scaled) {
        let v0 = arg0.mantissa * arg1.mantissa;
        let v1 = arg2.mantissa * arg3.mantissa;
        let v2 = (arg0.exponent as u32) + (arg1.exponent as u32);
        let v3 = (arg2.exponent as u32) + (arg3.exponent as u32);
        assert!(raw_product_greater(v0, v2, v1, v3), 2);
        let v4 = normalize_product(v0, ((v2 - (4096 as u32)) as u16));
        let v5 = normalize_product(v1, ((v3 - (4096 as u32)) as u16));
        assert_ordered(&v4, &v5);
        (v4, v5)
    }

    fun raw_product_greater(arg0: u256, arg1: u32, arg2: u256, arg3: u32) : bool {
        let v0 = 883423532389192164791648750371459257913741948437809479060803100646309888;
        let v1 = arg0 >= v0;
        let v2 = arg2 >= v0;
        let v3 = if (v1) {
            1
        } else {
            0
        };
        let v4 = arg1 + v3;
        let v5 = if (v2) {
            1
        } else {
            0
        };
        let v6 = arg3 + v5;
        if (v4 != v6) {
            return v4 > v6
        };
        if (v1 == v2) {
            return arg0 > arg2
        };
        v1 && arg0 > arg2 << 1 || arg0 << 1 > arg2
    }

    public fun select_input(arg0: RouteFormula, arg1: u64, arg2: u64) : u64 {
        assert_profitable(&arg0.a, &arg0.b, arg1, arg2);
        optimum(arg0.a, arg0.b, denominator(&arg0), arg1, arg2)
    }

    public fun select_v3(arg0: RouteFormula, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64) : u64 {
        assert_bounds(arg6, arg7);
        let (v0, v1, v2) = v3_coefficients(arg1, arg2, arg3, arg4, arg5);
        let (v3, v4) = profitable_products(arg0.a, v0, arg0.b, v1);
        optimum(v3, v4, add(mul_u64(arg0.b, v2), mul(denominator(&arg0), v0)), arg6, arg7)
    }

    fun sqrt(arg0: Scaled) : Scaled {
        let v0 = arg0.mantissa;
        let v1 = v0;
        let v2 = arg0.exponent;
        let v3 = v2;
        let v4 = v2 & 1 == 1;
        if (v4) {
            v1 = v0 << 1;
            v3 = v2 - 1;
        };
        let v5 = if (v4) {
            2658455991569831745807614120560689152
        } else {
            1329227995784915872903807060280344576
        };
        if (v4) {
            Scaled{mantissa: sqrt_u256(v1 << (120 as u8), v5) >> 1, exponent: (((v3 as u32) + (4096 as u32) - (120 as u32) >> 1) as u16) + 1}
        } else {
            Scaled{mantissa: sqrt_u256(v1 << (120 as u8), v5), exponent: (((v3 as u32) + (4096 as u32) - (120 as u32) >> 1) as u16)}
        }
    }

    fun sqrt_u256(arg0: u256, arg1: u256) : u256 {
        let v0 = 0;
        while (v0 < 6) {
            let v1 = arg1 + arg0 / arg1 >> 1;
            if (v1 >= arg1) {
                return arg1
            };
            arg1 = v1;
            v0 = v0 + 1;
        };
        let v2 = arg0 / arg1;
        if (v2 < arg1) {
            v2
        } else {
            arg1
        }
    }

    fun suiswap_fee_factors(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (u64, u64, u64, u64) {
        let v0 = 10000;
        if (arg4 && arg0 == 200 || !arg4 && arg0 == 201) {
            ((v0 - arg1) * (v0 - arg3) * (v0 - arg2), v0 * v0 * v0, 1, 1)
        } else {
            (v0 - arg2, v0, (v0 - arg1) * (v0 - arg3), v0 * v0)
        }
    }

    public fun suiswap_v2_route(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : RouteFormula {
        let (v0, v1, v2, v3) = suiswap_fee_factors(arg2, arg3, arg4, arg5, arg6);
        v2_route_with_factors(arg0, arg1, v0, v1, v2, v3)
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
        let v0 = arg3 - arg2;
        RouteFormula{
            a                   : from_u256((arg1 as u256) * (v0 as u256)),
            b                   : from_u256((arg0 as u256) * (arg3 as u256)),
            first_fee_numerator : v0,
            denominator_terms   : 0x1::vector::empty<DenominatorTerm>(),
        }
    }

    public fun v2_route_with_factors(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : RouteFormula {
        RouteFormula{
            a                   : from_u256((arg1 as u256) * (arg2 as u256) * (arg4 as u256)),
            b                   : from_u256((arg0 as u256) * (arg3 as u256) * (arg5 as u256)),
            first_fee_numerator : arg2 * arg5,
            denominator_terms   : 0x1::vector::empty<DenominatorTerm>(),
        }
    }

    fun v3_coefficients(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool) : (Scaled, Scaled, u64) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let (v2, v3) = if (arg4) {
            ((v0 << 64) / v1, v0 * v1 >> 64)
        } else {
            (v0 * v1 >> 64, (v0 << 64) / v1)
        };
        let v4 = arg3 - arg2;
        (from_u256(v3 * (v4 as u256)), from_u256(v2 * (arg3 as u256)), v4)
    }

    public fun v3_route(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool) : RouteFormula {
        let (v0, v1, v2) = v3_coefficients(arg0, arg1, arg2, arg3, arg4);
        RouteFormula{
            a                   : v0,
            b                   : v1,
            first_fee_numerator : v2,
            denominator_terms   : 0x1::vector::empty<DenominatorTerm>(),
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

