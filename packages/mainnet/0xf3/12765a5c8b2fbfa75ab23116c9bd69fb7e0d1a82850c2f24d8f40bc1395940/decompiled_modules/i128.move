module 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::i128 {
    struct I128 has copy, drop, store {
        bits: u128,
    }

    public fun abs(arg0: I128) : I128 {
        if (sign(arg0) == 0) {
            arg0
        } else {
            assert!(arg0.bits > 170141183460469231731687303715884105728, 0);
            I128{bits: u128_neg(arg0.bits - 1)}
        }
    }

    public fun abs_u128(arg0: I128) : u128 {
        if (sign(arg0) == 0) {
            arg0.bits
        } else {
            u128_neg(arg0.bits - 1)
        }
    }

    public fun add(arg0: I128, arg1: I128) : I128 {
        let v0 = wrapping_add(arg0, arg1);
        assert!((sign(arg0) & sign(arg1) & u8_neg(sign(v0))) + (u8_neg(sign(arg0)) & u8_neg(sign(arg1)) & sign(v0)) == 0, 0);
        v0
    }

    public fun and(arg0: I128, arg1: I128) : I128 {
        I128{bits: arg0.bits & arg1.bits}
    }

    public fun as_i32(arg0: I128) : 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::i32::I32 {
        if (is_neg(arg0)) {
            return 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::i32::neg_from((abs_u128(arg0) as u32))
        };
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::i32::from((abs_u128(arg0) as u32))
    }

    public fun as_i64(arg0: I128) : 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::i64::I64 {
        if (is_neg(arg0)) {
            return 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::i64::neg_from((abs_u128(arg0) as u64))
        };
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::i64::from((abs_u128(arg0) as u64))
    }

    public fun as_u128(arg0: I128) : u128 {
        arg0.bits
    }

    public fun cmp(arg0: I128, arg1: I128) : u8 {
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

    public fun div(arg0: I128, arg1: I128) : I128 {
        if (sign(arg0) != sign(arg1)) {
            return neg_from(abs_u128(arg0) / abs_u128(arg1))
        };
        from(abs_u128(arg0) / abs_u128(arg1))
    }

    public fun eq(arg0: I128, arg1: I128) : bool {
        arg0.bits == arg1.bits
    }

    public fun from(arg0: u128) : I128 {
        assert!(arg0 <= 170141183460469231731687303715884105727, 0);
        I128{bits: arg0}
    }

    public fun gt(arg0: I128, arg1: I128) : bool {
        cmp(arg0, arg1) == 2
    }

    public fun gte(arg0: I128, arg1: I128) : bool {
        cmp(arg0, arg1) >= 1
    }

    public fun is_neg(arg0: I128) : bool {
        sign(arg0) == 1
    }

    public fun lt(arg0: I128, arg1: I128) : bool {
        cmp(arg0, arg1) == 0
    }

    public fun lte(arg0: I128, arg1: I128) : bool {
        cmp(arg0, arg1) <= 1
    }

    public fun mul(arg0: I128, arg1: I128) : I128 {
        if (sign(arg0) != sign(arg1)) {
            return neg_from(abs_u128(arg0) * abs_u128(arg1))
        };
        from(abs_u128(arg0) * abs_u128(arg1))
    }

    public fun neg(arg0: I128) : I128 {
        if (is_neg(arg0)) {
            abs(arg0)
        } else {
            neg_from(arg0.bits)
        }
    }

    public fun neg_from(arg0: u128) : I128 {
        assert!(arg0 <= 170141183460469231731687303715884105728, 0);
        if (arg0 == 0) {
            I128{bits: arg0}
        } else {
            I128{bits: u128_neg(arg0) + 1 | 170141183460469231731687303715884105728}
        }
    }

    public fun or(arg0: I128, arg1: I128) : I128 {
        I128{bits: arg0.bits | arg1.bits}
    }

    public fun overflowing_add(arg0: I128, arg1: I128) : (I128, bool) {
        let v0 = wrapping_add(arg0, arg1);
        (v0, (sign(arg0) & sign(arg1) & u8_neg(sign(v0))) + (u8_neg(sign(arg0)) & u8_neg(sign(arg1)) & sign(v0)) != 0)
    }

    public fun overflowing_sub(arg0: I128, arg1: I128) : (I128, bool) {
        let v0 = I128{bits: u128_neg(arg1.bits)};
        let v1 = wrapping_add(v0, from(1));
        let v2 = wrapping_add(arg0, v1);
        (v2, (sign(arg0) & sign(v1) & u8_neg(sign(v2))) + (u8_neg(sign(arg0)) & u8_neg(sign(v1)) & sign(v2)) != 0)
    }

    public fun shl(arg0: I128, arg1: u8) : I128 {
        I128{bits: arg0.bits << arg1}
    }

    public fun shr(arg0: I128, arg1: u8) : I128 {
        if (arg1 == 0) {
            return arg0
        };
        if (sign(arg0) == 1) {
            return I128{bits: arg0.bits >> arg1 | 340282366920938463463374607431768211455 << 128 - arg1}
        };
        I128{bits: arg0.bits >> arg1}
    }

    public fun sign(arg0: I128) : u8 {
        ((arg0.bits >> 127) as u8)
    }

    public fun sub(arg0: I128, arg1: I128) : I128 {
        let v0 = I128{bits: u128_neg(arg1.bits)};
        add(arg0, wrapping_add(v0, from(1)))
    }

    fun u128_neg(arg0: u128) : u128 {
        arg0 ^ 340282366920938463463374607431768211455
    }

    fun u8_neg(arg0: u8) : u8 {
        arg0 ^ 255
    }

    public fun wrapping_add(arg0: I128, arg1: I128) : I128 {
        let v0 = arg0.bits ^ arg1.bits;
        let v1 = (arg0.bits & arg1.bits) << 1;
        while (v1 != 0) {
            let v2 = v0;
            v0 = v0 ^ v1;
            let v3 = v2 & v1;
            v1 = v3 << 1;
        };
        I128{bits: v0}
    }

    public fun wrapping_sub(arg0: I128, arg1: I128) : I128 {
        let v0 = I128{bits: u128_neg(arg1.bits)};
        wrapping_add(arg0, wrapping_add(v0, from(1)))
    }

    public fun zero() : I128 {
        I128{bits: 0}
    }

    // decompiled from Move bytecode v6
}

