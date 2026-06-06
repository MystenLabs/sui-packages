module 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::acl::new<SAM>(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SAM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

