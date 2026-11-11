module 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::price_math {
    struct PRICE_MATH_TEST_TOKEN has drop {
        dummy_field: bool,
    }

    public fun assert_price_within_tolerance(arg0: u128, arg1: u128, arg2: u64) {
        let v0 = arg0 * (arg2 as u128) / 10000;
        let v1 = if (arg0 > v0) {
            arg0 - v0
        } else {
            0
        };
        assert!(arg1 >= v1 && arg1 <= arg0 + v0, 1);
    }

    public fun expected_sqrt_price_x64<T0>(arg0: u128, arg1: bool) : u128 {
        if (arg1) {
            sqrt_price_x64_from_ratio(1, arg0)
        } else {
            sqrt_price_x64_from_ratio(arg0, 1)
        }
    }

    public fun isqrt_u256(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    fun sqrt_price_x64_from_ratio(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 > 0, 0);
        (isqrt_u256(((arg0 as u256) << 128) / (arg1 as u256)) as u128)
    }

    public fun sui_is_coin_a<T0>() : bool {
        type_a_sorts_after<0x2::sui::SUI, T0>()
    }

    fun type_a_sorts_after<T0, T1>() : bool {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()));
        let v2 = 0x1::vector::length<u8>(&v0);
        let v3 = 0x1::vector::length<u8>(&v1);
        let v4 = if (v2 < v3) {
            v2
        } else {
            v3
        };
        let v5 = 0;
        while (v5 < v4) {
            let v6 = *0x1::vector::borrow<u8>(&v0, v5);
            let v7 = *0x1::vector::borrow<u8>(&v1, v5);
            if (v6 != v7) {
                return v6 > v7
            };
            v5 = v5 + 1;
        };
        v2 > v3
    }

    // decompiled from Move bytecode v7
}

