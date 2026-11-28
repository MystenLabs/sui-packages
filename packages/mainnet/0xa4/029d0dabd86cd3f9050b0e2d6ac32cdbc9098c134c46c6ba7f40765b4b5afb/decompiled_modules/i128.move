module 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128 {
    struct I128 has copy, drop, store {
        bits: u128,
    }

    public fun abs(arg0: I128) : I128 {
        if (arg0.bits >= 170141183460469231731687303715884105728) {
            neg(arg0)
        } else {
            arg0
        }
    }

    public fun abs_u(arg0: I128) : u128 {
        if (arg0.bits >= 170141183460469231731687303715884105728) {
            neg_bits(arg0.bits)
        } else {
            arg0.bits
        }
    }

    public fun add(arg0: I128, arg1: I128) : I128 {
        let v0 = wadd(arg0.bits, arg1.bits);
        let v1 = arg0.bits >= 170141183460469231731687303715884105728;
        assert!(v1 != arg1.bits >= 170141183460469231731687303715884105728 || v0 >= 170141183460469231731687303715884105728 == v1, 1);
        I128{bits: v0}
    }

    public fun bits(arg0: I128) : u128 {
        arg0.bits
    }

    public fun cmp(arg0: I128, arg1: I128) : u8 {
        if (arg0.bits == arg1.bits) {
            1
        } else if (lt(arg0, arg1)) {
            0
        } else {
            2
        }
    }

    public fun div_ceil(arg0: I128, arg1: I128) : I128 {
        let v0 = abs_u(arg0);
        let v1 = abs_u(arg1);
        let v2 = arg0.bits >= 170141183460469231731687303715884105728 != arg1.bits >= 170141183460469231731687303715884105728;
        if (!v2 && v0 % v1 != 0) {
            from_parts(false, v0 / v1 + 1)
        } else {
            from_parts(v2, v0 / v1)
        }
    }

    public fun div_floor(arg0: I128, arg1: I128) : I128 {
        let v0 = abs_u(arg0);
        let v1 = abs_u(arg1);
        let v2 = arg0.bits >= 170141183460469231731687303715884105728 != arg1.bits >= 170141183460469231731687303715884105728;
        if (v2 && v0 % v1 != 0) {
            from_parts(true, v0 / v1 + 1)
        } else {
            from_parts(v2, v0 / v1)
        }
    }

    public fun div_trunc(arg0: I128, arg1: I128) : I128 {
        from_parts(arg0.bits >= 170141183460469231731687303715884105728 != arg1.bits >= 170141183460469231731687303715884105728, abs_u(arg0) / abs_u(arg1))
    }

    public fun eq(arg0: I128, arg1: I128) : bool {
        arg0.bits == arg1.bits
    }

    public fun from_bits(arg0: u128) : I128 {
        I128{bits: arg0}
    }

    public fun from_parts(arg0: bool, arg1: u128) : I128 {
        if (arg0) {
            assert!(arg1 <= 170141183460469231731687303715884105728, 1);
            I128{bits: neg_bits(arg1)}
        } else {
            assert!(arg1 < 170141183460469231731687303715884105728, 1);
            I128{bits: arg1}
        }
    }

    public fun from_u(arg0: u128) : I128 {
        assert!(arg0 < 170141183460469231731687303715884105728, 1);
        I128{bits: arg0}
    }

    public fun ge(arg0: I128, arg1: I128) : bool {
        le(arg1, arg0)
    }

    public fun gt(arg0: I128, arg1: I128) : bool {
        lt(arg1, arg0)
    }

    public fun is_neg(arg0: I128) : bool {
        arg0.bits >= 170141183460469231731687303715884105728
    }

    public fun le(arg0: I128, arg1: I128) : bool {
        let v0 = arg0.bits >= 170141183460469231731687303715884105728;
        v0 != arg1.bits >= 170141183460469231731687303715884105728 && v0 || arg0.bits <= arg1.bits
    }

    public fun lt(arg0: I128, arg1: I128) : bool {
        let v0 = arg0.bits >= 170141183460469231731687303715884105728;
        v0 != arg1.bits >= 170141183460469231731687303715884105728 && v0 || arg0.bits < arg1.bits
    }

    public fun max(arg0: I128, arg1: I128) : I128 {
        if (lt(arg0, arg1)) {
            arg1
        } else {
            arg0
        }
    }

    public fun max_value() : I128 {
        I128{bits: 170141183460469231731687303715884105728 - 1}
    }

    public fun min(arg0: I128, arg1: I128) : I128 {
        if (lt(arg1, arg0)) {
            arg1
        } else {
            arg0
        }
    }

    public fun min_value() : I128 {
        I128{bits: 170141183460469231731687303715884105728}
    }

    public fun mod(arg0: I128, arg1: I128) : I128 {
        let v0 = abs_u(arg1);
        let v1 = abs_u(arg0) % v0;
        let v2 = arg1.bits >= 170141183460469231731687303715884105728;
        if (v1 != 0 && arg0.bits >= 170141183460469231731687303715884105728 != v2) {
            from_parts(v2, v0 - v1)
        } else {
            from_parts(v2, v1)
        }
    }

    public fun mul(arg0: I128, arg1: I128) : I128 {
        let v0 = abs_u(arg0);
        let v1 = abs_u(arg1);
        let v2 = arg0.bits >= 170141183460469231731687303715884105728 != arg1.bits >= 170141183460469231731687303715884105728;
        if (v0 != 0) {
            let v3 = if (v2) {
                170141183460469231731687303715884105728
            } else {
                170141183460469231731687303715884105728 - 1
            };
            assert!(v1 <= v3 / v0, 1);
        };
        from_parts(v2, v0 * v1)
    }

    public fun neg(arg0: I128) : I128 {
        assert!(arg0.bits != 170141183460469231731687303715884105728, 1);
        I128{bits: neg_bits(arg0.bits)}
    }

    fun neg_bits(arg0: u128) : u128 {
        if (arg0 == 0) {
            0
        } else {
            340282366920938463463374607431768211455 - arg0 + 1
        }
    }

    public fun rem(arg0: I128, arg1: I128) : I128 {
        from_parts(arg0.bits >= 170141183460469231731687303715884105728, abs_u(arg0) % abs_u(arg1))
    }

    public fun shl(arg0: I128, arg1: u8) : I128 {
        let v0 = arg0.bits >= 170141183460469231731687303715884105728;
        let v1 = abs_u(arg0);
        let v2 = if (v0) {
            170141183460469231731687303715884105728
        } else {
            170141183460469231731687303715884105728 - 1
        };
        assert!(v1 <= v2 >> arg1, 1);
        from_parts(v0, v1 << arg1)
    }

    public fun shr(arg0: I128, arg1: u8) : I128 {
        if (arg0.bits >= 170141183460469231731687303715884105728) {
            I128{bits: 340282366920938463463374607431768211455 - (340282366920938463463374607431768211455 - arg0.bits >> arg1)}
        } else {
            I128{bits: arg0.bits >> arg1}
        }
    }

    public fun sub(arg0: I128, arg1: I128) : I128 {
        let v0 = wsub(arg0.bits, arg1.bits);
        let v1 = arg0.bits >= 170141183460469231731687303715884105728;
        assert!(v1 == arg1.bits >= 170141183460469231731687303715884105728 || v0 >= 170141183460469231731687303715884105728 == v1, 1);
        I128{bits: v0}
    }

    public fun to_u(arg0: I128) : u128 {
        assert!(arg0.bits < 170141183460469231731687303715884105728, 2);
        arg0.bits
    }

    fun wadd(arg0: u128, arg1: u128) : u128 {
        let v0 = 340282366920938463463374607431768211455 - arg1;
        if (arg0 > v0) {
            arg0 - v0 - 1
        } else {
            arg0 + arg1
        }
    }

    fun wsub(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            340282366920938463463374607431768211455 - arg1 + arg0 + 1
        }
    }

    public fun zero() : I128 {
        I128{bits: 0}
    }

    // decompiled from Move bytecode v7
}

