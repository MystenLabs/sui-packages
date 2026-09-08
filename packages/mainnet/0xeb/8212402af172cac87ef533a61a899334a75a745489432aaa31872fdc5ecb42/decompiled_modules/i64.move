module 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::i64 {
    struct I64 has copy, drop, store {
        magnitude: u64,
        is_negative: bool,
    }

    public fun add(arg0: &I64, arg1: &I64) : I64 {
        if (arg0.is_negative == arg1.is_negative) {
            from_parts(arg0.magnitude + arg1.magnitude, arg0.is_negative)
        } else if (arg0.magnitude >= arg1.magnitude) {
            from_parts(arg0.magnitude - arg1.magnitude, arg0.is_negative)
        } else {
            from_parts(arg1.magnitude - arg0.magnitude, arg1.is_negative)
        }
    }

    public fun div_scaled(arg0: &I64, arg1: &I64) : I64 {
        assert!(arg1.magnitude > 0, 0);
        from_parts((((arg0.magnitude as u128) * 1000000000 / (arg1.magnitude as u128)) as u64), arg0.is_negative != arg1.is_negative)
    }

    public fun from_parts(arg0: u64, arg1: bool) : I64 {
        if (arg0 == 0) {
            zero()
        } else {
            I64{magnitude: arg0, is_negative: arg1}
        }
    }

    public fun from_u64(arg0: u64) : I64 {
        I64{
            magnitude   : arg0,
            is_negative : false,
        }
    }

    public fun is_negative(arg0: &I64) : bool {
        arg0.is_negative
    }

    public fun is_zero(arg0: &I64) : bool {
        arg0.magnitude == 0
    }

    public fun magnitude(arg0: &I64) : u64 {
        arg0.magnitude
    }

    public fun mul_scaled(arg0: &I64, arg1: &I64) : I64 {
        from_parts((((arg0.magnitude as u128) * (arg1.magnitude as u128) / 1000000000) as u64), arg0.is_negative != arg1.is_negative)
    }

    public fun neg(arg0: &I64) : I64 {
        if (arg0.magnitude == 0) {
            zero()
        } else {
            I64{magnitude: arg0.magnitude, is_negative: !arg0.is_negative}
        }
    }

    public fun square_scaled(arg0: &I64) : u64 {
        let v0 = mul_scaled(arg0, arg0);
        v0.magnitude
    }

    public fun sub(arg0: &I64, arg1: &I64) : I64 {
        let v0 = neg(arg1);
        add(arg0, &v0)
    }

    public fun zero() : I64 {
        I64{
            magnitude   : 0,
            is_negative : false,
        }
    }

    // decompiled from Move bytecode v7
}

