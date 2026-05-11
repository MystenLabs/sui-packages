module 0xe36d3aba995816e6696137a341ba2e09ce0cb2058de02aa7a4285ab9bb44cfd5::acl {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn_operator(arg0: &AdminCap, arg1: OperatorCap) {
        let OperatorCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint_operator(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<OperatorCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

