module 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::AdminCap, arg1: &mut 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_app::LeverageApp, arg2: 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::PackageCallerCap) {
        0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::AdminCap, arg1: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_market::LeverageMarket>(0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_market::new_market(0x2::object::id<0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::AdminCap, arg1: &mut 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::ProtocolApp, arg2: &mut 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_app::LeverageApp) {
        0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

