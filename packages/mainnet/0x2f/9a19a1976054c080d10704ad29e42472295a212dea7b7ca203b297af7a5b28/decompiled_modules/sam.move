module 0x2f9a19a1976054c080d10704ad29e42472295a212dea7b7ca203b297af7a5b28::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2f9a19a1976054c080d10704ad29e42472295a212dea7b7ca203b297af7a5b28::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

