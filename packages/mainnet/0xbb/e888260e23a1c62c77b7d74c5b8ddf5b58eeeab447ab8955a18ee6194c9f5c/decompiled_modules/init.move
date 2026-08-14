module 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

