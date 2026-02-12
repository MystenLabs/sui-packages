module 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::AdminCap, arg1: &mut 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_app::LeverageApp, arg2: 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::PackageCallerCap) {
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::AdminCap, arg1: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_market::LeverageMarket>(0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_market::new_market(0x2::object::id<0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::AdminCap, arg1: &mut 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::app::ProtocolApp, arg2: &mut 0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_app::LeverageApp) {
        0xebeeea1adb7181e9e9d5762006aff9623f91576373529ae56efababf9b13bd3c::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

