module 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::math_fixed64_with_sign {
    public fun std(arg0: vector<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0, false);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0)) {
            v0 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::add(v0, pow(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::sub(*0x1::vector::borrow<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, v1), mean(arg0)), 2));
            v1 = v1 + 1;
        };
        sqrt(div_u128(v0, (0x1::vector::length<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0) as u128)))
    }

    public fun exp(arg0: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::get_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::math_fixed64::exp(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::get_raw_value(arg0)))), true);
        let v1 = v0;
        if (!0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg0)) {
            v1 = div(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(18446744073709551616, true), v0);
        };
        v1
    }

    public fun mul_div(arg0: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg1);
        let v1 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg0) == v0 && 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg2) == v0;
        0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::get_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::math_fixed64::mul_div(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::remove_sign(arg0), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::remove_sign(arg1), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::remove_sign(arg2))), v1)
    }

    public fun pow(arg0: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u64) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::get_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::math_fixed64::pow(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::get_raw_value(arg0)), arg1)), true)
    }

    public fun sqrt(arg0: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg0), 1);
        0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::get_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::math_fixed64::sqrt(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::get_raw_value(arg0)))), true)
    }

    public fun div(arg0: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::get_raw_value(arg1) != 0, 0);
        0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::get_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::math_fixed64::mul_div(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::remove_sign(arg0), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_raw_value(18446744073709551616), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::remove_sign(arg1))), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg0) == 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg1))
    }

    public fun div_u128(arg0: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u128) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::get_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::math_fixed64::mul_div(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::get_raw_value(arg0)), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_raw_value(18446744073709551616), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_raw_value(arg1 << 64))), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg0))
    }

    public fun ln(arg0: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg0), 1);
        0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::sub(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::get_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::math_fixed64::ln_plus_32ln2(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::remove_sign(arg0))), true), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(64 * 12786308645202655660, true))
    }

    public fun log2(arg0: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg0), 1);
        0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::sub(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::get_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::math_fixed64::log2_plus_64(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::remove_sign(arg0))), true), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(1180591620717411303424, true))
    }

    public fun maximum(arg0: vector<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0x1::vector::length<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0) > 0, 2);
        let v0 = 0x1::vector::borrow<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0)) {
            let v2 = 0x1::vector::borrow<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, v1);
            if (0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::sub(*v2, *v0))) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        *v0
    }

    public fun mean(arg0: vector<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0x1::vector::length<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0) > 0, 2);
        let v0 = 0x1::vector::length<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0);
        let v1 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0, false);
        let v2 = 0;
        while (v2 < v0) {
            v1 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::add(v1, *0x1::vector::borrow<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, v2));
            v2 = v2 + 1;
        };
        div(v1, 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value((v0 as u128) << 64, true))
    }

    public fun minimum(arg0: vector<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(0x1::vector::length<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0) > 0, 2);
        let v0 = 0x1::vector::borrow<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0)) {
            let v2 = 0x1::vector::borrow<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, v1);
            if (0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::sub(*v0, *v2))) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        *v0
    }

    public fun mul(arg0: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::get_raw_value(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::math_fixed64::mul_div(0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::remove_sign(arg0), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::remove_sign(arg1), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64::create_from_raw_value(18446744073709551616))), 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg0) == 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::is_positive(arg1))
    }

    public fun sum(arg0: vector<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>) : 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::create_from_raw_value(0, false);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0)) {
            v0 = 0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::add(v0, *0x1::vector::borrow<0x418dc53348ea56bdebe518dc30e129ab51f1c902ece32798b1f71acbe2075ef::fixed_point64_with_sign::FixedPoint64WithSign>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

