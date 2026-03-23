module 0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::bluefin {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::SwapContext, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        let v0 = 0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::take_balance<T0>(arg0);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg1, arg2, arg3, true, true, 0x2::balance::value<T0>(&v0), 4295048017);
        0x2::balance::destroy_zero<T0>(v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg2, arg3, v0, 0x2::balance::zero<T1>(), v3);
        0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::merge_balance<T1>(arg0, v2);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::SwapContext, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        let v0 = 0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::take_balance<T1>(arg0);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg1, arg2, arg3, false, true, 0x2::balance::value<T1>(&v0), 79226673515401279992447579054);
        0x2::balance::destroy_zero<T1>(v2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), v0, v3);
        0x6a4a9d92d5db6410701b48c6cd7cecde6dfc3a271687cd2d83523c1d4b8a0a0a::router::merge_balance<T0>(arg0, v1);
    }

    // decompiled from Move bytecode v6
}

