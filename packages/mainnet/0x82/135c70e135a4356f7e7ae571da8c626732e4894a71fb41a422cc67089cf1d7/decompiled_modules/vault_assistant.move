module 0xbb1d1a2e9635ed8a1733f591eede33ad525983186ac2c0dd1eb3a1bf336adc23::vault_assistant {
    struct VaultAssistantCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public(friend) fun create_vault_assistant_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : VaultAssistantCap {
        VaultAssistantCap{
            id  : 0x2::object::new(arg1),
            for : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

