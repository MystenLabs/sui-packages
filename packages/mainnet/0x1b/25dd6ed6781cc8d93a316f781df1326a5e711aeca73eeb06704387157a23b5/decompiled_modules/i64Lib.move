module 0x1b25dd6ed6781cc8d93a316f781df1326a5e711aeca73eeb06704387157a23b5::i64Lib {
    struct I64 has copy, drop, store {
        bits: u64,
    }

    public fun abs(arg0: &I64) : I64 {
        if (arg0.bits < 9223372036854775808) {
            *arg0
        } else {
            I64{bits: arg0.bits - 9223372036854775808}
        }
    }

    public fun add(arg0: &I64, arg1: &I64) : I64 {
        if (arg0.bits >> 63 == 0) {
            if (arg1.bits >> 63 == 0) {
                return I64{bits: arg0.bits + arg1.bits}
            };
            if (arg1.bits - 9223372036854775808 <= arg0.bits) {
                return I64{bits: arg0.bits - arg1.bits - 9223372036854775808}
            };
            return I64{bits: arg1.bits - arg0.bits}
        };
        if (arg1.bits >> 63 == 0) {
            if (arg0.bits - 9223372036854775808 <= arg1.bits) {
                return I64{bits: arg1.bits - arg0.bits - 9223372036854775808}
            };
            return I64{bits: arg0.bits - arg1.bits}
        };
        I64{bits: arg0.bits + arg1.bits - 9223372036854775808}
    }

    public fun as_u64(arg0: &I64) : u64 {
        assert!(arg0.bits < 9223372036854775808, 1);
        arg0.bits
    }

    public fun compare(arg0: &I64, arg1: &I64) : u8 {
        if (arg0.bits == arg1.bits) {
            return 0
        };
        if (arg0.bits < 9223372036854775808) {
            if (arg1.bits < 9223372036854775808) {
                return if (arg0.bits > arg1.bits) {
                    2
                } else {
                    1
                }
            };
            return 2
        };
        if (arg1.bits < 9223372036854775808) {
            return 1
        };
        if (arg0.bits > arg1.bits) {
            1
        } else {
            2
        }
    }

    public fun div(arg0: &I64, arg1: &I64) : I64 {
        if (arg0.bits >> 63 == 0) {
            if (arg1.bits >> 63 == 0) {
                return I64{bits: arg0.bits / arg1.bits}
            };
            return I64{bits: 9223372036854775808 | arg0.bits / (arg1.bits - 9223372036854775808)}
        };
        if (arg1.bits >> 63 == 0) {
            return I64{bits: 9223372036854775808 | (arg0.bits - 9223372036854775808) / arg1.bits}
        };
        I64{bits: (arg0.bits - 9223372036854775808) / (arg1.bits - 9223372036854775808)}
    }

    public fun from(arg0: u64) : I64 {
        assert!(arg0 <= 9223372036854775807, 0);
        I64{bits: arg0}
    }

    public fun getEual() : u8 {
        0
    }

    public fun getGreaterThan() : u8 {
        2
    }

    public fun getLessThan() : u8 {
        1
    }

    public fun is_neg(arg0: &I64) : bool {
        arg0.bits > 9223372036854775808
    }

    public fun is_zero(arg0: &I64) : bool {
        arg0.bits == 0
    }

    public fun mul(arg0: &I64, arg1: &I64) : I64 {
        if (arg0.bits >> 63 == 0) {
            if (arg1.bits >> 63 == 0) {
                return I64{bits: arg0.bits * arg1.bits}
            };
            return I64{bits: 9223372036854775808 | arg0.bits * (arg1.bits - 9223372036854775808)}
        };
        if (arg1.bits >> 63 == 0) {
            return I64{bits: 9223372036854775808 | arg1.bits * (arg0.bits - 9223372036854775808)}
        };
        I64{bits: (arg0.bits - 9223372036854775808) * (arg1.bits - 9223372036854775808)}
    }

    public fun neg(arg0: &I64) : I64 {
        if (arg0.bits == 0) {
            return *arg0
        };
        let v0 = if (arg0.bits < 9223372036854775808) {
            arg0.bits | 9223372036854775808
        } else {
            arg0.bits - 9223372036854775808
        };
        I64{bits: v0}
    }

    public fun neg_from(arg0: u64) : I64 {
        let v0 = from(arg0);
        if (v0.bits > 0) {
            v0.bits = v0.bits | 9223372036854775808;
        };
        v0
    }

    public fun sub(arg0: &I64, arg1: &I64) : I64 {
        if (arg0.bits >> 63 == 0) {
            if (arg1.bits >> 63 == 0) {
                if (arg0.bits >= arg1.bits) {
                    return I64{bits: arg0.bits - arg1.bits}
                };
                return I64{bits: 9223372036854775808 | arg1.bits - arg0.bits}
            };
            return I64{bits: arg0.bits + arg1.bits - 9223372036854775808}
        };
        if (arg1.bits >> 63 == 0) {
            return I64{bits: arg0.bits + arg1.bits}
        };
        if (arg1.bits >= arg0.bits) {
            return I64{bits: arg1.bits - arg0.bits}
        };
        I64{bits: arg0.bits - arg1.bits - 9223372036854775808}
    }

    public fun zero() : I64 {
        I64{bits: 0}
    }

    // decompiled from Move bytecode v6
}

