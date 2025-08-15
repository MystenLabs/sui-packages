module 0x2efd59646d33fdd9f8d2c1e588340f570ac9cfbce4b1fe960300bad01b8a77dd::package {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PACKAGE>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

