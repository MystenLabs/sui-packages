module 0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::swap_turbos_clmm {
    fun swap<T0, T1, T2, T3, T4>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::state::State, arg5: &0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::swap_transaction::SwapTransaction<T3, T4>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let v2 = if (v1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v3, v4) = if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
            let (v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg2, 0x1::option::to_vec<0x2::coin::Coin<T0>>(arg0), v0, 0, v2, true, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg6) + 60000, arg6, arg3, arg7);
            (v6, v5)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg2, 0x1::option::to_vec<0x2::coin::Coin<T1>>(arg1), v0, 0, v2, true, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg6) + 60000, arg6, arg3, arg7)
        };
        let v7 = v4;
        let v8 = v3;
        let v9 = if (v1) {
            0x2::coin::value<T1>(&v7)
        } else {
            0x2::coin::value<T0>(&v8)
        };
        let v10 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2);
        0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::swap_event::emit_common_swap<T0, T1>(0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::consts::DEX_TURBOS_CLMM(), 0x2::object::id_to_address(&v10), v1, v0, v9, true);
        (v8, v7)
    }

    public fun swap_a2b<T0, T1, T2, T3, T4>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::state::State, arg4: &0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::swap_transaction::SwapTransaction<T3, T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap<T0, T1, T2, T3, T4>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg3, arg4, arg5, arg6);
        0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::utils::transfer_or_destroy<T0>(v0, arg6);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3, T4>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::state::State, arg4: &0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::swap_transaction::SwapTransaction<T3, T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap<T0, T1, T2, T3, T4>(0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
        0x597cd36040d136d2434032ef9bed547bf7503055c1061ec019805c3d7a8b20de::utils::transfer_or_destroy<T1>(v1, arg6);
        v0
    }

    // decompiled from Move bytecode v6
}

