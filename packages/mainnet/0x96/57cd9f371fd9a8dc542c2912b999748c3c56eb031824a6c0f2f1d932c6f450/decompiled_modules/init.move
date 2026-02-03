module 0x9657cd9f371fd9a8dc542c2912b999748c3c56eb031824a6c0f2f1d932c6f450::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x9657cd9f371fd9a8dc542c2912b999748c3c56eb031824a6c0f2f1d932c6f450::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x9657cd9f371fd9a8dc542c2912b999748c3c56eb031824a6c0f2f1d932c6f450::config::create_config_and_share<INIT>(&arg0, arg1);
        0x9657cd9f371fd9a8dc542c2912b999748c3c56eb031824a6c0f2f1d932c6f450::vault::create_vault_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

