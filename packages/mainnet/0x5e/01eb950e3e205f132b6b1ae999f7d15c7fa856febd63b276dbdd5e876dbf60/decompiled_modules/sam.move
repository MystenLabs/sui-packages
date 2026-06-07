module 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

