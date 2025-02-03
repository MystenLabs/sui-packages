module 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point64 {
    struct FixedPoint64 has copy, drop, store {
        value: u128,
    }

    public fun add(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        let v0 = (arg0.value as u256) + (arg1.value as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        FixedPoint64{value: (v0 as u128)}
    }

    public fun div(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        assert!(arg1.value != 0, 3);
        FixedPoint64{value: (0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::div_down((arg0.value as u256) << 64, (arg1.value as u256)) as u128)}
    }

    public fun div_down_u128(arg0: u128, arg1: FixedPoint64) : u128 {
        assert!(arg1.value != 0, 3);
        let v0 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::div_down((arg0 as u256) << 64, (arg1.value as u256));
        assert!(v0 <= 340282366920938463463374607431768211455, 4);
        (v0 as u128)
    }

    public fun div_up_u128(arg0: u128, arg1: FixedPoint64) : u128 {
        assert!(arg1.value != 0, 3);
        let v0 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::div_up((arg0 as u256) << 64, (arg1.value as u256));
        assert!(v0 <= 340282366920938463463374607431768211455, 4);
        (v0 as u128)
    }

    public fun eq(arg0: FixedPoint64, arg1: FixedPoint64) : bool {
        arg0.value == arg1.value
    }

    public fun exp(arg0: FixedPoint64) : FixedPoint64 {
        FixedPoint64{value: (exp_raw((arg0.value as u256)) as u128)}
    }

    fun exp_raw(arg0: u256) : u256 {
        let v0 = arg0 / 12786308645202655660;
        assert!(v0 <= 63, 5);
        let v1 = (v0 as u8);
        let v2 = arg0 % 12786308645202655660;
        let v3 = 22045359733108027;
        let v4 = v2 / v3;
        let v5 = v2 % v3;
        let v6 = pow_raw(18468802611690918839, (v4 as u128));
        let v7 = v6 - (v6 * 219071715585908898 * v4 >> 128);
        let v8 = v7 * v5 >> 64 - v1;
        let v9 = v8 * v5 >> 64;
        let v10 = v9 * v5 >> 64;
        let v11 = v10 * v5 >> 64;
        let v12 = v11 * v5 >> 64;
        (v7 << v1) + v8 + v9 / 2 + v10 / 6 + v11 / 24 + v12 / 120 + (v12 * v5 >> 64) / 720
    }

    public fun from(arg0: u128) : FixedPoint64 {
        let v0 = (arg0 as u256) << 64;
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        FixedPoint64{value: (v0 as u128)}
    }

    public fun from_rational(arg0: u128, arg1: u128) : FixedPoint64 {
        assert!(arg1 != 0, 3);
        let v0 = ((arg0 as u256) << 64) / (arg1 as u256);
        assert!(v0 != 0 || arg0 == 0, 1);
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        FixedPoint64{value: (v0 as u128)}
    }

    public fun from_raw_value(arg0: u128) : FixedPoint64 {
        FixedPoint64{value: arg0}
    }

    public fun gt(arg0: FixedPoint64, arg1: FixedPoint64) : bool {
        arg0.value > arg1.value
    }

    public fun gte(arg0: FixedPoint64, arg1: FixedPoint64) : bool {
        arg0.value >= arg1.value
    }

    public fun is_zero(arg0: FixedPoint64) : bool {
        arg0.value == 0
    }

    public fun lt(arg0: FixedPoint64, arg1: FixedPoint64) : bool {
        arg0.value < arg1.value
    }

    public fun lte(arg0: FixedPoint64, arg1: FixedPoint64) : bool {
        arg0.value <= arg1.value
    }

    public fun max(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        if (arg0.value > arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        if (arg0.value < arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        FixedPoint64{value: (((arg0.value as u256) * (arg1.value as u256) >> 64) as u128)}
    }

    public fun mul_div(arg0: FixedPoint64, arg1: FixedPoint64, arg2: FixedPoint64) : FixedPoint64 {
        assert!(arg2.value != 0, 3);
        FixedPoint64{value: 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math128::mul_div_down(arg0.value, arg1.value, arg2.value)}
    }

    public fun mul_u128(arg0: u128, arg1: FixedPoint64) : u128 {
        let v0 = (arg0 as u256) * (arg1.value as u256) >> 64;
        assert!(340282366920938463463374607431768211455 >= v0, 2);
        (v0 as u128)
    }

    public fun pow(arg0: FixedPoint64, arg1: u64) : FixedPoint64 {
        FixedPoint64{value: (pow_raw((arg0.value as u256), (arg1 as u128)) as u128)}
    }

    fun pow_raw(arg0: u256, arg1: u128) : u256 {
        let v0 = 18446744073709551616;
        while (arg1 != 0) {
            if (arg1 & 1 != 0) {
                let v1 = v0 * arg0;
                v0 = v1 >> 64;
            };
            arg1 = arg1 >> 1;
            let v2 = arg0 * arg0;
            arg0 = v2 >> 64;
        };
        v0
    }

    public fun sqrt(arg0: FixedPoint64) : FixedPoint64 {
        let v0 = arg0.value;
        let v1 = ((0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math128::sqrt_down(v0) << 32) as u256);
        FixedPoint64{value: ((v1 + ((v0 as u256) << 64) / v1 >> 1) as u128)}
    }

    public fun sub(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        let v0 = arg0.value;
        let v1 = arg1.value;
        assert!(v0 >= v1, 0);
        FixedPoint64{value: v0 - v1}
    }

    public fun to_u128(arg0: FixedPoint64) : u128 {
        let v0 = to_u128_down(arg0) << 64;
        if (arg0.value < v0 + 9223372036854775808) {
            v0 >> 64
        } else {
            to_u128_up(arg0)
        }
    }

    public fun to_u128_down(arg0: FixedPoint64) : u128 {
        arg0.value >> 64
    }

    public fun to_u128_up(arg0: FixedPoint64) : u128 {
        let v0 = to_u128_down(arg0) << 64;
        if (arg0.value == v0) {
            return v0 >> 64
        };
        (((v0 as u256) + 18446744073709551616 >> 64) as u128)
    }

    public fun value(arg0: FixedPoint64) : u128 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

