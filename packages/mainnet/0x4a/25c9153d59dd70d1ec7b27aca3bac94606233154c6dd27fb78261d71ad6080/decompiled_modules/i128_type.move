module 0x4a25c9153d59dd70d1ec7b27aca3bac94606233154c6dd27fb78261d71ad6080::i128_type {
    struct I128 has copy, drop, store {
        bits: u128,
    }

    public fun abs(arg0: &I128) : I128 {
        if (arg0.bits < 170141183460469231731687303715884105728) {
            *arg0
        } else {
            I128{bits: arg0.bits - 170141183460469231731687303715884105728}
        }
    }

    public fun add(arg0: &I128, arg1: &I128) : I128 {
        if (arg0.bits >> 127 == 0) {
            if (arg1.bits >> 127 == 0) {
                return I128{bits: arg0.bits + arg1.bits}
            };
            if (arg1.bits - 170141183460469231731687303715884105728 <= arg0.bits) {
                return I128{bits: arg0.bits - arg1.bits - 170141183460469231731687303715884105728}
            };
            return I128{bits: arg1.bits - arg0.bits}
        };
        if (arg1.bits >> 127 == 0) {
            if (arg0.bits - 170141183460469231731687303715884105728 <= arg1.bits) {
                return I128{bits: arg1.bits - arg0.bits - 170141183460469231731687303715884105728}
            };
            return I128{bits: arg0.bits - arg1.bits}
        };
        I128{bits: arg0.bits + arg1.bits - 170141183460469231731687303715884105728}
    }

    public fun as_u128(arg0: &I128) : u128 {
        assert!(arg0.bits < 170141183460469231731687303715884105728, 65537);
        arg0.bits
    }

    public fun compare(arg0: &I128, arg1: &I128) : u8 {
        if (arg0.bits == arg1.bits) {
            return 0
        };
        if (arg0.bits < 170141183460469231731687303715884105728) {
            if (arg1.bits < 170141183460469231731687303715884105728) {
                return if (arg0.bits > arg1.bits) {
                    2
                } else {
                    1
                }
            };
            return 2
        };
        if (arg1.bits < 170141183460469231731687303715884105728) {
            return 1
        };
        if (arg0.bits > arg1.bits) {
            1
        } else {
            2
        }
    }

    public fun div(arg0: &I128, arg1: &I128) : I128 {
        if (arg0.bits >> 127 == 0) {
            if (arg1.bits >> 127 == 0) {
                return I128{bits: arg0.bits / arg1.bits}
            };
            return I128{bits: 170141183460469231731687303715884105728 | arg0.bits / (arg1.bits - 170141183460469231731687303715884105728)}
        };
        if (arg1.bits >> 127 == 0) {
            return I128{bits: 170141183460469231731687303715884105728 | (arg0.bits - 170141183460469231731687303715884105728) / arg1.bits}
        };
        I128{bits: (arg0.bits - 170141183460469231731687303715884105728) / (arg1.bits - 170141183460469231731687303715884105728)}
    }

    public fun from(arg0: u128) : I128 {
        assert!(arg0 <= 170141183460469231731687303715884105727, 65536);
        I128{bits: arg0}
    }

    public fun is_neg(arg0: &I128) : bool {
        arg0.bits > 170141183460469231731687303715884105728
    }

    public fun is_zero(arg0: &I128) : bool {
        arg0.bits == 0
    }

    public fun mul(arg0: &I128, arg1: &I128) : I128 {
        if (arg0.bits >> 127 == 0) {
            if (arg1.bits >> 127 == 0) {
                return I128{bits: arg0.bits * arg1.bits}
            };
            return I128{bits: 170141183460469231731687303715884105728 | arg0.bits * (arg1.bits - 170141183460469231731687303715884105728)}
        };
        if (arg1.bits >> 127 == 0) {
            return I128{bits: 170141183460469231731687303715884105728 | arg1.bits * (arg0.bits - 170141183460469231731687303715884105728)}
        };
        I128{bits: (arg0.bits - 170141183460469231731687303715884105728) * (arg1.bits - 170141183460469231731687303715884105728)}
    }

    public fun neg(arg0: &I128) : I128 {
        if (arg0.bits == 0) {
            return *arg0
        };
        let v0 = if (arg0.bits < 170141183460469231731687303715884105728) {
            arg0.bits | 170141183460469231731687303715884105728
        } else {
            arg0.bits - 170141183460469231731687303715884105728
        };
        I128{bits: v0}
    }

    public fun neg_from(arg0: u128) : I128 {
        let v0 = from(arg0);
        if (v0.bits > 0) {
            v0.bits = v0.bits | 170141183460469231731687303715884105728;
        };
        v0
    }

    public fun sub(arg0: &I128, arg1: &I128) : I128 {
        if (arg0.bits >> 127 == 0) {
            if (arg1.bits >> 127 == 0) {
                if (arg0.bits >= arg1.bits) {
                    return I128{bits: arg0.bits - arg1.bits}
                };
                return I128{bits: 170141183460469231731687303715884105728 | arg1.bits - arg0.bits}
            };
            return I128{bits: arg0.bits + arg1.bits - 170141183460469231731687303715884105728}
        };
        if (arg1.bits >> 127 == 0) {
            return I128{bits: arg0.bits + arg1.bits}
        };
        if (arg1.bits >= arg0.bits) {
            return I128{bits: arg1.bits - arg0.bits}
        };
        I128{bits: arg0.bits - arg1.bits - 170141183460469231731687303715884105728}
    }

    public fun zero() : I128 {
        I128{bits: 0}
    }

    // decompiled from Move bytecode v6
}

