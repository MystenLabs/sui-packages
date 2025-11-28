module 0xd01343c58e5598d8f3dcbe5c94a2e9251cf8854b6d03662558d45ab4cde961b9::cache {
    public fun account_for_extension_liquidity_of_type<T0, T1, T2>(arg0: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::Vault<T0>, arg1: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::cache::UpdateLiquidityCacheCap<T0>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: &mut 0xd01343c58e5598d8f3dcbe5c94a2e9251cf8854b6d03662558d45ab4cde961b9::protected::ProtectedLendingMarket<T1>) {
        let v0 = 0xd01343c58e5598d8f3dcbe5c94a2e9251cf8854b6d03662558d45ab4cde961b9::state::create_extension_key();
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::cache::account_for_extension_liquidity_of_type<T0, T2, 0xd01343c58e5598d8f3dcbe5c94a2e9251cf8854b6d03662558d45ab4cde961b9::state::ExtensionKey>(arg1, arg2, &v0, 0xd01343c58e5598d8f3dcbe5c94a2e9251cf8854b6d03662558d45ab4cde961b9::state::total_active_liquidity<T1, T2>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_extension<T0, 0xd01343c58e5598d8f3dcbe5c94a2e9251cf8854b6d03662558d45ab4cde961b9::state::ExtensionKey, 0xd01343c58e5598d8f3dcbe5c94a2e9251cf8854b6d03662558d45ab4cde961b9::state::ExtensionStateV1<T1>>(arg0, v0), 0xd01343c58e5598d8f3dcbe5c94a2e9251cf8854b6d03662558d45ab4cde961b9::protected::borrow_mut<T1>(arg3)));
    }

    // decompiled from Move bytecode v6
}

