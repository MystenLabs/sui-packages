module 0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

