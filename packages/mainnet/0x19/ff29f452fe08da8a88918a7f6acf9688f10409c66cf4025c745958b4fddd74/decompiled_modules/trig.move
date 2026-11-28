module 0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::trig {
    public fun cos_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        cos_r(arg0, false)
    }

    fun cos_kernel(arg0: u256) : u256 {
        horner(arg0 * arg0 / 1000000000000000000000000000000000000, 0, 15)
    }

    fun cos_r(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = reduce(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0)));
        let (v2, v3) = octant((v0 + 2) % 8, v1);
        finish(v2, v3, 8 + (v0 / 8 + 1) * 1, arg1)
    }

    public fun cos_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        cos_r(arg0, true)
    }

    fun finish(arg0: bool, arg1: u256, arg2: u256, arg3: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = if (arg0 != arg3) {
            (arg0, arg1 + arg2)
        } else if (arg1 >= arg2) {
            (arg0, arg1 - arg2)
        } else {
            (!arg0, arg2 - arg1)
        };
        round_clamp(v0, v1, arg3)
    }

    public fun half_pi_down() : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1570796326794896619))
    }

    public fun half_pi_up() : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1570796326794896620))
    }

    fun horner(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 1000000000000000000000000000000000000;
        let v1 = arg2;
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = arg1 + 2 * v1;
            let v3 = arg0 * v0 / (v2 + 1) * (v2 + 2) * 1000000000000000000000000000000000000;
            v0 = 1000000000000000000000000000000000000 - v3;
        };
        v0
    }

    fun octant(arg0: u256, arg1: u256) : (bool, u256) {
        let v0 = if (arg0 % 2 == 0) {
            arg1
        } else {
            785398163397448309615660845819875721 - arg1
        };
        let v1 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 5) {
            true
        } else {
            arg0 == 6
        };
        let v2 = if (v1) {
            cos_kernel(v0)
        } else {
            sin_kernel(v0)
        };
        (arg0 >= 4, v2)
    }

    public fun pi_down() : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(3141592653589793238))
    }

    public fun pi_up() : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(3141592653589793239))
    }

    public fun quarter_pi_down() : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(785398163397448309))
    }

    public fun quarter_pi_up() : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(785398163397448310))
    }

    fun reduce(arg0: u256) : (u256, u256) {
        let v0 = 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg0, 1000000000000000000, 785398163397448309615660845819875721);
        (v0, 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::wrapping_sub(0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::wrapping_mul(arg0, 1000000000000000000), 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::wrapping_mul(v0, 785398163397448309615660845819875721)))
    }

    fun round_clamp(arg0: bool, arg1: u256, arg2: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = if (arg0 != arg2) {
            0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::div_up(arg1, 1000000000000000000)
        } else {
            arg1 / 1000000000000000000
        };
        let v1 = if (v0 > 1000000000000000000) {
            1000000000000000000
        } else {
            v0
        };
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(arg0, v1))
    }

    public(friend) fun sin_cos_wide(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : (bool, u256, bool, u256, u256) {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        let (v1, v2) = reduce(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0));
        let (v3, v4) = octant(v1 % 8, v2);
        let (v5, v6) = octant((v1 + 2) % 8, v2);
        (v3 != 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0), v4, v5, v6, 8 + (v1 / 8 + 1) * 1)
    }

    public fun sin_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        sin_r(arg0, false)
    }

    fun sin_kernel(arg0: u256) : u256 {
        arg0 * horner(arg0 * arg0 / 1000000000000000000000000000000000000, 1, 14) / 1000000000000000000000000000000000000
    }

    fun sin_r(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        let (v1, v2) = reduce(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0));
        let (v3, v4) = octant(v1 % 8, v2);
        finish(v3 != 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0), v4, 8 + (v1 / 8 + 1) * 1, arg1)
    }

    public fun sin_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        sin_r(arg0, true)
    }

    public fun two_pi_down() : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(6283185307179586476))
    }

    public fun two_pi_up() : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(6283185307179586477))
    }

    // decompiled from Move bytecode v7
}

