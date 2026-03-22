module 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::AdminCap, arg1: &mut 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::LeverageApp, arg2: 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::PackageCallerCap) {
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::ensure_version_matches(arg1);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::AdminCap, arg1: &mut 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::LeverageApp) : u64 {
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::AdminCap, arg1: &mut 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::LeverageApp, arg2: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::ensure_version_matches(arg1);
        0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::Market<T0>>(arg2);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::add_market(arg1, v0, arg3);
        0x2::transfer::public_share_object<0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_market::LeverageMarket>(0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::AdminCap, arg1: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg2: &mut 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::LeverageApp) {
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::ensure_version_matches(arg2);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

