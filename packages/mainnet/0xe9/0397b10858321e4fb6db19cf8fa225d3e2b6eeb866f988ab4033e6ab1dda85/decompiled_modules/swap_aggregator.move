module 0xe90397b10858321e4fb6db19cf8fa225d3e2b6eeb866f988ab4033e6ab1dda85::swap_aggregator {
    struct TimeEvent has copy, drop {
        timestamp_ms: u64,
    }

    struct InitiateSwapEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        steps: u64,
    }

    public entry fun cetus_router<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = cetus_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v2 = 0x2::tx_context::sender(arg10);
        0xe90397b10858321e4fb6db19cf8fa225d3e2b6eeb866f988ab4033e6ab1dda85::utils::transfer_or_destroy_zero<T0>(v0, v2);
        0xe90397b10858321e4fb6db19cf8fa225d3e2b6eeb866f988ab4033e6ab1dda85::utils::transfer_or_destroy_zero<T1>(v1, v2);
    }

    fun cetus_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xe90397b10858321e4fb6db19cf8fa225d3e2b6eeb866f988ab4033e6ab1dda85::utils::merge_coins<T1>(arg3, arg10);
        let v1 = 0xe90397b10858321e4fb6db19cf8fa225d3e2b6eeb866f988ab4033e6ab1dda85::utils::merge_coins<T0>(arg2, arg10);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        if (arg4) {
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg10)))
        };
        0x2::coin::join<T1>(&mut v0, 0x2::coin::from_balance<T1>(v6, arg10));
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v7, arg10));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v5);
        (v1, v0)
    }

    // decompiled from Move bytecode v6
}

