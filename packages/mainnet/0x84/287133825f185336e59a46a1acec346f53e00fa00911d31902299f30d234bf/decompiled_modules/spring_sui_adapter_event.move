module 0x84287133825f185336e59a46a1acec346f53e00fa00911d31902299f30d234bf::spring_sui_adapter_event {
    struct NewSpringSuiPassEvent has copy, drop {
        id: 0x2::object::ID,
        of: 0x2::object::ID,
    }

    struct StakeSuiEvent has copy, drop {
        vault_id: 0x2::object::ID,
        input_amount: u64,
        output_amount: u64,
    }

    public fun new_spring_sui_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewSpringSuiPassEvent{
            id : arg0,
            of : arg1,
        };
        0x2::event::emit<NewSpringSuiPassEvent>(v0);
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

