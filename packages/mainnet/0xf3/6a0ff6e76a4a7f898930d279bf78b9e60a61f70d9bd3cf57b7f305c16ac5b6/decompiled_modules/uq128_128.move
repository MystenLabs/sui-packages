module 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128 {
    struct UQ128_128 has copy, drop, store {
        mantissa: u256,
    }

    public fun add(arg0: &UQ128_128, arg1: &UQ128_128) : UQ128_128 {
        UQ128_128{mantissa: arg0.mantissa + arg1.mantissa}
    }

    public fun diff(arg0: &UQ128_128, arg1: &UQ128_128) : UQ128_128 {
        let v0 = min(arg0, arg1);
        let v1 = max(arg0, arg1);
        UQ128_128{mantissa: v1.mantissa - v0.mantissa}
    }

    public fun div(arg0: &UQ128_128, arg1: &UQ128_128) : UQ128_128 {
        UQ128_128{mantissa: (arg0.mantissa << 64) / arg1.mantissa}
    }

    public fun div_by_u64(arg0: &UQ128_128, arg1: u64) : u64 {
        let v0 = new((arg1 as u256) << 64);
        let v1 = div(arg0, &v0);
        to_u64(&v1)
    }

    public fun div_u64(arg0: &UQ128_128, arg1: u64) : u64 {
        let v0 = new((arg1 as u256) << 64);
        let v1 = div(&v0, arg0);
        to_u64(&v1)
    }

    public fun eq(arg0: &UQ128_128, arg1: &UQ128_128) : bool {
        arg0.mantissa == arg1.mantissa
    }

    public fun from_fraction(arg0: u256, arg1: u256) : UQ128_128 {
        assert!(arg1 != 0, 13906834363321942015);
        UQ128_128{mantissa: (arg0 << 64) / arg1}
    }

    public fun from_u128(arg0: u128) : UQ128_128 {
        UQ128_128{mantissa: (arg0 as u256) << 64}
    }

    public fun from_u64(arg0: u64) : UQ128_128 {
        UQ128_128{mantissa: (arg0 as u256) << 64}
    }

    public fun mantissa(arg0: &UQ128_128) : u256 {
        arg0.mantissa
    }

    public fun max(arg0: &UQ128_128, arg1: &UQ128_128) : UQ128_128 {
        if (arg0.mantissa >= arg1.mantissa) {
            return *arg0
        };
        *arg1
    }

    public fun min(arg0: &UQ128_128, arg1: &UQ128_128) : UQ128_128 {
        if (arg0.mantissa <= arg1.mantissa) {
            return *arg0
        };
        *arg1
    }

    public fun mul(arg0: &UQ128_128, arg1: &UQ128_128) : UQ128_128 {
        UQ128_128{mantissa: arg0.mantissa * arg1.mantissa >> 64}
    }

    public fun mul_u64(arg0: &UQ128_128, arg1: u64) : u64 {
        let v0 = new((arg1 as u256) << 64);
        let v1 = mul(&v0, arg0);
        to_u64(&v1)
    }

    public fun new(arg0: u256) : UQ128_128 {
        UQ128_128{mantissa: arg0}
    }

    public fun one() : UQ128_128 {
        UQ128_128{mantissa: 18446744073709551616}
    }

    public fun pow(arg0: &UQ128_128, arg1: u64) : UQ128_128 {
        let v0 = one();
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = &v0;
            v0 = mul(v2, arg0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun pow_neg(arg0: &UQ128_128, arg1: u64) : UQ128_128 {
        let v0 = one();
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = &v0;
            v0 = div(v2, arg0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun to_u128(arg0: &UQ128_128) : u128 {
        ((arg0.mantissa >> 64) as u128)
    }

    public fun to_u64(arg0: &UQ128_128) : u64 {
        ((arg0.mantissa >> 64) as u64)
    }

    public fun zero() : UQ128_128 {
        UQ128_128{mantissa: 0}
    }

    // decompiled from Move bytecode v6
}

