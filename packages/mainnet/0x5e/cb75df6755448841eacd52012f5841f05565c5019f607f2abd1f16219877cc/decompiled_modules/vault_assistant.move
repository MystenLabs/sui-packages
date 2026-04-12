module 0x5ecb75df6755448841eacd52012f5841f05565c5019f607f2abd1f16219877cc::vault_assistant {
    struct VaultAssistantCap has key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public(friend) fun create_and_transfer_vault_assistant_cap(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = VaultAssistantCap{
            id  : 0x2::object::new(arg2),
            for : arg0,
        };
        0x2::transfer::transfer<VaultAssistantCap>(v0, arg1);
        0x2::object::id<VaultAssistantCap>(&v0)
    }

    // decompiled from Move bytecode v7
}

