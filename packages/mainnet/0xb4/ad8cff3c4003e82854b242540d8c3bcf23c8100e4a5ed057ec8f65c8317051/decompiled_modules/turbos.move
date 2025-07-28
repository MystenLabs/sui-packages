module 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::turbos {
    public(friend) fun ta<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::get_coin_vec<T0>(arg0), 0x2::coin::value<T0>(&arg0), arg2, arg3, true, arg5, 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::get_deadline(arg6), arg6, arg4, arg7)
    }

    public(friend) fun tb<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::get_coin_vec<T1>(arg0), 0x2::coin::value<T1>(&arg0), arg2, arg3, true, arg5, 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::get_deadline(arg6), arg6, arg4, arg7)
    }

    public fun test_ta<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::admin::get_address();
        let (v1, v2) = ta<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6);
        let v3 = v2;
        0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::send_coin<T1>(v1, v0);
        if (0x2::coin::value<T0>(&v3) == 0) {
            0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::destroy_zero<T0>(v3);
        } else {
            0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::send_coin<T0>(v3, v0);
        };
    }

    public fun test_tb<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::admin::get_address();
        let (v1, v2) = tb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6);
        let v3 = v2;
        0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::send_coin<T0>(v1, v0);
        if (0x2::coin::value<T1>(&v3) == 0) {
            0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::destroy_zero<T1>(v3);
        } else {
            0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::tools::send_coin<T1>(v3, v0);
        };
    }

    // decompiled from Move bytecode v6
}

