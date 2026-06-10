module 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

