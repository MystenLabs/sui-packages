module 0x57855a8223f6eec2e9f31824e7abf7fe5c73f6b66860841aa777aa6df530a52e::locker_utils {
    public fun calculate_position_liquidity_in_token_a<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : u128 {
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::full_mul(v0, v0);
        assert!(v1 > 0, 9375892909283584);
        let (v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::get_position_amounts<T0, T1>(arg0, arg1);
        let (v4, v5) = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::overflowing_add((v2 as u128) << 64, ((((v3 as u256) << 64 << 64 << 64) / v1) as u128));
        assert!(!v5, 9877453648562383);
        v4
    }

    public fun calculate_position_liquidity_in_token_b<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : u128 {
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::full_mul(v0, v0);
        assert!(v1 > 0, 9375892909283584);
        let (v2, v3) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::get_position_amounts<T0, T1>(arg0, arg1);
        let (v4, v5) = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::overflowing_add((v3 as u128) << 64, (((v2 as u256) * v1 >> 64) as u128));
        assert!(!v5, 9877453648562383);
        v4
    }

    public fun calculate_token_a_in_token_b<T0, T1>(arg0: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::full_mul(v0, v0);
        assert!(v1 > 0, 9375892909283584);
        (((arg1 as u256) * v1 >> 64 >> 64) as u64)
    }

    // decompiled from Move bytecode v6
}

