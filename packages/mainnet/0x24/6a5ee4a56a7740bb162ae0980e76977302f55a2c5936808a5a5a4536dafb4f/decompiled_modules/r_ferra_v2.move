module 0xa51ff840e804ac1ecfcbed8259d49c8a6ccbf1a1809686b5772c0de8fb47157e::r_ferra_v2 {
    public fun a2b<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg2: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::Pool<T0, T1>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        a2b_at<T0, T1>(arg0, arg1, arg2, arg3, 4295048016, arg4, arg5);
    }

    public fun a2b_at<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg2: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::Pool<T0, T1>, arg3: u8, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::assert_decided(arg0);
        if (!0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::armed(arg0)) {
            return
        };
        let v0 = 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::take<T0>(arg0, arg3);
        let (v1, v2, v3) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::balance::value<T0>(&v0), arg4, arg5, arg6);
        0x2::balance::destroy_zero<T0>(v1);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::repay_flash_swap<T0, T1>(arg1, arg2, v0, 0x2::balance::zero<T1>(), v3);
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::put<T1>(arg0, arg3 + 1, v2);
    }

    public fun b2a<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg2: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::Pool<T0, T1>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        b2a_at<T0, T1>(arg0, arg1, arg2, arg3, 79226673515401279992447579055, arg4, arg5);
    }

    public fun b2a_at<T0, T1>(arg0: &mut 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::Session, arg1: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg2: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::Pool<T0, T1>, arg3: u8, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::assert_decided(arg0);
        if (!0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::armed(arg0)) {
            return
        };
        let v0 = 0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::take<T1>(arg0, arg3);
        let (v1, v2, v3) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::balance::value<T1>(&v0), arg4, arg5, arg6);
        0x2::balance::destroy_zero<T1>(v2);
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v0, v3);
        0xe50618c7a0091de50f4d1b6c156c020a2578eb861c4be326c8734141216e3267::session::put<T0>(arg0, arg3 + 1, v1);
    }

    // decompiled from Move bytecode v7
}

