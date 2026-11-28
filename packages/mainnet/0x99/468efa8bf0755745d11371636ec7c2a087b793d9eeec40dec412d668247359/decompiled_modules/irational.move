module 0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational {
    struct IRational has copy, drop, store {
        num: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::I128,
        den: u128,
    }

    public fun abs(arg0: IRational) : IRational {
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::is_neg(arg0.num)) {
            neg(arg0)
        } else {
            arg0
        }
    }

    public fun add(arg0: IRational, arg1: IRational) : IRational {
        let (v0, v1, v2) = parts(arg0);
        let (v3, v4, v5) = parts(arg1);
        add_parts(v0, v1, v2, v3, v4, v5)
    }

    fun add_parts(arg0: bool, arg1: u256, arg2: u256, arg3: bool, arg4: u256, arg5: u256) : IRational {
        let v0 = 0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::gcd(arg2, arg5);
        let v1 = arg2 / v0;
        let v2 = arg1 * arg5 / v0;
        let v3 = arg4 * v1;
        if (arg0 == arg3) {
            make(arg0, v2 + v3, v1 * arg5)
        } else if (v2 >= v3) {
            make(arg0, v2 - v3, v1 * arg5)
        } else {
            make(arg3, v3 - v2, v1 * arg5)
        }
    }

    public fun ceil(arg0: IRational) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::I128 {
        let v0 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::is_neg(arg0.num);
        let v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::abs_u(arg0.num);
        if (!v0 && v1 % arg0.den != 0) {
            0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::from_parts(false, v1 / arg0.den + 1)
        } else {
            0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::from_parts(v0, v1 / arg0.den)
        }
    }

    public fun cmp(arg0: IRational, arg1: IRational) : u8 {
        let (v0, v1, v2) = parts(arg0);
        let (v3, v4, v5) = parts(arg1);
        if (v0 && !v3) {
            0
        } else if (!v0 && v3) {
            2
        } else if (v0) {
            cmp_u(v4 * v2, v1 * v5)
        } else {
            cmp_u(v1 * v5, v4 * v2)
        }
    }

    fun cmp_u(arg0: u256, arg1: u256) : u8 {
        if (arg0 < arg1) {
            0
        } else if (arg0 == arg1) {
            1
        } else {
            2
        }
    }

    public fun den(arg0: IRational) : u128 {
        arg0.den
    }

    public fun div(arg0: IRational, arg1: IRational) : IRational {
        let (v0, v1, v2) = parts(arg0);
        let (v3, v4, v5) = parts(arg1);
        assert!(v4 != 0, 4);
        make(v0 != v3, v1 * v5, v2 * v4)
    }

    public fun eq(arg0: IRational, arg1: IRational) : bool {
        cmp(arg0, arg1) == 1
    }

    public fun floor(arg0: IRational) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::I128 {
        let v0 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::is_neg(arg0.num);
        let v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::abs_u(arg0.num);
        if (v0 && v1 % arg0.den != 0) {
            0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::from_parts(true, v1 / arg0.den + 1)
        } else {
            0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::from_parts(v0, v1 / arg0.den)
        }
    }

    public fun from_int(arg0: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::I128) : IRational {
        IRational{
            num : arg0,
            den : 1,
        }
    }

    public fun le(arg0: IRational, arg1: IRational) : bool {
        cmp(arg0, arg1) != 2
    }

    public fun lt(arg0: IRational, arg1: IRational) : bool {
        cmp(arg0, arg1) == 0
    }

    fun make(arg0: bool, arg1: u256, arg2: u256) : IRational {
        let v0 = 0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory::gcd(arg1, arg2);
        let v1 = arg1 / v0;
        let v2 = arg2 / v0;
        assert!(v2 < 340282366920938463463374607431768211456, 2);
        if (arg0) {
            assert!(v1 <= 170141183460469231731687303715884105728, 2);
        } else {
            assert!(v1 < 170141183460469231731687303715884105728, 2);
        };
        IRational{
            num : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::from_parts(arg0, (v1 as u128)),
            den : (v2 as u128),
        }
    }

    public fun mediant(arg0: IRational, arg1: IRational) : IRational {
        let (v0, v1, v2) = parts(arg0);
        let (v3, v4, v5) = parts(arg1);
        if (v0 == v3) {
            make(v0, v1 + v4, v2 + v5)
        } else if (v1 >= v4) {
            make(v0, v1 - v4, v2 + v5)
        } else {
            make(v3, v4 - v1, v2 + v5)
        }
    }

    public fun mul(arg0: IRational, arg1: IRational) : IRational {
        let (v0, v1, v2) = parts(arg0);
        let (v3, v4, v5) = parts(arg1);
        make(v0 != v3, v1 * v4, v2 * v5)
    }

    public fun neg(arg0: IRational) : IRational {
        assert!(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::bits(arg0.num) != 170141183460469231731687303715884105728, 2);
        IRational{
            num : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::neg(arg0.num),
            den : arg0.den,
        }
    }

    public fun new(arg0: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::I128, arg1: u128) : IRational {
        assert!(arg1 != 0, 1);
        make(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::is_neg(arg0), (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::abs_u(arg0) as u256), (arg1 as u256))
    }

    public fun num(arg0: IRational) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::I128 {
        arg0.num
    }

    fun parts(arg0: IRational) : (bool, u256, u256) {
        (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::is_neg(arg0.num), (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::abs_u(arg0.num) as u256), (arg0.den as u256))
    }

    public fun round(arg0: IRational) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::I128 {
        let v0 = (arg0.den as u256);
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::from_parts(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::is_neg(arg0.num), (((2 * (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::abs_u(arg0.num) as u256) + v0) / 2 * v0) as u128))
    }

    public fun sub(arg0: IRational, arg1: IRational) : IRational {
        let (v0, v1, v2) = parts(arg0);
        let (v3, v4, v5) = parts(arg1);
        add_parts(v0, v1, v2, !v3, v4, v5)
    }

    // decompiled from Move bytecode v7
}

