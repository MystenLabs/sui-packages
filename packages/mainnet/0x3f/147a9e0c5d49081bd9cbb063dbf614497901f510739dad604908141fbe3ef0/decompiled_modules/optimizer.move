module 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::optimizer {
    struct Scaled has copy, drop, store {
        mantissa: u256,
        exponent: u16,
    }

    struct RouteFormula has drop {
        a: Scaled,
        b: Scaled,
        c: Scaled,
        hops: u8,
    }

    struct QuoteSelected has copy, drop {
        max_input: u64,
        selected_input: u64,
        quoted_output: u64,
        quoted_profit: u64,
        hops: u8,
    }

    fun add(arg0: Scaled, arg1: Scaled) : Scaled {
        if (is_zero(arg0)) {
            return arg1
        };
        if (is_zero(arg1)) {
            return arg0
        };
        let v0 = if (arg0.exponent >= arg1.exponent) {
            arg0.exponent
        } else {
            arg1.exponent
        };
        normalize(align(arg0, v0) + align(arg1, v0), v0)
    }

    fun align(arg0: Scaled, arg1: u16) : u256 {
        if (is_zero(arg0)) {
            return 0
        };
        let v0 = arg1 - arg0.exponent;
        if (v0 >= 256) {
            0
        } else {
            arg0.mantissa >> (v0 as u8)
        }
    }

    public fun append_v2_edge(arg0: &mut RouteFormula, arg1: u256, arg2: u256, arg3: u64, arg4: u64) {
        assert!(arg1 > 0 && arg2 > 0, 1);
        assert!(arg4 > arg3, 1);
        assert!(arg0.hops < 4, 4);
        let v0 = arg4 - arg3;
        let v1 = mul(from_u256(arg1), from_u256((arg4 as u256)));
        let v2 = arg0.a;
        arg0.a = mul(mul(from_u256(arg2), from_u256((v0 as u256))), v2);
        arg0.b = mul(v1, arg0.b);
        arg0.c = add(mul(v1, arg0.c), mul(from_u256((v0 as u256)), v2));
        arg0.hops = arg0.hops + 1;
    }

    public fun append_v3_edge(arg0: &mut RouteFormula, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: bool) {
        assert!(arg1 > 0 && arg2 > 0, 1);
        let v0 = (arg1 as u256);
        let v1 = (arg2 as u256);
        if (arg5) {
            append_v2_edge(arg0, v0 * 18446744073709551616 / v1, v0 * v1 / 18446744073709551616, arg3, arg4);
        } else {
            append_v2_edge(arg0, v0 * v1 / 18446744073709551616, v0 * 18446744073709551616 / v1, arg3, arg4);
        };
    }

    fun bit_length(arg0: u256) : u16 {
        let v0 = 0;
        while (arg0 > 0) {
            arg0 = arg0 >> 1;
            v0 = v0 + 1;
        };
        v0
    }

    fun compare(arg0: Scaled, arg1: Scaled) : u8 {
        if (is_zero(arg0)) {
            return if (is_zero(arg1)) {
                0
            } else {
                1
            }
        };
        if (is_zero(arg1)) {
            return 2
        };
        if (arg0.exponent > arg1.exponent) {
            return 2
        };
        if (arg0.exponent < arg1.exponent) {
            return 1
        };
        if (arg0.mantissa > arg1.mantissa) {
            2
        } else if (arg0.mantissa < arg1.mantissa) {
            1
        } else {
            0
        }
    }

    fun div(arg0: Scaled, arg1: Scaled) : Scaled {
        assert!(!is_zero(arg1), 3);
        if (is_zero(arg0)) {
            return zero()
        };
        let v0 = (arg0.exponent as u32) + (4096 as u32);
        assert!(v0 >= (arg1.exponent as u32) + (120 as u32), 3);
        normalize((arg0.mantissa << (120 as u8)) / arg1.mantissa, ((v0 - (arg1.exponent as u32) - (120 as u32)) as u16))
    }

    fun from_u256(arg0: u256) : Scaled {
        if (arg0 == 0) {
            return zero()
        };
        normalize(arg0, 4096)
    }

    fun is_zero(arg0: Scaled) : bool {
        arg0.mantissa == 0
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun mul(arg0: Scaled, arg1: Scaled) : Scaled {
        if (is_zero(arg0) || is_zero(arg1)) {
            return zero()
        };
        let v0 = (arg0.exponent as u32) + (arg1.exponent as u32);
        assert!(v0 >= (4096 as u32) && v0 <= 65535 + (4096 as u32), 3);
        normalize(arg0.mantissa * arg1.mantissa, ((v0 - (4096 as u32)) as u16))
    }

    public fun new_route() : RouteFormula {
        RouteFormula{
            a    : from_u256(1),
            b    : from_u256(1),
            c    : zero(),
            hops : 0,
        }
    }

    fun normalize(arg0: u256, arg1: u16) : Scaled {
        if (arg0 == 0) {
            return zero()
        };
        let v0 = bit_length(arg0);
        if (v0 > 120) {
            let v2 = v0 - 120;
            let v3 = arg0 >> (v2 as u8);
            let v4 = v3;
            if (arg0 & (1 << (v2 as u8)) - 1 > 1 << ((v2 - 1) as u8)) {
                v4 = v3 + 1;
            };
            let v5 = arg1 + v2;
            let v6 = v5;
            if (bit_length(v4) > 120) {
                v4 = v4 >> 1;
                v6 = v5 + 1;
            };
            Scaled{mantissa: v4, exponent: v6}
        } else {
            let v7 = 120 - v0;
            assert!(arg1 >= v7, 3);
            Scaled{mantissa: arg0 << (v7 as u8), exponent: arg1 - v7}
        }
    }

    fun output(arg0: &RouteFormula, arg1: u64) : u64 {
        let v0 = from_u256((arg1 as u256));
        to_u64_floor(div(mul(arg0.a, v0), add(arg0.b, mul(arg0.c, v0))))
    }

    public fun select_input(arg0: RouteFormula, arg1: u64, arg2: u64) : u64 {
        select_input_with_minimum(arg0, 0, arg1, arg2)
    }

    public fun select_input_with_minimum(arg0: RouteFormula, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg0.hops > 0) {
            if (arg2 > 0) {
                !is_zero(arg0.c)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(arg1 <= arg2, 2);
        assert!(compare(arg0.a, arg0.b) == 2, 2);
        let v1 = sqrt(mul(arg0.a, arg0.b));
        assert!(compare(v1, arg0.b) == 2, 2);
        let v2 = min_u64(to_u64_floor(div(sub(v1, arg0.b), arg0.c)), arg2);
        assert!(v2 > 0 && v2 >= arg1, 2);
        let v3 = output(&arg0, v2);
        assert!(v3 > v2, 2);
        let v4 = v3 - v2;
        assert!(v4 >= arg3, 2);
        let v5 = QuoteSelected{
            max_input      : arg2,
            selected_input : v2,
            quoted_output  : v3,
            quoted_profit  : v4,
            hops           : arg0.hops,
        };
        0x2::event::emit<QuoteSelected>(v5);
        v2
    }

    fun sqrt(arg0: Scaled) : Scaled {
        if (is_zero(arg0)) {
            return zero()
        };
        let v0 = arg0.mantissa;
        let v1 = v0;
        let v2 = arg0.exponent;
        let v3 = v2;
        if (v2 % 2 == 1) {
            v1 = v0 << 1;
            v3 = v2 - 1;
        };
        normalize(sqrt_u256(v1 << (120 as u8)), ((((v3 as u32) + (4096 as u32) - (120 as u32)) / 2) as u16))
    }

    fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 < 2) {
            return arg0
        };
        let v0 = 1 << (((bit_length(arg0) + 1) / 2) as u8);
        loop {
            let v1 = (v0 + arg0 / v0) / 2;
            if (v1 >= v0) {
                break
            };
            v0 = v1;
        };
        v0
    }

    fun sub(arg0: Scaled, arg1: Scaled) : Scaled {
        let v0 = compare(arg0, arg1);
        assert!(v0 != 1, 3);
        if (v0 == 0) {
            return zero()
        };
        let v1 = if (arg0.exponent >= arg1.exponent) {
            arg0.exponent
        } else {
            arg1.exponent
        };
        let v2 = align(arg0, v1);
        let v3 = align(arg1, v1);
        assert!(v2 >= v3, 3);
        normalize(v2 - v3, v1)
    }

    fun to_u64_floor(arg0: Scaled) : u64 {
        if (is_zero(arg0)) {
            return 0
        };
        let v0 = if (arg0.exponent >= 4096) {
            let v1 = arg0.exponent - 4096;
            assert!(v1 < 256, 3);
            arg0.mantissa << (v1 as u8)
        } else {
            let v2 = 4096 - arg0.exponent;
            if (v2 >= 256) {
                0
            } else {
                arg0.mantissa >> (v2 as u8)
            }
        };
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
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

