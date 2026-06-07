module 0xcf5c0a46b9fbee0a0f46ae41b9c8305cb2075f105436aba49cce3ff6551f573b::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0xcf5c0a46b9fbee0a0f46ae41b9c8305cb2075f105436aba49cce3ff6551f573b::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

