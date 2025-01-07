module 0x56d0df93c16b99e0258b417b1e09e31e0439dfdb2aec3d9c046fbb02e64d6848::swap {
    public(friend) fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (arg4) {
            0x2::balance::value<T0>(&arg2)
        } else {
            0x2::balance::value<T1>(&arg3)
        };
        if (v0 == 0) {
            return (arg2, arg3)
        };
        let v1 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, true, v0, v1, arg5);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let (v8, v9) = if (arg4) {
            (0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)))
        };
        0x2::balance::join<T0>(&mut v7, arg2);
        0x2::balance::join<T1>(&mut v6, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v5);
        (v7, v6)
    }

    // decompiled from Move bytecode v6
}

