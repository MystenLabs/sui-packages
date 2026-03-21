module 0x568f3889b8833cb953eb4a6cd103d219a370bdcb3578dd85027123727d6c2efa::cetus {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x568f3889b8833cb953eb4a6cd103d219a370bdcb3578dd85027123727d6c2efa::router::SwapContext, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = 0x568f3889b8833cb953eb4a6cd103d219a370bdcb3578dd85027123727d6c2efa::router::take_balance<T0>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::balance::value<T0>(&v0), 4295048016, arg3);
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v0, 0x2::balance::zero<T1>(), v3);
        0x568f3889b8833cb953eb4a6cd103d219a370bdcb3578dd85027123727d6c2efa::router::merge_balance<T1>(arg0, v2);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x568f3889b8833cb953eb4a6cd103d219a370bdcb3578dd85027123727d6c2efa::router::SwapContext, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = 0x568f3889b8833cb953eb4a6cd103d219a370bdcb3578dd85027123727d6c2efa::router::take_balance<T1>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::balance::value<T1>(&v0), 79226673515401279992447579055, arg3);
        0x2::balance::destroy_zero<T1>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v0, v3);
        0x568f3889b8833cb953eb4a6cd103d219a370bdcb3578dd85027123727d6c2efa::router::merge_balance<T0>(arg0, v1);
    }

    // decompiled from Move bytecode v6
}

