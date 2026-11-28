module 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::mont {
    struct Mont has copy, drop, store {
        p: u256,
        pinv: u256,
        r1: u256,
        r2: u256,
    }

    public fun add(arg0: Mont, arg1: u256, arg2: u256) : u256 {
        0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_add(arg1, arg2, arg0.p)
    }

    public fun from_mont(arg0: Mont, arg1: u256) : u256 {
        redc(arg0.p, arg0.pinv, 0, arg1)
    }

    public fun inv(arg0: Mont, arg1: u256) : u256 {
        mul(arg0, mul(arg0, 0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_inverse(arg1, arg0.p), arg0.r2), arg0.r2)
    }

    public fun modulus(arg0: Mont) : u256 {
        arg0.p
    }

    public fun mul(arg0: Mont, arg1: u256, arg2: u256) : u256 {
        let v0 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::mul_u256(arg1 % arg0.p, arg2 % arg0.p);
        redc(arg0.p, arg0.pinv, 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::hi(v0), 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::lo(v0))
    }

    public fun neg(arg0: Mont, arg1: u256) : u256 {
        0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_sub(0, arg1, arg0.p)
    }

    fun neg_inv(arg0: u256) : u256 {
        newton(arg0, newton(arg0, newton(arg0, newton(arg0, newton(arg0, newton(arg0, newton(arg0, newton(arg0, 1))))))))
    }

    public fun new(arg0: u256) : Mont {
        assert!(arg0 & 1 == 1, 1);
        let v0 = (115792089237316195423570985008687907853269984665640564039457584007913129639935 % arg0 + 1) % arg0;
        Mont{
            p    : arg0,
            pinv : neg_inv(arg0),
            r1   : v0,
            r2   : 0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_mul(v0, v0, arg0),
        }
    }

    fun newton(arg0: u256, arg1: u256) : u256 {
        wmul(arg1, wadd(wmul(arg0, arg1), 2))
    }

    public fun one(arg0: Mont) : u256 {
        arg0.r1
    }

    public fun pow(arg0: Mont, arg1: u256, arg2: u256) : u256 {
        let v0 = arg1 % arg0.p;
        let v1 = arg2;
        let v2 = arg0.r1;
        while (v1 > 0) {
            if (v1 & 1 == 1) {
                v2 = mul(arg0, v2, v0);
            };
            v1 = v1 >> 1;
            if (v1 > 0) {
                v0 = mul(arg0, v0, v0);
            };
        };
        v2
    }

    fun redc(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        let v0 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::hi(0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::mul_u256(wmul(arg3, arg1), arg0));
        let v1 = if (arg3 != 0) {
            1
        } else {
            0
        };
        let v2 = arg2 + v1;
        let v3 = arg0 - v0;
        if (v2 >= v3) {
            v2 - v3
        } else {
            v2 + v0
        }
    }

    public fun sqr(arg0: Mont, arg1: u256) : u256 {
        mul(arg0, arg1, arg1)
    }

    public fun sub(arg0: Mont, arg1: u256, arg2: u256) : u256 {
        0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_sub(arg1, arg2, arg0.p)
    }

    public fun to_mont(arg0: Mont, arg1: u256) : u256 {
        mul(arg0, arg1, arg0.r2)
    }

    fun wadd(arg0: u256, arg1: u256) : u256 {
        let v0 = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1;
        if (arg0 > v0) {
            arg0 - v0 - 1
        } else {
            arg0 + arg1
        }
    }

    fun wmul(arg0: u256, arg1: u256) : u256 {
        0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::lo(0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::mul_u256(arg0, arg1))
    }

    // decompiled from Move bytecode v7
}

