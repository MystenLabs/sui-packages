module 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::permission {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    struct TransferAdminRoleEvent has copy, drop {
        new_admin: address,
        old_admin: address,
    }

    struct CreateOperatorRoleEvent has copy, drop {
        operator: address,
        created_by: address,
    }

    struct TransferOperatorRoleEvent has copy, drop {
        new_operator: address,
        old_operator: address,
    }

    public(friend) fun create_operator_role(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CreateOperatorRoleEvent{
            operator   : arg1,
            created_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CreateOperatorRoleEvent>(v0);
        let v1 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v1, arg1);
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

    public(friend) fun transfer_operator_role(arg0: OperatorCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = TransferOperatorRoleEvent{
            new_operator : arg1,
            old_operator : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TransferOperatorRoleEvent>(v0);
        0x2::transfer::transfer<OperatorCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

