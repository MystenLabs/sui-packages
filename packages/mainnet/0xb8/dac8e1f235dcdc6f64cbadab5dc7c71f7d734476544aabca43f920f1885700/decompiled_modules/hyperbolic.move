module 0xb8dac8e1f235dcdc6f64cbadab5dc7c71f7d734476544aabca43f920f1885700::hyperbolic {
    fun acosh_arg_down(arg0: u256) : u256 {
        if (arg0 <= 170141183460469231731687303715884105728) {
            arg0 + 0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::isqrt_down(arg0 * arg0 - 1000000000000000000000000000000000000)
        } else {
            arg0 + arg0 - 1
        }
    }

    fun acosh_arg_up(arg0: u256) : u256 {
        if (arg0 <= 170141183460469231731687303715884105728) {
            arg0 + 0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::isqrt_up(arg0 * arg0 - 1000000000000000000000000000000000000)
        } else {
            arg0 + arg0
        }
    }

    public fun acosh_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        assert!(!v0 && v1 >= 1000000000000000000, 2);
        out(false, pos_part(ln_d(acosh_arg_down(v1))))
    }

    public fun acosh_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        assert!(!v0 && v1 >= 1000000000000000000, 2);
        out(false, pos_part(ln_u(acosh_arg_up(v1))))
    }

    fun asinh_arg_down(arg0: u256) : u256 {
        if (arg0 <= 170141183460469231731687303715884105728) {
            arg0 + 0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::isqrt_down(arg0 * arg0 + 1000000000000000000000000000000000000)
        } else {
            arg0 + arg0 - 1
        }
    }

    fun asinh_arg_up(arg0: u256) : u256 {
        if (arg0 <= 170141183460469231731687303715884105728) {
            arg0 + 0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits256::isqrt_up(arg0 * arg0 + 1000000000000000000000000000000000000)
        } else if (arg0 < 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
            arg0 + arg0 + 1
        } else {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        }
    }

    public fun asinh_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        if (v0) {
            out(true, asinh_mag_up(v1))
        } else {
            out(false, asinh_mag_down(v1))
        }
    }

    fun asinh_mag_down(arg0: u256) : u256 {
        pos_part(ln_d(asinh_arg_down(arg0)))
    }

    fun asinh_mag_up(arg0: u256) : u256 {
        if (arg0 < 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
            pos_part(ln_u(asinh_arg_up(arg0)))
        } else {
            pos_part(ln_u(asinh_arg_up(arg0))) + 1
        }
    }

    public fun asinh_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        if (v0) {
            out(true, asinh_mag_down(v1))
        } else {
            out(false, asinh_mag_up(v1))
        }
    }

    public fun atanh_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        assert!(v1 < 1000000000000000000, 2);
        if (v0) {
            out(true, atanh_mag_up(v1))
        } else {
            out(false, atanh_mag_down(v1))
        }
    }

    fun atanh_mag_down(arg0: u256) : u256 {
        (pos_part(ln_d(1000000000000000000 + arg0)) + neg_part(ln_u(1000000000000000000 - arg0))) / 2
    }

    fun atanh_mag_up(arg0: u256) : u256 {
        (pos_part(ln_u(1000000000000000000 + arg0)) + neg_part(ln_d(1000000000000000000 - arg0)) + 1) / 2
    }

    public fun atanh_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        assert!(v1 < 1000000000000000000, 2);
        if (v0) {
            out(true, atanh_mag_down(v1))
        } else {
            out(false, atanh_mag_up(v1))
        }
    }

    public fun cosh_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (_, v1) = split(arg0);
        assert!(v1 <= 135999146549453176898, 1);
        out(false, cosh_mag_down(v1))
    }

    fun cosh_mag_down(arg0: u256) : u256 {
        let v0 = ed(arg0);
        (v0 + 1000000000000000000000000000000000000 / v0) / 2
    }

    fun cosh_mag_up(arg0: u256) : u256 {
        let v0 = eu(arg0);
        (v0 + (1000000000000000000000000000000000000 + v0 - 1) / v0 + 1) / 2
    }

    public fun cosh_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (_, v1) = split(arg0);
        assert!(v1 <= 135999146549453176898, 1);
        out(false, cosh_mag_up(v1))
    }

    fun ed(arg0: u256) : u256 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_ud18::exp_down(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(arg0)))
    }

    fun eu(arg0: u256) : u256 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_ud18::exp_up(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(arg0)))
    }

    fun from_off(arg0: u256) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        if (arg0 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
            out(false, arg0 - 57896044618658097711785492504343953926634992332820282019728792003956564819968)
        } else {
            out(true, 57896044618658097711785492504343953926634992332820282019728792003956564819968 - arg0)
        }
    }

    fun ln_d(arg0: u256) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x4ba8bde8d1631882c60de935ede951d1a27efc18372ee4a3fb58157d5418b59f::log::ln_down(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(arg0))
    }

    fun ln_u(arg0: u256) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x4ba8bde8d1631882c60de935ede951d1a27efc18372ee4a3fb58157d5418b59f::log::ln_up(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(arg0))
    }

    public fun log_sum_exp_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = off(arg0);
        let v1 = off(arg1);
        let v2 = if (v0 >= v1) {
            v0
        } else {
            v1
        };
        let v3 = if (v0 >= v1) {
            v0 - v1
        } else {
            v1 - v0
        };
        assert!(v2 <= 115792089237316195423570985008687907853269984665640564039456584007913129639935, 1);
        from_off(v2 + lse_tail_down(v3))
    }

    public fun log_sum_exp_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = off(arg0);
        let v1 = off(arg1);
        let v2 = if (v0 >= v1) {
            v0
        } else {
            v1
        };
        let v3 = if (v0 >= v1) {
            v0 - v1
        } else {
            v1 - v0
        };
        assert!(v2 <= 115792089237316195423570985008687907853269984665640564039456584007913129639935, 1);
        from_off(v2 + lse_tail_up(v3))
    }

    fun lse_tail_down(arg0: u256) : u256 {
        if (arg0 > 50000000000000000000) {
            0
        } else {
            let v1 = q_pos_part(0x4ba8bde8d1631882c60de935ede951d1a27efc18372ee4a3fb58157d5418b59f::log::q_ln_down((((pos_part(0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_sd18::exp_down(shifted(0))) + pos_part(0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_sd18::exp_down(shifted(arg0)))) * 18446744073709551616 / 1000000000000000000) as u128)));
            let v2 = if (v1 > 368934881474191032320) {
                v1 - 368934881474191032320
            } else {
                0
            };
            v2 * 1000000000000000000 / 18446744073709551616
        }
    }

    fun lse_tail_up(arg0: u256) : u256 {
        if (arg0 > 50000000000000000000) {
            1
        } else {
            let v1 = q_pos_part(0x4ba8bde8d1631882c60de935ede951d1a27efc18372ee4a3fb58157d5418b59f::log::q_ln_up(((((pos_part(0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_sd18::exp_up(shifted(0))) + pos_part(0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_sd18::exp_up(shifted(arg0)))) * 18446744073709551616 + 1000000000000000000 - 1) / 1000000000000000000) as u128)));
            let v2 = if (v1 > 368934881474191032320) {
                v1 - 368934881474191032320
            } else {
                0
            };
            (v2 * 1000000000000000000 + 18446744073709551615) / 18446744073709551616
        }
    }

    fun neg_part(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : u256 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0)) {
            0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0)
        } else {
            0
        }
    }

    fun off(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : u256 {
        let (v0, v1) = split(arg0);
        if (v0) {
            57896044618658097711785492504343953926634992332820282019728792003956564819968 - v1
        } else {
            v1 + 57896044618658097711785492504343953926634992332820282019728792003956564819968
        }
    }

    fun out(arg0: bool, arg1: u256) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(arg0, arg1))
    }

    fun pos_part(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : u256 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0)) {
            0
        } else {
            0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::bits(v0)
        }
    }

    fun q_pos_part(arg0: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::I128) : u256 {
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::is_neg(arg0)) {
            0
        } else {
            (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::bits(arg0) as u256)
        }
    }

    fun qd(arg0: u256, arg1: u256) : u256 {
        arg0 / (arg1 + 1000000000000000000)
    }

    fun qu(arg0: u256, arg1: u256) : u256 {
        (arg0 + arg1 + 1000000000000000000 - 1) / (arg1 + 1000000000000000000)
    }

    fun shifted(arg0: u256) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        if (arg0 <= 20000000000000000000) {
            out(false, 20000000000000000000 - arg0)
        } else {
            out(true, arg0 - 20000000000000000000)
        }
    }

    fun sig_neg_down(arg0: u256) : u256 {
        if (arg0 > 42000000000000000000) {
            0
        } else {
            qd(1000000000000000000000000000000000000, eu(arg0))
        }
    }

    fun sig_neg_up(arg0: u256) : u256 {
        if (arg0 > 42000000000000000000) {
            1
        } else {
            qu(1000000000000000000000000000000000000, ed(arg0))
        }
    }

    fun sig_pos_down(arg0: u256) : u256 {
        if (arg0 > 42000000000000000000) {
            1000000000000000000 - 1
        } else {
            1000000000000000000 - qu(1000000000000000000000000000000000000, ed(arg0))
        }
    }

    fun sig_pos_up(arg0: u256) : u256 {
        if (arg0 > 42000000000000000000) {
            1000000000000000000
        } else {
            1000000000000000000 - qd(1000000000000000000000000000000000000, eu(arg0))
        }
    }

    public fun sigmoid_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        if (v0) {
            out(false, sig_neg_down(v1))
        } else {
            out(false, sig_pos_down(v1))
        }
    }

    public fun sigmoid_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        if (v0) {
            out(false, sig_neg_up(v1))
        } else {
            out(false, sig_pos_up(v1))
        }
    }

    public fun sinh_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        assert!(v1 <= 135999146549453176898, 1);
        if (v0) {
            out(true, sinh_mag_up(v1))
        } else {
            out(false, sinh_mag_down(v1))
        }
    }

    fun sinh_mag_down(arg0: u256) : u256 {
        let v0 = ed(arg0);
        (v0 - (1000000000000000000000000000000000000 + v0 - 1) / v0) / 2
    }

    fun sinh_mag_up(arg0: u256) : u256 {
        let v0 = eu(arg0);
        (v0 - 1000000000000000000000000000000000000 / v0 + 1) / 2
    }

    public fun sinh_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        assert!(v1 <= 135999146549453176898, 1);
        if (v0) {
            out(true, sinh_mag_down(v1))
        } else {
            out(false, sinh_mag_up(v1))
        }
    }

    public fun softplus_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        if (!0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0) && 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::bits(v0) > 100000000000000000000) {
            arg0
        } else {
            0x4ba8bde8d1631882c60de935ede951d1a27efc18372ee4a3fb58157d5418b59f::log::log1p_down(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(pos_part(0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_sd18::exp_down(arg0))))
        }
    }

    public fun softplus_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        if (!0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0) && 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::bits(v0) > 100000000000000000000) {
            let v2 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::bits(v0);
            assert!(v2 < 57896044618658097711785492504343953926634992332820282019728792003956564819967, 1);
            out(false, v2 + 1)
        } else {
            0x4ba8bde8d1631882c60de935ede951d1a27efc18372ee4a3fb58157d5418b59f::log::log1p_up(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(pos_part(0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_sd18::exp_up(arg0))))
        }
    }

    fun split(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : (bool, u256) {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0))
    }

    public fun tanh_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        if (v0) {
            out(true, tanh_mag_up(v1))
        } else {
            out(false, tanh_mag_down(v1))
        }
    }

    fun tanh_mag_down(arg0: u256) : u256 {
        if (arg0 > 22000000000000000000) {
            1000000000000000000 - 1
        } else {
            1000000000000000000 - qu(2000000000000000000000000000000000000, ed(arg0 + arg0))
        }
    }

    fun tanh_mag_up(arg0: u256) : u256 {
        if (arg0 > 22000000000000000000) {
            1000000000000000000
        } else {
            1000000000000000000 - qd(2000000000000000000000000000000000000, eu(arg0 + arg0))
        }
    }

    public fun tanh_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, v1) = split(arg0);
        if (v0) {
            out(true, tanh_mag_down(v1))
        } else {
            out(false, tanh_mag_up(v1))
        }
    }

    // decompiled from Move bytecode v7
}

