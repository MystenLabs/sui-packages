module 0xedea81113da2ec2ca02175b8485f4eb6cb7e288d8fc27ff733acf00973d14879::uc_collection {
    struct UC_COLLECTION has drop {
        dummy_field: bool,
    }

    struct UC has drop, store {
        dummy_field: bool,
    }

    fun init(arg0: UC_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<UC_COLLECTION>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

