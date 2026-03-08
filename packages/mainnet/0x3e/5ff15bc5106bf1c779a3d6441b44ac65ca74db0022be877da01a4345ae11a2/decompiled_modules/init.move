module 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    public fun whitelist_extension<T0>(arg0: &0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::config::Config, arg1: &mut 0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::Config, arg2: &0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::AuthorityCap<0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::authority::PACKAGE, T0>) {
        0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::config::assert_package_version(arg0);
        let v0 = 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::state::create_extension_key();
        0x1d1b069a09caeb310d8d0e402517aa7b3a2a45455311dd5c3dd1743b7cb3aac3::config::whitelist_extension<T0, 0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::state::ExtensionKey>(arg1, arg2, &v0);
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x3b0af32a71fe4f58648c25cccb769f9e4beff5846a54de931c87005561984f9e::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

