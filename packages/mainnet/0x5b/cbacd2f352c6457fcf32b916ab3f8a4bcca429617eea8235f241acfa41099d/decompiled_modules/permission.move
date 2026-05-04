module 0x5bcbacd2f352c6457fcf32b916ab3f8a4bcca429617eea8235f241acfa41099d::permission {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCapTransferredEvent has copy, drop {
        from: address,
        to: address,
    }

    struct OperatorCapCreatedEvent has copy, drop {
        to: address,
        created_by: address,
    }

    struct OperatorCapTransferredEvent has copy, drop {
        from: address,
        to: address,
    }

    public(friend) fun create_operator(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCapCreatedEvent{
            to         : arg1,
            created_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<OperatorCapCreatedEvent>(v0);
        let v1 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OperatorCap>(v1, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = AdminCapTransferredEvent{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<AdminCapTransferredEvent>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public(friend) fun transfer_operator(arg0: OperatorCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = OperatorCapTransferredEvent{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<OperatorCapTransferredEvent>(v0);
        0x2::transfer::transfer<OperatorCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

