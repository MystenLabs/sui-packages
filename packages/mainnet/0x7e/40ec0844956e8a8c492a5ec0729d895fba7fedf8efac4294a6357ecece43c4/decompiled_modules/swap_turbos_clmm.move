module 0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::swap_turbos_clmm {
    fun swap<T0, T1, T2, T3, T4>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::state::State, arg5: &0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::swap_transaction::SwapTransaction<T3, T4>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let v2 = if (v1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v3, v4, v5) = if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
            let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg2, 0x1::option::to_vec<0x2::coin::Coin<T0>>(arg0), v0, 0, v2, true, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg6) + 18000, arg6, arg3, arg7);
            let v8 = v6;
            (v7, v8, 0x2::coin::value<T1>(&v8))
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
            let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg2, 0x1::option::to_vec<0x2::coin::Coin<T1>>(arg1), v0, 0, v2, true, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg6) + 18000, arg6, arg3, arg7);
            let v11 = v9;
            (v11, v10, 0x2::coin::value<T0>(&v11))
        };
        let v12 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2);
        0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::swap_event::emit_common_swap<T0, T1>(0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::consts::DEX_CETUS_CLMM(), 0x2::object::id_to_address(&v12), v1, v0, v5, true);
        (v3, v4)
    }

    public fun swap_a2b<T0, T1, T2, T3, T4>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::state::State, arg4: &0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::swap_transaction::SwapTransaction<T3, T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap<T0, T1, T2, T3, T4>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg3, arg4, arg5, arg6);
        0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::utils::transfer_or_destroy<T0>(v0, arg6);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3, T4>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::state::State, arg4: &0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::swap_transaction::SwapTransaction<T3, T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap<T0, T1, T2, T3, T4>(0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
        0x7e40ec0844956e8a8c492a5ec0729d895fba7fedf8efac4294a6357ecece43c4::utils::transfer_or_destroy<T1>(v1, arg6);
        v0
    }

    // decompiled from Move bytecode v6
}

