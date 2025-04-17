module 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

