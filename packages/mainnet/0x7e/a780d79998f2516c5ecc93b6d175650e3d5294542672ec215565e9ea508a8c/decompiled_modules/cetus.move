module 0x7ea780d79998f2516c5ecc93b6d175650e3d5294542672ec215565e9ea508a8c::cetus {
    public fun swap_a2b<T0, T1, T2, T3>(arg0: &mut 0x7ea780d79998f2516c5ecc93b6d175650e3d5294542672ec215565e9ea508a8c::checkpoint::Payload<T2, T3>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<T0>();
        0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(0x7ea780d79998f2516c5ecc93b6d175650e3d5294542672ec215565e9ea508a8c::checkpoint::take_next<T2, T3, T0>(arg0)));
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg5, arg3, true, 0x2::balance::value<T0>(&v0), arg4, arg6);
        0x7ea780d79998f2516c5ecc93b6d175650e3d5294542672ec215565e9ea508a8c::checkpoint::place_next<T2, T3, T1>(arg0, 0x2::coin::from_balance<T1>(v2, arg7));
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg1, arg2, arg5, v0, 0x2::balance::zero<T1>(), v3);
    }

    // decompiled from Move bytecode v6
}

