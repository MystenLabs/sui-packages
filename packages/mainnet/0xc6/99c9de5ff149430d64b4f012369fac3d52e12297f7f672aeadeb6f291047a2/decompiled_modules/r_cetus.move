module 0x16a587662f5f2377a1ffca55185198459ea064f7fb38c45b55818934f955c1c5::r_cetus {
    public fun a2b<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        a2b_at<T0, T1>(arg0, arg1, arg2, arg3, 4295048017, arg4, arg5)
    }

    public fun a2b_at<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u8, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::assert_decided(arg0);
        if (!0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::armed(arg0)) {
            return 0x2::coin::zero<T0>(arg6)
        };
        let v0 = 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::take<T0>(arg0, arg3);
        let (v1, v2) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::zero<T1>(arg6), true, true, 0x2::balance::value<T0>(&v0), arg4, false, arg5, arg6);
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::put<T1>(arg0, arg3 + 1, 0x2::coin::into_balance<T1>(v2));
        v1
    }

    public fun b2a<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        b2a_at<T0, T1>(arg0, arg1, arg2, arg3, 79226673515401279992447579054, arg4, arg5)
    }

    public fun b2a_at<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u8, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::assert_decided(arg0);
        if (!0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::armed(arg0)) {
            return 0x2::coin::zero<T1>(arg6)
        };
        let v0 = 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::take<T1>(arg0, arg3);
        let (v1, v2) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T0, T1>(arg1, arg2, 0x2::coin::zero<T0>(arg6), 0x2::coin::from_balance<T1>(v0, arg6), false, true, 0x2::balance::value<T1>(&v0), arg4, false, arg5, arg6);
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::put<T0>(arg0, arg3 + 1, 0x2::coin::into_balance<T0>(v1));
        v2
    }

    // decompiled from Move bytecode v7
}

