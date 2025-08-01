module 0x475350ab8a07644d3ceb0cbf14d82659f861f72ac052468d2c34fe67cbda593e::genesis {
    struct GENESIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENESIS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<GENESIS>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

