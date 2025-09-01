module 0xe9cf4c2502513eca676b560c9f822b2c11ee6a757df6cbb283cbc0e1a7d6f04f::haedal_adapter_event {
    struct NewHaedalVaultEvent has copy, drop {
        id: 0x2::object::ID,
        of: 0x2::object::ID,
    }

    struct StakeSuiEvent has copy, drop {
        vault_id: 0x2::object::ID,
        input_amount: u64,
        output_amount: u64,
    }

    public fun new_haedal_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewHaedalVaultEvent{
            id : arg0,
            of : arg1,
        };
        0x2::event::emit<NewHaedalVaultEvent>(v0);
    }

    public fun stake_sui_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = StakeSuiEvent{
            vault_id      : arg0,
            input_amount  : arg1,
            output_amount : arg2,
        };
        0x2::event::emit<StakeSuiEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

