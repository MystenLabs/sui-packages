module 0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::swap_kriya_clmm {
    public fun swap<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::swap_transaction::SwapTransaction<T2, T3>, arg6: &0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::state::State, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let v2 = if (v1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v3, v4, v5) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg2, v1, true, v0, v2, arg3, arg4, arg7);
        let v6 = v4;
        let v7 = v3;
        let v8 = if (v1) {
            0x2::coin::into_balance<T0>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0))
        } else {
            0x2::balance::zero<T0>()
        };
        let v9 = if (v1) {
            0x2::balance::zero<T1>()
        } else {
            0x2::coin::into_balance<T1>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut arg1))
        };
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg2, v5, v8, v9, arg4, arg7);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
        let v10 = 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg2);
        let v11 = if (v1) {
            0x2::balance::value<T1>(&v6)
        } else {
            0x2::balance::value<T0>(&v7)
        };
        0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::swap_event::emit_common_swap<T0, T1>(0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::consts::DEX_KRIYA_CLMM(), 0x2::object::id_to_address(&v10), v1, v0, v11, true);
        (0x2::coin::from_balance<T0>(v7, arg7), 0x2::coin::from_balance<T1>(v6, arg7))
    }

    public fun swap_a2b<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::swap_transaction::SwapTransaction<T2, T3>, arg5: &0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap<T0, T1, T2, T3>(arg0, 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg3, arg4, arg5, arg6);
        0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::utils::transfer_or_destroy<T0>(v0, arg6);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T1>>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::swap_transaction::SwapTransaction<T2, T3>, arg5: &0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap<T0, T1, T2, T3>(0x1::option::none<0x2::coin::Coin<T0>>(), arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xb8f948256f6a6eb67ff80f9330d8ecd3e891c571f1ad54d60b06dbedc41e195b::utils::transfer_or_destroy<T1>(v1, arg6);
        v0
    }

    // decompiled from Move bytecode v6
}

