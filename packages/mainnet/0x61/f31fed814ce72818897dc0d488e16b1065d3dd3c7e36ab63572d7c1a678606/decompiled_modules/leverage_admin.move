module 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::AdminCap, arg1: &mut 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::LeverageApp, arg2: 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::PackageCallerCap) {
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::ensure_version_matches(arg1);
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::AdminCap, arg1: &mut 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::LeverageApp) : u64 {
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::AdminCap, arg1: &mut 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::LeverageApp, arg2: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::ensure_version_matches(arg1);
        0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::Market<T0>>(arg2);
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::add_market(arg1, v0, arg3);
        0x2::transfer::public_share_object<0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_market::LeverageMarket>(0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::AdminCap, arg1: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: &mut 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::LeverageApp) {
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::ensure_version_matches(arg2);
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

