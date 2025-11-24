module 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::AdminCap, arg1: &mut 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_app::LeverageApp, arg2: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::PackageCallerCap) {
        0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::AdminCap, arg1: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_market::LeverageMarket>(0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_market::new_market(0x2::object::id<0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::AdminCap, arg1: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg2: &mut 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_app::LeverageApp) {
        0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

