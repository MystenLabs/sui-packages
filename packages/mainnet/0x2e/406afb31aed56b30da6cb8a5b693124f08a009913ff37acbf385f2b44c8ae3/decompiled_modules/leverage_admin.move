module 0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::AdminCap, arg1: &mut 0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_app::LeverageApp, arg2: 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap) {
        0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::AdminCap, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_market::LeverageMarket>(0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_market::new_market(0x2::object::id<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::AdminCap, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: &mut 0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_app::LeverageApp) {
        0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

