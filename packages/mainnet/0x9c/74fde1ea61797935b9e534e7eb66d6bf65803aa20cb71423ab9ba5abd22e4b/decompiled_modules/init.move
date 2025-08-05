module 0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x9c74fde1ea61797935b9e534e7eb66d6bf65803aa20cb71423ab9ba5abd22e4b::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

