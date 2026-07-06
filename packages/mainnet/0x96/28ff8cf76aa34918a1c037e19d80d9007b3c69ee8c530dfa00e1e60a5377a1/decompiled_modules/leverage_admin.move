module 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::AdminCap, arg1: &mut 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::LeverageApp, arg2: 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::PackageCallerCap) {
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::ensure_version_matches(arg1);
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::AdminCap, arg1: &mut 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::LeverageApp) : u64 {
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::AdminCap, arg1: &mut 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::LeverageApp, arg2: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::ensure_version_matches(arg1);
        0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::market::Market<T0>>(arg2);
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::add_market(arg1, v0, arg3);
        0x2::transfer::public_share_object<0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_market::LeverageMarket>(0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::AdminCap, arg1: &mut 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::app::ProtocolApp, arg2: &mut 0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::LeverageApp) {
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::ensure_version_matches(arg2);
        0x2cb82bab7575b7210ab9e18831dad514a13e3ce29900dcf1fc9b6aef66f2eda5::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v7
}

