module 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::AdminCap, arg1: &mut 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::LeverageApp, arg2: 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::PackageCallerCap) {
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::ensure_version_matches(arg1);
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::AdminCap, arg1: &mut 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::LeverageApp) : u64 {
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::AdminCap, arg1: &mut 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::LeverageApp, arg2: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::ensure_version_matches(arg1);
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::Market<T0>>(arg2);
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::add_market(arg1, v0, arg3);
        0x2::transfer::public_share_object<0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_market::LeverageMarket>(0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::AdminCap, arg1: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg2: &mut 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::LeverageApp) {
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::ensure_version_matches(arg2);
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

