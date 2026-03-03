module 0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::AdminCap, arg1: &mut 0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::LeverageApp, arg2: 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::PackageCallerCap) {
        0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::ensure_version_matches(arg1);
        0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::AdminCap, arg1: &mut 0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::LeverageApp) : u64 {
        0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::AdminCap, arg1: &mut 0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::LeverageApp, arg2: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::ensure_version_matches(arg1);
        0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::Market<T0>>(arg2);
        0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::add_market_id(arg1, v0);
        0x2::transfer::public_share_object<0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_market::LeverageMarket>(0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::AdminCap, arg1: &mut 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ProtocolApp, arg2: &mut 0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::LeverageApp) {
        0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::ensure_version_matches(arg2);
        0x91214ba05fb203bcdadedb94878513a6bbeda0a8213a50727f20bc6977eeaed4::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

