module 0xe611e03b9e900480c61fd07653f8920d7e00cd0d564946dd5fa72bf2e108fb17::roles {
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

