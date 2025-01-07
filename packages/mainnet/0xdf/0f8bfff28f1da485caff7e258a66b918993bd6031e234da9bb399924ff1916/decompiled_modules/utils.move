module 0xdf0f8bfff28f1da485caff7e258a66b918993bd6031e234da9bb399924ff1916::utils {
    public fun are_coins_sorted<T0, T1>() : bool {
        let v0 = compare_struct<T0, T1>();
        assert!(v0 != get_equal_enum(), 1);
        v0 == get_smaller_enum()
    }

    public fun are_types_equal<T0, T1>() : bool {
        compare_struct<T0, T1>() == 0
    }

    public fun calculate_cumulative_balance(arg0: u256, arg1: u64, arg2: u256) : u256 {
        let v0 = arg0 * (arg1 as u256) + arg2;
        while (v0 > 1340282366920938463463374607431768211455) {
            v0 = v0 - 1340282366920938463463374607431768211455;
        };
        v0
    }

    fun compare_struct<T0, T1>() : u8 {
        let v0 = get_coin_info<T0>();
        let v1 = get_coin_info<T1>();
        let v2 = 0xdf0f8bfff28f1da485caff7e258a66b918993bd6031e234da9bb399924ff1916::comparator::compare_u8_vector(v0, v1);
        if (0xdf0f8bfff28f1da485caff7e258a66b918993bd6031e234da9bb399924ff1916::comparator::is_greater_than(&v2)) {
            2
        } else {
            let v4 = 0xdf0f8bfff28f1da485caff7e258a66b918993bd6031e234da9bb399924ff1916::comparator::compare_u8_vector(v0, v1);
            if (0xdf0f8bfff28f1da485caff7e258a66b918993bd6031e234da9bb399924ff1916::comparator::is_equal(&v4)) {
                0
            } else {
                1
            }
        }
    }

    public fun get_coin_info<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun get_coin_info_string<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    public fun get_equal_enum() : u8 {
        0
    }

    public fun get_greater_enum() : u8 {
        2
    }

    public fun get_ms_per_year() : u64 {
        31536000000
    }

    public fun get_smaller_enum() : u8 {
        1
    }

    public fun handle_coin_vector<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            return v0
        };
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 > arg1) {
            0x2::pay::split_and_transfer<T0>(&mut v0, v1 - arg1, 0x2::tx_context::sender(arg2), arg2);
        };
        v0
    }

    public fun max_u_128() : u256 {
        1340282366920938463463374607431768211455
    }

    public fun quote_liquidity(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xdf0f8bfff28f1da485caff7e258a66b918993bd6031e234da9bb399924ff1916::math::mul_div(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v6
}

