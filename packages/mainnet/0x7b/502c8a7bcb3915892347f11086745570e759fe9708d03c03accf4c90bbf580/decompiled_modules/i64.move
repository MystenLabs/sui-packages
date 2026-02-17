module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64 {
    struct I64 has copy, drop, store {
        negative: bool,
        magnitude: u64,
    }

    public fun from_u64(arg0: u64) : I64 {
        let v0 = arg0 >> 63 == 1;
        let v1 = if (!v0) {
            arg0
        } else {
            (arg0 ^ 18446744073709551615) + 1
        };
        new(v1, v0)
    }

    public fun get_is_negative(arg0: &I64) : bool {
        arg0.negative
    }

    public fun get_magnitude_if_negative(arg0: &I64) : u64 {
        assert!(arg0.negative, 13906834410566975495);
        arg0.magnitude
    }

    public fun get_magnitude_if_positive(arg0: &I64) : u64 {
        assert!(!arg0.negative, 13906834389092007941);
        arg0.magnitude
    }

    public fun new(arg0: u64, arg1: bool) : I64 {
        let v0 = 9223372036854775807;
        if (arg1) {
            v0 = 9223372036854775808;
        };
        assert!(arg0 <= v0, 13906834303192530947);
        if (arg0 == 0) {
            arg1 = false;
        };
        I64{
            negative  : arg1,
            magnitude : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

