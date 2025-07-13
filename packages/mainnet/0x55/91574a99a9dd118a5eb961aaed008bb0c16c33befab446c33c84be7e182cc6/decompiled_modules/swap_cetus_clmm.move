module 0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::swap_cetus_clmm {
    public fun swap<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::swap_transaction::SwapTransaction<T2, T3>, arg5: &0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::state::State, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let v2 = if (v1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, v1, true, v0, v2, arg6);
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
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg2, arg3, v8, v9, v5);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
        let v10 = if (v1) {
            0x2::balance::value<T1>(&v6)
        } else {
            0x2::balance::value<T0>(&v7)
        };
        let v11 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3);
        0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::swap_event::emit_common_swap<T0, T1>(0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::consts::DEX_CETUS_CLMM(), 0x2::object::id_to_address(&v11), v1, v0, v10, true);
        (0x2::coin::from_balance<T0>(v7, arg7), 0x2::coin::from_balance<T1>(v6, arg7))
    }

    public fun swap_a2b<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::state::State, arg4: &0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::swap_transaction::SwapTransaction<T2, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap<T0, T1, T2, T3>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg4, arg3, arg5, arg6);
        0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::utils::transfer_or_destroy<T0>(v0, arg6);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::state::State, arg4: &0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::swap_transaction::SwapTransaction<T2, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap<T0, T1, T2, T3>(0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg0), arg1, arg2, arg4, arg3, arg5, arg6);
        0x5591574a99a9dd118a5eb961aaed008bb0c16c33befab446c33c84be7e182cc6::utils::transfer_or_destroy<T1>(v1, arg6);
        v0
    }

    // decompiled from Move bytecode v6
}

