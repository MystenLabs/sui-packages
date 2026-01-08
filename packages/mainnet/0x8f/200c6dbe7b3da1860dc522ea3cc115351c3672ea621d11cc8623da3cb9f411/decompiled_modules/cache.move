module 0x37fe800bad222b151fb080afc701ccf2b3a139106f6908857ad0a27e6e52c319::cache {
    public fun account_for_extension_liquidity_of_type<T0, T1>(arg0: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::Vault<T0>, arg1: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::cache::UpdateLiquidityCacheCap<T0>, arg2: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg3: &mut 0x37fe800bad222b151fb080afc701ccf2b3a139106f6908857ad0a27e6e52c319::protected::ProtectedStorage) {
        let v0 = 0x37fe800bad222b151fb080afc701ccf2b3a139106f6908857ad0a27e6e52c319::state::create_extension_key();
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::cache::account_for_extension_liquidity_of_type<T0, T1, 0x37fe800bad222b151fb080afc701ccf2b3a139106f6908857ad0a27e6e52c319::state::ExtensionKey>(arg1, arg2, &v0, 0x37fe800bad222b151fb080afc701ccf2b3a139106f6908857ad0a27e6e52c319::state::total_active_liquidity<T1>(0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::borrow_extension<T0, 0x37fe800bad222b151fb080afc701ccf2b3a139106f6908857ad0a27e6e52c319::state::ExtensionKey, 0x37fe800bad222b151fb080afc701ccf2b3a139106f6908857ad0a27e6e52c319::state::ExtensionStateV1>(arg0, v0), 0x37fe800bad222b151fb080afc701ccf2b3a139106f6908857ad0a27e6e52c319::protected::borrow_mut(arg3)));
    }

    // decompiled from Move bytecode v6
}

