module 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

