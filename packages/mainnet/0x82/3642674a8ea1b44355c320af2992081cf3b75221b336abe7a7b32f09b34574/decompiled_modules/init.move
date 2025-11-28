module 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

