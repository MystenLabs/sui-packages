module 0x37fe800bad222b151fb080afc701ccf2b3a139106f6908857ad0a27e6e52c319::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    public fun whitelist_extension<T0>(arg0: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::PACKAGE, T0>) {
        let v0 = 0x37fe800bad222b151fb080afc701ccf2b3a139106f6908857ad0a27e6e52c319::state::create_extension_key();
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::whitelist_extension<T0, 0x37fe800bad222b151fb080afc701ccf2b3a139106f6908857ad0a27e6e52c319::state::ExtensionKey>(arg0, arg1, &v0);
    }

    // decompiled from Move bytecode v6
}

