module 0xa248e4ac36f2907a18843c68809fae46139e3cf3a8898d2459809088b5a91150::permissions {
    struct PERMISSIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERMISSIONS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PERMISSIONS>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

