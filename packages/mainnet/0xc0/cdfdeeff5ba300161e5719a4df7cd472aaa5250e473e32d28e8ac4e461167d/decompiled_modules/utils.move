module 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::utils {
    public fun add_balance_to_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0))
    }

    public fun oracle_price_multiplier_decimal() : u8 {
        10
    }

    public fun price_multiplier_decimal() : u8 {
        10
    }

    public fun price_to_sqrt_price(arg0: u64) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(0x1::u128::sqrt((arg0 as u128) * 0x1::u128::pow(10, 10)), 18446744073709551616, 0x1::u128::pow(10, (10 + 10) / 2))
    }

    public fun remove_balance_from_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: u64, arg2: bool) : (0x2::balance::Balance<T0>, u64) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            return (0x2::balance::zero<T0>(), 0)
        };
        let v1 = if (arg2) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0))
        } else {
            arg1
        };
        (0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), v1), 0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0)))
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun uint64_max() : u128 {
        18446744073709551616
    }

    // decompiled from Move bytecode v6
}

