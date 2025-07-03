module 0x4737ddb47cab22937e2511c4faa694dc3bb9b1b5a741847d04fb9e937ace77de::swap_kriya_clmm {
    public fun swap<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x4737ddb47cab22937e2511c4faa694dc3bb9b1b5a741847d04fb9e937ace77de::swap_transaction::SwapTransaction<T2, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x4737ddb47cab22937e2511c4faa694dc3bb9b1b5a741847d04fb9e937ace77de::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let (v2, v3, v4) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg2, v1, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg5, arg3, arg6);
        let v5 = v3;
        let v6 = v2;
        let v7 = if (v1) {
            0x2::coin::into_balance<T0>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0))
        } else {
            0x2::balance::zero<T0>()
        };
        let v8 = if (v1) {
            0x2::balance::zero<T1>()
        } else {
            0x2::coin::into_balance<T1>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut arg1))
        };
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg2, v4, v7, v8, arg3, arg6);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
        let v9 = 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg2);
        let v10 = if (v1) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        0x4737ddb47cab22937e2511c4faa694dc3bb9b1b5a741847d04fb9e937ace77de::swap_event::emit_common_swap<T0, T1>(0x4737ddb47cab22937e2511c4faa694dc3bb9b1b5a741847d04fb9e937ace77de::consts::DEX_KRIYA_CLMM(), 0x2::object::id_to_address(&v9), v1, v0, v10, true);
        (0x2::coin::from_balance<T0>(v6, arg6), 0x2::coin::from_balance<T1>(v5, arg6))
    }

    public fun swap_a2b<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: &0x4737ddb47cab22937e2511c4faa694dc3bb9b1b5a741847d04fb9e937ace77de::state::State, arg4: &0x4737ddb47cab22937e2511c4faa694dc3bb9b1b5a741847d04fb9e937ace77de::swap_transaction::SwapTransaction<T2, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap<T0, T1, T2, T3>(arg0, 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg4, arg5, arg6);
        0x4737ddb47cab22937e2511c4faa694dc3bb9b1b5a741847d04fb9e937ace77de::utils::transfer_or_destroy<T0>(v0, arg6);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T1>>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: &0x4737ddb47cab22937e2511c4faa694dc3bb9b1b5a741847d04fb9e937ace77de::state::State, arg4: &0x4737ddb47cab22937e2511c4faa694dc3bb9b1b5a741847d04fb9e937ace77de::swap_transaction::SwapTransaction<T2, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap<T0, T1, T2, T3>(0x1::option::none<0x2::coin::Coin<T0>>(), arg0, arg1, arg2, arg4, arg5, arg6);
        0x4737ddb47cab22937e2511c4faa694dc3bb9b1b5a741847d04fb9e937ace77de::utils::transfer_or_destroy<T1>(v1, arg6);
        v0
    }

    // decompiled from Move bytecode v6
}

