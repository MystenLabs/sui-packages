module 0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SU>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

