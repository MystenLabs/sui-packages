module 0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::ob_allowlist {
    struct OB_ALLOWLIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: OB_ALLOWLIST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<OB_ALLOWLIST>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

