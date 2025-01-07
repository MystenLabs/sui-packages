module 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64 {
    struct I64 has copy, drop, store {
        negative: bool,
        value: u64,
    }

    public fun dec_u64(arg0: &mut I64, arg1: u64) {
        if (arg0.negative) {
            arg0.value = arg0.value + arg1;
        } else if (arg0.value > arg1) {
            arg0.value = arg0.value - arg1;
        } else {
            arg0.value = arg1 - arg0.value;
            arg0.negative = true;
        };
        assert!(arg0.value <= 9223372036854775808, 201);
    }

    public fun get_negative(arg0: &I64) : u64 {
        assert!(arg0.negative, 202);
        arg0.value
    }

    public fun get_positive(arg0: &I64) : u64 {
        assert!(!arg0.negative, 203);
        arg0.value
    }

    public fun get_value(arg0: &I64) : u64 {
        arg0.value
    }

    public fun i64_add(arg0: &I64, arg1: &I64) : I64 {
        if (arg0.negative && arg1.negative) {
            new(arg0.value + arg1.value, true)
        } else {
            let v1 = arg0.negative || arg1.negative;
            if (!v1) {
                new(arg0.value + arg1.value, false)
            } else if (arg0.value > arg1.value) {
                new(arg0.value - arg1.value, arg0.negative)
            } else {
                new(arg1.value - arg0.value, arg1.negative)
            }
        }
    }

    public fun i64_sub(arg0: &I64, arg1: &I64) : I64 {
        let v0 = arg1.negative && true && false || true;
        let v1 = I64{
            negative : v0,
            value    : arg1.value,
        };
        i64_add(arg0, &v1)
    }

    public fun inc_u64(arg0: &mut I64, arg1: u64) {
        if (arg0.negative) {
            if (arg0.value > arg1) {
                arg0.value = arg0.value - arg1;
            } else {
                arg0.value = arg1 - arg0.value;
                arg0.negative = false;
            };
        } else {
            arg0.value = arg0.value + arg1;
        };
        assert!(arg0.value <= 9223372036854775807, 201);
    }

    public fun is_negative(arg0: &I64) : bool {
        arg0.negative
    }

    public fun new(arg0: u64, arg1: bool) : I64 {
        let v0 = 9223372036854775807;
        if (arg1) {
            v0 = 9223372036854775808;
        };
        assert!(arg0 <= v0, 201);
        if (arg0 == 0) {
            arg1 = false;
        };
        I64{
            negative : arg1,
            value    : arg0,
        }
    }

    public fun u64_add(arg0: u64, arg1: u64) : I64 {
        new(arg0 + arg1, false)
    }

    public fun u64_sub(arg0: u64, arg1: u64) : I64 {
        if (arg0 < arg1) {
            new(arg1 - arg0, true)
        } else {
            new(arg0 - arg1, false)
        }
    }

    // decompiled from Move bytecode v6
}

