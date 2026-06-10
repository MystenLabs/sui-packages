module 0x867013d7a041da60ce997cfe1b25e439d06d0e3e0475176519c848206af393eb::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0x867013d7a041da60ce997cfe1b25e439d06d0e3e0475176519c848206af393eb::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

