module 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

