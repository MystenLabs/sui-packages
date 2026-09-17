module 0x16a587662f5f2377a1ffca55185198459ea064f7fb38c45b55818934f955c1c5::r_suidex_v3 {
    public fun a2b<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        a2b_at<T0, T1>(arg0, arg1, arg2, arg3, 4295048016, arg4, arg5);
    }

    public fun a2b_at<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: u8, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::assert_decided(arg0);
        if (!0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::armed(arg0)) {
            return
        };
        let v0 = 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::take<T0>(arg0, arg3);
        let (v1, v2, v3) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&v0), arg4, arg5, arg2, arg6);
        0x2::balance::destroy_zero<T0>(v1);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v3, v0, 0x2::balance::zero<T1>(), arg2, arg6);
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::put<T1>(arg0, arg3 + 1, v2);
    }

    public fun b2a<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        b2a_at<T0, T1>(arg0, arg1, arg2, arg3, 79226673515401279992447579055, arg4, arg5);
    }

    public fun b2a_at<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: u8, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::assert_decided(arg0);
        if (!0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::armed(arg0)) {
            return
        };
        let v0 = 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::take<T1>(arg0, arg3);
        let (v1, v2, v3) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&v0), arg4, arg5, arg2, arg6);
        0x2::balance::destroy_zero<T1>(v2);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), v0, arg2, arg6);
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::put<T0>(arg0, arg3 + 1, v1);
    }

    // decompiled from Move bytecode v7
}

