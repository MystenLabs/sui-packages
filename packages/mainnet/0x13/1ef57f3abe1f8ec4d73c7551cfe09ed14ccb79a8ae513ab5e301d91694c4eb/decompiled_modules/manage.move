module 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::manage {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Setting) {
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::migrate(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_operator_cap_to_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

