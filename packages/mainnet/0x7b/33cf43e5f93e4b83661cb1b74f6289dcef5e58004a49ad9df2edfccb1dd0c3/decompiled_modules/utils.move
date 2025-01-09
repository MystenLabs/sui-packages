module 0x7b33cf43e5f93e4b83661cb1b74f6289dcef5e58004a49ad9df2edfccb1dd0c3::utils {
    public fun calculate_liquidity(arg0: u128, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: u64, arg4: u64) : u128 {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_liquidity_for_amounts(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg2), (arg3 as u128), (arg4 as u128))
    }

    public fun coin_to_vec<T0>(arg0: 0x2::coin::Coin<T0>) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        v0
    }

    public fun get_type_name_str<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

