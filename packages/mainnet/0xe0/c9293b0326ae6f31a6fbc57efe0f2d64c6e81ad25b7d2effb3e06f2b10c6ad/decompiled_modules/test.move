module 0xe0c9293b0326ae6f31a6fbc57efe0f2d64c6e81ad25b7d2effb3e06f2b10c6ad::test {
    public entry fun cetus_mmt<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg5), 4295128739, arg4);
        let v3 = 0x2::coin::into_balance<T0>(arg5);
        0x2::balance::join<T0>(&mut v3, v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v3, 0x2::balance::zero<T1>(), v2);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg6);
        let (v5, v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T0>(arg2, true, true, 0x2::coin::value<T1>(&v4), 4295128739, arg4, arg3, arg6);
        let v8 = 0x2::coin::into_balance<T1>(v4);
        0x2::balance::join<T1>(&mut v8, v5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T0>(arg2, v7, v8, 0x2::balance::zero<T0>(), arg3, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg6), 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

