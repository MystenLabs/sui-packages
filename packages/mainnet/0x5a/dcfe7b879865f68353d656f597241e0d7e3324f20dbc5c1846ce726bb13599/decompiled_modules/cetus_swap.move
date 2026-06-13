module 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::cetus_swap {
    public fun buffered_swap_a_to_b<T0, T1>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::add<T0>(arg0, arg1);
        if (v0 == 0 || v0 < arg2) {
            return 0x2::balance::zero<T1>()
        };
        let v1 = 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::take<T0>(arg0);
        let v2 = &mut v1;
        0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::add<T0>(arg0, v1);
        swap_a_to_b<T0, T1>(arg3, arg4, v2, arg5)
    }

    public fun buffered_swap_b_to_a<T0, T1>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::add<T1>(arg0, arg1);
        if (v0 == 0 || v0 < arg2) {
            return 0x2::balance::zero<T0>()
        };
        let v1 = 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::take<T1>(arg0);
        let v2 = &mut v1;
        0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::add<T1>(arg0, v1);
        swap_b_to_a<T0, T1>(arg3, arg4, v2, arg5)
    }

    public fun swap_a_to_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        0x2::balance::join<T0>(arg2, v0);
        v1
    }

    public fun swap_b_to_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        0x2::balance::join<T1>(arg2, v1);
        v0
    }

    // decompiled from Move bytecode v7
}

