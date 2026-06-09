module 0x1617106ec413cc226e0c2f8af70b46a881648d1c0e4ef095c36dc530ab731671::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0x1617106ec413cc226e0c2f8af70b46a881648d1c0e4ef095c36dc530ab731671::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

