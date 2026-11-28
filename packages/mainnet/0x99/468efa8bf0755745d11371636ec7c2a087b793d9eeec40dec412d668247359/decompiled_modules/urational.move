module 0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::urational {
    struct URational has copy, drop, store {
        num: u128,
        den: u128,
    }

    public fun add(arg0: URational, arg1: URational) : URational {
        let v0 = (arg0.den as u256);
        let v1 = (arg1.den as u256);
        let v2 = 0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::gcd(v0, v1);
        let v3 = v0 / v2;
        reduce((arg0.num as u256) * v1 / v2 + (arg1.num as u256) * v3, v3 * v1)
    }

    public fun ceil(arg0: URational) : u128 {
        if (arg0.num % arg0.den != 0) {
            arg0.num / arg0.den + 1
        } else {
            arg0.num / arg0.den
        }
    }

    public fun cmp(arg0: URational, arg1: URational) : u8 {
        let v0 = (arg0.num as u256) * (arg1.den as u256);
        let v1 = (arg1.num as u256) * (arg0.den as u256);
        if (v0 < v1) {
            0
        } else if (v0 == v1) {
            1
        } else {
            2
        }
    }

    public fun den(arg0: URational) : u128 {
        arg0.den
    }

    public fun div(arg0: URational, arg1: URational) : URational {
        assert!(arg1.num != 0, 4);
        reduce((arg0.num as u256) * (arg1.den as u256), (arg0.den as u256) * (arg1.num as u256))
    }

    public fun eq(arg0: URational, arg1: URational) : bool {
        cmp(arg0, arg1) == 1
    }

    public fun floor(arg0: URational) : u128 {
        arg0.num / arg0.den
    }

    public fun from_int(arg0: u128) : URational {
        URational{
            num : arg0,
            den : 1,
        }
    }

    public fun le(arg0: URational, arg1: URational) : bool {
        cmp(arg0, arg1) != 2
    }

    public fun lt(arg0: URational, arg1: URational) : bool {
        cmp(arg0, arg1) == 0
    }

    public fun mediant(arg0: URational, arg1: URational) : URational {
        reduce((arg0.num as u256) + (arg1.num as u256), (arg0.den as u256) + (arg1.den as u256))
    }

    public fun mul(arg0: URational, arg1: URational) : URational {
        reduce((arg0.num as u256) * (arg1.num as u256), (arg0.den as u256) * (arg1.den as u256))
    }

    public fun new(arg0: u128, arg1: u128) : URational {
        assert!(arg1 != 0, 1);
        reduce((arg0 as u256), (arg1 as u256))
    }

    public fun num(arg0: URational) : u128 {
        arg0.num
    }

    fun reduce(arg0: u256, arg1: u256) : URational {
        let v0 = 0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::gcd(arg0, arg1);
        let v1 = arg0 / v0;
        let v2 = arg1 / v0;
        assert!(v1 < 340282366920938463463374607431768211456, 2);
        assert!(v2 < 340282366920938463463374607431768211456, 2);
        URational{
            num : (v1 as u128),
            den : (v2 as u128),
        }
    }

    public fun round(arg0: URational) : u128 {
        let v0 = (arg0.den as u256);
        (((2 * (arg0.num as u256) + v0) / 2 * v0) as u128)
    }

    public fun sub(arg0: URational, arg1: URational) : URational {
        let v0 = (arg0.den as u256);
        let v1 = (arg1.den as u256);
        let v2 = 0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::gcd(v0, v1);
        let v3 = v0 / v2;
        let v4 = (arg0.num as u256) * v1 / v2;
        let v5 = (arg1.num as u256) * v3;
        assert!(v4 >= v5, 3);
        reduce(v4 - v5, v3 * v1)
    }

    // decompiled from Move bytecode v7
}

