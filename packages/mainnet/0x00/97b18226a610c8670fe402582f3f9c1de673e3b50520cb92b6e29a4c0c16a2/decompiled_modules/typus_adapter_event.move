module 0x97b18226a610c8670fe402582f3f9c1de673e3b50520cb92b6e29a4c0c16a2::typus_adapter_event {
    struct NewTypusVaultEvent has copy, drop {
        id: 0x2::object::ID,
        of: 0x2::object::ID,
    }

    public fun new_typus_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewTypusVaultEvent{
            id : arg0,
            of : arg1,
        };
        0x2::event::emit<NewTypusVaultEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

