module 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::AdminCap, arg1: &mut 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::LeverageApp, arg2: 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::PackageCallerCap) {
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::ensure_version_matches(arg1);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::AdminCap, arg1: &mut 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::LeverageApp) : u64 {
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::AdminCap, arg1: &mut 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::LeverageApp, arg2: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::ensure_version_matches(arg1);
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>>(arg2);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::add_market_id(arg1, v0);
        0x2::transfer::public_share_object<0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_market::LeverageMarket>(0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::AdminCap, arg1: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: &mut 0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::LeverageApp) {
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::ensure_version_matches(arg2);
        0x81fefef907d775faab48dbfd64cb7d37596ea5565de1850937c8807c2ce33f40::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

