module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::i64 {
    struct I64 has copy, drop, store {
        negative: bool,
        magnitude: u64,
    }

    public(friend) fun add(arg0: &I64, arg1: &I64) : I64 {
        if (arg0.negative == arg1.negative) {
            let v1 = arg0.magnitude + arg1.magnitude;
            if (!arg0.negative) {
                assert!(v1 <= 9223372036854775807, 1);
            } else {
                assert!(v1 <= 9223372036854775808, 2);
            };
            new(v1, arg0.negative)
        } else if (arg0.magnitude >= arg1.magnitude) {
            new(arg0.magnitude - arg1.magnitude, arg0.negative)
        } else {
            new(arg1.magnitude - arg0.magnitude, arg1.negative)
        }
    }

    public fun checked_add(arg0: &I64, arg1: &I64) : I64 {
        add(arg0, arg1)
    }

    public fun checked_sub(arg0: &I64, arg1: &I64) : I64 {
        sub(arg0, arg1)
    }

    public fun eq(arg0: &I64, arg1: &I64) : bool {
        arg0.negative == arg1.negative && arg0.magnitude == arg1.magnitude
    }

    public(friend) fun from_u64(arg0: u64) : I64 {
        let v0 = arg0 >> 63 == 1;
        new(parse_magnitude(arg0, v0), v0)
    }

    public(friend) fun get_magnitude_if_negative(arg0: &I64) : u64 {
        assert!(arg0.negative, 0);
        arg0.magnitude
    }

    public(friend) fun get_magnitude_if_positive(arg0: &I64) : u64 {
        assert!(!arg0.negative, 0);
        arg0.magnitude
    }

    public fun gt(arg0: &I64, arg1: &I64) : bool {
        lt(arg1, arg0)
    }

    public(friend) fun is_negative(arg0: &I64) : bool {
        arg0.negative
    }

    public fun lt(arg0: &I64, arg1: &I64) : bool {
        if (arg0.negative && !arg1.negative) {
            return true
        };
        if (!arg0.negative && arg1.negative) {
            return false
        };
        if (arg0.negative) {
            return arg0.magnitude > arg1.magnitude
        };
        arg0.magnitude < arg1.magnitude
    }

    public(friend) fun new(arg0: u64, arg1: bool) : I64 {
        let v0 = 9223372036854775807;
        if (arg1) {
            v0 = 9223372036854775808;
        };
        assert!(arg0 <= v0, 0);
        if (arg0 == 0) {
            arg1 = false;
        };
        I64{
            negative  : arg1,
            magnitude : arg0,
        }
    }

    fun parse_magnitude(arg0: u64, arg1: bool) : u64 {
        if (!arg1) {
            return arg0
        };
        (arg0 ^ 18446744073709551615) + 1
    }

    public fun saturating_add(arg0: &I64, arg1: &I64) : I64 {
        let v0 = add(arg0, arg1);
        if (arg0.negative == arg1.negative && v0.negative != arg0.negative) {
            if (arg0.negative) {
                return new(9223372036854775808, true)
            };
            return new(9223372036854775807, false)
        };
        v0
    }

    public fun saturating_sub(arg0: &I64, arg1: &I64) : I64 {
        let v0 = sub(arg0, arg1);
        if (arg0.negative != arg1.negative && v0.negative != arg0.negative) {
            if (arg0.negative) {
                return new(9223372036854775808, true)
            };
            return new(9223372036854775807, false)
        };
        v0
    }

    public(friend) fun sub(arg0: &I64, arg1: &I64) : I64 {
        let v0 = new(arg1.magnitude, !arg1.negative);
        add(arg0, &v0)
    }

    // decompiled from Move bytecode v6
}

