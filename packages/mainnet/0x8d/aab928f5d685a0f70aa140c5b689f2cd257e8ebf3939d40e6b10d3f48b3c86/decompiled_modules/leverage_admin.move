module 0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::AdminCap, arg1: &mut 0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_app::LeverageApp, arg2: 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::PackageCallerCap) {
        0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::AdminCap, arg1: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_market::LeverageMarket>(0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_market::new_market(0x2::object::id<0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::AdminCap, arg1: &mut 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::app::ProtocolApp, arg2: &mut 0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_app::LeverageApp) {
        0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

