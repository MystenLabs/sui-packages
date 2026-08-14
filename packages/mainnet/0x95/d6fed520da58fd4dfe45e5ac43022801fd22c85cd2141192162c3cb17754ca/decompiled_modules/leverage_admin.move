module 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::AdminCap, arg1: &mut 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::LeverageApp, arg2: 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::PackageCallerCap) {
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::ensure_version_matches(arg1);
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::AdminCap, arg1: &mut 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::LeverageApp) : u64 {
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::AdminCap, arg1: &mut 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::LeverageApp, arg2: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::ensure_version_matches(arg1);
        0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>>(arg2);
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::add_market(arg1, v0, arg3);
        0x2::transfer::public_share_object<0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_market::LeverageMarket>(0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::AdminCap, arg1: &mut 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp, arg2: &mut 0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::LeverageApp) {
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::ensure_version_matches(arg2);
        0x95d6fed520da58fd4dfe45e5ac43022801fd22c85cd2141192162c3cb17754ca::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

