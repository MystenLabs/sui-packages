module 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::signed {
    struct Signed has copy, drop, store {
        magnitude: u128,
        negative: bool,
    }

    public fun add(arg0: &Signed, arg1: &Signed) : Signed {
        if (arg0.negative == arg1.negative) {
            pack_signed(checked_add_or_abort(arg0.magnitude, arg1.magnitude), arg0.negative)
        } else if (arg0.magnitude >= arg1.magnitude) {
            pack_signed(arg0.magnitude - arg1.magnitude, arg0.negative)
        } else {
            pack_signed(arg1.magnitude - arg0.magnitude, arg1.negative)
        }
    }

    fun checked_add_or_abort(arg0: u128, arg1: u128) : u128 {
        let v0 = 0x1::u128::checked_add(arg0, arg1);
        assert!(0x1::option::is_some<u128>(&v0), 1008);
        0x1::option::destroy_some<u128>(v0)
    }

    fun checked_mul_or_abort(arg0: u128, arg1: u128) : u128 {
        let v0 = 0x1::u128::checked_mul(arg0, arg1);
        assert!(0x1::option::is_some<u128>(&v0), 1008);
        0x1::option::destroy_some<u128>(v0)
    }

    public fun cross_sign(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : Signed {
        let v0 = sub_u64(arg2, arg0);
        let v1 = sub_u64(arg5, arg1);
        let v2 = mul(&v0, &v1);
        let v3 = sub_u64(arg3, arg1);
        let v4 = sub_u64(arg4, arg0);
        let v5 = mul(&v3, &v4);
        if (v2.negative == v5.negative) {
            if (v2.magnitude >= v5.magnitude) {
                pack_signed(v2.magnitude - v5.magnitude, v2.negative)
            } else {
                pack_signed(v5.magnitude - v2.magnitude, !v5.negative)
            }
        } else {
            pack_signed(checked_add_or_abort(v2.magnitude, v5.magnitude), v2.negative)
        }
    }

    public fun eq(arg0: &Signed, arg1: &Signed) : bool {
        arg0.magnitude == 0 && arg1.magnitude == 0 || arg0.magnitude == arg1.magnitude && arg0.negative == arg1.negative
    }

    public fun from_u64(arg0: u64) : Signed {
        pack_signed((arg0 as u128), false)
    }

    public fun ge(arg0: &Signed, arg1: &Signed) : bool {
        !lt(arg0, arg1)
    }

    public fun gt(arg0: &Signed, arg1: &Signed) : bool {
        !le(arg0, arg1)
    }

    public fun is_negative(arg0: &Signed) : bool {
        arg0.negative
    }

    public fun le(arg0: &Signed, arg1: &Signed) : bool {
        lt(arg0, arg1) || eq(arg0, arg1)
    }

    public fun lt(arg0: &Signed, arg1: &Signed) : bool {
        eq(arg0, arg1) && false || arg0.negative != arg1.negative && arg0.negative || arg0.negative && arg0.magnitude > arg1.magnitude || arg0.magnitude < arg1.magnitude
    }

    public fun magnitude(arg0: &Signed) : u128 {
        arg0.magnitude
    }

    public fun mul(arg0: &Signed, arg1: &Signed) : Signed {
        if (arg0.magnitude == 0 || arg1.magnitude == 0) {
            return pack_signed(0, false)
        };
        pack_signed(checked_mul_or_abort(arg0.magnitude, arg1.magnitude), arg0.negative != arg1.negative)
    }

    public fun new(arg0: u128, arg1: bool) : Signed {
        pack_signed(arg0, arg1)
    }

    fun pack_signed(arg0: u128, arg1: bool) : Signed {
        let v0 = arg0 != 0 && arg1;
        Signed{
            magnitude : arg0,
            negative  : v0,
        }
    }

    public fun sub_u64(arg0: u64, arg1: u64) : Signed {
        if (arg0 >= arg1) {
            pack_signed(((arg0 - arg1) as u128), false)
        } else {
            pack_signed(((arg1 - arg0) as u128), true)
        }
    }

    // decompiled from Move bytecode v7
}

