module 0xd1094d62ab4eebc548772427e8d46a48b341dea039807a0eb06cf4fc4d778dda::yt_vault {
    struct YT_VAULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let YT_VAULT {  } = arg0;
    }

    // decompiled from Move bytecode v7
}

