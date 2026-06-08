module 0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0x1c75369933aeeb5db04275bca36935a819deba86eb5522ed8b98029367c842a7::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

