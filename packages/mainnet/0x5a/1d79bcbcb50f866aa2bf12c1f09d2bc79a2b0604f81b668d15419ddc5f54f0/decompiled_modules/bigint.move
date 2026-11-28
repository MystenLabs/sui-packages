module 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint {
    struct BigInt has copy, drop, store {
        neg: bool,
        mag: vector<u64>,
    }

    public fun abs(arg0: &BigInt) : BigInt {
        from_parts(false, arg0.mag)
    }

    public fun add(arg0: &BigInt, arg1: &BigInt) : BigInt {
        if (arg0.neg == arg1.neg) {
            return from_parts(arg0.neg, 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::add(&arg0.mag, &arg1.mag))
        };
        if (0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::cmp(&arg0.mag, &arg1.mag) != 0) {
            from_parts(arg0.neg, 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::sub(&arg0.mag, &arg1.mag))
        } else {
            from_parts(arg1.neg, 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::sub(&arg1.mag, &arg0.mag))
        }
    }

    public fun cmp(arg0: &BigInt, arg1: &BigInt) : u8 {
        let v0 = is_neg(arg0);
        if (v0 != is_neg(arg1)) {
            return if (v0) {
                0
            } else {
                2
            }
        };
        if (v0) {
            2 - 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::cmp(&arg0.mag, &arg1.mag)
        } else {
            0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::cmp(&arg0.mag, &arg1.mag)
        }
    }

    public fun div_euclid(arg0: &BigInt, arg1: &BigInt) : BigInt {
        let (v0, _) = divmod_euclid(arg0, arg1);
        v0
    }

    public fun divmod_euclid(arg0: &BigInt, arg1: &BigInt) : (BigInt, BigInt) {
        let (v0, v1) = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::divmod(&arg0.mag, &arg1.mag);
        let v2 = v0;
        let v3 = v1;
        if (arg0.neg && 0x1::vector::length<u64>(&v3) > 0) {
            let v4 = &v2;
            let v5 = vector[1];
            v2 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::add(v4, &v5);
            let v6 = &v3;
            v3 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::sub(&arg1.mag, v6);
        };
        (from_parts(arg0.neg != arg1.neg, v2), from_parts(false, v3))
    }

    public fun from_parts(arg0: bool, arg1: vector<u64>) : BigInt {
        let v0 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::normalize(arg1);
        let v1 = arg0 && 0x1::vector::length<u64>(&v0) > 0;
        BigInt{
            neg : v1,
            mag : v0,
        }
    }

    public fun is_neg(arg0: &BigInt) : bool {
        arg0.neg && !0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::is_zero(&arg0.mag)
    }

    public fun magnitude(arg0: &BigInt) : vector<u64> {
        0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::normalize(arg0.mag)
    }

    public fun mul(arg0: &BigInt, arg1: &BigInt) : BigInt {
        from_parts(arg0.neg != arg1.neg, 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::mul(&arg0.mag, &arg1.mag))
    }

    public fun neg(arg0: &BigInt) : BigInt {
        from_parts(!arg0.neg, arg0.mag)
    }

    public fun rem_euclid(arg0: &BigInt, arg1: &BigInt) : BigInt {
        let (_, v1) = divmod_euclid(arg0, arg1);
        v1
    }

    public fun sub(arg0: &BigInt, arg1: &BigInt) : BigInt {
        let v0 = neg(arg1);
        add(arg0, &v0)
    }

    // decompiled from Move bytecode v7
}

