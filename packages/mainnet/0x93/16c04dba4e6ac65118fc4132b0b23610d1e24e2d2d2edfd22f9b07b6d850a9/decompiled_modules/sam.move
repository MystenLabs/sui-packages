module 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

