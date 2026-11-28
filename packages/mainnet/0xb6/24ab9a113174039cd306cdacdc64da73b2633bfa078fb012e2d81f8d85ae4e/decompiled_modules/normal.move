module 0xb624ab9a113174039cd306cdacdc64da73b2633bfa078fb012e2d81f8d85ae4e::normal {
    public(friend) fun cdf_neg_down(arg0: u256) : u256 {
        if (arg0 >= 8944271909999158785) {
            0
        } else {
            let v1 = (0xb624ab9a113174039cd306cdacdc64da73b2633bfa078fb012e2d81f8d85ae4e::kernel::gint_hi(arg0, 150) * 39894228040143267794011389794996528455 + 30000000000000000000000000000000000000000000000000000000000 - 1) / 30000000000000000000000000000000000000000000000000000000000;
            if (v1 >= 500000000000000000) {
                0
            } else {
                500000000000000000 - v1
            }
        }
    }

    public(friend) fun cdf_neg_up(arg0: u256) : u256 {
        if (arg0 >= 8944271909999158785) {
            1
        } else {
            let v1 = 0xb624ab9a113174039cd306cdacdc64da73b2633bfa078fb012e2d81f8d85ae4e::kernel::gint_lo(arg0, 150) * 39894228040143267793947896159062287484 / 30000000000000000000000000000000000000000000000000000000000;
            if (v1 >= 499999999999999999) {
                1
            } else {
                500000000000000000 - v1
            }
        }
    }

    public(friend) fun cdf_pos_down(arg0: u256) : u256 {
        if (arg0 >= 8944271909999158785) {
            999999999999999999
        } else {
            let v1 = 500000000000000000 + 0xb624ab9a113174039cd306cdacdc64da73b2633bfa078fb012e2d81f8d85ae4e::kernel::gint_lo(arg0, 150) * 39894228040143267793947896159062287484 / 30000000000000000000000000000000000000000000000000000000000;
            if (v1 > 999999999999999999) {
                999999999999999999
            } else {
                v1
            }
        }
    }

    public(friend) fun cdf_pos_up(arg0: u256) : u256 {
        if (arg0 >= 8944271909999158785) {
            1000000000000000000
        } else {
            let v1 = 500000000000000000 + (0xb624ab9a113174039cd306cdacdc64da73b2633bfa078fb012e2d81f8d85ae4e::kernel::gint_hi(arg0, 150) * 39894228040143267794011389794996528455 + 30000000000000000000000000000000000000000000000000000000000 - 1) / 30000000000000000000000000000000000000000000000000000000000;
            if (v1 > 1000000000000000000) {
                1000000000000000000
            } else {
                v1
            }
        }
    }

    public fun inv_normal_cdf_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0);
        assert!(v0 > 0, 1);
        assert!(v0 < 1000000000000000000, 1);
        let v1 = 0;
        let v2 = 17888543819998317570;
        let v3 = 0;
        while (v3 < 65) {
            let v4 = (v1 + v2) / 2;
            if (off_up(v4) <= v0) {
                v1 = v4;
            } else {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        off_to_sd(v1)
    }

    public fun inv_normal_cdf_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0);
        assert!(v0 > 0, 1);
        assert!(v0 < 1000000000000000000, 1);
        let v1 = 0;
        let v2 = 17888543819998317570;
        let v3 = 0;
        while (v3 < 65) {
            v1 = (v1 + v2) / 2;
            if (off_down(v1) < v0) {
            } else {
                v2 = v1;
            };
            v3 = v3 + 1;
        };
        off_to_sd(v2)
    }

    public fun normal_cdf_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0)) {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u(cdf_neg_down(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0))))
        } else {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u(cdf_pos_down(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0))))
        }
    }

    public fun normal_cdf_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0);
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(v0)) {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u(cdf_neg_up(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0))))
        } else {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u(cdf_pos_up(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(v0))))
        }
    }

    public fun normal_pdf_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u(pdf_mag_down(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0)))))
    }

    public fun normal_pdf_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u(pdf_mag_up(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(arg0)))))
    }

    fun off_down(arg0: u256) : u256 {
        if (arg0 >= 8944271909999158785) {
            cdf_pos_down(arg0 - 8944271909999158785)
        } else {
            cdf_neg_down(8944271909999158785 - arg0)
        }
    }

    fun off_to_sd(arg0: u256) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        if (arg0 >= 8944271909999158785) {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u(arg0 - 8944271909999158785))
        } else {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(true, 8944271909999158785 - arg0))
        }
    }

    fun off_up(arg0: u256) : u256 {
        if (arg0 >= 8944271909999158785) {
            cdf_pos_up(arg0 - 8944271909999158785)
        } else {
            cdf_neg_up(8944271909999158785 - arg0)
        }
    }

    public(friend) fun pdf_mag_down(arg0: u256) : u256 {
        if (arg0 > 9165151389911680013) {
            0
        } else {
            119682684120429803381843688477186862452000000000000000000 / 0xb624ab9a113174039cd306cdacdc64da73b2633bfa078fb012e2d81f8d85ae4e::kernel::exp_hi(arg0 * arg0 * 150)
        }
    }

    public(friend) fun pdf_mag_up(arg0: u256) : u256 {
        let v0 = if (arg0 > 9165151389911680013) {
            9165151389911680013
        } else {
            arg0
        };
        let v1 = 0xb624ab9a113174039cd306cdacdc64da73b2633bfa078fb012e2d81f8d85ae4e::kernel::exp_lo(v0 * v0 * 150);
        (119682684120429803382034169384989585365000000000000000000 + v1 - 1) / v1
    }

    // decompiled from Move bytecode v7
}

