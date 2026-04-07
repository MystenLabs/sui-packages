module 0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::admin_cap {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperationCap has store, key {
        id: 0x2::object::UID,
    }

    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
    }

    struct MintOperationCapEvent has copy, drop {
        cap_id: 0x2::object::ID,
        addr: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = InitEvent{admin_cap_id: 0x2::object::id<AdminCap>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_operation_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OperationCap{id: 0x2::object::new(arg2)};
        let v1 = MintOperationCapEvent{
            cap_id : 0x2::object::id<OperationCap>(&v0),
            addr   : arg1,
        };
        0x2::event::emit<MintOperationCapEvent>(v1);
        0x2::transfer::transfer<OperationCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

