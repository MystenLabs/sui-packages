module 0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::trig_experimental {
    public(friend) fun acos_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        acos_r(arg0, false)
    }

    fun acos_r(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        let v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0);
        assert!(v1 <= 1000000000000000000, 4);
        let v2 = if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0)) {
            2 * 785398163397448309615660845819875721 + asin_mag(v1)
        } else {
            2 * 785398163397448309615660845819875721 - asin_mag(v1)
        };
        0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::atan::round_wide(false, v2, 10000000000000000, arg1)
    }

    public(friend) fun acos_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        acos_r(arg0, true)
    }

    public(friend) fun asin_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        asin_r(arg0, false)
    }

    fun asin_mag(arg0: u256) : u256 {
        let v0 = isqrt((1000000000000000000000000000000000000 - arg0 * arg0) * 1000000000000000000000000000000000000);
        let v1 = arg0 * 1000000000000000000;
        if (v1 <= v0) {
            0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::atan::atan_unit(0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(v1, 1000000000000000000000000000000000000, v0))
        } else {
            2 * 785398163397448309615660845819875721 - 0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::atan::atan_unit(0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(v0, 1000000000000000000000000000000000000, v1))
        }
    }

    fun asin_r(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        let v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0);
        assert!(v1 <= 1000000000000000000, 4);
        0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::atan::round_wide(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0), asin_mag(v1), 10000000000000000, arg1)
    }

    public(friend) fun asin_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        asin_r(arg0, true)
    }

    fun isqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 340282366920938463463374607431768211456;
        let v1 = (v0 + arg0 / v0) / 2;
        while (v1 < v0) {
            let v2 = v1 + arg0 / v1;
            v1 = v2 / 2;
        };
        v0
    }

    public(friend) fun tan_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        tan_r(arg0, false)
    }

    fun tan_r(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1, v2, v3, v4) = 0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::trig::sin_cos_wide(arg0);
        assert!(v3 >= 2 * v4, 5);
        let v5 = 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(v1, 1000000000000000000000000000000000000, v3);
        0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::atan::round_wide(v0 != v2, v5, 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(v4, 1000000000000000000000000000000000000 + v5, v3 - v4) + 1, arg1)
    }

    public(friend) fun tan_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        tan_r(arg0, true)
    }

    // decompiled from Move bytecode v7
}

