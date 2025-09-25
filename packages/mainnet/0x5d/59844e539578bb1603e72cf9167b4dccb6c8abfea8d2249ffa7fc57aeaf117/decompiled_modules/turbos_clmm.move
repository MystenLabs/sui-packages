module 0x89ecd484c3694b14936ede1a21163f578daa5fb59c91a657616239064c81e642::turbos_clmm {
    struct TurbosClmmSwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    fun swap<T0, T1, T2>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x89ecd484c3694b14936ede1a21163f578daa5fb59c91a657616239064c81e642::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let v2 = if (v1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v3, v4) = if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
            let (v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg2, 0x1::option::to_vec<0x2::coin::Coin<T0>>(arg0), v0, 0, v2, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4) + 60000, arg4, arg3, arg5);
            (v6, v5)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg2, 0x1::option::to_vec<0x2::coin::Coin<T1>>(arg1), v0, 0, v2, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4) + 60000, arg4, arg3, arg5)
        };
        let v7 = v4;
        let v8 = v3;
        let v9 = if (v1) {
            0x2::coin::value<T1>(&v7)
        } else {
            0x2::coin::value<T0>(&v8)
        };
        let v10 = TurbosClmmSwapEvent{
            pool_id      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2),
            a2b          : v1,
            amount_in    : v0,
            amount_out   : v9,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<TurbosClmmSwapEvent>(v10);
        (v8, v7)
    }

    public fun swap_a2b<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        swap<T0, T1, T2>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg3, arg4)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        swap<T0, T1, T2>(0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg0), arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

