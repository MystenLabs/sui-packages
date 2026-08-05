module 0x789385dc89af88e100dd957c9cbe7bdd4fa6b172dbbe657d5e5f5a0cd1cfa53a::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

