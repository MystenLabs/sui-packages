module 0xd32371629cc08a3643029ded7fd614eef53c8e12dba6b274b0e39a5c0f613515::turbos {
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

    fun swap<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (arg3) {
            0x2::coin::value<T0>(&arg1)
        } else {
            0x2::coin::value<T1>(&arg2)
        };
        if (arg3) {
            let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::split<T0>(&mut arg1, v0, arg7));
            let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v1, v0, 0, arg4, true, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg5) + 18000, arg5, arg6, arg7);
            let v4 = v2;
            let v5 = TurbosSwapEvent{
                pool         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
                amount_in    : v0,
                amount_out   : 0x2::coin::value<T1>(&v4),
                a2b          : arg3,
                by_amount_in : true,
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
                fee          : 0x1::type_name::get<T2>(),
            };
            0x2::event::emit<TurbosSwapEvent>(v5);
            0x2::coin::join<T0>(&mut arg1, v3);
            0x2::coin::join<T1>(&mut arg2, v4);
        } else {
            let v6 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v6, 0x2::coin::split<T1>(&mut arg2, v0, arg7));
            let (v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v6, v0, 0, arg4, true, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg5) + 18000, arg5, arg6, arg7);
            let v9 = v7;
            let v10 = TurbosSwapEvent{
                pool         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
                amount_in    : v0,
                amount_out   : 0x2::coin::value<T0>(&v9),
                a2b          : arg3,
                by_amount_in : true,
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
                fee          : 0x1::type_name::get<T2>(),
            };
            0x2::event::emit<TurbosSwapEvent>(v10);
            0x2::coin::join<T0>(&mut arg1, v9);
            0x2::coin::join<T1>(&mut arg2, v8);
        };
        (arg1, arg2)
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let (v1, v2) = swap<T0, T1, T2>(arg0, arg1, v0, true, arg2, arg3, arg4, arg5);
        0xd32371629cc08a3643029ded7fd614eef53c8e12dba6b274b0e39a5c0f613515::utils::transfer_or_destroy_coin<T0>(v1, arg5);
        v2
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let (v1, v2) = swap<T0, T1, T2>(arg0, v0, arg1, false, arg2, arg3, arg4, arg5);
        0xd32371629cc08a3643029ded7fd614eef53c8e12dba6b274b0e39a5c0f613515::utils::transfer_or_destroy_coin<T1>(v2, arg5);
        v1
    }

    // decompiled from Move bytecode v6
}

