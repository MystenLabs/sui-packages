module 0xbc7cc3adbef8aad82f92030fd90157fda53800984fa4563d2dedd68c675bedd1::collectible_authority {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct CollectibleOperatorCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun issue_operator_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectibleOperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<CollectibleOperatorCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

