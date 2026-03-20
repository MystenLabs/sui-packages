module 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::AdminCap, arg1: &mut 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::LeverageApp, arg2: 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::PackageCallerCap) {
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::ensure_version_matches(arg1);
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::AdminCap, arg1: &mut 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::LeverageApp) : u64 {
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::AdminCap, arg1: &mut 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::LeverageApp, arg2: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::ensure_version_matches(arg1);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>>(arg2);
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::add_market(arg1, v0, arg3);
        0x2::transfer::public_share_object<0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_market::LeverageMarket>(0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::AdminCap, arg1: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: &mut 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::LeverageApp) {
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::ensure_version_matches(arg2);
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

