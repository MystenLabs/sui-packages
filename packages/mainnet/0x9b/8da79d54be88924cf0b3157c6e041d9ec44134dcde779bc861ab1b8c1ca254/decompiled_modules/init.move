module 0x9b8da79d54be88924cf0b3157c6e041d9ec44134dcde779bc861ab1b8c1ca254::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x9b8da79d54be88924cf0b3157c6e041d9ec44134dcde779bc861ab1b8c1ca254::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x9b8da79d54be88924cf0b3157c6e041d9ec44134dcde779bc861ab1b8c1ca254::config::create_config_and_share<INIT>(&arg0, arg1);
        0x9b8da79d54be88924cf0b3157c6e041d9ec44134dcde779bc861ab1b8c1ca254::vault::create_vault_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

