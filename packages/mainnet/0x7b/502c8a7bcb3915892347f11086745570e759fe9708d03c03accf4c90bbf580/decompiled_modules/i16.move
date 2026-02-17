module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16 {
    struct I16 has copy, drop, store {
        negative: bool,
        magnitude: u16,
    }

    public fun from_u16(arg0: u16) : I16 {
        let v0 = arg0 >> 15 == 1;
        let v1 = if (!v0) {
            arg0
        } else {
            (arg0 ^ 65535) + 1
        };
        new(v1, v0)
    }

    public fun get_is_negative(arg0: &I16) : bool {
        arg0.negative
    }

    public fun get_magnitude_if_negative(arg0: &I16) : u16 {
        assert!(arg0.negative, 13906834406272008199);
        arg0.magnitude
    }

    public fun get_magnitude_if_positive(arg0: &I16) : u16 {
        assert!(!arg0.negative, 13906834384797040645);
        arg0.magnitude
    }

    public fun new(arg0: u16, arg1: bool) : I16 {
        let v0 = 32767;
        if (arg1) {
            v0 = 32768;
        };
        assert!(arg0 <= v0, 13906834303192530947);
        if (arg0 == 0) {
            arg1 = false;
        };
        I16{
            negative  : arg1,
            magnitude : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

