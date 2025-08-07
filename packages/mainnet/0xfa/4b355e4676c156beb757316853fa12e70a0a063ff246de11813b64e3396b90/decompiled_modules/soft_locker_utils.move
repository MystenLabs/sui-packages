module 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::soft_locker_utils {
    public fun calculate_position_liquidity_in_token_a<T0, T1>(arg0: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : u128 {
        let v0 = 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::full_mul(v0, v0);
        assert!(v1 > 0, 9375892909283584);
        let (v2, v3) = 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::get_position_amounts<T0, T1>(arg0, arg1);
        let (v4, v5) = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::overflowing_add((v2 as u128) << 64, ((((v3 as u256) << 192) / v1) as u128));
        assert!(!v5, 9877453648562383);
        v4
    }

    public fun calculate_position_liquidity_in_token_b<T0, T1>(arg0: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : u128 {
        let v0 = 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::full_mul(v0, v0);
        assert!(v1 > 0, 9375892909283584);
        let (v2, v3) = 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::get_position_amounts<T0, T1>(arg0, arg1);
        let (v4, v5) = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u128::overflowing_add((v3 as u128) << 64, (((v2 as u256) * v1 >> 64) as u128));
        assert!(!v5, 9877453648562383);
        v4
    }

    public fun calculate_token_a_in_token_b<T0, T1>(arg0: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::full_mul(v0, v0);
        assert!(v1 > 0, 9375892909283584);
        (((arg1 as u256) * v1 >> 128) as u64)
    }

    // decompiled from Move bytecode v6
}

