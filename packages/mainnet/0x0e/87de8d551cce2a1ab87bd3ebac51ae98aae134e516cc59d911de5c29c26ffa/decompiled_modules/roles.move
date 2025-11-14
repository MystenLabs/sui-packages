module 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::roles {
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

