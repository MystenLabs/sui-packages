module 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fixed_point64 {
    struct FP64 has copy, drop, store {
        raw: u128,
    }

    public fun add(arg0: FP64, arg1: FP64) : FP64 {
        let v0 = (arg0.raw as u256) + (arg1.raw as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 2);
        FP64{raw: (v0 as u128)}
    }

    public fun div(arg0: FP64, arg1: FP64) : FP64 {
        assert!(arg1.raw != 0, 1);
        FP64{raw: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor(arg0.raw, 18446744073709551616, arg1.raw)}
    }

    public fun div_u64_ceil(arg0: u64, arg1: FP64) : u64 {
        assert!(arg1.raw != 0, 1);
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_ceil((arg0 as u128), 18446744073709551616, arg1.raw);
        assert!(v0 <= 18446744073709551615, 2);
        (v0 as u64)
    }

    public fun div_u64_ceil_u128(arg0: u64, arg1: FP64) : u128 {
        assert!(arg1.raw != 0, 1);
        0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_ceil((arg0 as u128), 18446744073709551616, arg1.raw)
    }

    public fun div_u64_floor(arg0: u64, arg1: FP64) : u64 {
        assert!(arg1.raw != 0, 1);
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor((arg0 as u128), 18446744073709551616, arg1.raw);
        assert!(v0 <= 18446744073709551615, 2);
        (v0 as u64)
    }

    public fun div_u64_floor_u128(arg0: u64, arg1: FP64) : u128 {
        assert!(arg1.raw != 0, 1);
        0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor((arg0 as u128), 18446744073709551616, arg1.raw)
    }

    public fun eq(arg0: FP64, arg1: FP64) : bool {
        arg0.raw == arg1.raw
    }

    public fun from_fraction(arg0: u64, arg1: u64) : FP64 {
        assert!(arg1 != 0, 1);
        FP64{raw: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor((arg0 as u128), 18446744073709551616, (arg1 as u128))}
    }

    public fun from_raw(arg0: u128) : FP64 {
        FP64{raw: arg0}
    }

    public fun from_u64(arg0: u64) : FP64 {
        FP64{raw: (arg0 as u128) * 18446744073709551616}
    }

    public fun gt(arg0: FP64, arg1: FP64) : bool {
        arg0.raw > arg1.raw
    }

    public fun gte(arg0: FP64, arg1: FP64) : bool {
        arg0.raw >= arg1.raw
    }

    public fun log2(arg0: FP64) : (bool, FP64) {
        assert!(arg0.raw > 0, 4);
        let v0 = arg0.raw < 18446744073709551616;
        let v1 = if (v0) {
            if (arg0.raw == 1) {
                let v2 = FP64{raw: 64 * 18446744073709551616};
                return (true, v2)
            };
            0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_floor(18446744073709551616, 18446744073709551616, arg0.raw)
        } else {
            arg0.raw
        };
        let v3 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::msb(v1) - 64;
        let v4 = 0;
        let v5 = v1 >> v3;
        let v6 = 63;
        loop {
            let v7 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_shr(v5, v5, 64);
            if (v7 >= 36893488147419103232) {
                v4 = v4 | 1 << v6;
                v5 = v7 >> 1;
            } else {
                v5 = v7;
            };
            if (v6 == 0) {
                break
            };
            v6 = v6 - 1;
        };
        let v8 = FP64{raw: (v3 as u128) << 64 | v4};
        (v0, v8)
    }

    public fun lt(arg0: FP64, arg1: FP64) : bool {
        arg0.raw < arg1.raw
    }

    public fun lte(arg0: FP64, arg1: FP64) : bool {
        arg0.raw <= arg1.raw
    }

    public fun mul(arg0: FP64, arg1: FP64) : FP64 {
        FP64{raw: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_shr(arg0.raw, arg1.raw, 64)}
    }

    public fun mul_u64_ceil(arg0: FP64, arg1: u64) : u64 {
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_shr_ceil(arg0.raw, (arg1 as u128), 64);
        assert!(v0 <= 18446744073709551615, 2);
        (v0 as u64)
    }

    public fun mul_u64_ceil_u128(arg0: FP64, arg1: u64) : u128 {
        0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_shr_ceil(arg0.raw, (arg1 as u128), 64)
    }

    public fun mul_u64_floor(arg0: FP64, arg1: u64) : u64 {
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_shr(arg0.raw, (arg1 as u128), 64);
        assert!(v0 <= 18446744073709551615, 2);
        (v0 as u64)
    }

    public fun mul_u64_floor_u128(arg0: FP64, arg1: u64) : u128 {
        0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_shr(arg0.raw, (arg1 as u128), 64)
    }

    public fun one() : FP64 {
        FP64{raw: 18446744073709551616}
    }

    public fun pow(arg0: FP64, arg1: u32) : FP64 {
        if (arg1 == 0) {
            return one()
        };
        let v0 = one();
        let v1 = arg1;
        while (v1 > 0) {
            if (v1 & 1 == 1) {
                v0 = mul(v0, arg0);
            };
            v1 = v1 >> 1;
            if (v1 > 0) {
                arg0 = mul(arg0, arg0);
            };
        };
        v0
    }

    public fun raw(arg0: FP64) : u128 {
        arg0.raw
    }

    public fun sub(arg0: FP64, arg1: FP64) : FP64 {
        assert!(arg0.raw >= arg1.raw, 3);
        FP64{raw: arg0.raw - arg1.raw}
    }

    public fun to_u32_round(arg0: FP64) : u32 {
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math::mul_div_nearest(arg0.raw, 1, 18446744073709551616);
        assert!(v0 <= 4294967295, 2);
        (v0 as u32)
    }

    public fun to_u64_ceil(arg0: FP64) : u64 {
        let v0 = if (arg0.raw % 18446744073709551616 > 0) {
            arg0.raw / 18446744073709551616 + 1
        } else {
            arg0.raw / 18446744073709551616
        };
        assert!(v0 <= 18446744073709551615, 2);
        (v0 as u64)
    }

    public fun to_u64_floor(arg0: FP64) : u64 {
        ((arg0.raw / 18446744073709551616) as u64)
    }

    public fun zero() : FP64 {
        FP64{raw: 0}
    }

    // decompiled from Move bytecode v7
}

