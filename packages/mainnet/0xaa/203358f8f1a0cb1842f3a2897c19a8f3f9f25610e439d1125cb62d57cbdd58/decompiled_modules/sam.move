module 0x5ac0f948102c72f09f048d83d817feb26288edf035e71e3e59b74260f4df806d::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5ac0f948102c72f09f048d83d817feb26288edf035e71e3e59b74260f4df806d::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

