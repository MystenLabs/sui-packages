module 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64_with_sign {
    public fun std(arg0: vector<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0, false);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0)) {
            v0 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::add(v0, pow(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::sub(*0x1::vector::borrow<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, v1), mean(arg0)), 2));
            v1 = v1 + 1;
        };
        sqrt(div_u128(v0, (0x1::vector::length<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0) as u128)))
    }

    public fun exp(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64::exp(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::get_raw_value(arg0)))), true);
        let v1 = v0;
        if (!0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(arg0)) {
            v1 = div(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(18446744073709551616, true), v0);
        };
        v1
    }

    public fun pow(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u64) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64::pow(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::get_raw_value(arg0)), arg1)), true)
    }

    public fun sqrt(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(arg0), 1);
        0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64::sqrt(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::get_raw_value(arg0)))), true)
    }

    public fun div(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::get_raw_value(arg1) != 0, 0);
        0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64::mul_div(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::remove_sign(arg0), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::create_from_raw_value(18446744073709551616), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::remove_sign(arg1))), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(arg0) == 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(arg1))
    }

    public fun divDown(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::round_down(div(arg0, arg1))
    }

    public fun div_u128(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u128) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64::mul_div(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::get_raw_value(arg0)), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::create_from_raw_value(18446744073709551616), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::create_from_raw_value(arg1 << 64))), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(arg0))
    }

    public fun ln(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(arg0), 1);
        0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::sub(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64::ln_plus_32ln2(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::remove_sign(arg0))), true), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(64 * 12786308645202655660, true))
    }

    public fun log2(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(arg0), 1);
        0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::sub(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64::log2_plus_64(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::remove_sign(arg0))), true), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(1180591620717411303424, true))
    }

    public fun maximum(arg0: vector<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0x1::vector::length<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0) > 0, 2);
        let v0 = 0x1::vector::borrow<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0)) {
            let v2 = 0x1::vector::borrow<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, v1);
            if (0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::sub(*v2, *v0))) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        *v0
    }

    public fun mean(arg0: vector<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0x1::vector::length<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0) > 0, 2);
        let v0 = 0x1::vector::length<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0);
        let v1 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0, false);
        let v2 = 0;
        while (v2 < v0) {
            v1 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::add(v1, *0x1::vector::borrow<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, v2));
            v2 = v2 + 1;
        };
        div(v1, 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value((v0 as u128) << 64, true))
    }

    public fun minimum(arg0: vector<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0x1::vector::length<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0) > 0, 2);
        let v0 = 0x1::vector::borrow<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0)) {
            let v2 = 0x1::vector::borrow<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, v1);
            if (0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::sub(*v0, *v2))) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        *v0
    }

    public fun mul(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::get_raw_value(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::math_fixed64::mul_div(0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::remove_sign(arg0), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::remove_sign(arg1), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64::create_from_raw_value(18446744073709551616))), 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(arg0) == 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::is_positive(arg1))
    }

    public fun mulDown(arg0: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::round_down(mul(arg0, arg1))
    }

    public fun sum(arg0: vector<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>) : 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::create_from_raw_value(0, false);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0)) {
            v0 = 0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::add(v0, *0x1::vector::borrow<0xf2e8a7dd164f26046ddeaa3723e545c0c8b6626769aa1f8d15cae369c2a2a96a::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

