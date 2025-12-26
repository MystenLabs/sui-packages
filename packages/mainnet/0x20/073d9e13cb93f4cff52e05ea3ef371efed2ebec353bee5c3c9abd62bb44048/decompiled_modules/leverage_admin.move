module 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::AdminCap, arg1: &mut 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_app::LeverageApp, arg2: 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::PackageCallerCap) {
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::AdminCap, arg1: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_market::LeverageMarket>(0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_market::new_market(0x2::object::id<0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::AdminCap, arg1: &mut 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::ProtocolApp, arg2: &mut 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_app::LeverageApp) {
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

