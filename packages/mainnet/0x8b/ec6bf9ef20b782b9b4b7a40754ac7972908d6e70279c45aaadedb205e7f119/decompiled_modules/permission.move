module 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    struct TransferAdminEvent has copy, drop {
        from: address,
        to: address,
    }

    struct CreateOperatorEvent has copy, drop {
        operator_cap_id: 0x2::object::ID,
        to: address,
    }

    struct TransferOperatorEvent has copy, drop {
        from: address,
        to: address,
    }

    struct RevokeOperatorEvent has copy, drop {
        operator_cap_id: 0x2::object::ID,
    }

    public(friend) fun create_admin(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, arg0);
    }

    public fun create_operator(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        let v1 = CreateOperatorEvent{
            operator_cap_id : 0x2::object::id<OperatorCap>(&v0),
            to              : arg1,
        };
        0x2::event::emit<CreateOperatorEvent>(v1);
        0x2::transfer::transfer<OperatorCap>(v0, arg1);
    }

    public fun destroy_operator(arg0: OperatorCap) {
        let OperatorCap { id: v0 } = arg0;
        let v1 = RevokeOperatorEvent{operator_cap_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<RevokeOperatorEvent>(v1);
        0x2::object::delete(v0);
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = TransferAdminEvent{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<TransferAdminEvent>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun transfer_operator(arg0: OperatorCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = TransferOperatorEvent{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<TransferOperatorEvent>(v0);
        0x2::transfer::transfer<OperatorCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

