module 0xb5e47ee2057d0e8ced113c659c055b33993bf80d4f49bcea6d1cf9df3248a83e::yt_vault {
    struct YT_VAULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let YT_VAULT {  } = arg0;
    }

    // decompiled from Move bytecode v7
}

