module 0x44e7fb1aa970155cf18b5a9e828b6d0712d443c6fa0137b0beaa0ba7208d4a14::permission {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TransferAdminRoleEvent has copy, drop {
        new_admin: address,
        old_admin: address,
    }

    public(friend) fun new_admin(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, arg0);
    }

    public(friend) fun transfer_admin_role(arg0: AdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = TransferAdminRoleEvent{
            new_admin : arg1,
            old_admin : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TransferAdminRoleEvent>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

