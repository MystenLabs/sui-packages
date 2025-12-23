module 0x8b970870aaa5072c4144fae805a2654dc9d7e20661bf0c9eecd548fc81a84f87::cetusclmm {
    public fun swap<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg4);
        let v5 = v3;
        let v6 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v0, 0x2::balance::zero<T1>(), v4);
        let v7 = 0x2::balance::value<T0>(&v6);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T0>(arg0, v6);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T1>(arg0, v5);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::emit_swap_event<T0, T1>(arg0, b"FERRACLMM", 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), v1 - v7, 0x2::balance::value<T1>(&v5), v7);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg4);
        let v5 = v3;
        let v6 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v0, v4);
        let v7 = 0x2::balance::value<T1>(&v5);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T1>(arg0, v5);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T0>(arg0, v6);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::emit_swap_event<T1, T0>(arg0, b"FERRACLMM", 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), v1 - v7, 0x2::balance::value<T0>(&v6), v7);
    }

    // decompiled from Move bytecode v6
}

