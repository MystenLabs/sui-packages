module 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::app::AdminCap, arg1: &mut 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_app::LeverageApp, arg2: 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::app::PackageCallerCap) {
        0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::app::AdminCap, arg1: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_market::LeverageMarket>(0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_market::new_market(0x2::object::id<0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::app::AdminCap, arg1: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::app::ProtocolApp, arg2: &mut 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_app::LeverageApp) {
        0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

