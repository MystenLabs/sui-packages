module 0x45403d87fb805a20c94c6bc5f79eaee53154b213e7b4e151a91fb5f3201849b5::root {
    fun cbrt_ceil(arg0: u256) : u256 {
        if (arg0 <= 115792089237316195423570985008687907853269) {
            0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::icbrt_up(arg0 * 1000000000000000000000000000000000000)
        } else {
            let v1 = cbrt_floor(arg0);
            if (v1 * v1 < 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(arg0, 1000000000000000000000000000000000000, v1)) {
                v1 + 1
            } else {
                v1
            }
        }
    }

    public fun cbrt_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(cbrt_floor(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0)))
    }

    fun cbrt_floor(arg0: u256) : u256 {
        if (arg0 <= 115792089237316195423570985008687907853269) {
            0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::icbrt_down(arg0 * 1000000000000000000000000000000000000)
        } else {
            let v1 = 0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::icbrt_down(arg0) * 1000000000000;
            cbrt_search(arg0, v1, v1 + 1000000000000 - 1)
        }
    }

    fun cbrt_search(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg1;
        while (v0 < arg2) {
            let v1 = v0 + (arg2 - v0 + 1) / 2;
            if (v1 * v1 <= 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg0, 1000000000000000000000000000000000000, v1)) {
                v0 = v1;
                continue
            };
            arg2 = v1 - 1;
        };
        v0
    }

    public fun cbrt_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(cbrt_ceil(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0)))
    }

    public fun q_cbrt_down(arg0: u128) : u128 {
        (0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::icbrt_down((arg0 as u256) << 128) as u128)
    }

    public fun q_cbrt_up(arg0: u128) : u128 {
        (0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::icbrt_up((arg0 as u256) << 128) as u128)
    }

    public fun q_sqrt_down(arg0: u128) : u128 {
        (0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::isqrt_down((arg0 as u256) << 64) as u128)
    }

    public fun q_sqrt_up(arg0: u128) : u128 {
        (0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::isqrt_up((arg0 as u256) << 64) as u128)
    }

    public fun sd_cbrt_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0)) {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(true, cbrt_ceil(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0))))
        } else {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(false, cbrt_floor(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0))))
        }
    }

    public fun sd_cbrt_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0)) {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(true, cbrt_floor(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0))))
        } else {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(false, cbrt_ceil(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0))))
        }
    }

    public fun sd_sqrt_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        assert!(!0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0), 1);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u(sqrt_floor(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0))))
    }

    public fun sd_sqrt_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        assert!(!0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0), 1);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u(sqrt_ceil(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0))))
    }

    fun sqrt_ceil(arg0: u256) : u256 {
        if (arg0 <= 115792089237316195423570985008687907853269984665640564039457) {
            0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::isqrt_up(arg0 * 1000000000000000000)
        } else {
            let v1 = sqrt_floor(arg0);
            if (v1 < 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(arg0, 1000000000000000000, v1)) {
                v1 + 1
            } else {
                v1
            }
        }
    }

    public fun sqrt_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(sqrt_floor(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0)))
    }

    fun sqrt_floor(arg0: u256) : u256 {
        if (arg0 <= 115792089237316195423570985008687907853269984665640564039457) {
            0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::isqrt_down(arg0 * 1000000000000000000)
        } else {
            let v1 = 0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::isqrt_down(arg0) * 1000000000;
            sqrt_search(arg0, v1, v1 + 1000000000 - 1)
        }
    }

    fun sqrt_search(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg1;
        while (v0 < arg2) {
            let v1 = v0 + (arg2 - v0 + 1) / 2;
            if (v1 <= 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg0, 1000000000000000000, v1)) {
                v0 = v1;
                continue
            };
            arg2 = v1 - 1;
        };
        v0
    }

    public fun sqrt_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(sqrt_ceil(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0)))
    }

    // decompiled from Move bytecode v7
}

