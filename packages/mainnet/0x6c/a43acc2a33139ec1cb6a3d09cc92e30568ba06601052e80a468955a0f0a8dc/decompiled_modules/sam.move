module 0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

