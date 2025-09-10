module 0x6369d3885d75db139e56d71ae9a1e9232af52ceaedb71e285972f5bae2a30e9e::typus_adapter_event {
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

