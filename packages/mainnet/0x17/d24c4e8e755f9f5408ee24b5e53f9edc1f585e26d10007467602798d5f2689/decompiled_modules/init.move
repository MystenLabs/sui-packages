module 0x17d24c4e8e755f9f5408ee24b5e53f9edc1f585e26d10007467602798d5f2689::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x17d24c4e8e755f9f5408ee24b5e53f9edc1f585e26d10007467602798d5f2689::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

