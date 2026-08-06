module 0x2ada3568422fee7c47dc264e17ae5c770bff2cc78deb24fc1afefb57eb4b3282::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2ada3568422fee7c47dc264e17ae5c770bff2cc78deb24fc1afefb57eb4b3282::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

