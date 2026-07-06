module 0x548b7470ddb057fe575b2ceb732741d7c6951b33ff67b11f785b88059d4f264f::roles {
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

    // decompiled from Move bytecode v7
}

