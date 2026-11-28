module 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field {
    public fun add(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_add(arg0, arg1, arg2)
    }

    public fun div(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_mul(arg0, 0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_inverse(arg1, arg2), arg2)
    }

    public fun eq(arg0: u256, arg1: u256, arg2: u256) : bool {
        arg0 % arg2 == arg1 % arg2
    }

    public fun inv(arg0: u256, arg1: u256) : u256 {
        0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_inverse(arg0, arg1)
    }

    public fun is_zero(arg0: u256, arg1: u256) : bool {
        arg0 % arg1 == 0
    }

    public fun mul(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_mul(arg0, arg1, arg2)
    }

    public fun neg(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 % arg1;
        if (v0 == 0) {
            0
        } else {
            arg1 - v0
        }
    }

    public fun pow(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_pow(arg0, arg1, arg2)
    }

    public fun reduce(arg0: u256, arg1: u256) : u256 {
        arg0 % arg1
    }

    public fun sqr(arg0: u256, arg1: u256) : u256 {
        0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_mul(arg0, arg0, arg1)
    }

    public fun sub(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::mod_sub(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

