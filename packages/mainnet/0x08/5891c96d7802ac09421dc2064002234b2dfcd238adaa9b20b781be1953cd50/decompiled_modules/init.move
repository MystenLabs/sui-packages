module 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

