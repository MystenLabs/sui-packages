module 0x7e2c6376f496d88732890c2009b37e5103dc173159081a849b3002ccdc29ae::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x7e2c6376f496d88732890c2009b37e5103dc173159081a849b3002ccdc29ae::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x7e2c6376f496d88732890c2009b37e5103dc173159081a849b3002ccdc29ae::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

