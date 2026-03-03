module 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::AdminCap, arg1: &mut 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::LeverageApp, arg2: 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::PackageCallerCap) {
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::ensure_version_matches(arg1);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::AdminCap, arg1: &mut 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::LeverageApp) : u64 {
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::AdminCap, arg1: &mut 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::LeverageApp, arg2: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::ensure_version_matches(arg1);
        0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::market::Market<T0>>(arg2);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::add_market_id(arg1, v0);
        0x2::transfer::public_share_object<0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_market::LeverageMarket>(0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::AdminCap, arg1: &mut 0x936023cfa3fe5b9ae6dd8b4acead70e3c1e0b9f2693e7b073980f34bdc74644b::app::ProtocolApp, arg2: &mut 0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::LeverageApp) {
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::ensure_version_matches(arg2);
        0xae62107ac6d3865863a5b6949dcf1c52ba12ba99e7086a16dcf1ab659144bc69::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

