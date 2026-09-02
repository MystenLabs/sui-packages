module 0x85991025156c1164864e8eeaf76668712ff04865b26708e74d9cca6fb65655bf::pub_claim {
    struct PUB_CLAIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUB_CLAIM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PUB_CLAIM>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

