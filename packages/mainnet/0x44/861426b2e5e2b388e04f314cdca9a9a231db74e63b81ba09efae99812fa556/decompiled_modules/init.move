module 0x44861426b2e5e2b388e04f314cdca9a9a231db74e63b81ba09efae99812fa556::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x44861426b2e5e2b388e04f314cdca9a9a231db74e63b81ba09efae99812fa556::pyth_lazer::create_pyth_lazer_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

