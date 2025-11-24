module 0xdf591c45c0b5c746e4d916451849dd7cbcebc76aa4206a892b1acd628d2560f6::roles {
    struct SuperAdminRole has key {
        id: 0x2::object::UID,
    }

    struct ROLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLES, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ROLES>(arg0, arg1);
        let v0 = SuperAdminRole{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SuperAdminRole>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

