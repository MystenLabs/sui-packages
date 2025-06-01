module 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault_assistant {
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

