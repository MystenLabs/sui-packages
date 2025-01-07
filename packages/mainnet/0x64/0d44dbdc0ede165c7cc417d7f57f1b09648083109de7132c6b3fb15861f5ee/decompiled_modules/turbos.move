module 0x640d44dbdc0ede165c7cc417d7f57f1b09648083109de7132c6b3fb15861f5ee::turbos {
    struct TurbosSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        fee: 0x1::type_name::TypeName,
    }

    public fun swap<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u128, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        if (arg6) {
            let v0 = if (arg5) {
                0x2::coin::value<T0>(&arg3)
            } else {
                0x2::coin::value<T1>(&arg4)
            };
            arg1 = v0;
        };
        let v1 = if (arg5) {
            assert!(0x2::coin::value<T0>(&arg3) >= arg1, 1);
            let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::split<T0>(&mut arg3, arg1, arg10));
            let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v2, arg1, arg2, arg7, true, 0x2::tx_context::sender(arg10), 0x2::clock::timestamp_ms(arg8) + 18000, arg8, arg9, arg10);
            let v5 = v3;
            assert!(0x2::coin::value<T1>(&v5) >= arg2, 0);
            let v6 = 0x2::coin::value<T1>(&v5);
            let v7 = TurbosSwapEvent{
                pool         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
                amount_in    : arg1,
                amount_out   : v6,
                a2b          : arg5,
                by_amount_in : true,
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
                fee          : 0x1::type_name::get<T2>(),
            };
            0x2::event::emit<TurbosSwapEvent>(v7);
            0x2::coin::join<T0>(&mut arg3, v4);
            0x2::coin::join<T1>(&mut arg4, v5);
            v6
        } else {
            assert!(0x2::coin::value<T1>(&arg4) >= arg1, 1);
            let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, 0x2::coin::split<T1>(&mut arg4, arg1, arg10));
            let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v8, arg1, arg2, arg7, true, 0x2::tx_context::sender(arg10), 0x2::clock::timestamp_ms(arg8) + 18000, arg8, arg9, arg10);
            let v11 = v9;
            assert!(0x2::coin::value<T0>(&v11) >= arg2, 0);
            let v12 = 0x2::coin::value<T0>(&v11);
            let v13 = TurbosSwapEvent{
                pool         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
                amount_in    : arg1,
                amount_out   : v12,
                a2b          : arg5,
                by_amount_in : true,
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
                fee          : 0x1::type_name::get<T2>(),
            };
            0x2::event::emit<TurbosSwapEvent>(v13);
            0x2::coin::join<T0>(&mut arg3, v11);
            0x2::coin::join<T1>(&mut arg4, v10);
            v12
        };
        (arg3, arg4, arg1, v1)
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64, u64) {
        let v0 = 0x2::coin::zero<T1>(arg8);
        let (v1, v2, v3, v4) = swap<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, true, arg4, arg5, arg6, arg7, arg8);
        0x640d44dbdc0ede165c7cc417d7f57f1b09648083109de7132c6b3fb15861f5ee::utils::transfer_or_destroy_coin<T0>(v1, arg8);
        (v2, v3, v4)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, u64) {
        let v0 = 0x2::coin::zero<T0>(arg8);
        let (v1, v2, v3, v4) = swap<T0, T1, T2>(arg0, arg1, arg2, v0, arg3, false, arg4, arg5, arg6, arg7, arg8);
        0x640d44dbdc0ede165c7cc417d7f57f1b09648083109de7132c6b3fb15861f5ee::utils::transfer_or_destroy_coin<T1>(v2, arg8);
        (v1, v3, v4)
    }

    // decompiled from Move bytecode v6
}

