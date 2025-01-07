module 0x4a02d6deaaef884ffd95d3e1c330a3b792382bbef6896a2b4b971501a515f8e1::uc_collection {
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

