module 0x9ee17446d0a8ee73581c7b4a3cdf38787b9f198708c2f787b87c8d40e7923e90::cache {
    public fun account_for_extension_liquidity_of_type<T0, T1>(arg0: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::Vault<T0>, arg1: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::cache::UpdateLiquidityCacheCap<T0>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: &mut 0x9ee17446d0a8ee73581c7b4a3cdf38787b9f198708c2f787b87c8d40e7923e90::protected::ProtectedMarket, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock) {
        let v0 = 0x9ee17446d0a8ee73581c7b4a3cdf38787b9f198708c2f787b87c8d40e7923e90::state::create_extension_key();
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::cache::account_for_extension_liquidity_of_type<T0, T1, 0x9ee17446d0a8ee73581c7b4a3cdf38787b9f198708c2f787b87c8d40e7923e90::state::ExtensionKey>(arg1, arg2, &v0, 0x9ee17446d0a8ee73581c7b4a3cdf38787b9f198708c2f787b87c8d40e7923e90::state::total_active_liquidity<T1>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_extension<T0, 0x9ee17446d0a8ee73581c7b4a3cdf38787b9f198708c2f787b87c8d40e7923e90::state::ExtensionKey, 0x9ee17446d0a8ee73581c7b4a3cdf38787b9f198708c2f787b87c8d40e7923e90::state::ExtensionStateV1>(arg0, v0), 0x9ee17446d0a8ee73581c7b4a3cdf38787b9f198708c2f787b87c8d40e7923e90::protected::borrow_mut(arg3), arg4, arg5));
    }

    // decompiled from Move bytecode v6
}

