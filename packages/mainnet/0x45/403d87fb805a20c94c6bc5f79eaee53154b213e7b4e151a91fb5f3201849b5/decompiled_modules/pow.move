module 0x45403d87fb805a20c94c6bc5f79eaee53154b213e7b4e151a91fb5f3201849b5::pow {
    fun clamp_log(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: bool) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0) == arg1) {
            v0
        } else {
            0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()
        }
    }

    fun clamp_root(arg0: u256, arg1: u256, arg2: bool) : u256 {
        let v0 = if (arg2) {
            arg1
        } else {
            1000000000000000000
        };
        let v1 = if (arg2) {
            1000000000000000000
        } else {
            arg1
        };
        if (arg0 < v0) {
            v0
        } else if (arg0 > v1) {
            v1
        } else {
            arg0
        }
    }

    fun clamp_sign(arg0: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256, arg1: bool) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(arg0) == arg1) {
            arg0
        } else {
            0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()
        }
    }

    fun exponent(arg0: u256, arg1: bool, arg2: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256, arg3: bool) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        let v0 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(arg2) != arg1;
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(v0, magnitude(arg0, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(arg2), arg3 != v0))
    }

    fun finish_down(arg0: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(arg0)) {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::to_u(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_sd18::exp_down(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(arg0)))))
        } else {
            0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_ud18::exp_down(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(arg0)))
        }
    }

    fun finish_up(arg0: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(arg0)) {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::to_u(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_sd18::exp_up(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(arg0)))))
        } else {
            0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_ud18::exp_up(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(arg0)))
        }
    }

    fun magnitude(arg0: u256, arg1: u256, arg2: bool) : u256 {
        if (arg1 != 0 && arg0 > 57896044618658097711785492504343953926634992332820282019728792003956564819968 / arg1) {
            340282366920938463463374607431768211456
        } else if (arg2) {
            (arg0 * arg1 + 170141183460469231731687303715884105728 - 1) / 170141183460469231731687303715884105728
        } else {
            arg0 * arg1 / 170141183460469231731687303715884105728
        }
    }

    public fun nth_root_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18, arg1: u64) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        assert!(arg1 != 0, 1);
        if (arg1 == 1) {
            arg0
        } else if (arg1 == 2) {
            0x45403d87fb805a20c94c6bc5f79eaee53154b213e7b4e151a91fb5f3201849b5::root::sqrt_down(arg0)
        } else if (arg1 == 3) {
            0x45403d87fb805a20c94c6bc5f79eaee53154b213e7b4e151a91fb5f3201849b5::root::cbrt_down(arg0)
        } else {
            let v1 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0);
            if (v1 == 0) {
                arg0
            } else {
                let v2 = v1 < 1000000000000000000;
                0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(clamp_root(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(finish_down(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_floor(clamp_log(0x4ba8bde8d1631882c60de935ede951d1a27efc18372ee4a3fb58157d5418b59f::log::ln_down(arg0), v2), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u((arg1 as u256))))), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(0x45403d87fb805a20c94c6bc5f79eaee53154b213e7b4e151a91fb5f3201849b5::root::cbrt_down(arg0)), v2))
            }
        }
    }

    public fun nth_root_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18, arg1: u64) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        assert!(arg1 != 0, 1);
        if (arg1 == 1) {
            arg0
        } else if (arg1 == 2) {
            0x45403d87fb805a20c94c6bc5f79eaee53154b213e7b4e151a91fb5f3201849b5::root::sqrt_up(arg0)
        } else if (arg1 == 3) {
            0x45403d87fb805a20c94c6bc5f79eaee53154b213e7b4e151a91fb5f3201849b5::root::cbrt_up(arg0)
        } else {
            let v1 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0);
            if (v1 == 0) {
                arg0
            } else {
                let v2 = v1 < 1000000000000000000;
                0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(clamp_root(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(finish_up(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_ceil(clamp_log(0x4ba8bde8d1631882c60de935ede951d1a27efc18372ee4a3fb58157d5418b59f::log::ln_up(arg0), v2), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u((arg1 as u256))))), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(0x45403d87fb805a20c94c6bc5f79eaee53154b213e7b4e151a91fb5f3201849b5::root::cbrt_up(arg0)), v2))
            }
        }
    }

    public fun pow_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0);
        let v1 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg1);
        let v2 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v1);
        let v3 = if (v0 == 0) {
            assert!(!v2, 1);
            if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v1) == 0) {
                0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()
            } else {
                0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(true, 340282366920938463463374607431768211456)
            }
        } else if (v0 == 1000000000000000000) {
            0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()
        } else {
            exponent(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v1), v2, clamp_sign(0x45403d87fb805a20c94c6bc5f79eaee53154b213e7b4e151a91fb5f3201849b5::ln_hp::ln_q127(v0, v2), v0 < 1000000000000000000), false)
        };
        finish_down(v3)
    }

    public fun pow_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0);
        let v1 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg1);
        let v2 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v1);
        let v3 = if (v0 == 0) {
            assert!(!v2, 1);
            if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v1) == 0) {
                0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()
            } else {
                0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(true, 340282366920938463463374607431768211456)
            }
        } else if (v0 == 1000000000000000000) {
            0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()
        } else {
            exponent(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v1), v2, clamp_sign(0x45403d87fb805a20c94c6bc5f79eaee53154b213e7b4e151a91fb5f3201849b5::ln_hp::ln_q127(v0, !v2), v0 < 1000000000000000000), true)
        };
        finish_up(v3)
    }

    // decompiled from Move bytecode v7
}

