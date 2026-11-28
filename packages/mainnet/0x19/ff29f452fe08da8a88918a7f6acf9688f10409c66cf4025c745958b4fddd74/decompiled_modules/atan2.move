module 0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::atan2 {
    public fun atan2_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        atan2_r(arg0, arg1, false)
    }

    fun atan2_mag(arg0: u256, arg1: u256) : u256 {
        if (arg0 <= arg1) {
            0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::atan::atan_unit(0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg0, 1000000000000000000000000000000000000, arg1))
        } else {
            2 * 785398163397448309615660845819875721 - 0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::atan::atan_unit(0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg1, 1000000000000000000000000000000000000, arg0))
        }
    }

    fun atan2_r(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg2: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = atan2_wide(arg0, arg1);
        0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::atan::round_wide(v0, v1, 10000000000000000, arg2)
    }

    public fun atan2_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        atan2_r(arg0, arg1, true)
    }

    fun atan2_wide(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : (bool, u256) {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        let v1 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg1);
        let v2 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0);
        let v3 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v1);
        assert!(v3 != 0 || v2 != 0, 3);
        (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0), quadrant(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v1), atan2_mag(v2, v3)))
    }

    fun quadrant(arg0: bool, arg1: u256) : u256 {
        if (arg0) {
            4 * 785398163397448309615660845819875721 - arg1
        } else {
            arg1
        }
    }

    // decompiled from Move bytecode v7
}

