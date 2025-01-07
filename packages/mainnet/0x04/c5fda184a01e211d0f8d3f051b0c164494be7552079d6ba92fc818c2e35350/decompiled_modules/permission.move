module 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::permission {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun new_admin(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

