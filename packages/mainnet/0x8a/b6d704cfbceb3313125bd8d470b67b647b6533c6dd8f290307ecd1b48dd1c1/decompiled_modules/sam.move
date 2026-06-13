module 0x8ab6d704cfbceb3313125bd8d470b67b647b6533c6dd8f290307ecd1b48dd1c1::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0x8ab6d704cfbceb3313125bd8d470b67b647b6533c6dd8f290307ecd1b48dd1c1::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

