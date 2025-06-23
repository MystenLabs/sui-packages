module 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::quoter_math {
    public(friend) fun swap(arg0: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, arg1: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, arg2: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, arg3: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, arg4: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, arg5: u64, arg6: u64, arg7: u64, arg8: bool) : u64 {
        let v0 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::utils::decimal_to_fixedpoint64(arg1);
        let v1 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::utils::decimal_to_fixedpoint64(arg2);
        let v2 = if (arg5 >= arg6) {
            0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::pow(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from(10), arg5 - arg6)
        } else {
            0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::div(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::one(), 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::pow(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from(10), arg6 - arg5))
        };
        let v3 = if (arg8) {
            0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::div(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::utils::decimal_to_fixedpoint64(arg0), 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::div(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::utils::decimal_to_fixedpoint64(arg3), 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::utils::decimal_to_fixedpoint64(arg4))), 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(v1, v2))
        } else {
            0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::div(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::utils::decimal_to_fixedpoint64(arg0), v2), 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(v0, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::div(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::utils::decimal_to_fixedpoint64(arg3), 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::utils::decimal_to_fixedpoint64(arg4))))
        };
        let v4 = if (arg8) {
            (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::to_u128_down(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(newton_raphson(v3, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from((arg7 as u128)), 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::min(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from_rational(9999999999, 10000000000), v3)), v1)) as u64)
        } else {
            (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::to_u128_down(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(newton_raphson(v3, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from((arg7 as u128)), 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::min(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from_rational(9999999999, 10000000000), v3)), v0)) as u64)
        };
        if (arg8) {
            if (v4 >= 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(arg2)) {
                return 0
            };
        } else if (v4 >= 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(arg1)) {
            return 0
        };
        v4
    }

    fun compute_f(arg0: 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::FixedPoint64, arg1: 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::FixedPoint64, arg2: 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::FixedPoint64) : (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::FixedPoint64, bool) {
        let v0 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::one();
        let v1 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from_raw_value(12786308645202655660), 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from(64));
        let v2 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::div(v0, arg1);
        let v3 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::ln_plus_64ln2(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::sub(v0, arg0));
        assert!(!0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::gt(v3, v1), 999);
        let v4 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::add(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::sub(v0, v2), arg0), 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(v2, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::sub(v1, v3)));
        if (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::gte(v4, arg2)) {
            (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::sub(v4, arg2), true)
        } else {
            (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::sub(arg2, v4), false)
        }
    }

    fun compute_f_prime(arg0: 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::FixedPoint64, arg1: 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::FixedPoint64) : 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::FixedPoint64 {
        let v0 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::one();
        0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::add(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::sub(v0, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::div(v0, arg1)), 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::div(v0, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(arg1, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::sub(v0, arg0))))
    }

    fun newton_raphson(arg0: 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::FixedPoint64, arg1: 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::FixedPoint64, arg2: 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::FixedPoint64) : 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::FixedPoint64 {
        let v0 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::one();
        let v1 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from_rational(1, 100000);
        let v2 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from_rational(999999999999999999, 1000000000000000000);
        let v3 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from_rational(1, 100000000000000);
        let v4 = if (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::gte(arg2, v0)) {
            v2
        } else {
            arg2
        };
        let v5 = v4;
        let v6 = 0;
        while (v6 < 20) {
            let (v7, v8) = compute_f(v5, arg1, arg0);
            if (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::lt(v7, v3)) {
                break
            };
            let v9 = compute_f_prime(v5, arg1);
            assert!(!0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::lt(v9, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from_rational(1, 10000000000)), 1001);
            let v10 = 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::div(v7, v9);
            let v11 = if (v8) {
                0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::sub(v5, v10)
            } else {
                0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::add(v5, v10)
            };
            let v12 = v11;
            if (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::lte(v11, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::zero()) || 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::gte(v11, v0)) {
                let v13 = if (v8) {
                    0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::sub(v4, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(v10, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from_rational(1, 2)))
                } else {
                    0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::add(v4, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::mul(v10, 0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::from_rational(1, 2)))
                };
                let v14 = if (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::lt(v13, v1)) {
                    v1
                } else if (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::gt(v13, v2)) {
                    v2
                } else {
                    v13
                };
                v12 = v14;
            };
            let v15 = if (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::gte(v12, v4)) {
                0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::sub(v12, v4)
            } else {
                0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::sub(v4, v12)
            };
            if (0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::fixed_point64::lt(v15, v3)) {
                break
            };
            v5 = v12;
            v6 = v6 + 1;
        };
        v5
    }

    // decompiled from Move bytecode v6
}

