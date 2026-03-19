module 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::AdminCap, arg1: &mut 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::LeverageApp, arg2: 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::PackageCallerCap) {
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::ensure_version_matches(arg1);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::AdminCap, arg1: &mut 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::LeverageApp) : u64 {
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::AdminCap, arg1: &mut 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::LeverageApp, arg2: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::ensure_version_matches(arg1);
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>>(arg2);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::add_market(arg1, v0, arg3);
        0x2::transfer::public_share_object<0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_market::LeverageMarket>(0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::AdminCap, arg1: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg2: &mut 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::LeverageApp) {
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::ensure_version_matches(arg2);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

