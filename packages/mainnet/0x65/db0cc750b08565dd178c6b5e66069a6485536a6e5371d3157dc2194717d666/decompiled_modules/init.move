module 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

