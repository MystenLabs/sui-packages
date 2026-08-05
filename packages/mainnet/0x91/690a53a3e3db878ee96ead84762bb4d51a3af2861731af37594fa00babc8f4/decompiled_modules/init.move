module 0x91690a53a3e3db878ee96ead84762bb4d51a3af2861731af37594fa00babc8f4::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x91690a53a3e3db878ee96ead84762bb4d51a3af2861731af37594fa00babc8f4::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

