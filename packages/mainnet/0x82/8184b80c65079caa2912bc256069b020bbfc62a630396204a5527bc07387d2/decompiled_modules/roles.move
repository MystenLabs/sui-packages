module 0xbd1384db1bbc2f9342476407fbb919a270acc26769c5e1a5fc80c3ba93b814e6::roles {
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

    public(friend) fun transfer_role(arg0: SuperAdminRole, arg1: address) {
        0x2::transfer::transfer<SuperAdminRole>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

