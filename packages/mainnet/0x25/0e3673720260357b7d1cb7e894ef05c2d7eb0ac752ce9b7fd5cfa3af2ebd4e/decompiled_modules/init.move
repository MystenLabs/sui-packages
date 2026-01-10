module 0x9ee17446d0a8ee73581c7b4a3cdf38787b9f198708c2f787b87c8d40e7923e90::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    public fun whitelist_extension<T0>(arg0: &mut 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::Config, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::AuthorityCap<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority::PACKAGE, T0>) {
        let v0 = 0x9ee17446d0a8ee73581c7b4a3cdf38787b9f198708c2f787b87c8d40e7923e90::state::create_extension_key();
        0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::config::whitelist_extension<T0, 0x9ee17446d0a8ee73581c7b4a3cdf38787b9f198708c2f787b87c8d40e7923e90::state::ExtensionKey>(arg0, arg1, &v0);
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

