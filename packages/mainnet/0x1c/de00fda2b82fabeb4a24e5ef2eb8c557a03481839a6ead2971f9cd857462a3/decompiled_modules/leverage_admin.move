module 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::AdminCap, arg1: &mut 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::LeverageApp, arg2: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap) {
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::ensure_version_matches(arg1);
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::AdminCap, arg1: &mut 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::LeverageApp) : u64 {
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::AdminCap, arg1: &mut 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::LeverageApp, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::ensure_version_matches(arg1);
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>>(arg2);
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::add_market(arg1, v0, arg3);
        0x2::transfer::public_share_object<0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_market::LeverageMarket>(0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::AdminCap, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::LeverageApp) {
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::ensure_version_matches(arg2);
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

