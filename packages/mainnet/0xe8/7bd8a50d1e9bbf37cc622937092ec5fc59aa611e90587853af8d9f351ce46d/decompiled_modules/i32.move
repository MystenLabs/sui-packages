module 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i32 {
    struct I32 has copy, drop, store {
        bits: u32,
    }

    public fun abs(arg0: I32) : I32 {
        if (sign(arg0) == 0) {
            arg0
        } else {
            assert!(arg0.bits > 2147483648, 0);
            I32{bits: u32_neg(arg0.bits - 1)}
        }
    }

    public fun abs_u32(arg0: I32) : u32 {
        if (sign(arg0) == 0) {
            arg0.bits
        } else {
            u32_neg(arg0.bits - 1)
        }
    }

    public fun add(arg0: I32, arg1: I32) : I32 {
        let v0 = wrapping_add(arg0, arg1);
        assert!((sign(arg0) & sign(arg1) & u8_neg(sign(v0))) + (u8_neg(sign(arg0)) & u8_neg(sign(arg1)) & sign(v0)) == 0, 0);
        v0
    }

    public fun and(arg0: I32, arg1: I32) : I32 {
        I32{bits: arg0.bits & arg1.bits}
    }

    public fun as_u32(arg0: I32) : u32 {
        arg0.bits
    }

    public fun cmp(arg0: I32, arg1: I32) : u8 {
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

    public fun div(arg0: I32, arg1: I32) : I32 {
        if (sign(arg0) != sign(arg1)) {
            return neg_from(abs_u32(arg0) / abs_u32(arg1))
        };
        from(abs_u32(arg0) / abs_u32(arg1))
    }

    public fun eq(arg0: I32, arg1: I32) : bool {
        arg0.bits == arg1.bits
    }

    public fun from(arg0: u32) : I32 {
        assert!(arg0 <= 2147483647, 0);
        I32{bits: arg0}
    }

    public fun from_u32(arg0: u32) : I32 {
        I32{bits: arg0}
    }

    public fun gt(arg0: I32, arg1: I32) : bool {
        cmp(arg0, arg1) == 2
    }

    public fun gte(arg0: I32, arg1: I32) : bool {
        cmp(arg0, arg1) >= 1
    }

    public fun is_neg(arg0: I32) : bool {
        sign(arg0) == 1
    }

    public fun lt(arg0: I32, arg1: I32) : bool {
        cmp(arg0, arg1) == 0
    }

    public fun lte(arg0: I32, arg1: I32) : bool {
        cmp(arg0, arg1) <= 1
    }

    public fun mod(arg0: I32, arg1: I32) : I32 {
        if (sign(arg0) == 1) {
            neg_from(abs_u32(arg0) % abs_u32(arg1))
        } else {
            from(as_u32(arg0) % abs_u32(arg1))
        }
    }

    public fun mul(arg0: I32, arg1: I32) : I32 {
        if (sign(arg0) != sign(arg1)) {
            return neg_from(abs_u32(arg0) * abs_u32(arg1))
        };
        from(abs_u32(arg0) * abs_u32(arg1))
    }

    public fun neg_from(arg0: u32) : I32 {
        assert!(arg0 <= 2147483648, 0);
        if (arg0 == 0) {
            I32{bits: arg0}
        } else {
            I32{bits: u32_neg(arg0) + 1 | 2147483648}
        }
    }

    public fun or(arg0: I32, arg1: I32) : I32 {
        I32{bits: arg0.bits | arg1.bits}
    }

    public fun shl(arg0: I32, arg1: u8) : I32 {
        I32{bits: arg0.bits << arg1}
    }

    public fun shr(arg0: I32, arg1: u8) : I32 {
        if (arg1 == 0) {
            return arg0
        };
        if (sign(arg0) == 1) {
            return I32{bits: arg0.bits >> arg1 | 4294967295 << 32 - arg1}
        };
        I32{bits: arg0.bits >> arg1}
    }

    public fun sign(arg0: I32) : u8 {
        ((arg0.bits >> 31) as u8)
    }

    public fun sub(arg0: I32, arg1: I32) : I32 {
        let v0 = I32{bits: u32_neg(arg1.bits)};
        add(arg0, wrapping_add(v0, from(1)))
    }

    fun u32_neg(arg0: u32) : u32 {
        arg0 ^ 4294967295
    }

    fun u8_neg(arg0: u8) : u8 {
        arg0 ^ 255
    }

    public fun wrapping_add(arg0: I32, arg1: I32) : I32 {
        let v0 = arg0.bits ^ arg1.bits;
        let v1 = (arg0.bits & arg1.bits) << 1;
        while (v1 != 0) {
            let v2 = v0;
            v0 = v0 ^ v1;
            let v3 = v2 & v1;
            v1 = v3 << 1;
        };
        I32{bits: v0}
    }

    public fun wrapping_sub(arg0: I32, arg1: I32) : I32 {
        let v0 = I32{bits: u32_neg(arg1.bits)};
        wrapping_add(arg0, wrapping_add(v0, from(1)))
    }

    public fun zero() : I32 {
        I32{bits: 0}
    }

    // decompiled from Move bytecode v6
}

