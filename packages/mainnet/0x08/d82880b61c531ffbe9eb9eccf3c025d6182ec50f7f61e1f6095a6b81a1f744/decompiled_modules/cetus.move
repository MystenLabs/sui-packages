module 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::cetus {
    public(friend) fun a_to_b<T0, T1>(arg0: &mut 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::Control, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        let v1 = 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::policies::borrow_mut<0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::SwapPolicy<T0, T1>>(0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::policies_mut(arg0));
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg5);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3, v7), 0x2::balance::zero<T1>(), v5);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::finish<T0, T1>(v1, 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::begin<T0, T1>(v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), v0, arg5), 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::controller(arg0), v7, 0x2::balance::value<T1>(&v6), arg4);
        (arg3, v6)
    }

    public(friend) fun b_to_a<T0, T1>(arg0: &mut 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::Control, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg3);
        let v1 = 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::policies::borrow_mut<0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::SwapPolicy<T1, T0>>(0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::policies_mut(arg0));
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg5);
        let v5 = v4;
        let v6 = v2;
        0x2::balance::destroy_zero<T1>(v3);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v7), v5);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::finish<T1, T0>(v1, 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::begin<T1, T0>(v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), v0, arg5), 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::controller(arg0), v7, 0x2::balance::value<T0>(&v6), arg4);
        (v6, arg3)
    }

    // decompiled from Move bytecode v7
}

