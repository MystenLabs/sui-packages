module 0x5a021d71df8c10dde5ce82bf1f3d1792d9ec9c46db0fafb5621ab982b780aaa1::permission {
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

