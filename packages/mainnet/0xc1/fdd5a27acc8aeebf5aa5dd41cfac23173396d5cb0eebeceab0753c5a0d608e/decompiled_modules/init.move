module 0xc1fdd5a27acc8aeebf5aa5dd41cfac23173396d5cb0eebeceab0753c5a0d608e::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

