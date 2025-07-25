module 0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::cetus {
    public fun swap_a2b<T0, T1, T2, T3>(arg0: &mut 0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::checkpoint::Payload<T2, T3>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::checkpoint::take_next<T2, T3, T0>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg4, true, true, 0x2::balance::value<T0>(&v0), arg3, arg5);
        0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::checkpoint::place_next<T2, T3, T1>(arg0, v2);
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg1, arg2, arg4, v0, 0x2::balance::zero<T1>(), v3);
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: &mut 0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::checkpoint::Payload<T2, T3>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::checkpoint::take_next<T2, T3, T1>(arg0);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg4, false, true, 0x2::balance::value<T1>(&v0), arg3, arg5);
        0x4879b8619a072936e4dffa225a9980324cb637a1ad9249104d88b0fe2ce7ef8b::checkpoint::place_next<T2, T3, T0>(arg0, v1);
        0x2::balance::destroy_zero<T1>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg1, arg2, arg4, 0x2::balance::zero<T0>(), v0, v3);
    }

    // decompiled from Move bytecode v6
}

