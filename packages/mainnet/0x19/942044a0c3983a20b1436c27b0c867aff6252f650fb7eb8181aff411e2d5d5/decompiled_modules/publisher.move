module 0x19942044a0c3983a20b1436c27b0c867aff6252f650fb7eb8181aff411e2d5d5::publisher {
    struct PUBLISHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBLISHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PUBLISHER>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

