module 0xf62f36145fe51e5d679bafdb8593701f627ab9b35984666c32011baf1f86f1c4::cetus_adapter {
    public fun swap_a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        swap_a2b_with_limit<T0, T1>(arg0, arg1, arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3, arg4)
    }

    public fun swap_a2b_with_limit<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, arg3, arg4);
        let v4 = v3;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::coin::from_balance<T1>(v2, arg5)
    }

    public fun swap_b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        swap_b2a_with_limit<T0, T1>(arg0, arg1, arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3, arg4)
    }

    public fun swap_b2a_with_limit<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, arg3, arg4);
        let v4 = v3;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), v4);
        0x2::balance::destroy_zero<T1>(v2);
        0x2::coin::from_balance<T0>(v1, arg5)
    }

    // decompiled from Move bytecode v6
}

