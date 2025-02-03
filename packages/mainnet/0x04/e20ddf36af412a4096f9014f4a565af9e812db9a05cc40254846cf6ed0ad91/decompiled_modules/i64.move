module 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64 {
    struct I64 has copy, drop, store {
        negative: bool,
        magnitude: u64,
    }

    public fun from_u64(arg0: u64) : I64 {
        let v0 = arg0 >> 63 == 1;
        new(parse_magnitude(arg0, v0), v0)
    }

    public fun get_is_negative(arg0: &I64) : bool {
        arg0.negative
    }

    public fun get_magnitude_if_negative(arg0: &I64) : u64 {
        assert!(arg0.negative, 0);
        arg0.magnitude
    }

    public fun get_magnitude_if_positive(arg0: &I64) : u64 {
        assert!(!arg0.negative, 0);
        arg0.magnitude
    }

    public fun new(arg0: u64, arg1: bool) : I64 {
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

    // decompiled from Move bytecode v6
}

