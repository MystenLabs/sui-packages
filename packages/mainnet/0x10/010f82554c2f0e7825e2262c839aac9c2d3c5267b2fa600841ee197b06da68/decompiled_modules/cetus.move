module 0x10010f82554c2f0e7825e2262c839aac9c2d3c5267b2fa600841ee197b06da68::cetus {
    public fun quote<T0, T1>(arg0: &mut 0x10010f82554c2f0e7825e2262c839aac9c2d3c5267b2fa600841ee197b06da68::plan::Plan, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = 0;
        while (v0 < 0x10010f82554c2f0e7825e2262c839aac9c2d3c5267b2fa600841ee197b06da68::plan::quote_count(arg0)) {
            let v1 = 0x10010f82554c2f0e7825e2262c839aac9c2d3c5267b2fa600841ee197b06da68::plan::quote_at(arg0, v0);
            if (v1 > 0) {
                let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, v1);
                let v3 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v2)) {
                    0
                } else {
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2)
                };
                0x10010f82554c2f0e7825e2262c839aac9c2d3c5267b2fa600841ee197b06da68::plan::set_quote_at(arg0, v0, v3);
            };
            v0 = v0 + 1;
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &0x10010f82554c2f0e7825e2262c839aac9c2d3c5267b2fa600841ee197b06da68::plan::Plan, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        if (!0x10010f82554c2f0e7825e2262c839aac9c2d3c5267b2fa600841ee197b06da68::plan::executing(arg0)) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x2::balance::value<T0>(&arg3);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, 4295048016, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 101);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v4);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &0x10010f82554c2f0e7825e2262c839aac9c2d3c5267b2fa600841ee197b06da68::plan::Plan, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        if (!0x10010f82554c2f0e7825e2262c839aac9c2d3c5267b2fa600841ee197b06da68::plan::executing(arg0)) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x2::balance::value<T1>(&arg3);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, 79226673515401279992447579055, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 101);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v4);
        v1
    }

    // decompiled from Move bytecode v7
}

