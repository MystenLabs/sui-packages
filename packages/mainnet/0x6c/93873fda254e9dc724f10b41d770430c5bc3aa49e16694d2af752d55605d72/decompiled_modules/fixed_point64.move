module 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::fixed_point64 {
    struct FixedPoint64 has copy, drop, store {
        value: u128,
    }

    public fun add(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        let v0 = (arg0.value as u256) + (arg1.value as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 0);
        FixedPoint64{value: (v0 as u128)}
    }

    public fun create_from_rational(arg0: u128, arg1: u128) : FixedPoint64 {
        assert!(arg1 != 0, 1);
        let v0 = ((arg0 as u256) << 64) / (arg1 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 0);
        FixedPoint64{value: (v0 as u128)}
    }

    public fun create_from_raw_value(arg0: u128) : FixedPoint64 {
        FixedPoint64{value: arg0}
    }

    public fun div(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        divDown(arg0, arg1)
    }

    public fun divDown(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        assert!(arg1.value != 0, 1);
        FixedPoint64{value: 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::full_math_u128::mul_div_floor(arg0.value, 18446744073709551616, arg1.value)}
    }

    public fun equal(arg0: FixedPoint64, arg1: FixedPoint64) : bool {
        arg0.value == arg1.value
    }

    public fun from_uint64(arg0: u64) : FixedPoint64 {
        FixedPoint64{value: (arg0 as u128) << 64}
    }

    public fun get_raw_value(arg0: FixedPoint64) : u128 {
        arg0.value
    }

    public fun greater(arg0: FixedPoint64, arg1: FixedPoint64) : bool {
        arg0.value > arg1.value
    }

    public fun greater_or_equal(arg0: FixedPoint64, arg1: FixedPoint64) : bool {
        arg0.value >= arg1.value
    }

    public fun is_zero(arg0: FixedPoint64) : bool {
        arg0.value == 0
    }

    public fun less(arg0: FixedPoint64, arg1: FixedPoint64) : bool {
        arg0.value < arg1.value
    }

    public fun max(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        if (arg0.value >= arg1.value) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        multiply(arg0, arg1)
    }

    public fun mul_div(arg0: FixedPoint64, arg1: FixedPoint64, arg2: FixedPoint64) : FixedPoint64 {
        assert!(arg2.value != 0, 1);
        FixedPoint64{value: 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::full_math_u128::mul_div_floor(arg0.value, arg1.value, arg2.value)}
    }

    public fun multiply(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        FixedPoint64{value: 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::full_math_u128::mul_div_floor(arg0.value, arg1.value, 18446744073709551616)}
    }

    public fun one() : FixedPoint64 {
        FixedPoint64{value: 18446744073709551616}
    }

    public fun sub(arg0: FixedPoint64, arg1: FixedPoint64) : FixedPoint64 {
        assert!(arg0.value >= arg1.value, 0);
        FixedPoint64{value: arg0.value - arg1.value}
    }

    public fun truncate(arg0: FixedPoint64) : u64 {
        ((arg0.value >> 64) as u64)
    }

    public fun truncate_up(arg0: FixedPoint64) : u64 {
        let v0 = if (arg0.value & 18446744073709551616 - 1 == 0) {
            (arg0.value as u256) >> 64
        } else {
            (arg0.value as u256) + (18446744073709551616 as u256) - 1 >> 64
        };
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    public fun zero() : FixedPoint64 {
        FixedPoint64{value: 0}
    }

    // decompiled from Move bytecode v7
}

