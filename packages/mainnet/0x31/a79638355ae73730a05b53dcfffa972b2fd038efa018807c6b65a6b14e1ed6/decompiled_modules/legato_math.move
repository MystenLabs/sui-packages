module 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::legato_math {
    public fun absolute(arg0: 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64, arg1: 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64) : (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64, bool) {
        if (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::greater_or_equal(arg0, arg1)) {
            (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::sub(arg0, arg1), false)
        } else {
            (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::sub(arg1, arg0), true)
        }
    }

    public fun ln(arg0: 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64) : 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64 {
        let (v0, _) = absolute(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::log2_plus_64(arg0), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(64));
        0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(v0, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_raw_value(26613026195707766742))
    }

    public fun nth_root(arg0: 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64, arg1: u64) : 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64 {
        if (arg1 == 0) {
            0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1)
        } else {
            let v1 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_rational(1, 2);
            let v2 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_rational(18446744073709551615, 1);
            while (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::greater(v2, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_rational(1, 1000))) {
                let v3 = pow_raw(v1, arg1);
                let v4 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128((arg1 as u128)), pow_raw(v1, arg1 - 1), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1));
                if (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::greater_or_equal(v3, arg0)) {
                    let v5 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::sub(v3, arg0), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1), v4);
                    v2 = v5;
                    v1 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::sub(v1, v5);
                    continue
                };
                v2 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::sub(arg0, v3), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1), v4);
                v1 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::add(v1, v2);
            };
            v1
        }
    }

    public fun pow_raw(arg0: 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64, arg1: u64) : 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64 {
        let v0 = (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::get_raw_value(arg0) as u256);
        let v1 = 18446744073709551616;
        while (arg1 != 0) {
            if (arg1 & 1 != 0) {
                let v2 = v1 * v0;
                v1 = v2 >> 64;
            };
            arg1 = arg1 >> 1;
            if (v0 <= 340282366920938463463374607431768211455) {
                let v3 = v0 * v0;
                v0 = v3 >> 64;
                continue
            };
            let v4 = v0 >> 32;
            let v5 = v0 >> 32;
            v0 = v4 * v5;
        };
        0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_raw_value((v1 as u128))
    }

    public fun power(arg0: 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64, arg1: 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64) : 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::FixedPoint64 {
        if (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::equal(arg1, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(0))) {
            0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1)
        } else if (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::equal(arg1, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1))) {
            arg0
        } else if (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::less(arg0, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1))) {
            let v1 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::floor(arg1);
            let v2 = 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::sub(arg1, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(v1));
            if (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::equal(v2, 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(0))) {
                0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::pow(arg0, (v1 as u64))
            } else {
                0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::pow(arg0, (v1 as u64)), nth_root(arg0, (0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::round(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1), v2)) as u64)), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1))
            }
        } else {
            0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::exp(0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::math_fixed64::mul_div(arg1, ln(arg0), 0x31a79638355ae73730a05b53dcfffa972b2fd038efa018807c6b65a6b14e1ed6::fixed_point64::create_from_u128(1)))
        }
    }

    // decompiled from Move bytecode v6
}

