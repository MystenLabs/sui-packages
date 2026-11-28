module 0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::bigrational {
    struct BigRational has copy, drop, store {
        num: 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::BigInt,
        den: vector<u64>,
    }

    public fun abs(arg0: &BigRational) : BigRational {
        BigRational{
            num : 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::abs(&arg0.num),
            den : arg0.den,
        }
    }

    public fun add(arg0: &BigRational, arg1: &BigRational) : BigRational {
        let v0 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::from_parts(false, arg1.den);
        let v1 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::from_parts(false, arg0.den);
        let v2 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::mul(&arg0.num, &v0);
        let v3 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::mul(&arg1.num, &v1);
        let v4 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::add(&v2, &v3);
        let v5 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::mul(&arg0.den, &arg1.den);
        make_int(&v4, &v5)
    }

    public fun cmp(arg0: &BigRational, arg1: &BigRational) : u8 {
        let v0 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::from_parts(false, arg1.den);
        let v1 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::from_parts(false, arg0.den);
        let v2 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::mul(&arg0.num, &v0);
        let v3 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::mul(&arg1.num, &v1);
        0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::cmp(&v2, &v3)
    }

    public fun mul(arg0: &BigRational, arg1: &BigRational) : BigRational {
        let v0 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::mul(&arg0.num, &arg1.num);
        let v1 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::mul(&arg0.den, &arg1.den);
        make_int(&v0, &v1)
    }

    public fun neg(arg0: &BigRational) : BigRational {
        BigRational{
            num : 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::neg(&arg0.num),
            den : arg0.den,
        }
    }

    public fun sub(arg0: &BigRational, arg1: &BigRational) : BigRational {
        let v0 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::from_parts(false, arg1.den);
        let v1 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::from_parts(false, arg0.den);
        let v2 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::mul(&arg0.num, &v0);
        let v3 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::mul(&arg1.num, &v1);
        let v4 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::sub(&v2, &v3);
        let v5 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::mul(&arg0.den, &arg1.den);
        make_int(&v4, &v5)
    }

    public fun div(arg0: &BigRational, arg1: &BigRational) : BigRational {
        let v0 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::magnitude(&arg1.num);
        assert!(0x1::vector::length<u64>(&v0) > 0, 4);
        let v1 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::from_parts(0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::is_neg(&arg1.num), arg1.den);
        let v2 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::mul(&arg0.num, &v1);
        let v3 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::mul(&arg0.den, &v0);
        make_int(&v2, &v3)
    }

    public fun ceil(arg0: &BigRational) : 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::BigInt {
        let v0 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::neg(&arg0.num);
        let v1 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::from_parts(false, arg0.den);
        let v2 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::div_euclid(&v0, &v1);
        0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::neg(&v2)
    }

    public fun den(arg0: &BigRational) : vector<u64> {
        arg0.den
    }

    public fun eq(arg0: &BigRational, arg1: &BigRational) : bool {
        cmp(arg0, arg1) == 1
    }

    public fun floor(arg0: &BigRational) : 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::BigInt {
        let v0 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::from_parts(false, arg0.den);
        0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::div_euclid(&arg0.num, &v0)
    }

    public fun from_int(arg0: 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::BigInt) : BigRational {
        let v0 = vector[1];
        make_int(&arg0, &v0)
    }

    fun gcd(arg0: &vector<u64>, arg1: &vector<u64>) : vector<u64> {
        let v0 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::normalize(*arg0);
        let v1 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::normalize(*arg1);
        while (0x1::vector::length<u64>(&v1) > 0 && (0x1::vector::length<u64>(&v0) > 4 || 0x1::vector::length<u64>(&v1) > 4)) {
            let v2 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::rem(&v0, &v1);
            v0 = v1;
            v1 = v2;
        };
        if (0x1::vector::length<u64>(&v1) == 0) {
            return v0
        };
        0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::from_u256(0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::gcd(0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::to_u256(&v0), 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::to_u256(&v1)))
    }

    public fun le(arg0: &BigRational, arg1: &BigRational) : bool {
        cmp(arg0, arg1) != 2
    }

    public fun lt(arg0: &BigRational, arg1: &BigRational) : bool {
        cmp(arg0, arg1) == 0
    }

    fun make(arg0: bool, arg1: vector<u64>, arg2: vector<u64>) : BigRational {
        let v0 = gcd(&arg1, &arg2);
        BigRational{
            num : 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::from_parts(arg0, 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::div(&arg1, &v0)),
            den : 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::div(&arg2, &v0),
        }
    }

    fun make_int(arg0: &0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::BigInt, arg1: &vector<u64>) : BigRational {
        make(0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::is_neg(arg0), 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::magnitude(arg0), *arg1)
    }

    public fun mediant(arg0: &BigRational, arg1: &BigRational) : BigRational {
        let v0 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::add(&arg0.num, &arg1.num);
        let v1 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::add(&arg0.den, &arg1.den);
        make_int(&v0, &v1)
    }

    public fun new(arg0: 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::BigInt, arg1: vector<u64>) : BigRational {
        assert!(!0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::is_zero(&arg1), 1);
        make_int(&arg0, &arg1)
    }

    public fun num(arg0: &BigRational) : 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::BigInt {
        arg0.num
    }

    public fun round(arg0: &BigRational) : 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::BigInt {
        let v0 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::magnitude(&arg0.num);
        let v1 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::mul_small_add(&v0, 2, 0);
        let v2 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::add(&v1, &arg0.den);
        let v3 = 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::mul_small_add(&arg0.den, 2, 0);
        0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::from_parts(0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::bigint::is_neg(&arg0.num), 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint::div(&v2, &v3))
    }

    // decompiled from Move bytecode v7
}

