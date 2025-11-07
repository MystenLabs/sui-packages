module 0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::AdminCap, arg1: &mut 0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_app::LeverageApp, arg2: 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::PackageCallerCap) {
        0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::AdminCap, arg1: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_market::LeverageMarket>(0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_market::new_market(0x2::object::id<0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::AdminCap, arg1: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::app::ProtocolApp, arg2: &mut 0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_app::LeverageApp) {
        0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

