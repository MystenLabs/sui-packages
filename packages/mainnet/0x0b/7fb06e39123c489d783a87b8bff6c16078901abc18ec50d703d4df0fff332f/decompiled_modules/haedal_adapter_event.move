module 0xb7fb06e39123c489d783a87b8bff6c16078901abc18ec50d703d4df0fff332f::haedal_adapter_event {
    struct NewHaedalPassEvent has copy, drop {
        id: 0x2::object::ID,
        of: 0x2::object::ID,
    }

    struct StakeSuiEvent has copy, drop {
        vault_id: 0x2::object::ID,
        input_amount: u64,
        output_amount: u64,
    }

    public fun new_haedal_pass_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewHaedalPassEvent{
            id : arg0,
            of : arg1,
        };
        0x2::event::emit<NewHaedalPassEvent>(v0);
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

