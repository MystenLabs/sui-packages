module 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::permission {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TransferAdminRoleEvent has copy, drop {
        new_admin: address,
        old_admin: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
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

