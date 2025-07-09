module 0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x8bde613791aa997621554dc6284144d4cde5c8b03227fed58f9353e0915aacf3::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

