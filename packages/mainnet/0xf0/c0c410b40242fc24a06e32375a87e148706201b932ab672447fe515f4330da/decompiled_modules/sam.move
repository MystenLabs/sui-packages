module 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

