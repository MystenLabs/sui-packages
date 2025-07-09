module 0xfc6927a4e49e317bda45e7d34e354facd277094fbfe74de2f887fc521351de2a::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xfc6927a4e49e317bda45e7d34e354facd277094fbfe74de2f887fc521351de2a::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0xfc6927a4e49e317bda45e7d34e354facd277094fbfe74de2f887fc521351de2a::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

