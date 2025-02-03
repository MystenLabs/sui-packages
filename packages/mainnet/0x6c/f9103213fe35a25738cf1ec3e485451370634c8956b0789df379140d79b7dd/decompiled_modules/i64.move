module 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i64 {
    struct I64 has copy, drop, store {
        bits: u64,
    }

    public fun abs(arg0: I64) : I64 {
        if (sign(arg0) == 0) {
            arg0
        } else {
            assert!(arg0.bits > 9223372036854775808, 0);
            I64{bits: u64_neg(arg0.bits - 1)}
        }
    }

    public fun abs_u64(arg0: I64) : u64 {
        if (sign(arg0) == 0) {
            arg0.bits
        } else {
            u64_neg(arg0.bits - 1)
        }
    }

    public fun add(arg0: I64, arg1: I64) : I64 {
        let v0 = wrapping_add(arg0, arg1);
        assert!((sign(arg0) & sign(arg1) & u8_neg(sign(v0))) + (u8_neg(sign(arg0)) & u8_neg(sign(arg1)) & sign(v0)) == 0, 0);
        v0
    }

    public fun and(arg0: I64, arg1: I64) : I64 {
        I64{bits: arg0.bits & arg1.bits}
    }

    public fun as_u64(arg0: I64) : u64 {
        arg0.bits
    }

    public fun cmp(arg0: I64, arg1: I64) : u8 {
        if (arg0.bits == arg1.bits) {
            return 1
        };
        if (sign(arg0) > sign(arg1)) {
            return 0
        };
        if (sign(arg0) < sign(arg1)) {
            return 2
        };
        if (arg0.bits > arg1.bits) {
            return 2
        };
        0
    }

    public fun div(arg0: I64, arg1: I64) : I64 {
        if (sign(arg0) != sign(arg1)) {
            return neg_from(abs_u64(arg0) / abs_u64(arg1))
        };
        from(abs_u64(arg0) / abs_u64(arg1))
    }

    public fun eq(arg0: I64, arg1: I64) : bool {
        arg0.bits == arg1.bits
    }

    public fun from(arg0: u64) : I64 {
        assert!(arg0 <= 9223372036854775807, 0);
        I64{bits: arg0}
    }

    public fun from_u64(arg0: u64) : I64 {
        I64{bits: arg0}
    }

    public fun gt(arg0: I64, arg1: I64) : bool {
        cmp(arg0, arg1) == 2
    }

    public fun gte(arg0: I64, arg1: I64) : bool {
        cmp(arg0, arg1) >= 1
    }

    public fun is_neg(arg0: I64) : bool {
        sign(arg0) == 1
    }

    public fun lt(arg0: I64, arg1: I64) : bool {
        cmp(arg0, arg1) == 0
    }

    public fun lte(arg0: I64, arg1: I64) : bool {
        cmp(arg0, arg1) <= 1
    }

    public fun mod(arg0: I64, arg1: I64) : I64 {
        if (sign(arg0) == 1) {
            neg_from(abs_u64(arg0) % abs_u64(arg1))
        } else {
            from(as_u64(arg0) % abs_u64(arg1))
        }
    }

    public fun mul(arg0: I64, arg1: I64) : I64 {
        if (sign(arg0) != sign(arg1)) {
            return neg_from(abs_u64(arg0) * abs_u64(arg1))
        };
        from(abs_u64(arg0) * abs_u64(arg1))
    }

    public fun neg_from(arg0: u64) : I64 {
        assert!(arg0 <= 9223372036854775808, 0);
        if (arg0 == 0) {
            I64{bits: arg0}
        } else {
            I64{bits: u64_neg(arg0) + 1 | 9223372036854775808}
        }
    }

    public fun or(arg0: I64, arg1: I64) : I64 {
        I64{bits: arg0.bits | arg1.bits}
    }

    public fun shl(arg0: I64, arg1: u8) : I64 {
        I64{bits: arg0.bits << arg1}
    }

    public fun shr(arg0: I64, arg1: u8) : I64 {
        if (arg1 == 0) {
            return arg0
        };
        if (sign(arg0) == 1) {
            return I64{bits: arg0.bits >> arg1 | 18446744073709551615 << 64 - arg1}
        };
        I64{bits: arg0.bits >> arg1}
    }

    public fun sign(arg0: I64) : u8 {
        ((arg0.bits >> 63) as u8)
    }

    public fun sub(arg0: I64, arg1: I64) : I64 {
        let v0 = I64{bits: u64_neg(arg1.bits)};
        add(arg0, wrapping_add(v0, from(1)))
    }

    fun u64_neg(arg0: u64) : u64 {
        arg0 ^ 18446744073709551615
    }

    fun u8_neg(arg0: u8) : u8 {
        arg0 ^ 255
    }

    public fun wrapping_add(arg0: I64, arg1: I64) : I64 {
        let v0 = arg0.bits ^ arg1.bits;
        let v1 = (arg0.bits & arg1.bits) << 1;
        while (v1 != 0) {
            let v2 = v0;
            v0 = v0 ^ v1;
            let v3 = v2 & v1;
            v1 = v3 << 1;
        };
        I64{bits: v0}
    }

    public fun wrapping_sub(arg0: I64, arg1: I64) : I64 {
        let v0 = I64{bits: u64_neg(arg1.bits)};
        wrapping_add(arg0, wrapping_add(v0, from(1)))
    }

    public fun zero() : I64 {
        I64{bits: 0}
    }

    // decompiled from Move bytecode v6
}

