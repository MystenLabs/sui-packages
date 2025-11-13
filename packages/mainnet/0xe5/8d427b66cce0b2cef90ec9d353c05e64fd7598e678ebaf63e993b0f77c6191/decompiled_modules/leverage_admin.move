module 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::app::AdminCap, arg1: &mut 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_app::LeverageApp, arg2: 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::app::PackageCallerCap) {
        0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::app::AdminCap, arg1: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_market::LeverageMarket>(0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_market::new_market(0x2::object::id<0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::app::AdminCap, arg1: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::app::ProtocolApp, arg2: &mut 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_app::LeverageApp) {
        0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

