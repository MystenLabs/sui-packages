module 0xc0912a1fa6568d2884341b839b74c7555d4da366bd04263d144afc36086729d::locker_utils {
    public fun calculate_position_liquidity_in_token_a<T0, T1>(arg0: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : u128 {
        let v0 = 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::full_mul(v0, v0);
        assert!(v1 > 0, 9375892909283584);
        let (v2, v3) = 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::get_position_amounts<T0, T1>(arg0, arg1);
        let (v4, v5) = 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::overflowing_add((v2 as u128) << 64, ((((v3 as u256) << 64 << 64 << 64) / v1) as u128));
        assert!(!v5, 9877453648562383);
        v4
    }

    public fun calculate_position_liquidity_in_token_b<T0, T1>(arg0: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : u128 {
        let v0 = 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::full_mul(v0, v0);
        assert!(v1 > 0, 9375892909283584);
        let (v2, v3) = 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::get_position_amounts<T0, T1>(arg0, arg1);
        let (v4, v5) = 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u128::overflowing_add((v3 as u128) << 64, (((v2 as u256) * v1 >> 64) as u128));
        assert!(!v5, 9877453648562383);
        v4
    }

    public fun calculate_token_a_in_token_b<T0, T1>(arg0: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::full_mul(v0, v0);
        assert!(v1 > 0, 9375892909283584);
        (((arg1 as u256) * v1 >> 64 >> 64) as u64)
    }

    // decompiled from Move bytecode v6
}

