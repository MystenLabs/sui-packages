module 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i16 {
    struct I16 has copy, drop, store {
        bits: u16,
    }

    public fun abs(arg0: I16) : I16 {
        if (arg0.bits >= 32768) {
            neg(arg0)
        } else {
            arg0
        }
    }

    public fun abs_u(arg0: I16) : u16 {
        if (arg0.bits >= 32768) {
            neg_bits(arg0.bits)
        } else {
            arg0.bits
        }
    }

    public fun add(arg0: I16, arg1: I16) : I16 {
        let v0 = wadd(arg0.bits, arg1.bits);
        let v1 = arg0.bits >= 32768;
        assert!(v1 != arg1.bits >= 32768 || v0 >= 32768 == v1, 1);
        I16{bits: v0}
    }

    public fun bits(arg0: I16) : u16 {
        arg0.bits
    }

    public fun cmp(arg0: I16, arg1: I16) : u8 {
        if (arg0.bits == arg1.bits) {
            1
        } else if (lt(arg0, arg1)) {
            0
        } else {
            2
        }
    }

    public fun div_ceil(arg0: I16, arg1: I16) : I16 {
        let v0 = abs_u(arg0);
        let v1 = abs_u(arg1);
        let v2 = arg0.bits >= 32768 != arg1.bits >= 32768;
        if (!v2 && v0 % v1 != 0) {
            from_parts(false, v0 / v1 + 1)
        } else {
            from_parts(v2, v0 / v1)
        }
    }

    public fun div_floor(arg0: I16, arg1: I16) : I16 {
        let v0 = abs_u(arg0);
        let v1 = abs_u(arg1);
        let v2 = arg0.bits >= 32768 != arg1.bits >= 32768;
        if (v2 && v0 % v1 != 0) {
            from_parts(true, v0 / v1 + 1)
        } else {
            from_parts(v2, v0 / v1)
        }
    }

    public fun div_trunc(arg0: I16, arg1: I16) : I16 {
        from_parts(arg0.bits >= 32768 != arg1.bits >= 32768, abs_u(arg0) / abs_u(arg1))
    }

    public fun eq(arg0: I16, arg1: I16) : bool {
        arg0.bits == arg1.bits
    }

    public fun from_bits(arg0: u16) : I16 {
        I16{bits: arg0}
    }

    public fun from_parts(arg0: bool, arg1: u16) : I16 {
        if (arg0) {
            assert!(arg1 <= 32768, 1);
            I16{bits: neg_bits(arg1)}
        } else {
            assert!(arg1 < 32768, 1);
            I16{bits: arg1}
        }
    }

    public fun from_u(arg0: u16) : I16 {
        assert!(arg0 < 32768, 1);
        I16{bits: arg0}
    }

    public fun ge(arg0: I16, arg1: I16) : bool {
        le(arg1, arg0)
    }

    public fun gt(arg0: I16, arg1: I16) : bool {
        lt(arg1, arg0)
    }

    public fun is_neg(arg0: I16) : bool {
        arg0.bits >= 32768
    }

    public fun le(arg0: I16, arg1: I16) : bool {
        let v0 = arg0.bits >= 32768;
        v0 != arg1.bits >= 32768 && v0 || arg0.bits <= arg1.bits
    }

    public fun lt(arg0: I16, arg1: I16) : bool {
        let v0 = arg0.bits >= 32768;
        v0 != arg1.bits >= 32768 && v0 || arg0.bits < arg1.bits
    }

    public fun max(arg0: I16, arg1: I16) : I16 {
        if (lt(arg0, arg1)) {
            arg1
        } else {
            arg0
        }
    }

    public fun max_value() : I16 {
        I16{bits: 32768 - 1}
    }

    public fun min(arg0: I16, arg1: I16) : I16 {
        if (lt(arg1, arg0)) {
            arg1
        } else {
            arg0
        }
    }

    public fun min_value() : I16 {
        I16{bits: 32768}
    }

    public fun mod(arg0: I16, arg1: I16) : I16 {
        let v0 = abs_u(arg1);
        let v1 = abs_u(arg0) % v0;
        let v2 = arg1.bits >= 32768;
        if (v1 != 0 && arg0.bits >= 32768 != v2) {
            from_parts(v2, v0 - v1)
        } else {
            from_parts(v2, v1)
        }
    }

    public fun mul(arg0: I16, arg1: I16) : I16 {
        let v0 = abs_u(arg0);
        let v1 = abs_u(arg1);
        let v2 = arg0.bits >= 32768 != arg1.bits >= 32768;
        if (v0 != 0) {
            let v3 = if (v2) {
                32768
            } else {
                32768 - 1
            };
            assert!(v1 <= v3 / v0, 1);
        };
        from_parts(v2, v0 * v1)
    }

    public fun neg(arg0: I16) : I16 {
        assert!(arg0.bits != 32768, 1);
        I16{bits: neg_bits(arg0.bits)}
    }

    fun neg_bits(arg0: u16) : u16 {
        if (arg0 == 0) {
            0
        } else {
            65535 - arg0 + 1
        }
    }

    public fun rem(arg0: I16, arg1: I16) : I16 {
        from_parts(arg0.bits >= 32768, abs_u(arg0) % abs_u(arg1))
    }

    public fun shl(arg0: I16, arg1: u8) : I16 {
        let v0 = arg0.bits >= 32768;
        let v1 = abs_u(arg0);
        let v2 = if (v0) {
            32768
        } else {
            32768 - 1
        };
        assert!(v1 <= v2 >> arg1, 1);
        from_parts(v0, v1 << arg1)
    }

    public fun shr(arg0: I16, arg1: u8) : I16 {
        if (arg0.bits >= 32768) {
            I16{bits: 65535 - (65535 - arg0.bits >> arg1)}
        } else {
            I16{bits: arg0.bits >> arg1}
        }
    }

    public fun sub(arg0: I16, arg1: I16) : I16 {
        let v0 = wsub(arg0.bits, arg1.bits);
        let v1 = arg0.bits >= 32768;
        assert!(v1 == arg1.bits >= 32768 || v0 >= 32768 == v1, 1);
        I16{bits: v0}
    }

    public fun to_u(arg0: I16) : u16 {
        assert!(arg0.bits < 32768, 2);
        arg0.bits
    }

    fun wadd(arg0: u16, arg1: u16) : u16 {
        let v0 = 65535 - arg1;
        if (arg0 > v0) {
            arg0 - v0 - 1
        } else {
            arg0 + arg1
        }
    }

    fun wsub(arg0: u16, arg1: u16) : u16 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            65535 - arg1 + arg0 + 1
        }
    }

    public fun zero() : I16 {
        I16{bits: 0}
    }

    // decompiled from Move bytecode v7
}

