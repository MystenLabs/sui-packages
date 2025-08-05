module 0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x3d59d152ab8f45dd63af35619f23039df756c7614cc72cf49a36d9f24352dabb::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

