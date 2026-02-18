module 0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    public fun whitelist_extension<T0>(arg0: &0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::config::Config, arg1: &mut 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::config::Config, arg2: &0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::AuthorityCap<0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::PACKAGE, T0>) {
        0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::config::assert_package_version(arg0);
        let v0 = 0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::state::create_extension_key();
        0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::config::whitelist_extension<T0, 0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::state::ExtensionKey>(arg1, arg2, &v0);
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

