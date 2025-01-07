module 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::ob_allowlist {
    struct OB_ALLOWLIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: OB_ALLOWLIST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<OB_ALLOWLIST>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

