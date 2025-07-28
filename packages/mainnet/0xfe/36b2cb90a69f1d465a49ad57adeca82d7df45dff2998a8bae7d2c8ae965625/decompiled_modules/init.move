module 0xfe36b2cb90a69f1d465a49ad57adeca82d7df45dff2998a8bae7d2c8ae965625::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xfe36b2cb90a69f1d465a49ad57adeca82d7df45dff2998a8bae7d2c8ae965625::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0xfe36b2cb90a69f1d465a49ad57adeca82d7df45dff2998a8bae7d2c8ae965625::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

