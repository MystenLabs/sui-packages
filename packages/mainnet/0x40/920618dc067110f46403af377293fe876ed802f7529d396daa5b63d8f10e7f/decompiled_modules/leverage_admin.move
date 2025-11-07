module 0x40920618dc067110f46403af377293fe876ed802f7529d396daa5b63d8f10e7f::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::app::AdminCap, arg1: &mut 0x40920618dc067110f46403af377293fe876ed802f7529d396daa5b63d8f10e7f::leverage_app::LeverageApp, arg2: 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::app::PackageCallerCap) {
        0x40920618dc067110f46403af377293fe876ed802f7529d396daa5b63d8f10e7f::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::app::AdminCap, arg1: &0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0x40920618dc067110f46403af377293fe876ed802f7529d396daa5b63d8f10e7f::leverage_market::LeverageMarket>(0x40920618dc067110f46403af377293fe876ed802f7529d396daa5b63d8f10e7f::leverage_market::new_market(0x2::object::id<0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::app::AdminCap, arg1: &mut 0xe0b2b759c88c478233520fe6c1eedca3b5cd318542a043955625ff45aed0d367::app::ProtocolApp, arg2: &mut 0x40920618dc067110f46403af377293fe876ed802f7529d396daa5b63d8f10e7f::leverage_app::LeverageApp) {
        0x40920618dc067110f46403af377293fe876ed802f7529d396daa5b63d8f10e7f::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

