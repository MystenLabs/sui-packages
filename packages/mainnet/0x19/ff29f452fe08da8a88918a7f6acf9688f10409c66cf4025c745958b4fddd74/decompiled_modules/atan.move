module 0x19ff29f452fe08da8a88918a7f6acf9688f10409c66cf4025c745958b4fddd74::atan {
    public fun atan_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        atan_r(arg0, false)
    }

    public(friend) fun atan_mag(arg0: u256) : u256 {
        if (arg0 <= 1000000000000000000) {
            atan_unit(arg0 * 1000000000000000000)
        } else {
            2 * 785398163397448309615660845819875721 - atan_unit(0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(1000000000000000000, 1000000000000000000000000000000000000, arg0))
        }
    }

    fun atan_r(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        round_wide(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0), atan_mag(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0)), 5000000000000000, arg1)
    }

    fun atan_small(arg0: u256) : u256 {
        let v0 = 1000000000000000000000000000000000000;
        let v1 = 56;
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = arg0 * arg0 / 1000000000000000000000000000000000000 * v0 * (2 * v1 + 1) / (2 * v1 + 3) * 1000000000000000000000000000000000000;
            v0 = 1000000000000000000000000000000000000 - v2;
        };
        arg0 * v0 / 1000000000000000000000000000000000000
    }

    public(friend) fun atan_unit(arg0: u256) : u256 {
        if (arg0 <= 414213562373095048801688724209698078) {
            atan_small(arg0)
        } else {
            785398163397448309615660845819875721 - atan_small((1000000000000000000000000000000000000 - arg0) * 1000000000000000000000000000000000000 / (1000000000000000000000000000000000000 + arg0))
        }
    }

    public fun atan_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        atan_r(arg0, true)
    }

    public(friend) fun round_wide(arg0: bool, arg1: u256, arg2: u256, arg3: bool) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = if (arg0 != arg3) {
            (arg0, arg1 + arg2)
        } else if (arg1 >= arg2) {
            (arg0, arg1 - arg2)
        } else {
            (!arg0, arg2 - arg1)
        };
        let v2 = if (v0 != arg3) {
            0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::div_up(v1, 1000000000000000000)
        } else {
            v1 / 1000000000000000000
        };
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(v0, v2))
    }

    // decompiled from Move bytecode v7
}

