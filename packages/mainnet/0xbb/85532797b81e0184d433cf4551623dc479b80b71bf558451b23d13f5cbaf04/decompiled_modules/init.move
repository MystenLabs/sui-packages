module 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

