module 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::config {
    struct RootCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RootCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RootCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun transfer_admin(arg0: &RootCap, arg1: AdminCap, arg2: address) {
        0x2::transfer::transfer<AdminCap>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

