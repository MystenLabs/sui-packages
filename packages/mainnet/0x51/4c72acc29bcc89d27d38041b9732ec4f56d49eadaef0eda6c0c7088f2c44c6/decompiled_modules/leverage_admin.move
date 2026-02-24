module 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &mut 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::LeverageApp, arg2: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap) {
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::ensure_version_matches(arg1);
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &mut 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::LeverageApp) : u64 {
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &mut 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::LeverageApp, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::ensure_version_matches(arg1);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>>(arg2);
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::add_market_id(arg1, v0);
        0x2::transfer::public_share_object<0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_market::LeverageMarket>(0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::LeverageApp) {
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::ensure_version_matches(arg2);
        0x514c72acc29bcc89d27d38041b9732ec4f56d49eadaef0eda6c0c7088f2c44c6::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

