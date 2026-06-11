module 0x3b7cab543b70f675ab860199f6c32633860fb5d7346a342b14f257804f2fd37d::yt_vault {
    struct YT_VAULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let YT_VAULT {  } = arg0;
    }

    // decompiled from Move bytecode v7
}

